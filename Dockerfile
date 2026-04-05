FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt install -y \
    fastqc \
    cutadapt \
    hisat2 \
    samtools \
    subread \
    wget \
    unzip \
    default-jre \
    && apt clean

WORKDIR /data
