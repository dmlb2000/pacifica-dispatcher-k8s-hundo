#!/bin/bash -xe

mkdir -p upload/demultiplexed-correctnames
/opt/fastq-multx/fastq-multx \
  -B download/barcode-file.txt \
  download/Undetermined_S0_L001_I1_001.fastq \
  download/Undetermined_S0_L001_R1_001.fastq \
  download/Undetermined_S0_L001_R2_001.fastq \
  -o n/a \
  -o upload/demultiplexed-correctnames/%_R1.fastq \
  -o upload/demultiplexed-correctnames/%_R2.fastq

hundo annotate \
  --jobs 8 \
  --out-dir upload/ \
  --author "Pacifica Dispatcher K8S Hundo" \
  --threads 8 \
  --database-dir /path/to/reference_databases \
  -fa /opt/qc_references/adapters.fa.gz \
  -fc /opt/qc_references/phix174.fa.gz \
  -rd unite -ml 125 -km 4 -am -md 8 -ee 2.5 \
  upload/demultiplexed-correctnames/ \
  --no-conda
  --conda-prefix /path/to/hundo/example/mothur_sop_silva/.snakemake/conda