SET search_path = public;

BEGIN;

create function set_limit(float4)
returns float4
AS '$libdir/pg_trgm'
LANGUAGE 'C' with (isstrict,iscachable);

create function show_limit()
returns float4
AS '$libdir/pg_trgm'
LANGUAGE 'C' with (isstrict,iscachable);

create function show_trgm(text)
returns _text
AS '$libdir/pg_trgm'
LANGUAGE 'C' with (isstrict,iscachable);

create function similarity(text,text)
returns float4
AS '$libdir/pg_trgm'
LANGUAGE 'C' with (isstrict,iscachable);

create function similarity_op(text,text)
returns bool
AS '$libdir/pg_trgm'
LANGUAGE 'C' with (isstrict,iscachable);

CREATE OPERATOR % (
        LEFTARG = text,
        RIGHTARG = text,
        PROCEDURE = similarity_op,
        COMMUTATOR = '%',
        RESTRICT = contsel,
        JOIN = contjoinsel
);

--gist key
CREATE FUNCTION gtrgm_in(cstring)
RETURNS gtrgm
AS '$libdir/pg_trgm'
LANGUAGE 'C' with (isstrict);

CREATE FUNCTION gtrgm_out(gtrgm)
RETURNS cstring
AS '$libdir/pg_trgm'
LANGUAGE 'C' with (isstrict);

CREATE TYPE gtrgm (
        INTERNALLENGTH = -1,
        INPUT = gtrgm_in,
        OUTPUT = gtrgm_out
);

-- support functions
CREATE FUNCTION gtrgm_consistent(gtrgm,internal,int4)
RETURNS bool
AS '$libdir/pg_trgm'
LANGUAGE 'C';
 
CREATE FUNCTION gtrgm_compress(internal)
RETURNS internal
AS '$libdir/pg_trgm'
LANGUAGE 'C';

CREATE FUNCTION gtrgm_decompress(internal)
RETURNS internal
AS '$libdir/pg_trgm'
LANGUAGE 'C';

CREATE FUNCTION gtrgm_penalty(internal,internal,internal)
RETURNS internal
AS '$libdir/pg_trgm'
LANGUAGE 'C' with (isstrict);

CREATE FUNCTION gtrgm_picksplit(internal, internal)
RETURNS internal
AS '$libdir/pg_trgm'
LANGUAGE 'C';

CREATE FUNCTION gtrgm_union(bytea, internal)
RETURNS _int4
AS '$libdir/pg_trgm'
LANGUAGE 'C';

CREATE FUNCTION gtrgm_same(gtrgm, gtrgm, internal)
RETURNS internal
AS '$libdir/pg_trgm'
LANGUAGE 'C';

-- create the operator class
CREATE OPERATOR CLASS gist_trgm_ops
FOR TYPE text USING gist
AS
        OPERATOR        1       % (text, text),
        FUNCTION        1       gtrgm_consistent (gtrgm, internal, int4),
        FUNCTION        2       gtrgm_union (bytea, internal),
        FUNCTION        3       gtrgm_compress (internal),
        FUNCTION        4       gtrgm_decompress (internal),
        FUNCTION        5       gtrgm_penalty (internal, internal, internal),
        FUNCTION        6       gtrgm_picksplit (internal, internal),
        FUNCTION        7       gtrgm_same (gtrgm, gtrgm, internal),
        STORAGE         gtrgm;


COMMIT;
