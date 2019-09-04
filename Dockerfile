FROM ubuntu:18.04
MAINTAINER gourytch

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && \
    apt-get install -y \
      autoconf \
      automake \
      autotools-dev \
      bsdmainutils \
      build-essential \
      git \
      libboost-chrono-dev \
      libboost-filesystem-dev \
      libboost-program-options-dev \
      libboost-system-dev \
      libboost-test-dev \
      libboost-thread-dev \
      libevent-dev \
      libgmp3-dev \
      libminiupnpc-dev \
      libssl1.0-dev \
      libtool \
      pkg-config \
      wget \
      zlib1g-dev

RUN mkdir -p /io

COPY build.sh /build.sh
RUN  chmod 0755 /build.sh

VOLUME [ "/io" ]
