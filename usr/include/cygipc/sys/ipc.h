/* $Id: ipc.h,v 1.10 2003/05/21 03:01:32 cwilson Exp $ */

/*	
 *   IPC package for CygWin
 *
 *   Copyright (C) 1997 Philippe CHAPUY
 *   Copyright (C) 1998 Ludovic LANGE
 *
 *   This program is free software; you can redistribute it and/or modify
 *   it under the terms of the GNU General Public License as published by
 *   the Free Software Foundation; either version 2 of the License, or
 *   (at your option) any later version.
 *
 *   This program is distributed in the hope that it will be useful,
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *   GNU General Public License for more details.
 *
 *   You should have received a copy of the GNU General Public License
 *   along with this program; if not, write to the Free Software
 *   Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
 */

/*
 *   HISTORY:
 *   --------
 *
 *   13/05/1998 : Version 1.00 released
 *                First public release
 *                adress any comments to llange@capgemini.fr
 *
 */
 
 
#ifndef _CYGWIN_IPC_H
#define _CYGWIN_IPC_H

#include <sys/types.h>

#ifdef __cplusplus
extern "C" {
#endif 

/* this is a value that will _never_ be a valid key from ftok:
   for this to be -2, the filepath given to ftok() must have
   ALL of the following true:
    1) device_major = 255 (this is enough to guarantee key!=-2, right here)
    2) device_minor = 255
    3) the upper 18 bits of nFileInfoHigh must all be '1'
    4) the lower 22 bits of nFileInfoLow must all be '1'
   AND
    the id # passed to ftok() must be 254.
*/
#define IPC_PRIVATE ((key_t) -2)

struct ipc_perm
{
  key_t  key;
  ushort uid;   /* owner euid and egid */
  ushort gid;
  ushort cuid;  /* creator euid and egid */
  ushort cgid;
  ushort mode;  /* access modes see mode flags below */
  ushort seq;   /* sequence number */
};


/* resource get request flags */
#define IPC_CREAT  00001000   /* create if key is nonexistent */
#define IPC_EXCL   00002000   /* fail if key exists */
#define IPC_NOWAIT 00004000   /* return error on wait */


/* 
 * Control commands used with semctl, msgctl and shmctl 
 * see also specific commands in sem.h, msg.h and shm.h
 */
#define IPC_RMID 0     /* remove resource */
#define IPC_SET  1     /* set ipc_perm options */
#define IPC_STAT 2     /* get ipc_perm options */
#define IPC_INFO 3     /* see ipcs */


/* special shmsegs[id], msgque[id] or semary[id]  values */
#define IPC_UNUSED	((void *) -1)
#define IPC_NOID	((void *) -2)		/* being allocated/destroyed */

/* 
 * These are used to wrap system calls. See ipc/util.c.
 */
struct ipc_kludge {
    struct msgbuf *msgp;
    long msgtyp;
};

#define SEMOP	 	1
#define SEMGET 		2
#define SEMCTL 		3
#define MSGSND 		11
#define MSGRCV 		12
#define MSGGET 		13
#define MSGCTL 		14
#define SHMAT 		21
#define SHMDT 		22
#define SHMGET 		23
#define SHMCTL 		24

#define IPCCALL(version,op)	((version)<<16 | (op))

extern key_t ftok (const char *path, int id);

#ifdef __cplusplus
}
#endif 


#endif /* _CYGWIN_IPC_H */


