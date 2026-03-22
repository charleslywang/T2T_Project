#!/bin/bash

winnowmap -ax asm20 -t 256 -H -MD  HAUpekinT2T.fa ZJU1.0.fa  > PUR/align.sam
paftools.js sam2paf -p PUR/align.sam > PUR/out.paf

awk '{print $1"\t"1"\t"$2}' HAUpekinT2T.fa.fai  |sort -k1,1V -k2,2n > PUR/T2T.length
cat  PUR/out.paf |awk '{if ($12 > 0) print $6"\t"$8"\t"$9}' | sort -k1,1V -k2,2n | \
bedtools merge -i - |  bedtools merge -i - | ner/bedtools.sif bedtools complement -i - -g  PUR/T2T.length > PUR/T2T_To_Genome.PUR.region.bed