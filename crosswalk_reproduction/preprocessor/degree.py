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