-- misc_utils.sql --
--
-- SQL code to define misc functions.
--
-- Copyright (c) 1998, Massimo Dal Zotto <dz@cs.unitn.it>
--
-- This file is distributed under the GNU General Public License
-- either version 2, or (at your option) any later version.

-- Return the pid of the backend.
--

-- Adjust this setting to control where the objects get created.
SET search_path = public;

CREATE OR REPLACE FUNCTION backend_pid()
RETURNS int4
AS '$libdir/misc_utils'
LANGUAGE 'C';

-- Unlisten from a relation.
--
CREATE OR REPLACE FUNCTION "unlisten"(name)
RETURNS int4
AS '$libdir/misc_utils'
LANGUAGE 'C';

-- Unlisten from all relations for this backend.
--
CREATE OR REPLACE FUNCTION "unlisten"()
RETURNS int4
AS 'SELECT "unlisten"(''*'')'
LANGUAGE 'SQL';

-- min(x,y)
--
CREATE OR REPLACE FUNCTION min(int4,int4)
RETURNS int4
AS '$libdir/misc_utils', 'int4min'
LANGUAGE 'C' STRICT;

-- max(x,y)
--
CREATE OR REPLACE FUNCTION max(int4,int4)
RETURNS int4
AS '$libdir/misc_utils', 'int4max'
LANGUAGE 'C' STRICT;

-- Return the number of active listeners on a relation
--
CREATE OR REPLACE FUNCTION active_listeners(text)
RETURNS int4
AS '$libdir/misc_utils'
LANGUAGE 'C';
