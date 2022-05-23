/* $Id: sem.h,v 1.6 2001/11/26 23:41:33 cwilson Exp $ */

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
 
 
#ifndef _CYGWIN_SEM_H
#define _CYGWIN_SEM_H

#include "ipc.h"
#include <stdarg.h>

#ifdef __cplusplus
extern "C" {
#endif 

/* semop flags */
#define SEM_UNDO        0x1000  /* undo the operation on exit */

/* semctl Command Definitions. */
#define GETPID  11       /* get sempid */
#define GETVAL  12       /* get semval */
#define GETALL  13       /* get all semval's */
#define GETNCNT 14       /* get semncnt */
#define GETZCNT 15       /* get semzcnt */
#define SETVAL  16       /* set semval */
#define SETALL  17       /* set all semval's */

/* One semid data structure for each set of semaphores in the system. */
struct semid_ds {
  struct ipc_perm sem_perm;            /* permissions .. see ipc.h */
  time_t          sem_otime;           /* last semop time */
  time_t          sem_ctime;           /* last change time */
  struct sem      *sem_base;           /* ptr to first semaphore in array */
  struct sem_undo *undo;	       /* undo requests on this array */
  ushort          sem_nsems;           /* no. of semaphores in array */
};

/* semop system calls takes an array of these. */
struct sembuf {
  ushort  sem_num;        /* semaphore index in array */
  short   sem_op;         /* semaphore operation */
  short   sem_flg;        /* operation flags */
};

struct  seminfo {
    int semmap;
    int semmni;
    int semmns;
    int semmnu;
    int semmsl;
    int semopm;
    int semume;
    int semusz;
    int semvmx;
    int semaem;
};

#define SEMMNI  128             /* ?  max # of semaphore identifiers */
#define SEMMSL  32              /* <= 512 max num of semaphores per id */
#define SEMMNS  (SEMMNI*SEMMSL) /* ? max # of semaphores in system */
#define SEMOPM  32	        /* ~ 100 max num of ops per semop call */
#define SEMVMX  32767           /* semaphore maximum value */

/* unused */
#define SEMUME  SEMOPM          /* max num of undo entries per process */
#define SEMMNU  SEMMNS          /* num of undo structures system wide */
#define SEMAEM  (SEMVMX >> 1)   /* adjust on exit max value */
#define SEMMAP  SEMMNS          /* # of entries in semaphore map */
#define SEMUSZ  20		/* sizeof struct sem_undo */

/* One semaphore structure for each semaphore in the system. */
struct sem {
  short   semval;         /* current value */
  short   sempid;         /* pid of last operation */
};

/* ipcs ctl cmds */
#define SEM_STAT 18
#define SEM_INFO 19

extern int semget (key_t key, int nsems, int semflg);
extern int semop (int semid, struct sembuf *sops, unsigned nsops);
extern int semctl (int semid, int semnum, int cmd, ... );

#ifdef __cplusplus
}
#endif 

#endif /* _CYGWIN_SEM_H */
