#!/bin/bash -ue
# Extract correct prefix INSIDE container
prefix=$(ls *.1.ht2 | sed 's/.1.ht2//')

hisat2 -x $prefix -U clean.fastq -S aligned.sam > align.log 2>&1

samtools view -bS aligned.sam > aligned.bam
samtools sort aligned.bam -o aligned_sorted.bam
samtools index aligned_sorted.bam
