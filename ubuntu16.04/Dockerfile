FROM ubuntu:16.04

RUN apt-get update && \
    apt-get -y install build-essential devscripts && \
    apt-get -y build-dep ejabberd

RUN useradd -m -s /bin/sh build
WORKDIR /home/build
RUN apt-get source ejabberd
COPY build.sh *.patch ./
RUN chown -R build:build .

USER build
CMD sh build.sh
