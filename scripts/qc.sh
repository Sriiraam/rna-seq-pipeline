#!/bin/bash
#!/bin/bash
echo "Starting QC..." > logs/qc.log
fastqc data/sample.fastq -o results/ >> logs/qc.log 2>&1
echo "QC completed." >> logs/qc.log
