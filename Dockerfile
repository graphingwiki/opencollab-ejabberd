FROM centos:centos6

RUN yum -y install epel-release && \
    yum -y install wget https://packages.erlang-solutions.com/erlang-solutions-1.0-1.noarch.rpm && \
    yum -y update --exclude=filesystem && \
    yum -y install \
        gcc \
        gcc-c++ \
        rpmdevtools \
        tar \
        yum-utils \
    && \
    yum clean all

RUN useradd -m -s /bin/bash build

WORKDIR /home/build
RUN mkdir -p rpmbuild/{BUILD,BUILDROOT,RPMS,SOURCES,SPECS,SRPMS}
COPY ejabberd.spec rpmbuild/SPECS/
COPY sources rpmbuild/SOURCES/
COPY build.sh ./
RUN chown -R build:build .

CMD sh build.sh
