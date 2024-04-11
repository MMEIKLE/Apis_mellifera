#!/bin/bash

module load sra

fasterq-dump --threads 8 --progress SRR21972968
fasterq-dump --threads 8 --progress SRR21972971
fasterq-dump --threads 8 --progress SRR21972974
fasterq-dump --threads 8 --progress SRR21972977

gzip *fastq
