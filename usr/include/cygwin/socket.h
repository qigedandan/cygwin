/* cygwin/socket.h

   Copyright 1999, 2000, 2001, 2005 Red Hat, Inc.

This file is part of Cygwin.

This software is a copyrighted work licensed under the terms of the
Cygwin license.  Please consult the file "CYGWIN_LICENSE" for
details. */

#ifndef _CYGWIN_SOCKET_H
#define _CYGWIN_SOCKET_H

#ifdef __cplusplus
extern "C" {
#endif /* __cplusplus */

#include <stdint.h>

/* Not unsigned for backward compatibility.  Keep #define for backward
   compatibility. */
#ifndef socklen_t
typedef int socklen_t;
#define socklen_t socklen_t
#endif

typedef uint16_t sa_family_t;

struct sockaddr {
  sa_family_t		sa_family;	/* address family, AF_xxx	*/
  char			sa_data[14];	/* 14 bytes of protocol address	*/
};

/* Definition of sockaddr_storage according to SUSv3. */
#define _SS_MAXSIZE 128			/* Maximum size. */
#define _SS_ALIGNSIZE (sizeof (int64_t))/* Desired alignment. */
#define _SS_PAD1SIZE (_SS_ALIGNSIZE - sizeof (sa_family_t))
#define _SS_PAD2SIZE (_SS_MAXSIZE - (sizeof (sa_family_t) \
		      + _SS_PAD1SIZE + _SS_ALIGNSIZE))

struct sockaddr_storage {
  sa_family_t		ss_family;
  char			_ss_pad1[_SS_PAD1SIZE];
  int64_t		__ss_align;
  char			_ss_pad2[_SS_PAD2SIZE];
};

#include <asm/socket.h>			/* arch-dependent defines	*/
#include <cygwin/sockios.h>		/* the SIOCxxx I/O controls	*/
#include <cygwin/uio.h>			/* iovec support		*/
#include <sys/types.h>

struct ucred {
  pid_t			pid;
  __uid32_t		uid;
  __gid32_t		gid;
};

struct linger {
  unsigned short	l_onoff;	/* Linger active	*/
  unsigned short	l_linger;	/* How long to linger for	*/
};

struct msghdr
{
  void *		msg_name;	/* Socket name			*/
  socklen_t		msg_namelen;	/* Length of name		*/
  struct iovec *	msg_iov;	/* Data blocks			*/
  int			msg_iovlen;	/* Number of blocks		*/
  void *		msg_control;	/* Ancillary data		*/
  socklen_t		msg_controllen;	/* Ancillary data buffer length	*/
  int			msg_flags;	/* Received flags on recvmsg	*/
};

struct cmsghdr
{
  socklen_t		cmsg_len;	/* Length of cmsghdr + data	*/
  int			cmsg_level;	/* Protocol			*/
  int			cmsg_type;	/* Protocol type		*/
};

#define CMSG_ALIGN(len) \
	(((len) + sizeof (size_t) - 1) & ~(sizeof (size_t) - 1))
#define CMSG_LEN(len) \
	(CMSG_ALIGN (sizeof (struct cmsghdr)) + (len))
#define CMSG_SPACE(len) \
	(CMSG_ALIGN (sizeof (struct cmsghdr)) + CMSG_ALIGN(len))
#define CMSG_FIRSTHDR(mhdr)	\
	({ \
	  struct msghdr *_m = (struct msghdr *) mhdr; \
	  (unsigned) (_m)->msg_controllen >= sizeof (struct cmsghdr) \
	  ? (struct cmsghdr *) (_m)->msg_control \
	  : (struct cmsghdr *) NULL; \
	})
#define CMSG_NXTHDR(mhdr,cmsg)	\
	({ \
	  struct msghdr *_m = (struct msghdr *) mhdr; \
	  struct cmsghdr *_c = (struct cmsghdr *) cmsg; \
	  ((char *) _c + CMSG_SPACE (_c->cmsg_len) \
	   > (char *) _m->msg_control + _m->msg_controllen) \
	  ? (struct cmsghdr *) NULL \
	  : (struct cmsghdr *) ((char *) _c + CMSG_ALIGN (_c->cmsg_len)); \
	})
#define CMSG_DATA(cmsg)		\
	((unsigned char *) ((struct cmsghdr *)(cmsg) + 1))

/* "Socket"-level control message types: */
#define	SCM_RIGHTS	0x01		/* access rights (array of int) */

#ifdef __INSIDE_CYGWIN__
/* Definition of struct msghdr up to release 1.5.18 */
struct OLD_msghdr
{
  void *		msg_name;	/* Socket name			*/
  int			msg_namelen;	/* Length of name		*/
  struct iovec *	msg_iov;	/* Data blocks			*/
  int			msg_iovlen;	/* Number of blocks		*/
  void *		msg_accrights;	/* Per protocol magic		*/
  					/* (eg BSD descriptor passing)	*/
  int			msg_accrightslen; /* Length of rights list	*/
};
#endif

/* Socket types. */
#define SOCK_STREAM	1		/* stream (connection) socket	*/
#define SOCK_DGRAM	2		/* datagram (conn.less) socket	*/
#define SOCK_RAW	3		/* raw socket			*/
#define SOCK_RDM	4		/* reliably-delivered message	*/
#define SOCK_SEQPACKET	5		/* sequential packet socket	*/

/* Supported address families. */
/*
 * Address families.
 */
