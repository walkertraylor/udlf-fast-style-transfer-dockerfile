# Install Ubuntu 14.04 with CUDA 8
FROM kaixhin/cuda-caffe:8.0

# Install Ubuntu 16.04, CUDA 8 and cudnn 5, and miniconda3
#FROM  nvidia/cuda:8.0-cudnn5-runtime-ubuntu16.04
FROM continuumio/miniconda3

RUN apt-get update && apt-get install -y sudo 

# Install wget and build-essential
#RUN apt-get update && apt-get install -y \
#    build-essential \
#    wget

# Install pip, python, and nano
RUN sudo apt-get update && sudo apt-get -y upgrade
RUN sudo apt-get install -y python-pip \
    nano \
    unzip

# Install virtualenv
#RUN pip install virtualenv

# Clone fast-style-transfer GitHub repo
RUN cd /root/ && git clone https://github.com/lengstrom/fast-style-transfer.git

# Set working directory to fast-style-transfer
WORKDIR /root/fast-style-transfer

# Download rain princess checkpoint
RUN git clone https://github.com/thommiano/udlf_fst_checkpoints.git

# Create a Python 2.7 environment in the style transfer directory 
# Note that this is not python 2.7.9, which was the version instructed to use.
#RUN virtualenv -p python2.7 env 
#RUN /bin/bash -c "source env/bin/activate \
#    && pip install scipy pillow tensorflow-gpu ffmpeg-normalize"

# Build Anaconda environment
RUN conda create -n style-transfer python=2.7.9
RUN /bin/bash -c "source activate style-transfer \
    && conda install -c conda-forge tensorflow=0.11.0 \
    && conda install scipy pillow"

# Run setup.py to extract training code
RUN cd /root/fast-style-transfer/ && sudo ./setup.sh
