FROM gaow/base-notebook:1.0.0

MAINTAINER Diana Cornejo <dmc2245@cumc.columbia.edu>

# GEMINI installer needs anaconda 2 environment; only python 2.7 is not enough
# Also install vt for VCF decomposition, VEP for annotation

USER root

RUN conda create --name py2 python=2.7 && \
    bash -c "source activate py2 && conda install --yes -c conda-forge -c bioconda gemini=0.30.2-0 vt=2015.11.10 variant-effect-predictor=87-0"

#Download datafiles 
#Update the exercise handout

USER jovyan

RUN curl -fsSL http://statgen.us/files/gemini-tutorial-data.tar.bz2 -o gemini.tar.bz2 && tar jxvf gemini.tar.bz2 && rm -f gemini.tar.bz2

RUN echo "source activate py2" >> $HOME/.bashrc

RUN mkdir -p $HOME/.gemini $HOME/annotation_db && echo "annotation_dir: $HOME/annotation_db" > $HOME/.gemini/gemini-config.yaml

RUN printf "This folder is meant for gemini annotation resource databases,\nas is configured in ~/.gemini/gemini-config.yaml\nThese annotations were used along with VCF files as input to generate the database files in the tutorial.\n" > $HOME/annotation_db/README.md

ARG DUMMY=unknown

RUN wget  https://raw.githubusercontent.com/statgenetics/statgen-courses/master/handout/Gemini.docx
