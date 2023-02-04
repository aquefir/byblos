
/bin/echo -n 'Downloading GNU Make... ';
curl -fsSL https://ftpmirror.gnu.org/gnu/make/make-3.82.tar.bz2 > make.tar.bz2;
/bin/echo 'done.';
if test "$(sha256sum make.tar.bz2 | sed 's/\s.*$//')" != e2c1a73f179c40c71e2fe8abf8a8a0688b8499538512984da4a76958d0402966; then
	/bin/echo 'ERROR: sha256 checksum does not match!';
	/bin/echo 'Exiting...';
	exit 127;
fi
/bin/echo -n 'Unpacking the tarball... ';
tar -xf make.tar.bz2;
/bin/echo 'done.';
/bin/echo -n 'Configuring the build with autotools... ';
cd make-* || exit 127;
./configure --prefix=/tmp/gnuproto --disable-dependency-tracking --disable-nls CC=/tmp/tccproto/bin/tcc CFLAGS='-w' LD=/tmp/tccproto/bin/tcc 1>/dev/null 2>&1;
/bin/echo 'done.';
/bin/echo -n 'Applying glibc glob patch... ';
sed -ie '210,212d;231,232d' glob/glob.c;
/bin/echo 'done.';
/bin/echo -n 'Building GNU Make using generated shell script... ';
. build.sh 1>/dev/null;
/bin/echo 'done.';
/bin/echo -n 'Installing GNU Make into /tmp/gnuproto... ';
./make install;
/bin/echo 'done.';
/bin/echo -n 'Cleaning up... ';
rm -rf make-* make.tar.bz2;
/bin/echo 'done.';
