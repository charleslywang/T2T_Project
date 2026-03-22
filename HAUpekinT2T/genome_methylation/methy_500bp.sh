#/bin/bash 

 bedtools makewindows -g HAUpekinT2T.fai -w 500 > 500bp.bed
###ONT 
grep -v ^chro methylation_freq.tsv | \
awk '{a[$1"__"$2]+=$5;b[$1"__"$2]+=$6}END{for(i in a){print i"\t"a[i]"\t"b[i]}}' | \
sed 's/__/ /' | awk '{print $1"\t"$2"\t"$2"\t"$3"\t"$4}' > methy.tsv

 bedtools map  -c 4,5 -o sum -a 500bp.bed -b methy.sort.freq | \
  awk '$4 > 20'  | awk '{OFS="\t"; print $1"\t"$2"\t"$3"\t"$5/$4}' > ONT.methy.finally.bed 

#####HiFi
awk '{print $1"\t"$2"\t"$3"\t"$6"\t"$7}' hifi_CpG.combined.bed  | \
sort -k1,1V -k2,2n > hifi_CpG.filter.bed
bedtools map  -c 4,5 -o sum -a 500bp.bed -b hifi_CpG.filter.bed  | awk '$4 >20' | \ 
awk '{OFS="\t"; print $1"\t"$2"\t"$3"\t"$5/$4}' > hifi.methy.finally.bed