#!/bin/bash -ue
cutadapt -q 20 -a AGATCGGAAGAGC -m 20 -o clean.fastq sample.fastq > trim.log 2>&1
