FROM continuumio/miniconda:4.5.4
MAINTAINER Pablo Prieto <pablo@lifebit.ai>
LABEL authors="pablo@lifebit.ai" \
      description="Docker image containing Beagle5 Conda package"

RUN apt-get update && apt-get install -y procps && apt-get clean -y 
RUN conda install conda=4.6.7

COPY environment.yml /
RUN conda env create -f /environment.yml && conda clean -a
ENV PATH /opt/conda/envs/beagle5/bin:$PATH

RUN mkdir -p /opt/beagle.28Sep18.793/share  && cd /opt/beagle.28Sep18.793/share && \
	wget http://faculty.washington.edu/browning/beagle/beagle.28Sep18.793.jar -O beagle.jar && \
        wget https://faculty.washington.edu/browning/beagle/unbref3.28Sep18.793.jar -O unbref3.jar

COPY ./beagle.sh /opt/beagle.28Sep18.793/share/beagle

RUN chmod +x /opt/beagle.28Sep18.793/share/beagle

ENV PATH /opt/beagle.28Sep18.793/share:$PATH
