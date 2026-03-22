#!/bin/bash

####ONT with fast5 format data
nanopolish index -d  fast5_dir Nanopore.fq.gz
minimap2 -t 32 -a -x map-ont HAUpekinT2T.fa  Nanopore.fq.gz | \
         samtools sort -@ 32  -T ./ -o  sorted.bam
samtools index -@ 32 sorted.bam
nanopolish call-methylation -t 32 -r Nanopore.fq.gz -b sorted.bam -g HAUpekinT2T.fa  >methylation_calls.tsv
/nanopolish/scripts/calculate_methylation_frequency.py -c 2 methylation_calls.tsv >methylation_freq.tsv



#########hifi data
pbmm2 align --num-threads 32  --preset CCS --sample HAUpekinT2T  --log-level INFO \
       --sort  --sort-memory 100G  --unmapped HAUpekinT2T.fa  bam.fof HiFi.align.bam
/Pub/Software/Biosoft/pb-CpG-tools/bin/aligned_bam_to_cpg_scores --bam HiFi.align.bam --ref HAUpekinT2T.fa  \
        --output-prefix 02.HIFI/hifi_CpG --model /Pub/Software/Biosoft/pb-CpG-tools/models/pileup_calling_model.v1.tflite  \
        --threads 64 --min-mapq 20
