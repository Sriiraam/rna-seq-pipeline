#!/usr/bin/env nextflow

params.reads = "data/sample.fastq"

process QC {

    publishDir "results/01_qc", mode: 'copy'

    input:
    path reads

    output:
    path "sample_fastqc.html"

    script:
    """
    fastqc ${reads} -o . > qc.log 2>&1
    """
}

process TRIM {

    publishDir "results/02_trim", mode: 'copy'

    input:
    path reads

    output:
    path "clean.fastq"

    script:
    """
    cutadapt -q 20 -a AGATCGGAAGAGC -m 20 -o clean.fastq ${reads} > trim.log 2>&1
    """
}

process ALIGN {

    publishDir "results/03_align", mode: 'copy'

    input:
    path clean
    path index_files

    output:
    path "aligned_sorted.bam"

    script:
    """
    # Extract correct prefix INSIDE container
    prefix=\$(ls *.1.ht2 | sed 's/.1.ht2//')

    hisat2 -x \$prefix -U ${clean} -S aligned.sam > align.log 2>&1

    samtools view -bS aligned.sam > aligned.bam
    samtools sort aligned.bam -o aligned_sorted.bam
    samtools index aligned_sorted.bam
    """
}
process COUNT {

    publishDir "results/04_count", mode: 'copy'

    input:
    path bam
    path annotation

    output:
    path "counts.txt"

    script:
    """
    featureCounts -L -a ${annotation} -o counts.txt ${bam} > count.log 2>&1
    """
}
workflow {

    reads_ch = Channel.fromPath(params.reads)

    index_ch = Channel.fromPath("reference/genome_index*.ht2").collect()
    annotation_ch = Channel.fromPath("reference/annotation.gtf")

    qc_out   = QC(reads_ch)
    trim_out = TRIM(reads_ch)

    align_out = ALIGN(trim_out, index_ch)

    count_out = COUNT(align_out, annotation_ch)
}
