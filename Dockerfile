FROM nvidia/cuda:11.8.0-runtime-ubuntu22.04

ARG DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends \
apt-utils \
software-properties-common \
sudo \
wget \
python3-pip \
python3.10-venv \
libglib2.0-0 \
libsm6 \
libgl1 \
libxrender1 \
libxext6 \
ffmpeg \
git \
nano \
curl \
psmisc \
pkg-config \
libcairo2-dev \
pkg-config \
python3-dev \
build-essential \
google-perftools

RUN pip install wheel gdown pycairo

WORKDIR /usr/local/bin/
RUN git clone https://github.com/AUTOMATIC1111/stable-diffusion-webui.git

WORKDIR /usr/local/bin/stable-diffusion-webui

RUN python3 -m venv .

ENV PATH="/usr/local/bin/stable-diffusion-webui/venv/bin:$PATH"
ENV PATH="/usr/local/bin/stable-diffusion-webui:$PATH"

ADD install.py .
RUN python3 -m install --skip-torch-cuda-test

RUN sudo apt-get clean && sudo rm -rf /var/lib/apt/lists/* && \
    sudo bash -c 'echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen' && \
    sudo apt-get update

WORKDIR /root
ADD onstart.sh .
RUN chmod +x onstart.sh

RUN useradd -m -s /bin/bash webui && \
    usermod -aG sudo webui && \
    chown -R webui:webui /home/webui && \
    echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
   
RUN chown -R webui:webui /usr/local/bin/stable-diffusion-webui
