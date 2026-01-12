#!/bin/bash
models=("deepwalk_skip" "deepwalk_fairwalk" "deepwalk_crosswalk")
data=("pokec_gender")
tasks=("infmax" "linkpred")
for d in "${data[@]}";
do
    echo $d
    for m in "${models[@]}";
    do
        echo $m
        for t in "${tasks[@]}";
        do
            echo $t
            uv run xwalk_reprod --cfg "experiments/${t}_rice_${m}.yml" --opts DATASET $d
        done
    done
done
