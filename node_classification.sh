#!/bin/bash
models=("deepwalk_skip" "deepwalk_fairwalk" "deepwalk_crosswalk" "deepwalk_degree" "deepwalk_fair_degree")
experiments=(112 113 114 115 116)
data=("tolokers")
tasks=("nodeclass")
for d in "${data[@]}";
do
    echo $d
    for i in $(seq 1 5);
    do
        m=${models[i]}
        e=${experiments[i]}
        echo $m
        for t in "${tasks[@]}";
        do
            echo $t
            uv run xwalk_reprod --cfg "experiments/${t}_rice_${m}.yml" --opts DATASET $d NODE_CLASSIFICATION.LABEL_KEY "labels" RESUME $e STAGE 1 NODE_CLASSIFICATION.KERNEL knn
        done
    done
done