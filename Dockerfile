from python:3.6

run mkdir /data /scripts.d /etc/pacifica-cli
run apt-get update && \
    apt-get -y install software-properties-common vim && \
    apt-add-repository 'deb http://security.debian.org/debian-security stretch/updates main' && \
    apt-get update && \
    apt-get install -y openjdk-8-jdk zip unzip libblas3 liblapack3 libblas-dev liblapack-dev gfortran
run pip install numpy==1.16.2 cython
run pip install hundo click pyyaml 'snakemake>=5.1.4' pandas==0.24.2 biopython==1.74 scipy==1.3.1 plotly relatively 'biom-format>=2.1.0'
run pip freeze
run curl -L https://ftp.ncbi.nlm.nih.gov/blast/executables/blast+/2.9.0/ncbi-blast-2.9.0+-x64-linux.tar.gz | tar -C /opt -xzf -
run git clone https://github.com/GSLBiotech/mafft.git /opt/mafft
workdir /opt/mafft/core
run make install
workdir /data
run curl -L https://github.com/torognes/vsearch/archive/v2.6.2.tar.gz | tar -C /opt -xzf -
workdir /opt/vsearch-2.6.2
run ./autogen.sh && \
    ./configure && \
    make install
workdir /data
run curl -o /usr/local/bin/FastTreeMP http://www.microbesonline.org/fasttree/FastTreeMP
run chmod +x /usr/local/bin/FastTreeMP
run curl -L https://versaweb.dl.sourceforge.net/project/bbmap/BBMap_37.17.tar.gz | tar -C /opt -xzf -
workdir /opt/bbmap
workdir /data
run mkdir /opt/qc_references
run curl -Lo /opt/qc_references/adapters.fa.gz https://github.com/pnnl/hundo/raw/master/example/qc_references/adapters.fa.gz
run curl -Lo /opt/qc_references/phix174.fa.gz https://github.com/pnnl/hundo/raw/master/example/qc_references/phix174.fa.gz
run git clone https://github.com/brwnj/fastq-multx /opt/fastq-multx
workdir /opt/fastq-multx
run make
workdir /data
run pip install git+https://github.com/pacifica/pacifica-dispatcher-k8s.git@v0.4.1 future pacifica-cli
copy uploader.json /data/uploader.json
copy run-fastq-multx.sh /opt/run-fastq-multx.sh
copy run-hundo.sh /opt/run-hundo.sh
copy run.sh /scripts.d/run
run mkdir /etc/pacifica-dispatcher-k8s
copy config.ini /etc/pacifica-dispatcher-k8s/config.ini
run chmod 0755 /scripts.d/run /opt/run-fastq-multx.sh /opt/run-hundo.sh
expose 8069
entrypoint pacifica-dispatcher-k8s
