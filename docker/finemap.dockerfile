FROM gaow/base-notebook:1.0.0

MAINTAINER Diana Cornejo  <dmc2245@cumc.columbia.edu>
   
USER root

RUN R --slave -e 'remotes::install_github("stephenslab/susieR")' 

RUN echo "#!/bin/bash \n\
\n\
cd ~jovyan \n\
\n\
curl -fsSL https://raw.githubusercontent.com/statgenetics/statgen-courses/master/handout/finemapping.pdf -o finemapping.pdf \n\
\n\
chown -R jovyan.jovyan ~jovyan \n\
\n\
rm $(readlink -f $0)\n\
" > boot.sh

RUN chmod 0755 boot.sh

ENTRYPOINT ["/root/boot.sh"]

    
USER jovyan

# Download notebook script and clean up output in the notebook
ARG DUMMY=unknown
RUN DUMMY=${DUMMY} curl -fsSL https://raw.githubusercontent.com/statgenetics/statgen-courses/master/notebooks/finemapping.ipynb -o finemapping.ipynb
RUN jupyter nbconvert --ClearOutputPreprocessor.enabled=True --inplace finemapping.ipynb



