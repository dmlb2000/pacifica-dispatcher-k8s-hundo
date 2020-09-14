#!/bin/bash -xe

export PATH=/opt/bbmap:/opt/ncbi-blast-2.9.0+/bin:$PATH
ITS_ARGS=""
# this tries to pull the Description column which should be
# either 16s or its
if awk -F, '{ print $8 }' download/*/SampleSheet.csv | grep -i ITS ; then
  ITS_ARGS="-rd unite"
fi

hundo annotate \
  --jobs 8 \
  --out-dir output_hundo/ \
  --author "Pacifica Dispatcher K8S Hundo" \
  --threads 8 \
  --database-dir output_fastq_multx/reference_databases \
  -fa /opt/qc_references/adapters.fa.gz \
  -fc /opt/qc_references/phix174.fa.gz \
  $ITS_ARGS \
  -ml 125 -km 4 -am -md 8 -ee 2.5 \
  output_fastq_multx/ \
  --no-conda
