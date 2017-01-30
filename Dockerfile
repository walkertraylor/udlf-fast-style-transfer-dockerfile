# Install Ubuntu 14.04 with CUDA 8
FROM kaixhin/cuda-caffe:8.0

# Install pip, python, and nano
RUN sudo apt-get update && sudo apt-get -y upgrade
RUN sudo apt-get install -y python-pip \
    nano 
#python2.7.9

# Install virtualenv
RUN pip install virtualenv

# Clone fast-style-transfer GitHub repo
RUN cd /root/ && git clone https://github.com/lengstrom/fast-style-transfer.git

# Set working directory to fast-style-transfer
WORKDIR /root/fast-style-transfer

# Download rain princess checkpoint
RUN mkdir checkpoints && cd checkpoints && git clone https://github.com/thommiano/rain_princess_checkpoint.git

# Create a Python 2.7 environment in the style transfer directory 
# Note that this is not python 2.7.9, which was the version instructed to use.
RUN virtualenv -p python2.7 env 
RUN /bin/bash -c "source env/bin/activate \
    && pip install scipy pillow tensorflow-gpu"
