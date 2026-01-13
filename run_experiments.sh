#!/bin/bash
models=("deepwalk_skip" "deepwalk_fairwalk" "deepwalk_crosswalk")
data=("pokec_gender")
tasks=("nodeclass")
for d in "${data[@]}";
do
    echo $d
    for m in "${models[@]}";
    do
        echo $m
        for t in "${tasks[@]}";
        do
            echo $t
            uv run xwalk_reprod --cfg "experiments/${t}_rice_${m}.yml" --opts DATASET $d NODE_CLASSIFICATION.LABEL_KEY "labels"
        done
    done
done
