#!/bin/bash
models=("deepwalk_crosswalk" "deepwalk_fairwalk" "deepwalk_skip")
data=("rice" "deezer")
tasks=("linkpred" "infmax")
for d in "${data[@]}";
do
    echo $d
    for m in "${models[@]}";
    do
        echo $m
        for t in "${tasks[@]}";
        do
            echo $t
            uv run xwalk_reprod --cfg "experiments/${t}_${d}_${m}.yml"
        done
    done
done
