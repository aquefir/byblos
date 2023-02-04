
## Create SDK user and folder hierarchy.

/bin/echo -n 'Creating user for permissions hierarchy... ';
useradd -rMs /bin/false byblos;
usermod -L byblos;
/bin/echo 'done.';
/bin/echo -n 'Creating sysroot at /opt/byblos... ';
if test -d /opt/byblos; then
	echo '';
	echo 'Error: /opt/byblos already exists. Exiting...';
	exit 127;
fi
mkdir /opt/byblos;
mkdir /opt/byblos/bin;
mkdir /opt/byblos/include;
mkdir /opt/byblos/lib;
mkdir /opt/byblos/libexec;
mkdir /opt/byblos/share;
mkdir /opt/byblos/share/doc;
mkdir /opt/byblos/share/info;
mkdir /opt/byblos/share/locale;
mkdir /opt/byblos/share/man;
/bin/echo 'done.';
