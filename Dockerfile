FROM nvidia/cuda:11.8.0-runtime-ubuntu22.04

ARG DEBIAN_FRONTEND noninteractive

RUN bash -c 'echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen'

WORKDIR /root
ADD onstart.sh .
RUN chmod +x onstart.sh

RUN apt-get update && apt-get install -y --no-install-recommends \
    apt-utils \
    software-properties-common \
    sudo \
    wget \
    python3-pip \
    python3.10-venv \
    python3-dev \
    libglib2.0-0 \
    libsm6 \
    libgl1 \
    libxrender1 \
    libxext6 \
    libgl1-mesa-glx \
    ffmpeg \
    git \
    nano \
    curl \
    psmisc \
    pkg-config \
    libcairo2-dev \
    pkg-config \
    build-essential \
    google-perftools \
    deborphan

RUN pip install gdown
    
RUN apt-get autoremove --purge && \
    deborphan | xargs sudo apt-get -y remove --purge && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* 

ARG USER="webui"
RUN useradd -m -g sudo -s /bin/bash $USER && \
    echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
    
USER $USER

ARG USER_HOME="/home/$USER"
ARG WEBUI_ACTIVATION_DIR="$USER_HOME/stable-diffusion-webui/venv/bin"

WORKDIR $USER_HOME
RUN git clone https://github.com/AUTOMATIC1111/stable-diffusion-webui.git

WORKDIR $USER_HOME/stable-diffusion-webui

RUN mkdir venv && \
    python3 -m venv venv

RUN . $WEBUI_ACTIVATION_DIR/activate && \
    python3 -m pip install --upgrade pip && \
    pip install wheel pycairo

ADD install.py .
RUN . $WEBUI_ACTIVATION_DIR/activate && \
    python3 install.py --skip-torch-cuda-test && \
    pip cache purge
    
# create the root dir and switch to it
ARG INVOKEAI_ROOT="$USER_HOME/invokeai"
RUN mkdir $INVOKEAI_ROOT

# Create the invokeai venv
WORKDIR $INVOKEAI_ROOT
RUN python3 -m venv .venv --prompt InvokeAI

# make sure the latest version of pip is installed inside the venv
RUN . .venv/bin/activate && \
    python3 -m pip install --upgrade pip && \
    pip install xformers==0.0.16rc425 && \
    pip install triton && \
    pip install "InvokeAI[xformers]" --use-pep517 --extra-index-url https://download.pytorch.org/whl/cu117 && \
    pip cache purge

# remove wheel cache
RUN rm -rf $USER_HOME/.cache/pip/wheels/*
    
EXPOSE 9090
EXPOSE 7860
