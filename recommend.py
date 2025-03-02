import torch
import numpy as np
from NGCF.NGCF import NGCF
from NGCF.utility.load_data import Data
from NGCF.utility.parser import parse_args
from NGCF.utility.metrics import ndcg_at_k, precision_at_k, recall_at_k, hit_at_k

class Recommender:
    def __init__(self, model_path, data_path):
        # Load data
        self.data_generator = Data(path=data_path, batch_size=1024)
        self.args = parse_args()

        # Print parameters for checking
        print("Parameters:")
        print(f"node_dropout: {self.args.node_dropout}")
        print(f"mess_dropout: {self.args.mess_dropout}")
        print(f"regs: {self.args.regs}")
        print(f"layer_size: {self.args.layer_size}")

        # Convert parameters - handle both string and evaluated forms
        try:
            # Only convert if they're strings
            self.args.node_dropout = eval(self.args.node_dropout) if isinstance(self.args.node_dropout, str) else self.args.node_dropout
            self.args.mess_dropout = eval(self.args.mess_dropout) if isinstance(self.args.mess_dropout, str) else self.args.mess_dropout
            self.args.regs = eval(self.args.regs) if isinstance(self.args.regs, str) else self.args.regs
            self.args.layer_size = eval(self.args.layer_size) if isinstance(self.args.layer_size, str) else self.args.layer_size
        except:
            print("Using default values for some parameters")
            self.args.node_dropout = [0.1]
            self.args.mess_dropout = [0.1, 0.1, 0.1]
            self.args.regs = [1e-5]
            self.args.layer_size = [64, 64, 64]

        self.args.device = torch.device('cuda:0' if torch.cuda.is_available() else 'cpu')

        # Initialize model
        self._initialize_model(model_path)

    def _initialize_model(self, model_path):
        """Initialize model and pre-compute embeddings"""
        try:
            print(f"Initializing model from: {model_path}")
            print(f"Model parameters:")
            print(f"n_users: {self.data_generator.n_users}")
            print(f"n_items: {self.data_generator.n_items}")
            print(f"embed_size: {self.args.embed_size}")
            print(f"layer_size: {self.args.layer_size}")

            # Create NGCF model instance with pre-evaluated parameters
            self.model = NGCF(self.data_generator.n_users,
                              self.data_generator.n_items,
                              self.data_generator.get_adj_mat()[1],
                              self.args).to(self.args.device)

            print("Loading model weights...")
            self.model.load_state_dict(torch.load(model_path))
            self.model.eval()
            print("Model loaded successfully")

            print("Pre-computing embeddings...")
            with torch.no_grad():
                users = torch.arange(self.data_generator.n_users).to(self.args.device)
                items = torch.arange(self.data_generator.n_items).to(self.args.device)

                self.all_users_emb, self.all_items_emb, _ = self.model(users,
                                                                       items,
                                                                       [],
                                                                       drop_flag=False)

                self.all_users_emb = self.all_users_emb.cpu()
                self.all_items_emb = self.all_items_emb.cpu()
            print("Embeddings pre-computed successfully")

        except Exception as e:
            print(f"Error during model initialization: {str(e)}")
            raise

    def recommend_for_user(self, user_id, top_k=10, exclude_train=True, exclude_test=False):
        """Recommend top_k items for specified user"""
        with torch.no_grad():
            u_emb = self.all_users_emb[user_id:user_id+1]
            scores = torch.mm(u_emb, self.all_items_emb.t()).flatten()

            # Get items to exclude
            exclude_items = set()
            if exclude_train and user_id in self.data_generator.train_items:
                exclude_items.update(self.data_generator.train_items[user_id])
            if exclude_test and user_id in self.data_generator.test_set:
                exclude_items.update(self.data_generator.test_set[user_id])

            # Create mask
            mask = torch.ones_like(scores, dtype=torch.bool)
            mask[list(exclude_items)] = False

            # Apply mask and get top-k
            masked_scores = scores.clone()
            masked_scores[~mask] = float('-inf')
            _, indices = torch.topk(masked_scores, k=min(top_k, mask.sum().item()))

            return indices.numpy().tolist()

    def evaluate_recommendation(self, user_id, recommended_items, Ks=[20, 40, 60, 80, 100]):
        """Evaluate recommendations for a user"""
        if user_id not in self.data_generator.test_set:
            return None

        test_items = self.data_generator.test_set[user_id]
        r = [1 if item in test_items else 0 for item in recommended_items]

        # Ensure length matches max K
        max_K = max(Ks)
        if len(r) < max_K:
            r.extend([0] * (max_K - len(r)))

        metrics = {
            'precision': [precision_at_k(r, k) for k in Ks],
            'recall': [recall_at_k(r, k, len(test_items)) for k in Ks],
            'ndcg': [ndcg_at_k(r, k, test_items) for k in Ks],
            'hit_ratio': [hit_at_k(r, k) for k in Ks],
            'Ks': Ks,
            'hit_items': [item for item in recommended_items if item in test_items]
        }

        return metrics

def print_metrics(metrics_dict):
    """Print evaluation metrics"""
    if metrics_dict is None:
        print("No test data available for this user.")
        return

    Ks = metrics_dict['Ks']
    print("\nEvaluation Results:")
    print("=" * 50)

    metrics_names = ['precision', 'recall', 'ndcg', 'hit_ratio']
    for idx, K in enumerate(Ks):
        print(f"\nAt K = {K}:")
        for metric in metrics_names:
            print(f"{metric}@{K}: {metrics_dict[metric][idx]:.4f}")

    print("\nHit Items:", metrics_dict['hit_items'])

if __name__ == '__main__':
    recommender = Recommender(
        model_path='/mnt/csip-099/FGX/NGCF-PyTorch/weights/gowalla_epoch_9.pkl',
        data_path='/mnt/csip-099/FGX/NGCF-PyTorch/Data/gowalla'
    )

    # Test single user recommendation
    user_id = 0
    recommended_items = recommender.recommend_for_user(user_id, top_k=100)
    print(f"\nRecommended items for user {user_id}:")
    print(recommended_items)

    # Evaluate recommendations
    evaluation = recommender.evaluate_recommendation(user_id, recommended_items)
    print_metrics(evaluation)