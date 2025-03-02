import random

# 设置随机种子，保证每次生成的数据一致
random.seed(42)

# 设置用户和物品数量
n_users = 10
n_items = 50
n_interactions = 10  # 生成10条交互记录

# 生成纯数字ID
original_user_ids = [random.randint(1, 10000) for _ in range(n_users)]
original_item_ids = [random.randint(1, 10000) for _ in range(n_items)]

# ID映射
user_list = [(original_user_ids[i], i) for i in range(n_users)]
item_list = [(original_item_ids[i], i) for i in range(n_items)]

# 保存 user_list.txt 和 item_list.txt
def save_user_item_list(user_list, item_list):
    with open('/home/vllm/NGCF-PyTorch/Data/Random/user_list.txt', 'w') as f_user:
        f_user.write("org_id remap_id\n")
        for orig_id, remap_id in user_list:
            f_user.write(f"{orig_id} {remap_id}\n")

    with open('/home/vllm/NGCF-PyTorch/Data/Random/item_list.txt', 'w') as f_item:
        f_item.write("org_id remap_id\n")
        for orig_id, remap_id in item_list:
            f_item.write(f"{orig_id} {remap_id}\n")

# 生成交互记录 train.txt
def generate_train_file(n_interactions):
    with open('/home/vllm/NGCF-PyTorch/Data/Random/train.txt', 'w') as f_train:
        for _ in range(n_interactions):
            user_id = random.randint(0, n_users - 1)  # 随机选一个用户
            # 随机生成用户与物品的交互记录
            items_interacted = random.sample(range(n_items), random.randint(1, 20))  # 每个用户交互1-20个物品
            f_train.write(f"{user_id} " + " ".join(map(str, items_interacted)) + "\n")

# 调用函数生成文件
save_user_item_list(user_list, item_list)
generate_train_file(n_interactions)

print("Files have been generated.")