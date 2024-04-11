#!/bin/bash

module load trimmomatic

trimmomatic PE -phred33 -threads 8 SRR21972968_1.fastq.gz SRR21972968_2.fastq.gz \
SRR21972968_1_paired_trimmed.fastq.gz SRR21972968_1_unpaired_trimmed.fastq.gz \
SRR21972968_2_paired_trimmed.fastq.gz SRR21972968_2_unpaired_trimmed.fastq.gz \
ILLUMINACLIP:${HPC_TRIMMOMATIC_ADAPTER}/TruSeq3-PE.fa:2:30:10 \
LEADING:3 TRAILING:3 SLIDINGWINDOW:4:20 MINLEN:75

trimmomatic PE -phred33 -threads 16 SRR21972971_1.fastq.gz SRR21972971_2.fastq.gz \
SRR21972971_1_paired_trimmed.fastq.gz SRR21972971_1_unpaired_trimmed.fastq.gz \
SRR21972971_2_paired_trimmed.fastq.gz SRR21972971_2_unpaired_trimmed.fastq.gz \
ILLUMINACLIP:${HPC_TRIMMOMATIC_ADAPTER}/TruSeq3-PE.fa:2:30:10 \
LEADING:3 TRAILING:3 SLIDINGWINDOW:4:20 MINLEN:75

trimmomatic PE -phred33 -threads 16 SRR21972974_1.fastq.gz SRR21972974_2.fastq.gz \
SRR21972974_1_paired_trimmed.fastq.gz SRR21972974_1_unpaired_trimmed.fastq.gz \
SRR21972974_2_paired_trimmed.fastq.gz SRR21972974_2_unpaired_trimmed.fastq.gz \
ILLUMINACLIP:${HPC_TRIMMOMATIC_ADAPTER}/TruSeq3-PE.fa:2:30:10 \
LEADING:3 TRAILING:3 SLIDINGWINDOW:4:20 MINLEN:75

trimmomatic PE -phred33 -threads 16 SRR21972977_1.fastq.gz SRR21972977_2.fastq.gz \
SRR21972977_1_paired_trimmed.fastq.gz SRR21972977_1_unpaired_trimmed.fastq.gz \
SRR21972977_2_paired_trimmed.fastq.gz SRR21972977_2_unpaired_trimmed.fastq.gz \
ILLUMINACLIP:${HPC_TRIMMOMATIC_ADAPTER}/TruSeq3-PE.fa:2:30:10 \
LEADING:3 TRAILING:3 SLIDINGWINDOW:4:20 MINLEN:75

