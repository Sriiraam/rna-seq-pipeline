#!/bin/bash -ue
featureCounts -L -a annotation.gtf -o counts.txt aligned_sorted.bam > count.log 2>&1
