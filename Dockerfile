from pacifica/dispatcher-k8s

run pip install hundo snakemake
run mkdir /opt/qc_references
run curl -Lo /opt/qc_references/adapters.fa.gz https://github.com/pnnl/hundo/raw/master/example/qc_references/adapters.fa.gz
run curl -Lo /opt/qc_references/phix174.fa.gz https://github.com/pnnl/hundo/raw/master/example/qc_references/phix174.fa.gz
run git clone https://github.com/brwnj/fastq-multx /opt/fastq-multx
workdir /opt/fastq-multx
run make
workdir /data
copy run.sh /scripts.d/run
run chmod 0755 /scripts.d/run
