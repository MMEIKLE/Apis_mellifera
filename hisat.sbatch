#!/bin/bash
#SBATCH --job-name=Hisat2
#SBATCH --mail-type=END,FAIL
#SBATCH --mail-user=<USER_EMAIL>
#SBATCH --nodes=1
#SBATCH --ntasks=8
#SBATCH --mem=6gb
#SBATCH --time=02:30:00
#SBATCH --output=hisat_align%j.log

cd /blue/mcb4934/share/makenzie.meikle/FinalProject

#Building hisat index
module load hisat2

hisat2-build -f ncbi_dataset/data/GCA_003254395.2/GCF_003254395.2_Amel_HAv3.1_genomic.fna A_mellifera_RefSeq

#Alignment to reference
hisat2 -p 8 -x A_mellifera_RefSeq -1 SRR21972968_1_paired_trimmed.fastq.gz -2 SRR21972968_2_paired_trimmed.fastq.gz -S Amel_68.sam

hisat2 -p 8 -x A_mellifera_RefSeq -1 SRR21972971_1_paired_trimmed.fastq.gz -2 SRR21972971_2_paired_trimmed.fastq.gz -S Amel_71.sam

hisat2 -p 8 -x A_mellifera_RefSeq -1 SRR21972974_1_paired_trimmed.fastq.gz -2 SRR21972974_2_paired_trimmed.fastq.gz -S Amel_74.sam

hisat2 -p 8 -x A_mellifera_RefSeq -1 SRR21972977_1_paired_trimmed.fastq.gz -2 SRR21972977_2_paired_trimmed.fastq.gz -S Amel_77.sam

#Walltime ~90% accurate
#Mem efficiency ~10% only needed ~750MB max
