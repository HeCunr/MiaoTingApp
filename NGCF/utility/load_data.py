#NGCF/utility/load_data.py
import numpy as np
import random as rd
import scipy.sparse as sp
from time import time
import os

class Data(object):
    def __init__(self, path, batch_size):
        self.path = path
        self.batch_size = batch_size
        # 删除旧的npz文件
        npz_files = [
            self.path + '/s_adj_mat.npz',
            self.path + '/s_norm_adj_mat.npz',
            self.path + '/s_mean_adj_mat.npz'
        ]
        for npz_file in npz_files:
            if os.path.exists(npz_file):
                os.remove(npz_file)
                print(f"Removed old matrix file: {npz_file}")

        train_file = path + '/train.txt'

        #get number of users and items
        self.n_users, self.n_items = 0, 0
        self.n_train = 0
        self.neg_pools = {}
        self.exist_users = []

        with open(train_file) as f:
            for l in f.readlines():
                if len(l) > 0:
                    l = l.strip('\n').split(' ')
                    items = [int(i) for i in l[1:]]
                    uid = int(l[0])
                    self.exist_users.append(uid)
                    self.n_items = max(self.n_items, max(items))
                    self.n_users = max(self.n_users, uid)
                    self.n_train += len(items)

        self.n_items += 1
        self.n_users += 1

        self.R = sp.dok_matrix((self.n_users, self.n_items), dtype=np.float32)
        self.train_items = {}

        with open(train_file) as f_train:
            for l in f_train.readlines():
                if len(l) == 0:
                    break
                l = l.strip('\n')
                items = [int(i) for i in l.split(' ')]
                uid, train_items = items[0], items[1:]

                for i in train_items:
                    self.R[uid, i] = 1.

                self.train_items[uid] = train_items

        self.print_statistics()


    def get_adj_mat(self):
        # 直接创建新的邻接矩阵
        adj_mat, norm_adj_mat, mean_adj_mat = self.create_adj_mat()

        # 保存新生成的矩阵（如果需要的话）
        sp.save_npz(self.path + '/s_adj_mat.npz', adj_mat)
        sp.save_npz(self.path + '/s_norm_adj_mat.npz', norm_adj_mat)
        sp.save_npz(self.path + '/s_mean_adj_mat.npz', mean_adj_mat)

        return adj_mat, norm_adj_mat, mean_adj_mat

    def create_adj_mat(self):
        adj_mat = sp.dok_matrix((self.n_users + self.n_items, self.n_users + self.n_items), dtype=np.float32)
        adj_mat = adj_mat.tolil()
        R = self.R.tolil()

        adj_mat[:self.n_users, self.n_users:] = R
        adj_mat[self.n_users:, :self.n_users] = R.T
        adj_mat = adj_mat.todok()

        def mean_adj_single(adj):
            rowsum = np.array(adj.sum(1))
            d_inv = np.power(rowsum, -1).flatten()
            d_inv[np.isinf(d_inv)] = 0.
            d_mat_inv = sp.diags(d_inv)
            norm_adj = d_mat_inv.dot(adj)
            return norm_adj.tocoo()

        norm_adj_mat = mean_adj_single(adj_mat + sp.eye(adj_mat.shape[0]))
        mean_adj_mat = mean_adj_single(adj_mat)

        return adj_mat.tocsr(), norm_adj_mat.tocsr(), mean_adj_mat.tocsr()

    def sample(self):
        if self.batch_size <= self.n_users:
            users = rd.sample(self.exist_users, self.batch_size)
        else:
            users = [rd.choice(self.exist_users) for _ in range(self.batch_size)]

        def sample_pos_items_for_u(u, num):
            pos_items = self.train_items[u]
            n_pos_items = len(pos_items)
            pos_batch = []
            while True:
                if len(pos_batch) == num:
                    break
                pos_id = np.random.randint(low=0, high=n_pos_items, size=1)[0]
                pos_i_id = pos_items[pos_id]
                if pos_i_id not in pos_batch:
                    pos_batch.append(pos_i_id)
            return pos_batch

        def sample_neg_items_for_u(u, num):
            neg_items = []
            while True:
                if len(neg_items) == num:
                    break
                neg_id = np.random.randint(low=0, high=self.n_items,size=1)[0]
                if neg_id not in self.train_items[u] and neg_id not in neg_items:
                    neg_items.append(neg_id)
            return neg_items

        pos_items, neg_items = [], []
        for u in users:
            pos_items += sample_pos_items_for_u(u, 1)
            neg_items += sample_neg_items_for_u(u, 1)

        return users, pos_items, neg_items

    def print_statistics(self):
        print('n_users=%d, n_items=%d' % (self.n_users, self.n_items))
        print('n_interactions=%d' % (self.n_train))
        print('n_train=%d, sparsity=%.5f' % (self.n_train, self.n_train/(self.n_users * self.n_items)))