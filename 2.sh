
## Download the prototypal TCC for bootstrapping proper TCC and then GCC.

/bin/echo -n 'Downloading the prototypal TCC for bootstrapping... ';
curl -fsSL https://byblos.tohoku.ac/tccproto.tar.lz > tccproto.tar.lz;
plzip -cd tccproto.tar.lz | tar -xf -;
test -d /tmp/tccproto && rm -rf /tmp/tccproto;
mv tccproto /tmp/tccproto;
if test "$(sha256sum /tmp/tccproto/bin/tcc | sed 's/\s.*$//')" != 27d9df237133dda8ef6360a7170dc4d5cc3b6f71351862ef5670c73ddd088d05; then
	/bin/echo 'ERROR: sha256 checksum of the TCC binary does not match!';
	/bin/echo 'Exiting...';
	exit 127;
fi
/bin/echo 'done.';
