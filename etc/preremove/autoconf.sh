bindir=/usr/bin

cd ${bindir}

for prog in autoconf autoheader autom4te autoreconf autoscan autoupdate ifnames
do
	rm -f ${prog}
done
