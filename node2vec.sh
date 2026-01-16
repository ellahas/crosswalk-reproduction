#!/bin/bash
model=node2vec_simple
data=rice
task=linkpred
ps=(0.01 0.5 1 2)
qs=(0.01 0.5 1 2)

for p in "${ps[@]}";
    do
        echo $p
        for q in "${qs[@]}"
            do
                echo $q
                uv run xwalk_reprod --cfg "experiments/${task}_${data}_${model}.yml" --opts RUNS 1
            done
    done
