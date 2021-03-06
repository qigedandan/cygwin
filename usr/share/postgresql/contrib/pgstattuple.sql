-- Adjust this setting to control where the objects get created.
SET search_path = public;

CREATE TYPE pgstattuple_type AS (
	table_len BIGINT,		-- physical table length in bytes
	tuple_count BIGINT,		-- number of live tuples
	tuple_len BIGINT,		-- total tuples length in bytes
	tuple_percent FLOAT,		-- live tuples in %
	dead_tuple_count BIGINT,	-- number of dead tuples
	dead_tuple_len BIGINT,		-- total dead tuples length in bytes
	dead_tuple_percent FLOAT,	-- dead tuples in %
	free_space BIGINT,		-- free space in bytes
	free_percent FLOAT		-- free space in %
);

CREATE OR REPLACE FUNCTION pgstattuple(text)
RETURNS pgstattuple_type
AS '$libdir/pgstattuple', 'pgstattuple'
LANGUAGE 'C' STRICT;

CREATE OR REPLACE FUNCTION pgstattuple(oid)
RETURNS pgstattuple_type
AS '$libdir/pgstattuple', 'pgstattuplebyid'
LANGUAGE 'C' STRICT;
