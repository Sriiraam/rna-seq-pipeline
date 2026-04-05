#!/bin/bash -ue
fastqc sample.fastq -o . > qc.log 2>&1
