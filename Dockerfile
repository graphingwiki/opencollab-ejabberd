FROM centos:centos6

RUN yum -y update --exclude=filesystem && \
    yum -y install \
        gcc \
        gcc-c++ \
        rpmdevtools \
        tar \
        yum-utils

COPY erlang_solutions.asc /etc/pki/rpm-gpg/
COPY erlang_solutions.repo /etc/yum.repos.d/
RUN rpm --import /etc/pki/rpm-gpg/erlang_solutions.asc

WORKDIR /home/build
RUN mkdir -p rpmbuild/{BUILD,BUILDROOT,RPMS,SOURCES,SPECS,SRPMS}
COPY ejabberd.spec rpmbuild/SPECS/
COPY sources rpmbuild/SOURCES/
COPY build.sh ./
RUN useradd -m -s /bin/bash build && \
    chown -R build:build .

RUN spectool -C rpmbuild/SOURCES/ -g rpmbuild/SPECS/ejabberd.spec
RUN sed -n 's:^BuildRequires\: *\([^ ]*\).*:\1:p' rpmbuild/SPECS/ejabberd.spec | xargs yum -y install

CMD sh build.sh
