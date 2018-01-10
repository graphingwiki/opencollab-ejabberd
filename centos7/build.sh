#!/bin/sh

set -e
umask 022

rpm -iv *.src.rpm
patch -p0 < ejabberd-spec.patch
cp ejabberd-collab.patch rpmbuild/SOURCES/

cd rpmbuild/SPECS
rpmbuild -bs ejabberd.spec

cd ../SRPMS
rpmbuild --rebuild *.src.rpm

cd ../..
mkdir output
mv rpmbuild/RPMS/*/*.rpm output/
mv rpmbuild/SRPMS/*.src.rpm output/
