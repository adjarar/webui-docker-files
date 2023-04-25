FROM ubuntu:jammy

ARG DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends \
apt-utils \
software-properties-common \
sudo \
python3-pip \
python3.10-venv \
libglib2.0-0 \
libsm6 \
libgl1 \
libxrender1 \
libxext6 \
git \
ffmpeg \
wget \
curl \
nano \
psmisc

RUN pip install gdown

RUN useradd -m -s /bin/bash webui && \
    usermod -aG sudo webui && \
    chown -R webui:webui /home/webui && \
    echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

USER webui
WORKDIR /home/webui

RUN git clone https://github.com/adjarar/stable-diffusion-webui.git
WORKDIR /home/webui/stable-diffusion-webui

RUN python3 -m venv /home/webui/stable-diffusion-webui/venv
ENV PATH="/home/webui/stable-diffusion-webui/venv/bin:$PATH"

ADD install.py .
RUN python3 -m install --skip-torch-cuda-test

RUN sudo apt-get clean && sudo rm -rf /var/lib/apt/lists/* && \
    sudo bash -c 'echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen' && \
    sudo apt-get update

USER root
WORKDIR /root

ADD onstart.sh .
RUN chmod +x onstart.sh
