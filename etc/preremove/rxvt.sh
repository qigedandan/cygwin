#!/bin/sh -x

PATH=/bin
export PATH

prefix=/usr
sbindir=${prefix}/sbin
bindir=${prefix}/bin

manifest=/etc/preremove/rxvt-manifest.lst

[ -f ${manifest} ] || (echo "Unable to find manifest file" && exit 0)

while read f; do
    fSrc=/etc/defaults/${f}
    fDest=/${f}
    if [ -e ${fDest} -o -L ${fDest} ]; then
	/bin/rm ${fDest}
    fi
    if [ -e ${fSrc} -o -L ${fSrc} ] ; then
        /bin/rm -f ${fSrc}
    fi
done < ${manifest}

