#!/bin/bash
tidk search --string ttaggg --window 10000 --output HAUpekinT2T.tolemere --dir ./ HAUpekinT2T.fa
tidk plot --tsv HAUpekinT2T.tolemere_telomeric_repeat_windows.tsv --output HAUpekinT2T.tolemere
