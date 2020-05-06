FROM nvidia/cuda:10.1-cudnn7-devel-ubuntu18.04

ARG python=3.7
ENV PYTHON_VERSION=${python}

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y \
      # essential
      build-essential \
      cmake \
      ffmpeg \
      g++-4.8 \
      git \
      curl \
      docker.io \
      vim \
      wget \
      unzip \
      ca-certificates \
      htop \
      libjpeg-dev \
      libpng-dev \
      libavdevice-dev \
      pkg-config \
      # python
      python${PYTHON_VERSION} \
      python${PYTHON_VERSION}-dev \
      python3-tk \
      python${PYTHON_VERSION}-distutils \
      # opencv
      python3-opencv \
      # opengl
      python3-opengl \
      mesa-utils \
      # openmpi
      libopenmpi-dev \
    # set python
    && ln -sf /usr/bin/python${PYTHON_VERSION} /usr/bin/python \
    && ln -sf /usr/bin/python${PYTHON_VERSION} /usr/bin/python3 \
    && rm -rf /var/lib/apt/lists/*

# Get pip.
RUN curl -O https://bootstrap.pypa.io/get-pip.py && \
    python get-pip.py && \
    rm get-pip.py

# Copy and install package
ARG WORKSPACE
COPY . ${WORKSPACE}
WORKDIR ${WORKSPACE}
# RUN python setup.py build develop
RUN pip install -e .

# Upgrade numpy
RUN pip install -U numpy

# Upgrade torch
RUN pip install -U torch torchvision
