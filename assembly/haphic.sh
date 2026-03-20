#!/bin/bash

bwa mem -5SP -t 28 initial_hifiasm.fa HIC_1.fq.gz HIC_2.fq.gz | \
          samblaster | \
          samtools view - -@ 14 -S -h -b -F 3340 -o HiC.bam


haphic pipeline  --correct_nrounds 2 --min_inflation 1.1 \
                --max_inflation 10 --bin_size 500 \ 
                       initial_hifiasm.fa HiC.bam 41 --Nx 100 --min_group_len 1

matlock  bam2 juicer HiC.bam out.nmd
sort -k2,2 -k6,6 out.nmd >out.sorted.nmd
run-assembly-visualizer.sh  -p false scaffolds.assembly out.sorted.nmd