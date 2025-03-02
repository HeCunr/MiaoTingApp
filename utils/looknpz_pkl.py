# !/user/bin/env python3
# -*- coding: utf-8 -*-
import numpy as np
import scipy.sparse as sp
import torch

# 查看邻接矩阵
def view_adj_mat():
    # 加载.npz文件
    adj_mat = sp.load_npz(r'/mnt/csip-099/FGX/NGCF-PyTorch/Data/gowalla/s_adj_mat.npz')
    norm_adj_mat = sp.load_npz(r'/mnt/csip-099/FGX/NGCF-PyTorch/Data/gowalla/s_norm_adj_mat.npz')
    mean_adj_mat = sp.load_npz(r'/mnt/csip-099/FGX/NGCF-PyTorch/Data/gowalla/s_mean_adj_mat.npz')

    # 转换为密集矩阵查看内容
    print("Original adjacency matrix:")
    print(adj_mat.todense())
    print("\nNormalized adjacency matrix:")
    print(norm_adj_mat.todense())
    print("\nMean adjacency matrix:")
    print(mean_adj_mat.todense())

# 查看模型权重
def view_model_weights():
    weights = torch.load(r'/mnt/csip-099/FGX/NGCF-PyTorch/weights/gowalla_epoch_9.pkl')
    for key, value in weights.items():
        print(f"Layer: {key}, Shape: {value.shape}")
        print(value)

if __name__ == '__main__':
    print("查看邻接矩阵...")
    view_adj_mat()

    print("\n查看模型权重...")
    view_model_weights()