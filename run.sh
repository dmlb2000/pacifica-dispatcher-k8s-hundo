#!/bin/bash -xe

mkdir -p output_hundo
(
    /opt/run-fastq-multx.sh
    printf 'do_processing,False' > output_fastq_multx/kvp.csv
    /opt/run-hundo.sh
    printf 'do_processing,False' > output_hundo/kvp.csv
) > output_hundo/script-output.log 2>&1
