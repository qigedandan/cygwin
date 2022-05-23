/* $Id: shm.h,v 1.4 2001/09/19 03:30:43 cwilson Exp $ */

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
 
 
/*
 * v1.00	Philippe Chapuy, le 20/05/97
 */
#ifndef _CYGWIN_SHM_H_
#define _CYGWIN_SHM_H_

#include "ipc.h"

#ifdef __cplusplus
extern "C" {
#endif 

#define SHMMNI		128

struct vm_area_struct {

	int   pid ;
	int   fd  ;
	char *adr ;
} ;


struct shmid_ds {
	struct ipc_perm shm_perm;	/* operation perms */
	int	shm_segsz;		/* size of segment (bytes) */
	time_t	shm_atime;		/* last attach time */
	time_t	shm_dtime;		/* last detach time */
	time_t	shm_ctime;		/* last change time */
	unsigned short	shm_cpid;	/* pid of creator */
	unsigned short	shm_lpid;	/* pid of last operator */
	short	shm_nattch;		/* no. of current attaches */
	/* the following are private */
	unsigned short   shm_npages;	/* size of segment (pages) */
	unsigned long   *shm_pages;	/* array of ptrs to frames -> SHMMAX */ 
	struct vm_area_struct attaches[SHMMNI]; /* descriptors for attaches */
};

/* permission flag for shmget */
#define SHM_R		0400	/* or S_IRUGO from <stat.h> */
#define SHM_W		0200	/* or S_IWUGO from <stat.h> */

/* mode for attach */
#define	SHM_RDONLY	010000	/* read-only access */
#define	SHM_RND		020000	/* round attach address to SHMLBA boundary */
#define	SHM_REMAP	040000	/* take-over region on attach */

/* super user shmctl commands */
#define SHM_LOCK 	11
#define SHM_UNLOCK 	12

struct	shminfo {
    int shmmax;	
    int shmmin;	
    int shmmni;	
    int shmseg;	
    int shmall;	
};

/* shm_mode upper byte flags */
#define	SHM_DEST	01000	/* segment will be destroyed on last detach */
#define SHM_LOCKED      02000   /* segment will not be swapped */

/* ipcs ctl commands */
#define SHM_STAT 	13
#define SHM_INFO 	14
struct shm_info {
	int   used_ids;
	unsigned long shm_tot; /* total allocated shm */
	unsigned long shm_rss; /* total resident shm */
	unsigned long shm_swp; /* total swapped shm */
	unsigned long swap_attempts;
	unsigned long swap_successes;
};

int shmget (key_t key, int size, int flag);

#if SHMAT_LINUX

int shmat (int shmid, char *shmaddr, int shmflg, char **adr);
#warning Compiling LINUX-like shmat

#else

char *shmat (int shmid, char *shmaddr, int shmflg);

#endif

int shmdt (char *shmaddr);
int shmctl (int shmid, int cmd, struct shmid_ds *buf);

#ifdef __cplusplus
}
#endif 

#endif /* _CYGWIN_SHM_H_ */

