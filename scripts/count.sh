#!/bin/bash

echo "Starting gene counting..." > ../logs/count.log

featureCounts -a ../reference/annotation.gtf \
-o ../results/counts.txt \
../results/aligned_sorted.bam >> ../logs/count.log 2>&1

echo "Gene counting completed." >> ../logs/count.log
