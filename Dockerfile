FROM centos:centos6

RUN yum -y update
RUN yum -y install gcc gcc-c++ rpmdevtools tar yum-utils
RUN yum -y install epel-release
RUN yum -y install https://packages.erlang-solutions.com/erlang-solutions-1.0-1.noarch.rpm

RUN useradd -m -s /bin/bash build

WORKDIR /home/build
RUN mkdir -p rpmbuild/{BUILD,BUILDROOT,RPMS,SOURCES,SPECS,SRPMS}
COPY ejabberd.spec rpmbuild/SPECS/
COPY sources rpmbuild/SOURCES/
COPY build.sh ./
RUN chown -R build:build .

CMD sh build.sh
