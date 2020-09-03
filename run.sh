#!/bin/bash -xe

/opt/run-fastq-multx.sh

printf 'do_processing,False' > output_fastq_multx/kvp.csv

/opt/run-hundo.sh

printf 'do_processing,False' > output_hundo/kvp.csv
