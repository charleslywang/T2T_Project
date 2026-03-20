#!/bin/bash



hifiasm -o initial_hifiasm -t 32  --ul Nanopore.fq.gz --h1 HiC_1.fq.gz --h2 HiC_2 HiFi.fq.gz

nextDenovo run.cfg

flye --nano-raw Nanopore.fq.gz --out-dir initial_flye --threads 32
