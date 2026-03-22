#!/bin/bash


minimap2   --secondary=no -t 40 -ax  map-hifi  HAUpekinT2T.fa  HiFi.fq.gz  | \
samtools view --threads 10 -T   ref.fa   -bS | samtools sort --threads 8 -m  3G -o  ref.sort.bam 
samtools index  -@ 20  ref.sort.bam

bwa mem -t  32 HAUpekinT2T.fa  NGS_1.fq.gz NGS_2.fq.gz | sambamba view -t 32 -S -f bam /dev/stdin | \ 
sambamba sort -t 32 --tmpdir=./ -o NGS.sorted.bam /dev/stdin