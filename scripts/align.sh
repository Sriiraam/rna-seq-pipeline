echo "Starting alignment..." > logs/align.log

# Run HISAT2 alignment
hisat2 -x reference/genome_index \
-U results/trimmed2.fastq \
-S results/aligned.sam >> logs/align.log 2>&1

# Convert SAM to BAM
samtools view -bS results/aligned.sam > results/aligned.bam

# Sort BAM
samtools sort results/aligned.bam -o results/aligned_sorted.bam

# Index BAM
samtools index results/aligned_sorted.bam

echo "Alignment completed." >> logs/align.log
