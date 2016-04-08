FROM centos:centos6

RUN yum -y update --exclude=filesystem && \
    yum -y install epel-release && \
    yum -y install \
        gcc \
        gcc-c++ \
        rpmdevtools \
        tar \
        yum-utils \
    && \
    yum clean all

COPY erlang_solutions.asc /etc/pki/rpm-gpg/
COPY erlang_solutions.repo /etc/yum.repos.d/
RUN rpm --import /etc/pki/rpm-gpg/erlang_solutions.asc

RUN useradd -m -s /bin/bash build

WORKDIR /home/build
RUN mkdir -p rpmbuild/{BUILD,BUILDROOT,RPMS,SOURCES,SPECS,SRPMS}
COPY ejabberd.spec rpmbuild/SPECS/
COPY sources rpmbuild/SOURCES/
COPY build.sh ./
RUN chown -R build:build .

CMD sh build.sh
