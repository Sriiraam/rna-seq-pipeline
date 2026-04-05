#!/bin/bash
echo "Starting trimming..." >logs/trim.log
cutadapt -q 20 -a AGATCGGAAGAGC -m 20 -o results/clean.fastq data/sample.fastq>>logs/trim.log 2>&1
echo "Trimming completed." >>logs/trim.log
