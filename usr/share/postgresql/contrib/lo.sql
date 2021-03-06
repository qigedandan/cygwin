--
--	PostgreSQL code for LargeObjects
--
--	$PostgreSQL: pgsql/contrib/lo/lo.sql.in,v 1.11.4.1 2005/01/29 22:35:17 tgl Exp $
--
--
--	Create the data type
--

-- used by the lo type, it takes an oid and returns an lo object

-- Adjust this setting to control where the objects get created.
SET search_path = public;

CREATE FUNCTION lo_in(cstring)
RETURNS lo
AS '$libdir/lo'
LANGUAGE C IMMUTABLE STRICT;

-- used by the lo type, it returns the oid of the object
CREATE FUNCTION lo_out(lo)
RETURNS cstring
AS '$libdir/lo'
LANGUAGE C IMMUTABLE STRICT;

-- finally the type itself
CREATE TYPE lo (
	INTERNALLENGTH = 4,
	EXTERNALLENGTH = variable,
	INPUT = lo_in,
	OUTPUT = lo_out
);

-- this returns the oid associated with a lo object
CREATE FUNCTION lo_oid(lo)
RETURNS oid
AS '$libdir/lo'
LANGUAGE C IMMUTABLE STRICT;

-- same function, named to allow it to be used as a type coercion, eg:
--    CREATE TABLE a (image lo);
--    SELECT image::oid FROM a;
--
CREATE FUNCTION oid(lo)
RETURNS oid
AS '$libdir/lo', 'lo_oid'
LANGUAGE C IMMUTABLE STRICT;
CREATE CAST (lo as oid) WITH FUNCTION oid(lo) AS IMPLICIT;

-- this allows us to convert an oid to a managed lo object
-- ie: insert into test values (lo_import('/fullpath/file')::lo);
CREATE FUNCTION lo(oid)
RETURNS lo
AS '$libdir/lo'
LANGUAGE C IMMUTABLE STRICT;
CREATE CAST (oid as lo) WITH FUNCTION lo(oid) AS IMPLICIT;

-- This is used in triggers
CREATE FUNCTION lo_manage()
RETURNS trigger
AS '$libdir/lo'
LANGUAGE C;
