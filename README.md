# Neural Graph Collaborative Filtering for CloudMusic App

A PyTorch implementation of Neural Graph Collaborative Filtering (NGCF) adapted for the CloudMusic (喵听) App recommendation system. This repository contains code for training and deploying a graph-based recommendation model that leverages user-item interactions to provide personalized music recommendations.

## Table of Contents

- [Introduction](#introduction)
- [Algorithm Principles](#algorithm-principles)
- [Architecture Overview](#architecture-overview)
- [Data Flow](#data-flow)
- [Installation](#installation)
- [Usage](#usage)
  - [Training](#training)
  - [Recommendation](#recommendation)
  - [Evaluation](#evaluation)
- [Integration with CloudMusic Database](#integration-with-cloudmusic-database)
- [Performance Metrics](#performance-metrics)
- [Future Improvements](#future-improvements)

## Introduction

This project implements the Neural Graph Collaborative Filtering (NGCF) model, a state-of-the-art recommendation algorithm that leverages graph neural networks to model high-order connectivity in user-item interactions. The implementation is specifically tailored for the CloudMusic App, providing personalized music recommendations based on user listening patterns.

The system connects to a CloudMusic MySQL database to fetch training data and write recommendations back, creating a complete recommendation pipeline from data extraction to recommendation deployment.

## Algorithm Principles

### Neural Graph Collaborative Filtering (NGCF)

NGCF enhances collaborative filtering by explicitly modeling the high-order connectivity in user-item interactions. Traditional matrix factorization-based methods learn user and item embeddings independently, ignoring the relations between interacted users and items. NGCF addresses this by injecting the collaborative signal into the embedding process to refine them.

#### Key Concepts:

1. **User-Item Bipartite Graph**: Represents users and items as nodes, with edges denoting interactions.
2. **Embedding Propagation Layers**: Recursively propagate embeddings through the graph structure.
3. **Message Construction**: Construct messages from neighbors to refine embeddings.
4. **Message Aggregation**: Aggregate messages to update embeddings.

#### Mathematical Foundation:

NGCF leverages graph convolution operations to capture collaborative signals. For a user node u and an item node i:

- **Initial Embeddings**: e_u and e_i
- **Message Passing**: 
  - Message from i to u: m_{i→u} = W_1 · e_i + W_2 · (e_i ⊙ e_u)
  - Message from u to i: m_{u→i} = W_1 · e_u + W_2 · (e_u ⊙ e_i)
- **Message Aggregation**:
  - e_u^(1) = LeakyReLU(e_u + ∑_{i∈N_u} m_{i→u})
  - e_i^(1) = LeakyReLU(e_i + ∑_{u∈N_i} m_{u→i})

Where:
- ⊙ is element-wise product
- W_1 and W_2 are weight matrices
- N_u is the set of items interacted by user u
- N_i is the set of users who interacted with item i

After L layers of embedding propagation, the final embedding for user u is the concatenation: e_u^* = e_u || e_u^(1) || ... || e_u^(L)

### How NGCF Makes Recommendations

1. **Embedding Learning**: The model learns embeddings for all users and items through the graph structure.
2. **Score Prediction**: Calculate the inner product between user embedding and item embedding.
3. **Ranking**: Rank items for each user based on the predicted scores.
4. **Top-K Selection**: Select the top K items as recommendations.

## Architecture Overview

The system consists of several key components:

1. **Data Loader (`load_data.py`)**: Handles data loading and preprocessing from files or database.
2. **NGCF Model (`NGCF.py`)**: Implements the core NGCF model with embedding propagation layers.
3. **Main Training Script (`main.py`)**: Orchestrates the training process and saves the model.
4. **Recommendation Engine (`recommend.py`)**: Generates recommendations for users using the trained model.
5. **Database Connector (`db_utils.py`, `import_file.py`)**: Manages database connections for reading training data and writing recommendations.
6. **Evaluation Metrics (`metrics.py`)**: Implements metrics for evaluating recommendation quality.

## Data Flow

1. **Data Import**: Training data is imported from the CloudMusic database.
2. **Preprocessing**: Data is processed into user-item interactions.
3. **Graph Construction**: A user-item bipartite graph is constructed.
4. **Model Training**: The NGCF model is trained using the constructed graph.
5. **Recommendation Generation**: Recommendations are generated for all users.
6. **Result Storage**: Recommendations are stored back in the CloudMusic database.

## Installation

```bash
# Clone the repository
git clone https://github.com/yourusername/ngcf-cloudmusic.git
cd ngcf-cloudmusic

# Install dependencies
pip install -r requirements.txt
```

### Requirements

- Python 3.6+
- PyTorch 1.7+
- MySQL Connector for Python
- NumPy
- SciPy
- Scikit-learn

## Usage

### Training

To train the NGCF model:

```bash
python main.py --epoch 400 --batch_size 32 --lr 0.0001 --embed_size 64 --layer_size [64,64,64]
```

Key parameters:
- `--epoch`: Number of training epochs
- `--batch_size`: Batch size for training
- `--lr`: Learning rate
- `--embed_size`: Embedding size
- `--layer_size`: Output sizes of each propagation layer (e.g., [64,64,64] for 3 layers)
- `--node_dropout`: Keep probability for node dropout (e.g., [0.1])
- `--mess_dropout`: Keep probability for message dropout (e.g., [0.1,0.1,0.1])

### Recommendation

To generate recommendations:

```bash
python recommend.py --model_path weights/best_model.pth --data_path temp_data --top_k 20
```

### Evaluation

The system uses the following standard recommendation metrics:

- **Precision@K**: Proportion of recommended items that are relevant
- **Recall@K**: Proportion of relevant items that are recommended
- **NDCG@K**: Normalized Discounted Cumulative Gain at K
- **Hit Ratio@K**: Whether at least one relevant item is among the top K recommendations

## Integration with CloudMusic Database

The system is designed to work with the CloudMusic MySQL database:

### Database Schema

The implementation uses a table named `train_file` with the following structure:
- `file_path`: Path identifier for the data file
- `content`: Content of the file

### Data Files

The system uses three main files in the database:
1. `/data/user_list.txt`: List of user IDs
2. `/data/item_list.txt`: List of item (song) IDs
3. `/data/train.txt`: User-item interactions for training
4. `/data/result.txt`: Generated recommendations

### Data Import

The `import_file.py` script handles importing data from local files to the database:

```bash
python import_file.py
```

### Recommendation Storage

Recommendations are stored in the database with the format:
```
user_id    item1,item2,item3,...,item18
```
Where each line represents recommendations for a specific user.

## Performance Metrics

The implemented NGCF model has shown promising results compared to traditional collaborative filtering approaches:

- Higher precision and recall at different K values
- Better coverage of long-tail items
- More diverse recommendations
- Improved NDCG scores indicating better ranking quality

## Future Improvements

1. **Content Integration**: Incorporate song features (genre, artist, etc.) for hybrid recommendations
2. **Sequential Modeling**: Integrate sequential patterns in user behavior
3. **Online Learning**: Update model incrementally with new user interactions
4. **Multi-behavior Modeling**: Consider multiple user behaviors (listening, liking, adding to playlist)
5. **Scalability Optimizations**: Improve efficiency for larger user bases
6. **Cold Start Handling**: Better strategies for new users and items
