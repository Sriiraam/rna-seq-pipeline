#!/bin/bash

echo "Starting final QC..." > logs/qc_final.log

fastqc results/trimmed2.fastq -o results/ >> logs/qc_final.log 2>&1

echo "Final QC completed." >> logs/qc_final.log
