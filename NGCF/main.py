import os
import torch
import torch.optim as optim
from NGCF import NGCF
import warnings
import mysql.connector
import numpy as np
from time import time
from utility.load_data import Data
import argparse

warnings.filterwarnings('ignore')

def parse_args():
    parser = argparse.ArgumentParser(description="Run NGCF.")
    parser.add_argument('--embed_size', type=int, default=64,
                        help='Embedding size.')
    parser.add_argument('--layer_size', nargs='?', default='[64,64,64]',
                        help='Output sizes of every layer')
    parser.add_argument('--batch_size', type=int, default=32,
                        help='Batch size.')
    parser.add_argument('--regs', nargs='?', default='[1e-5]',
                        help='Regularizations.')
    parser.add_argument('--lr', type=float, default=0.0001,
                        help='Learning rate.')
    parser.add_argument('--epoch', type=int, default=400,
                        help='Number of epoch.')
    parser.add_argument('--verbose', type=int, default=1,
                        help='Interval of evaluation.')
    parser.add_argument('--node_dropout', nargs='?', default='[0.1]',
                        help='Keep probability w.r.t. node dropout.')
    parser.add_argument('--mess_dropout', nargs='?', default='[0.1,0.1,0.1]',
                        help='Keep probability w.r.t. message dropout.')
    parser.add_argument('--node_dropout_flag', type=int, default=1,
                        help='0: Disable node dropout, 1: Activate node dropout')
    parser.add_argument('--save_flag', type=int, default=1,
                        help='0: Disable model saver, 1: Activate model saver')
    args = parser.parse_args()

    # Convert string parameters to lists/numbers
    args.layer_size = eval(args.layer_size)
    args.node_dropout = eval(args.node_dropout)
    args.mess_dropout = eval(args.mess_dropout)
    args.regs = eval(args.regs)

    return args

class DBConnector:
    def __init__(self):
        self.conn = mysql.connector.connect(
            host='8.210.250.29',
            port=3306,
            user='root',
            password='@Aa123456',
            database='cloudmusic'
        )
        self.cursor = self.conn.cursor()

    def read_file_from_db(self, file_path):
        query = f"SELECT content FROM train_file WHERE file_path = '{file_path}'"
        self.cursor.execute(query)
        content = self.cursor.fetchone()[0]
        temp_path = os.path.join("temp_data", os.path.basename(file_path))
        os.makedirs(os.path.dirname(temp_path), exist_ok=True)
        with open(temp_path, 'w') as f:
            f.write(content)
        return temp_path

    def write_results_to_db(self, results, file_path='/data/result.txt'):
        content = '\n'.join([f"{user_id}\t{','.join(map(str, items))}"
                             for user_id, items in results.items()])
        try:
            # 使用UPDATE而不是DELETE+INSERT
            update_query = "UPDATE train_file SET content = %s WHERE file_path = %s"
            self.cursor.execute(update_query, (content, file_path))

            # 如果记录不存在则插入
            if self.cursor.rowcount == 0:
                insert_query = "INSERT INTO train_file (file_path, content) VALUES (%s, %s)"
                self.cursor.execute(insert_query, (file_path, content))

            self.conn.commit()
            print("Results successfully updated in database")
        except mysql.connector.Error as err:
            print(f"Error writing results to DB: {err}")
            self.conn.rollback()

    def close(self):
        self.cursor.close()
        self.conn.close()

if __name__ == '__main__':
    args = parse_args()

    # Create temp directory
    temp_dir = "temp_data"
    if not os.path.exists(temp_dir):
        os.makedirs(temp_dir)

    # Connect to database and get files
    db = DBConnector()
    temp_files = []

    # Load data from database
    for file_path in ['/data/train.txt', '/data/user_list.txt', '/data/item_list.txt']:
        temp_file = db.read_file_from_db(file_path)
        temp_files.append(temp_file)
        print(f"Loaded {file_path}")


    # Initialize data generator
    data_generator = Data(path=temp_dir, batch_size=args.batch_size)

    # Create weights directory
    os.makedirs('weights', exist_ok=True)

    # Set device
    device = torch.device('cuda:0' if torch.cuda.is_available() else 'cpu')
    args.device = device

    # Get adjacency matrix
    _, norm_adj, _ = data_generator.get_adj_mat()


    # Initialize model

    model = NGCF(data_generator.n_users,
                 data_generator.n_items,
                 norm_adj,
                 args).to(args.device)


    optimizer = optim.Adam(model.parameters(), lr=args.lr)

    # Training loop

    # Training loop
    best_loss = float('inf')
    for epoch in range(args.epoch):
        t1 = time()
        loss, mf_loss, emb_loss = 0., 0., 0.
        n_batch = data_generator.n_train // args.batch_size + 1

        for idx in range(n_batch):
            users, pos_items, neg_items = data_generator.sample()
            u_g_embeddings, pos_i_g_embeddings, neg_i_g_embeddings = model(users,
                                                                           pos_items,
                                                                           neg_items,
                                                                           drop_flag=args.node_dropout_flag)

            batch_loss, batch_mf_loss, batch_emb_loss = model.create_bpr_loss(u_g_embeddings,
                                                                              pos_i_g_embeddings,
                                                                              neg_i_g_embeddings)
            optimizer.zero_grad()
            batch_loss.backward()
            optimizer.step()

            loss += batch_loss
            mf_loss += batch_mf_loss
            emb_loss += batch_emb_loss

        if args.verbose > 0 and epoch % args.verbose == 0:
            print(f'Epoch {epoch} [{time() - t1:.1f}s]: train==[{loss:.5f}={mf_loss:.5f} + {emb_loss:.5f}]')

        # Save best model
        if loss < best_loss:
            best_loss = loss
            if args.save_flag == 1:
                torch.save(model.state_dict(), 'weights/best_model.pth')

    # Generate recommendations for all users
    print("Generating recommendations...")
    results = {}
    model.eval()
    batch_size =16
    with torch.no_grad():
        for start_idx in range(0, data_generator.n_users, batch_size):
            end_idx = min(start_idx + batch_size, data_generator.n_users)
            user_batch = list(range(start_idx, end_idx))

            user_tensor = torch.LongTensor(user_batch).to(device)
            user_embeddings = model.embedding_dict['user_emb'][user_tensor]
            all_item_embeddings = model.embedding_dict['item_emb']

            scores = torch.mm(user_embeddings, all_item_embeddings.t())
            _, indices = torch.topk(scores, k=18)
            indices = indices.cpu().numpy()

            for i, user_id in enumerate(user_batch):
                results[user_id] = indices[i].tolist()

    # Save results to database
    print("Saving recommendations to database...")
    db.write_results_to_db(results)

    # Cleanup
    for file in temp_files:
        if os.path.exists(file):
            os.remove(file)
    if os.path.exists(temp_dir):
        try:
            os.rmdir(temp_dir)
        except OSError:
            print(f"Could not remove temporary directory: {temp_dir}")

    db.close()
    print("Finished!")