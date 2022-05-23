/* $Id: ipctrace.h,v 1.3 2001/09/19 03:22:26 cwilson Exp $ */

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

#ifndef _IPCTRACE_H
#define _IPCTRACE_H

#ifdef __cplusplus
extern "C" {
#endif 

extern int cygipc_get_debug(void);
extern void cygipc_set_debug(int new_val);
extern int cygipc_tracing_enabled(void);

typedef int (*err_handlerP)(FILE *, int, const char *, ... );
extern err_handlerP cygipc_get_err_handler(void);
extern void cygipc_set_err_handler(err_handlerP new_val);

#ifdef TRACE
/* #define debug_printf(fmt, args...) system_printf(fmt , ## args) */
#define debug_printf(fmt, args...) err_handler(stderr , LOG_DEBUG , fmt , ## args)
#else
#define debug_printf(fmt, args...)
#endif

#ifdef __cplusplus
}
#endif 

#endif /*_IPCTRACE_H */    
	
