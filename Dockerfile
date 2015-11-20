FROM centos:centos6

RUN yum -y update
RUN yum -y install epel-release
RUN yum -y install wget git tar
RUN yum -y install https://packages.erlang-solutions.com/erlang-solutions-1.0-1.noarch.rpm
RUN yum -y install autoconf automake erlang expat-devel \
    fedora-usermgmt-devel gcc openssl-devel pam-devel patch \
    redhat-rpm-config rpm-build rpmdevtools yum-utils \
    libyaml-devel
RUN yum -y install gcc-c++

WORKDIR /root
RUN mkdir -p rpmbuild/{BUILD,BUILDROOT,RPMS,SOURCES,SPECS,SRPMS}
COPY ejabberd* rpmbuild/SOURCES/
COPY build.sh ./
VOLUME /output

CMD sh build.sh
