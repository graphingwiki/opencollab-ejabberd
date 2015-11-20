cd ~/rpmbuild/SOURCES
spectool -g ejabberd.spec
mv ejabberd.spec ~/rpmbuild/SPECS
cd ~/rpmbuild/SPECS
rpmbuild -ba ejabberd.spec
cp ~/rpmbuild/RPMS/*/*.rpm /output
