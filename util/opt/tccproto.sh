#!/bin/sh
#

oldcwd="$PWD";
cd /tmp;
test -d tccproto && rm -rf tccproto;
mkdir tccproto;
curl -fsSL https://download.savannah.gnu.org/releases/tinycc/tcc-0.9.27.tar.bz2 > tcc.tar.bz2;
tar -xf tcc.tar.bz2;
cd tcc-* || exit 127;
./configure --prefix=/tmp/tccproto --cc=gcc --extra-cflags='-O3 -w -Werror=date-time -frandom-seed=0 -pipe -fstack-protector-strong -fno-plt' --extra-ldflags='-fPIE -Wl,--build-id=none' --strip-binaries;
make -j"$(nproc)";
make install;
if test "$(sha256sum /tmp/tccproto/bin/tcc | sed 's/\s.*$//')" != 27d9df237133dda8ef6360a7170dc4d5cc3b6f71351862ef5670c73ddd088d05; then
	echo 'ERROR: sha256 checksum of the TCC binary does not match!';
	echo 'Exiting...';
	exit 127;
fi
cd .. || exit 127;
tarlz -9hpcn 512 --anonymous tccproto > "$oldcwd/tccproto.tar.lz";
rm -rf tccproto tcc.tar.bz2 tcc-*;
cd "$oldcwd";
