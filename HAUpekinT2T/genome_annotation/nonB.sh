#!/bin/bash

gfa -seq HAUpekinT2T -out nonB/genome

Rscript /Pub/Software/Biosoft/Quadron-master/Quadron_cmd.R  HAUpekinT2T.fa nonB/G4.txt