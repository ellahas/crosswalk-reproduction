import torch

import logging
logger = logging.getLogger(__name__)

def get_degree_weights(g):
    new_weights = torch.empty(size=(g.num_edges(),))
    for source in g.nodes():
        all_neighbors = g.successors(source)
        if len(all_neighbors) == 0:
            continue
        neighbor_degrees = g.in_degrees(all_neighbors)

        for nb in all_neighbors:
            new_weights[g.edge_ids(source, nb)] = (1 / g.in_degrees(nb).item()) / torch.sum(1/neighbor_degrees)

    return new_weights

def get_fair_degree_weights(g, group_key):
    # Iterate through all nodes and compute their outgoing edges' weights
    new_weights = torch.empty(size=(g.num_edges(),))
    for source in g.nodes():
        all_neighbors = g.successors(source)
        neighbor_groups = g.ndata[group_key][all_neighbors]
        unique_neighbor_groups = neighbor_groups.unique()

        # No neighbor no cry
        if len(unique_neighbor_groups) == 0:
            continue

        # the sum of edge weights toward its members should be the same for all groups
        total_weight_per_group = 1.0 / len(unique_neighbor_groups)

        for group in unique_neighbor_groups:
            group_neighbors = all_neighbors[neighbor_groups == group]
            # Each edge towards a node of the same group should receive the same weight
            weight_per_node = total_weight_per_group / len(group_neighbors)

            for nb in group_neighbors:
                new_weights[g.edge_ids(source, nb)] = weight_per_node / g.in_degrees(nb).item()
    return new_weights