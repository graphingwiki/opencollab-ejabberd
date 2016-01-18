cd ./rpmbuild/SPECS
runuser build -c "spectool -C ../SOURCES -g ejabberd.spec"
runuser build -c "rpmbuild -bs ejabberd.spec"

cd ../SRPMS
yum-builddep -y *.src.rpm
runuser build -c "rpmbuild --rebuild *.src.rpm"

test -d /output && \
    cp *.src.rpm ../RPMS/*/*.rpm /output
