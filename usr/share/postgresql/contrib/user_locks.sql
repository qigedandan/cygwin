-- user_locks.sql --
--
-- SQL code to define the user locks functions.
--
-- Copyright (c) 1998, Massimo Dal Zotto <dz@cs.unitn.it>
--
-- This file is distributed under the GNU General Public License
-- either version 2, or (at your option) any later version.

-- select user_lock(group,id,mode);
--
-- Adjust this setting to control where the objects get created.
SET search_path = public;

CREATE OR REPLACE FUNCTION user_lock(int4,int4,int4)
RETURNS int4
AS '$libdir/user_locks'
LANGUAGE C STRICT;

-- SELECT user_unlock(group,id,mode);
--
CREATE OR REPLACE FUNCTION user_unlock(int4,int4,int4)
RETURNS int4
AS '$libdir/user_locks'
LANGUAGE C STRICT;

-- SELECT user_write_lock(group,id);
--
CREATE OR REPLACE FUNCTION user_write_lock(int4,int4)
RETURNS int4
AS '$libdir/user_locks'
LANGUAGE C STRICT;

-- SELECT user_write_unlock(group,id);
--
CREATE OR REPLACE FUNCTION user_write_unlock(int4,int4)
RETURNS int4
AS '$libdir/user_locks'
LANGUAGE C STRICT;

-- SELECT user_write_lock(group,oid);
--
CREATE OR REPLACE FUNCTION user_write_lock(int4,oid)
RETURNS int4
AS '$libdir/user_locks'
LANGUAGE C STRICT;

-- SELECT user_write_unlock(group,oid);
--
CREATE OR REPLACE FUNCTION user_write_unlock(int4,oid)
RETURNS int4
AS '$libdir/user_locks'
LANGUAGE C STRICT;

-- SELECT user_write_lock_oid(oid);
--
CREATE OR REPLACE FUNCTION user_write_lock_oid(oid)
RETURNS int4
AS '$libdir/user_locks'
LANGUAGE C STRICT;

-- SELECT user_write_unlock_oid(oid);
--
CREATE OR REPLACE FUNCTION user_write_unlock_oid(oid)
RETURNS int4
AS '$libdir/user_locks'
LANGUAGE C STRICT;

-- SELECT user_write_lock_oid(int4);
--
CREATE OR REPLACE FUNCTION user_write_lock_oid(int4)
RETURNS int4
AS '$libdir/user_locks'
LANGUAGE C STRICT;

-- SELECT user_write_unlock_oid(int4);
--
CREATE OR REPLACE FUNCTION user_write_unlock_oid(int4)
RETURNS int4
AS '$libdir/user_locks'
LANGUAGE C STRICT;

-- SELECT user_unlock_all();
--
CREATE OR REPLACE FUNCTION user_unlock_all()
RETURNS int4
AS '$libdir/user_locks'
LANGUAGE C STRICT;
