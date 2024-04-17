FROM nvidia/cuda:11.0.3-base-ubuntu20.04
ENV DEBIAN_FRONTEND=noninteractive
RUN apt update && \
    apt install -y build-essential && \
    apt install -y git && \
    apt install -y wget && \
    apt install -y software-properties-common

# Install Conda
ENV CONDA_DIR=/opt/conda
RUN wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh && \
    /bin/bash ~/miniconda.sh -b -p /opt/conda
ENV PATH=$CONDA_DIR/bin:$PATH

# Install Sumo
RUN add-apt-repository ppa:sumo/stable && \
    apt update && \
    apt install -y sumo sumo-tools sumo-doc
ENV SUMO_HOME=/usr/share/sumo
ENV LIBSUMO_AS_TRACI=1

# Create Python Environment
COPY requirements.txt ./
RUN conda create -y -n sumo-rl python=3.8
SHELL ["conda", "run", "-n", "sumo-rl", "/bin/bash", "-c"]
RUN pip install -r requirements.txt -f https://data.pyg.org/whl/torch-2.2.1+cu121.html
ENTRYPOINT ["conda", "run", "--no-capture-output", "-n", "sumo-rl", "/bin/bash"]