FROM centos:centos7

RUN yum -y update && \
    yum -y install epel-release && \
    yum -y install gcc gcc-c++ make rpm-build yum-utils && \
    yum-builddep --enablerepo=epel-testing -y ejabberd

RUN useradd -m -s /bin/sh build
WORKDIR /home/build
RUN yumdownloader --enablerepo=epel-testing-source --source ejabberd
COPY build.sh *.patch ./
RUN chown -R build:build .

USER build
CMD sh build.sh
