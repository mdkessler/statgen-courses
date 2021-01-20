FROM gaow/base-notebook:1.0.0

MAINTAINER Diana Cornejo  <dmc2245@cumc.columbia.edu>
   
USER root

RUN R --slave -e 'remotes::install_github("stephenslab/susieR")' 

RUN mkdir -p /usr/local/lib/statgen

RUN echo "#!/bin/bash \n\
\n\
cd ~jovyan \n\
\n\
if [ ! -f .firstrun ] ; then \n\
  curl -fsSL https://raw.githubusercontent.com/statgenetics/statgen-courses/master/handout/finemapping.pdf -o finemapping.pdf \n\
  curl -fsSL https://raw.githubusercontent.com/statgenetics/statgen-courses/master/notebooks/finemapping.ipynb -o finemapping.ipynb \n\
  jupyter nbconvert --ClearOutputPreprocessor.enabled=True --inplace finemapping.ipynb \n\
\n\
  chown -R jovyan.jovyan ~jovyan \n\
\n\
  touch .firstrun \n\
fi \n\
" > /usr/local/lib/statgen/boot.sh

RUN chmod 0755 /usr/local/lib/statgen/boot.sh

ENTRYPOINT ["/usr/local/lib/statgen/boot.sh"]

USER jovyan
