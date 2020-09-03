#!/bin/bash -xe

for zip_file in `find download -name '*.gz'` ; do
  gunzip $zip_file
done
mkdir -p output_fastq_multx
/opt/fastq-multx/fastq-multx \
  -B download/barcodes.txt \
  download/Undetermined_S0_L001_I1_001.fastq \
  download/Undetermined_S0_L001_R1_001.fastq \
  download/Undetermined_S0_L001_R2_001.fastq \
  -o n/a \
  -o output_fastq_multx/%_R1.fastq \
  -o output_fastq_multx/%_R2.fastq

mkdir output_fastq_multx/unmatched_datasets
mv output_fastq_multx/unmatched*.fastq output_fastq_multx/unmatched_datasets/
for output_file in output_fastq_multx/*.fastq ; do
  if [[ $(stat -c '%s' $output_file) == 0 ]] ; then
    mv $output_file output_fastq_multx/unmatched_datasets/
  fi
done