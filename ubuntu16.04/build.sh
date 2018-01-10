#!/bin/sh

set -e
umask 022

EJABBERD="ejabberd-16.01"

cp ejabberd-collab.patch ${EJABBERD}/debian/patches/
echo ejabberd-collab.patch >> ${EJABBERD}/debian/patches/series

cd ${EJABBERD}
debchange --local collab "Rebuild with collab patches"
dpkg-buildpackage

cd ..
mkdir output
mv ejabberd_*collab* output/
