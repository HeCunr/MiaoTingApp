import mysql.connector
import os

def read_file(file_path):
    with open(file_path, 'r') as f:
        return f.read()

conn = mysql.connector.connect(
    host='8.210.250.29',
    port=3306,
    user='root',
    password='@Aa123456',
    database='cloudmusic'
)
cursor = conn.cursor()

files = {
    '/data/user_list.txt': '/home/vllm/NGCF-PyTorch/Data/Random/user_list.txt',
    '/data/item_list.txt': '/home/vllm/NGCF-PyTorch/Data/Random/item_list.txt',
    '/data/train.txt': '/home/vllm/NGCF-PyTorch/Data/Random/train.txt'
}

for db_path, local_path in files.items():
    content = read_file(local_path)
    # 使用UPDATE语句更新content
    update_query = "UPDATE train_file SET content = %s WHERE file_path = %s"
    cursor.execute(update_query, (content, db_path))
    if cursor.rowcount == 0:
        print(f"Warning: No record found for {db_path}")
    else:
        print(f"Successfully updated content for {db_path}")

conn.commit()
cursor.close()
conn.close()