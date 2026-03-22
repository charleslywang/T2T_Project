#!/bin/bash 

LTR_FINDER_parallel -harvest_out -seq HAUpekinT2T.fa -t 128

BuildDatabase -name HAUpekinT2T_db HAUpekinT2T.fa
RepeatModeler -database HAUpekinT2T_db -pa 60 -LTRStruct

DeepTE.py  -d ./working_dir/ -o ./output_dir/ -i db.fa -sp M -m_dir m_dir/Metazoans_model


RepeatMasker -e rmblast -pa 30 -gff -a -lib db_repbase.deepte.fa -dir output HAUpekinT2T.fa