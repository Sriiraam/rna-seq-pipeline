#!/bin/bash
viRNA-Seq Pipeline 
## Step 1: Quality Control using FastQC

Input:
data/sample.fastq

Output:
results/sample_fastqc.html

Run:
./scripts/qc.sh

## Step 2: Trimming

Tool:
Cutadapt

Purpose:
Remove low-quality bases, adapter sequences, and short reads from raw sequencing data

Input:
data/sample.fastq

Output:
results/clean.fastq

Command:
cutadapt -q 20 -a AGATCGGAAGAGC -m 20 -o results/clean.fastq data/sample.fastq

Run Script:
bash scripts/trim.sh

Logs:
logs/trim.log

## Step 3: QC After Trimming

Tool:
FastQC

Purpose:
Validate quality after trimming

Input:
results/trimmed2.fastq

Output:
results/trimmed2_fastqc.html

Run:
bash scripts/qc_final.sh  

Step 4: Alignment

Tool:
HISAT2

Purpose:
Map cleaned RNA-Seq reads to a reference genome to determine their genomic positions

Input:
results/trimmed2.fastq
reference/genome_index

Output:
results/aligned.sam
results/aligned.bam
results/aligned_sorted.bam
results/aligned_sorted.bam.bai

Step 4.1: Build Index

Command:
hisat2-build reference/genome.fa genome_index

Purpose:
Create index files for fast alignment

Step 4.2: Run Alignment

Command:
hisat2 -x reference/genome_index -U results/trimmed2.fastq -S results/aligned.sam

Logs:
logs/align.log

Step 4.3: Convert SAM to BAM

Command:
samtools view -bS results/aligned.sam > results/aligned.bam

Step 4.4: Sort BAM

Command:
samtools sort results/aligned.bam -o results/aligned_sorted.bam

Step 4.5: Index BAM

Command:
samtools index results/aligned_sorted.bam

Run Script

bash scripts/align.sh
## Step 4: Alignment

Tool:
HISAT2

Purpose:
Map cleaned RNA-Seq reads to a reference genome to determine their genomic positions

Input:
results/trimmed2.fastq
reference/genome_index

Output:
results/aligned.sam
results/aligned.bam
results/aligned_sorted.bam
results/aligned_sorted.bam.bai

Step 4.1: Build Index

Command:
hisat2-build reference/genome.fa genome_index

Purpose:
Create index files for fast alignment

Step 4.2: Run Alignment

Command:
hisat2 -x reference/genome_index -U results/trimmed2.fastq -S results/aligned.sam

Logs:
logs/align.log

Step 4.3: Convert SAM to BAM

Command:
samtools view -bS results/aligned.sam > results/aligned.bam

Step 4.4: Sort BAM

Command:
samtools sort results/aligned.bam -o results/aligned_sorted.bam

Step 4.5: Index BAM

Command:
samtools index results/aligned_sorted.bam

Run Script

bash scripts/align.sh

## Step 5: Gene Counting
Tool:

featureCounts

Purpose:

Count how many reads are mapped to each gene using aligned BAM file and annotation file

Input:
results/aligned_sorted.bam
reference/annotation.gtf
Output:
results/counts.txt
results/counts.txt.summary
Command:
featureCounts -a reference/annotation.gtf -o results/counts.txt results/aligned_sorted.bam
Run Script:
bash scripts/count.sh
Logs:
logs/count.log


## ⚙️  Pipeline Automation (Nextflow)

Purpose:
Automate the RNA-Seq pipeline using workflow management.

Run:
nextflow run main.nf
