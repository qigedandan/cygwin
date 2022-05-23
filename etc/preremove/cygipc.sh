#!/bin/sh
prefix=/usr
for fn in ipc.h  ipctrace.h  msg.h  sem.h  shm.h ; do
  if [ -L ${prefix}/include/sys/${fn} ] ; then
    rm -f ${prefix}/include/sys/${fn}
  fi
done

