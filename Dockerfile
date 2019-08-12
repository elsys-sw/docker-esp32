    #The first thing we need to do is define from what image we want to build from.
    #Here we will use a 16.04 LTS(long term support) version of ubuntu from docker Hub :
    FROM ubuntu:16.04

    MAINTAINER Pedro Ferreira Mamede "pedroferreira.mamede at gmail"

    ARG DEBIAN_FRONTEND=noninteractive

    #RUN rm -rf /var/lib/apt/lists/*
    #RUN dpkg --add-architecture i386

    RUN apt-get update -q

    #install software requirements
    RUN apt-get install -y \
    git \
    wget \
    make \
    libtool \
    pkg-config \
    autoconf \
    automake \
    texinfo \
    libusb-1.0 \
    libusb-dev \
    libncurses-dev \
    libhidapi-dev \
    libftdi-dev \
    cmake \
    flex \
    bison \
    gperf \
    python \
    python-pip \
    python-serial
    RUN pip install --upgrade pip
    ENV LANG en_US.UTF-8

    #Install and configure esp-idf env
    RUN mkdir /esp
    WORKDIR /esp
    RUN git clone --recursive https://github.com/elsys-sw/esp-idf.git

    WORKDIR /esp/esp-idf
    RUN ./install.sh

    #RUN echo ". /esp/esp-idf/export.sh 1>/dev/null 2>&1" >> /root/.bashrc
    #RUN echo ". /esp/esp-idf/export.sh" >> /root/.bashrc
    #RUN echo "/esp/esp-idf/install.sh" >> /root/.bashrc
    RUN echo ". /esp/esp-idf/export.sh" >> /root/.bashrc
    RUN echo "echo Hello ESP-32 developer, have fun!" >> /root/.bashrc
    
    #Go to root work directory
    WORKDIR /esp
    RUN cd /esp

    EXPOSE 3333
