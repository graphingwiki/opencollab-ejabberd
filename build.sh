#!/bin/sh

cd ./rpmbuild/SPECS
runuser build -c "rpmbuild -bs ejabberd.spec"

cd ../SRPMS
yum-builddep -y *.src.rpm
runuser build -c "rpmbuild --rebuild *.src.rpm"

mkdir /output && cp *.src.rpm ../RPMS/*/*.rpm /output
