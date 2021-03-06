-- Adjust this setting to control where the objects get created.
SET search_path = public;

-- TXTIDX type

CREATE FUNCTION txtidx_in(cstring)
RETURNS txtidx
AS '$libdir/tsearch'
LANGUAGE 'C' with (isstrict);

CREATE FUNCTION txtidx_out(txtidx)
RETURNS cstring
AS '$libdir/tsearch'
LANGUAGE 'C' with (isstrict);

CREATE TYPE txtidx (
	INTERNALLENGTH = -1,
	INPUT = txtidx_in,
	OUTPUT = txtidx_out,
	STORAGE = extended
);

CREATE FUNCTION txt2txtidx(text)
RETURNS txtidx
AS '$libdir/tsearch'
LANGUAGE 'C' with (isstrict);

CREATE FUNCTION txtidxsize(txtidx)
RETURNS int4
AS '$libdir/tsearch'
LANGUAGE 'C' with (isstrict);

--QUERYTYPES
--without morphology
CREATE FUNCTION qtxt_in(cstring)
RETURNS query_txt
AS '$libdir/tsearch'
LANGUAGE 'C' with (isstrict);

CREATE FUNCTION qtxt_out(query_txt)
RETURNS cstring
AS '$libdir/tsearch'
LANGUAGE 'C' with (isstrict);

CREATE TYPE query_txt (
	INTERNALLENGTH = -1,
	INPUT = qtxt_in,
	OUTPUT = qtxt_out
);

--with morphology
CREATE FUNCTION mqtxt_in(cstring)
RETURNS mquery_txt
AS '$libdir/tsearch'
LANGUAGE 'C' with (isstrict);

--same C output function as for query_txt
CREATE FUNCTION mqtxt_out(mquery_txt)
RETURNS cstring
AS '$libdir/tsearch', 'qtxt_out'
LANGUAGE 'C' with (isstrict);

CREATE TYPE mquery_txt (
	INTERNALLENGTH = -1,
	INPUT = mqtxt_in,
	OUTPUT = mqtxt_out
);

--only for debug
CREATE FUNCTION querytree(query_txt)
RETURNS text
AS '$libdir/tsearch'
LANGUAGE 'C' with (isstrict);

CREATE FUNCTION querytree(mquery_txt)
RETURNS text
AS '$libdir/tsearch'
LANGUAGE 'C' with (isstrict);

--operations
CREATE FUNCTION execqtxt(txtidx, query_txt)
RETURNS bool
AS '$libdir/tsearch'
LANGUAGE 'C' with (isstrict);

COMMENT ON FUNCTION execqtxt(txtidx, query_txt) IS 'boolean operation with text index';

CREATE FUNCTION execqtxt(txtidx, mquery_txt)
RETURNS bool
AS '$libdir/tsearch'
LANGUAGE 'C' with (isstrict);

COMMENT ON FUNCTION execqtxt(txtidx, mquery_txt) IS 'boolean operation with text index';

CREATE FUNCTION rexecqtxt(query_txt, txtidx)
RETURNS bool
AS '$libdir/tsearch'
LANGUAGE 'C' with (isstrict);

COMMENT ON FUNCTION rexecqtxt(query_txt, txtidx) IS 'boolean operation with text index';

CREATE FUNCTION rexecqtxt(mquery_txt, txtidx)
RETURNS bool
AS '$libdir/tsearch'
LANGUAGE 'C' with (isstrict);

COMMENT ON FUNCTION rexecqtxt(mquery_txt, txtidx) IS 'boolean operation with text index';

CREATE OPERATOR @@ (
	LEFTARG = txtidx,
	RIGHTARG = query_txt,
	PROCEDURE = execqtxt,
	COMMUTATOR = '~@',
	RESTRICT = contsel,
	JOIN = contjoinsel
);

CREATE OPERATOR ~@ (
	LEFTARG = query_txt,
	RIGHTARG = txtidx,
	PROCEDURE = rexecqtxt,
	COMMUTATOR = '@@',
	RESTRICT = contsel,
	JOIN = contjoinsel
);

CREATE OPERATOR ## (
	LEFTARG = txtidx,
	RIGHTARG = mquery_txt,
	PROCEDURE = execqtxt,
	COMMUTATOR = '~#',
	RESTRICT = contsel,
	JOIN = contjoinsel
);

CREATE OPERATOR ~# (
	LEFTARG = mquery_txt,
	RIGHTARG = txtidx,
	PROCEDURE = rexecqtxt,
	COMMUTATOR = '##',
	RESTRICT = contsel,
	JOIN = contjoinsel
);

--Trigger
CREATE FUNCTION tsearch()
RETURNS trigger
AS '$libdir/tsearch', 'tsearch_trigger'
LANGUAGE 'C';

--GiST
--GiST key type
CREATE FUNCTION gtxtidx_in(cstring)
RETURNS gtxtidx
AS '$libdir/tsearch'
LANGUAGE 'C' with (isstrict);

CREATE FUNCTION gtxtidx_out(gtxtidx)
RETURNS cstring
AS '$libdir/tsearch'
LANGUAGE 'C' with (isstrict);

CREATE TYPE gtxtidx (
	INTERNALLENGTH = -1,
	INPUT = gtxtidx_in,
	OUTPUT = gtxtidx_out
);

-- support functions
CREATE FUNCTION gtxtidx_consistent(gtxtidx,internal,int4)
RETURNS bool
AS '$libdir/tsearch'
LANGUAGE 'C';

CREATE FUNCTION gtxtidx_compress(internal)
RETURNS internal
AS '$libdir/tsearch'
LANGUAGE 'C';

CREATE FUNCTION gtxtidx_decompress(internal)
RETURNS internal
AS '$libdir/tsearch'
LANGUAGE 'C';

CREATE FUNCTION gtxtidx_penalty(internal,internal,internal)
RETURNS internal
AS '$libdir/tsearch'
LANGUAGE 'C' with (isstrict);

CREATE FUNCTION gtxtidx_picksplit(internal, internal)
RETURNS internal
AS '$libdir/tsearch'
LANGUAGE 'C';

CREATE FUNCTION gtxtidx_union(internal, internal)
RETURNS _int4
AS '$libdir/tsearch'
LANGUAGE 'C';

CREATE FUNCTION gtxtidx_same(gtxtidx, gtxtidx, internal)
RETURNS internal
AS '$libdir/tsearch'
LANGUAGE 'C';

-- create the operator class
CREATE OPERATOR CLASS gist_txtidx_ops
DEFAULT FOR TYPE txtidx USING gist
AS
	OPERATOR	1	@@ (txtidx, query_txt)	RECHECK ,
	OPERATOR	2	## (txtidx, mquery_txt)	RECHECK ,
	FUNCTION	1	gtxtidx_consistent (gtxtidx, internal, int4),
	FUNCTION	2	gtxtidx_union (internal, internal),
	FUNCTION	3	gtxtidx_compress (internal),
	FUNCTION	4	gtxtidx_decompress (internal),
	FUNCTION	5	gtxtidx_penalty (internal, internal, internal),
	FUNCTION	6	gtxtidx_picksplit (internal, internal),
	FUNCTION	7	gtxtidx_same (gtxtidx, gtxtidx, internal),
	STORAGE		gtxtidx;
