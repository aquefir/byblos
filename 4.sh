
/bin/echo -n 'Downloading GCC 4.7.4... ';
curl -fsSL https://ftpmirror.gnu.org/gnu/gcc/gcc-4.7.4/gcc-4.7.4.tar.bz2 > gcc.tar.bz2;
/bin/echo 'done.';
if test "$(sha256sum gcc.tar.bz2 | sed 's/\s.*$//')" != 92e61c6dc3a0a449e62d72a38185fda550168a86702dea07125ebd3ec3996282; then
	/bin/echo 'ERROR: sha256 checksum does not match!';
	/bin/echo 'Exiting...';
	exit 127;
fi
/bin/echo -n 'Unpacking the tarball... ';
tar -xf gcc.tar.bz2;
/bin/echo 'done.';
/bin/echo -n 'Downloading GMP 4.3.2... ';
curl -fsSL https://ftpmirror.gnu.org/gnu/gmp/gmp-4.3.2.tar.bz2 > gmp.tar.bz2;
/bin/echo 'done.';
if test "$(sha256sum gmp.tar.bz2 | sed 's/\s.*$//')" != 936162c0312886c21581002b79932829aa048cfaf9937c6265aeaa14f1cd1775; then
	/bin/echo 'ERROR: sha256 checksum does not match!';
	/bin/echo 'Exiting...';
	exit 127;
fi
/bin/echo -n 'Downloading MPC 1.0.1... ';
curl -fsSL https://ftpmirror.gnu.org/gnu/mpc/mpc-1.0.1.tar.gz > mpc.tar.gz;
/bin/echo 'done.';
if test "$(sha256sum mpc.tar.gz | sed 's/\s.*$//')" != ed5a815cfea525dc778df0cb37468b9c1b554aaf30d9328b1431ca705b7400ff; then
	/bin/echo 'ERROR: sha256 checksum does not match!';
	/bin/echo 'Exiting...';
	exit 127;
fi
/bin/echo -n 'Downloading MPFR 2.4.2... ';
curl -fsSL https://ftpmirror.gnu.org/gnu/mpfr/mpfr-2.4.2.tar.bz2 > mpfr.tar.gz;
/bin/echo 'done.';
if test "$(sha256sum mpfr.tar.gz | sed 's/\s.*$//')" != c7e75a08a8d49d2082e4caee1591a05d11b9d5627514e678f02d66a124bcf2ba; then
	/bin/echo 'ERROR: sha256 checksum does not match!';
	/bin/echo 'Exiting...';
	exit 127;
fi
/bin/echo -n 'Copying GMP, MPC and MPFR sources into GCC source directory... ';
cd gcc-* || exit 127;
tar -xf ../gmp.tar.bz2;
mv gmp-* gmp;
tar -xf ../mpc.tar.gz;
mv mpc-* mpc;
tar -xf ../mpfr.tar.gz;
mv mpfr-* mpfr;
cd .. || exit 127;
/bin/echo 'done.';
/bin/echo -n 'Configuring the build with autotools... ';
mkdir gcc.build;
cd gcc.build || exit 127;
../gcc-*/configure --prefix=/tmp/gnuproto --disable-bootstrap --disable-build-with-cxx --disable-build-poststage1-with-cxx --enable-lto --enable-stage1-languages=c,c++ --disable-stage1-checking --enable-werror CC=/tmp/tccproto/bin/tcc CFLAGS='-w' LD=/tmp/tccproto/bin/tcc;