#define AF_UNSPEC       0               /* unspecified */
#define AF_UNIX         1               /* local to host (pipes, portals) */
#define AF_LOCAL        1               /* POSIX name for AF_UNIX */
#define AF_INET         2               /* internetwork: UDP, TCP, etc. */
#define AF_IMPLINK      3               /* arpanet imp addresses */
#define AF_PUP          4               /* pup protocols: e.g. BSP */
#define AF_CHAOS        5               /* mit CHAOS protocols */
#define AF_NS           6               /* XEROX NS protocols */
#define AF_ISO          7               /* ISO protocols */
#define AF_OSI          AF_ISO          /* OSI is ISO */
#define AF_ECMA         8               /* european computer manufacturers */
#define AF_DATAKIT      9               /* datakit protocols */
#define AF_CCITT        10              /* CCITT protocols, X.25 etc */
#define AF_SNA          11              /* IBM SNA */
#define AF_DECnet       12              /* DECnet */
#define AF_DLI          13              /* Direct data link interface */
#define AF_LAT          14              /* LAT */
#define AF_HYLINK       15              /* NSC Hyperchannel */
#define AF_APPLETALK    16              /* AppleTalk */
#define AF_NETBIOS      17              /* NetBios-style addresses */
#if 0					/* Not yet */
#define AF_INET6        23              /* IP version 6 */
#endif

#define AF_MAX          32
/*
 * Protocol families, same as address families for now.
 */
#define PF_UNSPEC       AF_UNSPEC
#define PF_UNIX         AF_UNIX
#define PF_LOCAL        AF_LOCAL
#define PF_INET         AF_INET
#define PF_IMPLINK      AF_IMPLINK
#define PF_PUP          AF_PUP
#define PF_CHAOS        AF_CHAOS
#define PF_NS           AF_NS
#define PF_ISO          AF_ISO
#define PF_OSI          AF_OSI
#define PF_ECMA         AF_ECMA
#define PF_DATAKIT      AF_DATAKIT
#define PF_CCITT        AF_CCITT
#define PF_SNA          AF_SNA
#define PF_DECnet       AF_DECnet
#define PF_DLI          AF_DLI
#define PF_LAT          AF_LAT
#define PF_HYLINK       AF_HYLINK
#define PF_APPLETALK    AF_APPLETALK
#define PF_NETBIOS      AF_NETBIOS
#if 0
#define PF_INET6        AF_INET6
#endif

#define PF_MAX          AF_MAX

/* Maximum queue length specificable by listen.  */
#define SOMAXCONN       0x7fffffff

/* Flags we can use with send/ and recv. */
#define MSG_OOB         0x1             /* process out-of-band data */
#define MSG_PEEK        0x2             /* peek at incoming message */
#define MSG_DONTROUTE   0x4             /* send without using routing tables */
#define MSG_WINMASK     0x7             /* flags understood by WinSock calls */
#define MSG_NOSIGNAL    0x20            /* Don't raise SIGPIPE */
#define MSG_TRUNC       0x0100          /* Normal data truncated */
#define MSG_CTRUNC      0x0200          /* Control data truncated */

/* Setsockoptions(2) level. Thanks to BSD these must match IPPROTO_xxx */
#define SOL_IP		0
#define SOL_IPX		256
#define SOL_AX25	257
#define SOL_ATALK	258
#define	SOL_NETROM	259
#define SOL_TCP		6
#define SOL_UDP		17

/* IP options */
#ifndef IPTOS_LOWDELAY
#define	IPTOS_LOWDELAY		0x10
#define	IPTOS_THROUGHPUT	0x08
#define	IPTOS_RELIABILITY	0x04
#endif

/* These need to appear somewhere around here */
#define IP_DEFAULT_MULTICAST_TTL        1
#define IP_DEFAULT_MULTICAST_LOOP       1
#define IP_MAX_MEMBERSHIPS              20

/* IP options for use with getsockopt/setsockopt */
#define IP_OPTIONS			 1
#define IP_HDRINCL			 2
#define IP_TOS				 3
#define IP_TTL				 4
#define IP_MULTICAST_IF			 9
#define IP_MULTICAST_TTL		10
#define IP_MULTICAST_LOOP		11
#define IP_ADD_MEMBERSHIP		12
#define IP_DROP_MEMBERSHIP		13
#define IP_DONTFRAGMENT			14
#define IP_ADD_SOURCE_MEMBERSHIP        15
#define IP_DROP_SOURCE_MEMBERSHIP       16
#define IP_BLOCK_SOURCE                 17
#define IP_UNBLOCK_SOURCE               18
#define IP_PKTINFO                      19

/* Old WinSock1 values, needed internally */
#ifdef __INSIDE_CYGWIN__
#define _WS1_IP_OPTIONS          1
#define _WS1_IP_MULTICAST_IF     2
#define _WS1_IP_MULTICAST_TTL    3
#define _WS1_IP_MULTICAST_LOOP   4
#define _WS1_IP_ADD_MEMBERSHIP   5
#define _WS1_IP_DROP_MEMBERSHIP  6
#define _WS1_IP_TTL              7
#define _WS1_IP_TOS              8
#define _WS1_IP_DONTFRAGMENT     9
#endif

/* IPX options */
#define IPX_TYPE	1

/* TCP options - this way around because someone left a set in the c library includes */
#ifndef TCP_NODELAY
#define TCP_NODELAY     0x0001
#define TCP_MAXSEG	2
#endif

/* The various priorities. */
#define SOPRI_INTERACTIVE	0
#define SOPRI_NORMAL		1
#define SOPRI_BACKGROUND	2

#ifdef __cplusplus
};
#endif /* __cplusplus */

#endif /* _CYGWIN_SOCKET_H */
