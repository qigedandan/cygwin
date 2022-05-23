CREATE FUNCTION database_size (name) RETURNS bigint
    AS '$libdir/dbsize', 'database_size'
    LANGUAGE C STRICT;

CREATE FUNCTION relation_size (text) RETURNS bigint
    AS '$libdir/dbsize', 'relation_size'
    LANGUAGE C STRICT;

CREATE FUNCTION pg_tablespace_size(oid) RETURNS bigint
    AS '$libdir/dbsize', 'pg_tablespace_size'
    LANGUAGE C STRICT;

CREATE FUNCTION pg_database_size(oid) RETURNS bigint
    AS '$libdir/dbsize', 'pg_database_size'
    LANGUAGE C STRICT;

CREATE FUNCTION pg_relation_size(oid) RETURNS bigint
    AS '$libdir/dbsize', 'pg_relation_size'
    LANGUAGE C STRICT;

CREATE FUNCTION pg_size_pretty(bigint) RETURNS text
    AS '$libdir/dbsize', 'pg_size_pretty'
    LANGUAGE C STRICT;
