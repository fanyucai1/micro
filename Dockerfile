FROM fanyucai1/biobase:latest
RUN Rscript -e "BiocManager::install(\"dada2\")"
RUN Rscript -e "BiocManager::install(\"phyloseq\")"
RUN Rscript -e "install.packages(\"reshape2\", dependencies=TRUE)"
COPY *.gz /software/
COPY *.zip /software/
COPY *.bz2 /software/
COPY *.rpm /software/
RUN cd /software/ && R CMD INSTALL RDPutils_1.2.3.tar.gz
COPY usearch11.0.667_i86linux32 /software/
COPY uchime4.2.40_i86linux32 /software/
COPY FastTree /software/
RUN cd /software/ && chmod 777 uchime4.2.40_i86linux32 usearch11.0.667_i86linux32 FastTree
RUN ln -s /software/uchime4.2.40_i86linux32 /usr/bin/uchime && ln -s /software/usearch11.0.667_i86linux32 /usr/bin/usearch && ln -s /software/FastTree /usr/bin/FastTree
RUN cd /software/ && tar xzvf FLASH-1.2.11-Linux-x86_64.tar.gz && tar xzvf ncbi-blast-2.13.0+-x64-linux.tar.gz
RUN ln -s /software/FLASH-1.2.11-Linux-x86_64/flash /usr/bin/flash
RUN cd /software/ && ln -s /software/ncbi-blast-2.13.0+/bin/* /usr/bin/
RUN cd /software/ && unzip seq_crumbs-0.1.9.zip && cd seq_crumbs-0.1.9 && python setup.py install && mv bin/* /usr/bin/
COPY picard.jar /software/
RUN chmod 777 /software/picard.jar
RUN cd /software/ && tar xjvf bwa-0.7.17.tar.bz2 && cd bwa-0.7.17 && make && ln -s /software/bwa-0.7.17/bwa /usr/bin/bwa
RUN cd /software/ && unzip 16sPIP-master.zip && chmod 777 16sPIP-master/bin/*
COPY 16sPIP.sh /software/16sPIP-master/bin/
RUN cd /software/16sPIP-master/db && tar xzvf 16S-completeBlastdb.tar.gz && unzip 16S-completeBwadb1.zip && unzip 16S-completeBwadb2.zip && unzip 16S-completeBwadb3.zip && tar -zvxf pathogensDB.tar.gz
RUN yum install -y enscript ghostscript
RUN cd /software/ && rpm -ivh mafft-7.490-gcc_fc6.x86_64.rpm
RUN cd /software/ && tar xzvf hmmer-3.3.1.tar.gz && cd hmmer-3.3.1 && ./configure && make install
RUN cd /software/ && tar xzvf Metaxa2_2.2.3.tar.gz && chmod 777 /software/Metaxa2_2.2.3/metaxa2*
RUN cd /software/ && yum install -y libtool-ltdl && rpm -ivh pandaseq-lib-2.11-1.fc20.x86_64.rpm && rpm -ivh pandaseq-2.11-1.fc20.x86_64.rpm
RUN cd /software/ && tar xjvf samtools-1.15.1.tar.bz2 && cd samtools-1.15.1 && ./configure && make && make install
RUN cd /software/ && tar xjvf minimap2-2.24.tar.bz2 && cd minimap2-2.24 && make && ln -s /software/minimap2-2.24/minimap2 /usr/bin/minimap2
RUN cd /software/ && tar xzvf quast-5.0.2.tar.gz
COPY freebayes-1.3.6-linux-amd64-static /usr/bin/freebayes
RUN cd /software/ && tar xzvf iqtree-2.2.0-Linux.tar.gz && ln -s /software/iqtree-2.2.0-Linux/bin/iqtree2 /usr/bin/iqtree2
RUN cd /software/ && tar xzvf iqtree-1.6.12-Linux.tar.gz && ln -s /software/iqtree-1.6.12-Linux/bin/iqtree /usr/bin/iqtree
COPY faToVcf /usr/bin/
RUN cd /software/ && tar xjvf htslib-1.15.1.tar.bz2 && cd htslib-1.15.1/ && ./configure --prefix=/software/htslib-v1.15.1/ && make && make install
RUN yum install -y automake && cd /software && tar xzvf v1.3.1.tar.gz && cd ivar-1.3.1/ && ./autogen.sh && ./configure --with-hts=/software/htslib-v1.15.1/ && make && make install
COPY fastv /usr/bin/
RUN cd /software/ && tar xzvf prinseq-lite-0.20.4.tar.gz
COPY gofasta-linux-amd64 /usr/bin/gofasta
RUN cd /software && yum install -y htslib bcftools
RUN ln -s /software/python3/Python-v3.7.0/bin/python3 /usr/bin/python3
RUN cp -r /software/htslib-v1.15.1/lib/* /usr/lib64/
RUN rm -rf /software/*gz /software/*unzip /software/Metaxa2_2.2.3/metaxa2_db/*  /software/*rpm /software/*bz2
