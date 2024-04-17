#!/bin/bash
#SBATCH --job-name=Read_Counts
#SBATCH --mail-type=END,FAIL
#SBATCH --mail-user=<USER_EMAIL>
#SBATCH --nodes=1
#SBATCH --ntasks=8
#SBATCH --mem=1gb
#SBATCH --time=24:00:00
#SBATCH --output=Read_counts%j.log

cd /blue/mcb4934/share/makenzie.meikle/FinalProject

#Convert sam to bam and sort!
#This is roughly a ~6hr process per sample if using full read counts. 
#For practice with this pipeline it may be wise to sample ~1-2M reads from the sam files before conversion to bam

module load samtools

samtools view -bS Amel_68.sam > Amel_68.bam
samtools view -bS Amel_71.sam > Amel_71.bam
samtools view -bS Amel_74.sam > Amel_74.bam
samtools view -bS Amel_77.sam > Amel_77.bam

samtools sort -n -o Amel_68_sorted.bam Amel_68.bam
samtools sort -n -o Amel_71_sorted.bam Amel_71.bam
samtools sort -n -o Amel_74_sorted.bam Amel_74.bam
samtools sort -n -o Amel_77_sorted.bam Amel_77.bam

#Annotate and count reads for genes

module load htseq

htseq-count -f bam -m intersection-nonempty -s no -t gene -i ID \
-o Amel_68_counts Amel_68_sorted.bam \
genomic.gff > Amel_68_gene_summary.txt

htseq-count -f bam -m intersection-nonempty -s no -t gene -i ID \
-o Amel_71_counts Amel_71_sorted.bam \
genomic.gff > Amel_71_gene_summary.txt

htseq-count -f bam -m intersection-nonempty -s no -t gene -i ID \
-o Amel_74_counts Amel_74_sorted.bam \
genomic.gff > Amel_74_gene_summary.txt

htseq-count -f bam -m intersection-nonempty -s no -t gene -i ID \
-o Amel_77_counts Amel_77_sorted.bam \
genomic.gff > Amel_77_gene_summary.txt
