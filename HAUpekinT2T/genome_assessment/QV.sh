#!/bin/bash

meryl k=21 threads=128 memory=500g  count NGS_1.fq.gz output fq1.meryl
meryl k=21 threads=128 memory=500g  count NGS_2.fq.gz output fq2.meryl

 meryl union-sum output k21.meryl fq*.meryl