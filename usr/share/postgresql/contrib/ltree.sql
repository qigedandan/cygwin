-- Adjust this setting to control where the objects get created.
SET search_path = public;

CREATE FUNCTION ltree_in(cstring)
RETURNS ltree
AS '$libdir/ltree'
LANGUAGE 'C' WITH (isstrict);

CREATE FUNCTION ltree_out(ltree)
RETURNS cstring
AS '$libdir/ltree'
LANGUAGE 'C' WITH (isstrict);

CREATE TYPE ltree (
	INTERNALLENGTH = -1,
	INPUT = ltree_in,
	OUTPUT = ltree_out,
	STORAGE = extended
);


--Compare function for ltree
CREATE FUNCTION ltree_cmp(ltree,ltree)
RETURNS int4
AS '$libdir/ltree'
LANGUAGE 'C' WITH (isstrict,iscachable);

CREATE FUNCTION ltree_lt(ltree,ltree)
RETURNS bool
AS '$libdir/ltree'
LANGUAGE 'C' WITH (isstrict,iscachable);

CREATE FUNCTION ltree_le(ltree,ltree)
RETURNS bool
AS '$libdir/ltree'
LANGUAGE 'C' WITH (isstrict,iscachable);

CREATE FUNCTION ltree_eq(ltree,ltree)
RETURNS bool
AS '$libdir/ltree'
LANGUAGE 'C' WITH (isstrict,iscachable);

CREATE FUNCTION ltree_ge(ltree,ltree)
RETURNS bool
AS '$libdir/ltree'
LANGUAGE 'C' WITH (isstrict,iscachable);

CREATE FUNCTION ltree_gt(ltree,ltree)
RETURNS bool
AS '$libdir/ltree'
LANGUAGE 'C' WITH (isstrict,iscachable);

CREATE FUNCTION ltree_ne(ltree,ltree)
RETURNS bool
AS '$libdir/ltree'
LANGUAGE 'C' WITH (isstrict,iscachable);


CREATE OPERATOR < (
        LEFTARG = ltree,
	RIGHTARG = ltree,
	PROCEDURE = ltree_lt,
        COMMUTATOR = '>',
	NEGATOR = '>=',
        RESTRICT = contsel,
	JOIN = contjoinsel
);

CREATE OPERATOR <= (
        LEFTARG = ltree,
	RIGHTARG = ltree,
	PROCEDURE = ltree_le,
        COMMUTATOR = '>=',
	NEGATOR = '>',
        RESTRICT = contsel,
	JOIN = contjoinsel
);

CREATE OPERATOR >= (
        LEFTARG = ltree,
	RIGHTARG = ltree,
	PROCEDURE = ltree_ge,
        COMMUTATOR = '<=',
	NEGATOR = '<',
        RESTRICT = contsel,
	JOIN = contjoinsel
);

CREATE OPERATOR > (
        LEFTARG = ltree,
	RIGHTARG = ltree,
	PROCEDURE = ltree_gt,
        COMMUTATOR = '<',
	NEGATOR = '<=',
        RESTRICT = contsel,
	JOIN = contjoinsel
);

CREATE OPERATOR = (
        LEFTARG = ltree,
	RIGHTARG = ltree,
	PROCEDURE = ltree_eq,
        COMMUTATOR = '=',
	NEGATOR = '<>',
        RESTRICT = eqsel,
	JOIN = eqjoinsel,
        SORT1 = '<',
	SORT2 = '<'
);

CREATE OPERATOR <> (
        LEFTARG = ltree,
	RIGHTARG = ltree,
	PROCEDURE = ltree_ne,
        COMMUTATOR = '<>',
	NEGATOR = '=',
        RESTRICT = neqsel,
	JOIN = neqjoinsel
);

--util functions

CREATE FUNCTION subltree(ltree,int4,int4)
RETURNS ltree
AS '$libdir/ltree'
LANGUAGE 'C' WITH (isstrict,iscachable);

CREATE FUNCTION subpath(ltree,int4,int4)
RETURNS ltree
AS '$libdir/ltree'
LANGUAGE 'C' WITH (isstrict,iscachable);

CREATE FUNCTION subpath(ltree,int4)
RETURNS ltree
AS '$libdir/ltree'
LANGUAGE 'C' WITH (isstrict,iscachable);

CREATE FUNCTION index(ltree,ltree)
RETURNS int4
AS '$libdir/ltree', 'ltree_index'
LANGUAGE 'C' WITH (isstrict,iscachable);

CREATE FUNCTION index(ltree,ltree,int4)
RETURNS int4
AS '$libdir/ltree', 'ltree_index'
LANGUAGE 'C' WITH (isstrict,iscachable);

CREATE FUNCTION nlevel(ltree)
RETURNS int4
AS '$libdir/ltree'
LANGUAGE 'C' WITH (isstrict,iscachable);

CREATE FUNCTION ltree2text(ltree)
RETURNS text
AS '$libdir/ltree'
LANGUAGE 'C' WITH (isstrict,iscachable);

CREATE FUNCTION text2ltree(text)
RETURNS ltree
AS '$libdir/ltree'
LANGUAGE 'C' WITH (isstrict,iscachable);

CREATE FUNCTION lca(_ltree)
RETURNS ltree
AS '$libdir/ltree','_lca'
LANGUAGE 'C' WITH (isstrict,iscachable);

CREATE FUNCTION lca(ltree,ltree)
RETURNS ltree
AS '$libdir/ltree'
LANGUAGE 'C' WITH (isstrict,iscachable);

CREATE FUNCTION lca(ltree,ltree,ltree)
RETURNS ltree
AS '$libdir/ltree'
LANGUAGE 'C' WITH (isstrict,iscachable);

CREATE FUNCTION lca(ltree,ltree,ltree,ltree)
RETURNS ltree
AS '$libdir/ltree'
LANGUAGE 'C' WITH (isstrict,iscachable);

CREATE FUNCTION lca(ltree,ltree,ltree,ltree,ltree)
RETURNS ltree
AS '$libdir/ltree'
LANGUAGE 'C' WITH (isstrict,iscachable);

CREATE FUNCTION lca(ltree,ltree,ltree,ltree,ltree,ltree)
RETURNS ltree
AS '$libdir/ltree'
LANGUAGE 'C' WITH (isstrict,iscachable);

CREATE FUNCTION lca(ltree,ltree,ltree,ltree,ltree,ltree,ltree)
RETURNS ltree
AS '$libdir/ltree'
LANGUAGE 'C' WITH (isstrict,iscachable);

CREATE FUNCTION lca(ltree,ltree,ltree,ltree,ltree,ltree,ltree,ltree)
RETURNS ltree
AS '$libdir/ltree'
LANGUAGE 'C' WITH (isstrict,iscachable);

CREATE FUNCTION ltree_isparent(ltree,ltree)
RETURNS bool
AS '$libdir/ltree'
LANGUAGE 'C' WITH (isstrict,iscachable);

CREATE FUNCTION ltree_risparent(ltree,ltree)
RETURNS bool
AS '$libdir/ltree'
LANGUAGE 'C' WITH (isstrict,iscachable);

CREATE FUNCTION ltree_addltree(ltree,ltree)
RETURNS ltree
AS '$libdir/ltree'
LANGUAGE 'C' WITH (isstrict,iscachable);

CREATE FUNCTION ltree_addtext(ltree,text)
RETURNS ltree
AS '$libdir/ltree'
LANGUAGE 'C' WITH (isstrict,iscachable);

CREATE FUNCTION ltree_textadd(text,ltree)
RETURNS ltree
AS '$libdir/ltree'
LANGUAGE 'C' WITH (isstrict,iscachable);

CREATE OPERATOR @> (
        LEFTARG = ltree,
	RIGHTARG = ltree,
	PROCEDURE = ltree_isparent,
        COMMUTATOR = '<@',
        RESTRICT = contsel,
	JOIN = contjoinsel
);

CREATE OPERATOR ^@> (
        LEFTARG = ltree,
	RIGHTARG = ltree,
	PROCEDURE = ltree_isparent,
        COMMUTATOR = '^<@',
        RESTRICT = contsel,
	JOIN = contjoinsel
);

CREATE OPERATOR <@ (
        LEFTARG = ltree,
	RIGHTARG = ltree,
	PROCEDURE = ltree_risparent,
        COMMUTATOR = '@>',
        RESTRICT = contsel,
	JOIN = contjoinsel
);

CREATE OPERATOR ^<@ (
        LEFTARG = ltree,
	RIGHTARG = ltree,
	PROCEDURE = ltree_risparent,
        COMMUTATOR = '^@>',
        RESTRICT = contsel,
	JOIN = contjoinsel
);

CREATE OPERATOR || (
        LEFTARG = ltree,
	RIGHTARG = ltree,
	PROCEDURE = ltree_addltree
);

CREATE OPERATOR || (
        LEFTARG = ltree,
	RIGHTARG = text,
	PROCEDURE = ltree_addtext
);

CREATE OPERATOR || (
        LEFTARG = text,
	RIGHTARG = ltree,
	PROCEDURE = ltree_textadd
);


-- B-tree support

CREATE OPERATOR CLASS ltree_ops
    DEFAULT FOR TYPE ltree USING btree AS
        OPERATOR        1       < ,
        OPERATOR        2       <= ,
        OPERATOR        3       = ,
        OPERATOR        4       >= ,
        OPERATOR        5       > ,
        FUNCTION        1       ltree_cmp(ltree, ltree);


--lquery type
CREATE FUNCTION lquery_in(cstring)
RETURNS lquery
AS '$libdir/ltree'
LANGUAGE 'C' WITH (isstrict);

CREATE FUNCTION lquery_out(lquery)
RETURNS cstring
AS '$libdir/ltree'
LANGUAGE 'C' WITH (isstrict);

CREATE TYPE lquery (
	INTERNALLENGTH = -1,
	INPUT = lquery_in,
	OUTPUT = lquery_out,
	STORAGE = extended
);

CREATE FUNCTION ltq_regex(ltree,lquery)
RETURNS bool
AS '$libdir/ltree'
LANGUAGE 'C' WITH (isstrict,iscachable);

CREATE FUNCTION ltq_rregex(lquery,ltree)
RETURNS bool
AS '$libdir/ltree'
LANGUAGE 'C' WITH (isstrict,iscachable);

CREATE OPERATOR ~ (
        LEFTARG = ltree,
	RIGHTARG = lquery,
	PROCEDURE = ltq_regex,
	COMMUTATOR = '~',
	RESTRICT = contsel,
	JOIN = contjoinsel
);

CREATE OPERATOR ~ (
        LEFTARG = lquery,
	RIGHTARG = ltree,
	PROCEDURE = ltq_rregex,
	COMMUTATOR = '~',
	RESTRICT = contsel,
	JOIN = contjoinsel
);

--not-indexed
CREATE OPERATOR ^~ (
        LEFTARG = ltree,
	RIGHTARG = lquery,
	PROCEDURE = ltq_regex,
	COMMUTATOR = '^~',
	RESTRICT = contsel,
	JOIN = contjoinsel
);

CREATE OPERATOR ^~ (
        LEFTARG = lquery,
	RIGHTARG = ltree,
	PROCEDURE = ltq_rregex,
	COMMUTATOR = '^~',
	RESTRICT = contsel,
	JOIN = contjoinsel
);

CREATE FUNCTION lt_q_regex(ltree,_lquery)
RETURNS bool
AS '$libdir/ltree'
LANGUAGE 'C' WITH (isstrict,iscachable);

CREATE FUNCTION lt_q_rregex(_lquery,ltree)
RETURNS bool
AS '$libdir/ltree'
LANGUAGE 'C' WITH (isstrict,iscachable);

CREATE OPERATOR ? (
        LEFTARG = ltree,
	RIGHTARG = _lquery,
	PROCEDURE = lt_q_regex,
	COMMUTATOR = '?',
	RESTRICT = contsel,
	JOIN = contjoinsel
);

CREATE OPERATOR ? (
        LEFTARG = _lquery,
	RIGHTARG = ltree,
	PROCEDURE = lt_q_rregex,
	COMMUTATOR = '?',
	RESTRICT = contsel,
	JOIN = contjoinsel
);

--not-indexed
CREATE OPERATOR ^? (
        LEFTARG = ltree,
	RIGHTARG = _lquery,
	PROCEDURE = lt_q_regex,
	COMMUTATOR = '^?',
	RESTRICT = contsel,
	JOIN = contjoinsel
);

CREATE OPERATOR ^? (
        LEFTARG = _lquery,
	RIGHTARG = ltree,
	PROCEDURE = lt_q_rregex,
	COMMUTATOR = '^?',
	RESTRICT = contsel,
	JOIN = contjoinsel
);

CREATE FUNCTION ltxtq_in(cstring)
RETURNS ltxtquery
AS '$libdir/ltree'
LANGUAGE 'C' WITH (isstrict);

CREATE FUNCTION ltxtq_out(ltxtquery)
RETURNS cstring
AS '$libdir/ltree'
LANGUAGE 'C' WITH (isstrict);

CREATE TYPE ltxtquery (
	INTERNALLENGTH = -1,
	INPUT = ltxtq_in,
	OUTPUT = ltxtq_out,
	STORAGE = extended
);

-- operations WITH ltxtquery

CREATE FUNCTION ltxtq_exec(ltree, ltxtquery)
RETURNS bool
AS '$libdir/ltree'
LANGUAGE 'C' WITH (isstrict, iscachable);

CREATE FUNCTION ltxtq_rexec(ltxtquery, ltree)
RETURNS bool
AS '$libdir/ltree'
LANGUAGE 'C' WITH (isstrict, iscachable);

CREATE OPERATOR @ (
        LEFTARG = ltree,
	RIGHTARG = ltxtquery,
	PROCEDURE = ltxtq_exec,
	COMMUTATOR = '@',
	RESTRICT = contsel,
	JOIN = contjoinsel
);

CREATE OPERATOR @ (
        LEFTARG = ltxtquery,
	RIGHTARG = ltree,
	PROCEDURE = ltxtq_rexec,
	COMMUTATOR = '@',
	RESTRICT = contsel,
	JOIN = contjoinsel
);

--not-indexed
CREATE OPERATOR ^@ (
        LEFTARG = ltree,
	RIGHTARG = ltxtquery,
	PROCEDURE = ltxtq_exec,
	COMMUTATOR = '^@',
	RESTRICT = contsel,
	JOIN = contjoinsel
);

CREATE OPERATOR ^@ (
        LEFTARG = ltxtquery,
	RIGHTARG = ltree,
	PROCEDURE = ltxtq_rexec,
	COMMUTATOR = '^@',
	RESTRICT = contsel,
	JOIN = contjoinsel
);

--GiST support for ltree
CREATE FUNCTION ltree_gist_in(cstring)
RETURNS ltree_gist
AS '$libdir/ltree'
LANGUAGE 'C' WITH (isstrict);
  
CREATE FUNCTION ltree_gist_out(ltree_gist)
RETURNS cstring
AS '$libdir/ltree'
LANGUAGE 'C' WITH (isstrict);
  
CREATE TYPE ltree_gist (
	internallength = -1,
	input = ltree_gist_in,
	output = ltree_gist_out,
	storage = plain
);   


CREATE FUNCTION ltree_consistent(internal,internal,int2)
RETURNS bool as '$libdir/ltree' language 'C';
CREATE FUNCTION ltree_compress(internal)
RETURNS internal as '$libdir/ltree' language 'C';
CREATE FUNCTION ltree_decompress(internal)
RETURNS internal as '$libdir/ltree' language 'C';
CREATE FUNCTION ltree_penalty(internal,internal,internal)
RETURNS internal as '$libdir/ltree' language 'C' with(isstrict);
CREATE FUNCTION ltree_picksplit(internal, internal)
RETURNS internal as '$libdir/ltree' language 'C';
CREATE FUNCTION ltree_union(internal, internal)
RETURNS int4 as '$libdir/ltree' language 'C';
CREATE FUNCTION ltree_same(internal, internal, internal)
RETURNS internal as '$libdir/ltree' language 'C';

CREATE OPERATOR CLASS gist_ltree_ops
    DEFAULT FOR TYPE ltree USING gist AS
	OPERATOR	1	< ,
	OPERATOR	2	<= ,
	OPERATOR	3	= ,
	OPERATOR	4	>= ,
	OPERATOR	5	> ,
	OPERATOR	10	@> ,
	OPERATOR	11	<@ ,
	OPERATOR	12	~ (ltree, lquery) ,
	OPERATOR	13	~ (lquery, ltree) ,
	OPERATOR	14	@ (ltree, ltxtquery) ,
	OPERATOR	15	@ (ltxtquery, ltree) ,
	OPERATOR	16	? (ltree, _lquery) ,
	OPERATOR	17	? (_lquery, ltree) ,
	FUNCTION	1	ltree_consistent (internal, internal, int2),
	FUNCTION	2	ltree_union (internal, internal),
	FUNCTION	3	ltree_compress (internal),
	FUNCTION	4	ltree_decompress (internal),
	FUNCTION	5	ltree_penalty (internal, internal, internal),
	FUNCTION	6	ltree_picksplit (internal, internal),
	FUNCTION	7	ltree_same (internal, internal, internal),
	STORAGE		ltree_gist;


-- arrays of ltree

CREATE FUNCTION _ltree_isparent(_ltree,ltree)
RETURNS bool
AS '$libdir/ltree'
LANGUAGE 'C' WITH (isstrict,iscachable);

CREATE FUNCTION _ltree_r_isparent(ltree,_ltree)
RETURNS bool
AS '$libdir/ltree'
LANGUAGE 'C' WITH (isstrict,iscachable);

CREATE FUNCTION _ltree_risparent(_ltree,ltree)
RETURNS bool
AS '$libdir/ltree'
LANGUAGE 'C' WITH (isstrict,iscachable);

CREATE FUNCTION _ltree_r_risparent(ltree,_ltree)
RETURNS bool
AS '$libdir/ltree'
LANGUAGE 'C' WITH (isstrict,iscachable);

CREATE FUNCTION _ltq_regex(_ltree,lquery)
RETURNS bool
AS '$libdir/ltree'
LANGUAGE 'C' WITH (isstrict,iscachable);

CREATE FUNCTION _ltq_rregex(lquery,_ltree)
RETURNS bool
AS '$libdir/ltree'
LANGUAGE 'C' WITH (isstrict,iscachable);

CREATE FUNCTION _lt_q_regex(_ltree,_lquery)
RETURNS bool
AS '$libdir/ltree'
LANGUAGE 'C' WITH (isstrict,iscachable);

CREATE FUNCTION _lt_q_rregex(_lquery,_ltree)
RETURNS bool
AS '$libdir/ltree'
LANGUAGE 'C' WITH (isstrict,iscachable);

CREATE FUNCTION _ltxtq_exec(_ltree, ltxtquery)
RETURNS bool
AS '$libdir/ltree'
LANGUAGE 'C' WITH (isstrict, iscachable);

CREATE FUNCTION _ltxtq_rexec(ltxtquery, _ltree)
RETURNS bool
AS '$libdir/ltree'
LANGUAGE 'C' WITH (isstrict, iscachable);

CREATE OPERATOR @> (
        LEFTARG = _ltree,
	RIGHTARG = ltree,
	PROCEDURE = _ltree_isparent,
        COMMUTATOR = '<@',
        RESTRICT = contsel,
	JOIN = contjoinsel
);

CREATE OPERATOR <@ (
        LEFTARG = ltree,
	RIGHTARG = _ltree,
	PROCEDURE = _ltree_r_isparent,
        COMMUTATOR = '@>',
        RESTRICT = contsel,
	JOIN = contjoinsel
);

CREATE OPERATOR <@ (
        LEFTARG = _ltree,
	RIGHTARG = ltree,
	PROCEDURE = _ltree_risparent,
        COMMUTATOR = '@>',
        RESTRICT = contsel,
	JOIN = contjoinsel
);

CREATE OPERATOR @> (
        LEFTARG = ltree,
	RIGHTARG = _ltree,
	PROCEDURE = _ltree_r_risparent,
        COMMUTATOR = '<@',
        RESTRICT = contsel,
	JOIN = contjoinsel
);

CREATE OPERATOR ~ (
        LEFTARG = _ltree,
	RIGHTARG = lquery,
	PROCEDURE = _ltq_regex,
        COMMUTATOR = '~',
        RESTRICT = contsel,
	JOIN = contjoinsel
);

CREATE OPERATOR ~ (
        LEFTARG = lquery,
	RIGHTARG = _ltree,
	PROCEDURE = _ltq_rregex,
        COMMUTATOR = '~',
        RESTRICT = contsel,
	JOIN = contjoinsel
);

CREATE OPERATOR ? (
        LEFTARG = _ltree,
	RIGHTARG = _lquery,
	PROCEDURE = _lt_q_regex,
        COMMUTATOR = '?',
        RESTRICT = contsel,
	JOIN = contjoinsel
);

CREATE OPERATOR ? (
        LEFTARG = _lquery,
	RIGHTARG = _ltree,
	PROCEDURE = _lt_q_rregex,
        COMMUTATOR = '?',
        RESTRICT = contsel,
	JOIN = contjoinsel
);

CREATE OPERATOR @ (
        LEFTARG = _ltree,
	RIGHTARG = ltxtquery,
	PROCEDURE = _ltxtq_exec,
        COMMUTATOR = '@',
        RESTRICT = contsel,
	JOIN = contjoinsel
);

CREATE OPERATOR @ (
        LEFTARG = ltxtquery,
	RIGHTARG = _ltree,
	PROCEDURE = _ltxtq_rexec,
        COMMUTATOR = '@',
        RESTRICT = contsel,
	JOIN = contjoinsel
);


--not indexed
CREATE OPERATOR ^@> (
        LEFTARG = _ltree,
	RIGHTARG = ltree,
	PROCEDURE = _ltree_isparent,
        COMMUTATOR = '^<@',
        RESTRICT = contsel,
	JOIN = contjoinsel
);

CREATE OPERATOR ^<@ (
        LEFTARG = ltree,
	RIGHTARG = _ltree,
	PROCEDURE = _ltree_r_isparent,
        COMMUTATOR = '^@>',
        RESTRICT = contsel,
	JOIN = contjoinsel
);

CREATE OPERATOR ^<@ (
        LEFTARG = _ltree,
	RIGHTARG = ltree,
	PROCEDURE = _ltree_risparent,
        COMMUTATOR = '^@>',
        RESTRICT = contsel,
	JOIN = contjoinsel
);

CREATE OPERATOR ^@> (
        LEFTARG = ltree,
	RIGHTARG = _ltree,
	PROCEDURE = _ltree_r_risparent,
        COMMUTATOR = '^<@',
        RESTRICT = contsel,
	JOIN = contjoinsel
);

CREATE OPERATOR ^~ (
        LEFTARG = _ltree,
	RIGHTARG = lquery,
	PROCEDURE = _ltq_regex,
        COMMUTATOR = '^~',
        RESTRICT = contsel,
	JOIN = contjoinsel
);

CREATE OPERATOR ^~ (
        LEFTARG = lquery,
	RIGHTARG = _ltree,
	PROCEDURE = _ltq_rregex,
        COMMUTATOR = '^~',
        RESTRICT = contsel,
	JOIN = contjoinsel
);

CREATE OPERATOR ^? (
        LEFTARG = _ltree,
	RIGHTARG = _lquery,
	PROCEDURE = _lt_q_regex,
        COMMUTATOR = '^?',
        RESTRICT = contsel,
	JOIN = contjoinsel
);

CREATE OPERATOR ^? (
        LEFTARG = _lquery,
	RIGHTARG = _ltree,
	PROCEDURE = _lt_q_rregex,
        COMMUTATOR = '^?',
        RESTRICT = contsel,
	JOIN = contjoinsel
);

CREATE OPERATOR ^@ (
        LEFTARG = _ltree,
	RIGHTARG = ltxtquery,
	PROCEDURE = _ltxtq_exec,
        COMMUTATOR = '^@',
        RESTRICT = contsel,
	JOIN = contjoinsel
);

CREATE OPERATOR ^@ (
        LEFTARG = ltxtquery,
	RIGHTARG = _ltree,
	PROCEDURE = _ltxtq_rexec,
        COMMUTATOR = '^@',
        RESTRICT = contsel,
	JOIN = contjoinsel
);

--extractors
CREATE FUNCTION _ltree_extract_isparent(_ltree,ltree)
RETURNS ltree
AS '$libdir/ltree'
LANGUAGE 'C' WITH (isstrict,iscachable);

CREATE OPERATOR ?@> (
        LEFTARG = _ltree,
	RIGHTARG = ltree,
	PROCEDURE = _ltree_extract_isparent
);

CREATE FUNCTION _ltree_extract_risparent(_ltree,ltree)
RETURNS ltree
AS '$libdir/ltree'
LANGUAGE 'C' WITH (isstrict,iscachable);

CREATE OPERATOR ?<@ (
        LEFTARG = _ltree,
	RIGHTARG = ltree,
	PROCEDURE = _ltree_extract_risparent
);

CREATE FUNCTION _ltq_extract_regex(_ltree,lquery)
RETURNS ltree
AS '$libdir/ltree'
LANGUAGE 'C' WITH (isstrict,iscachable);

CREATE OPERATOR ?~ (
        LEFTARG = _ltree,
	RIGHTARG = lquery,
	PROCEDURE = _ltq_extract_regex
);

CREATE FUNCTION _ltxtq_extract_exec(_ltree,ltxtquery)
RETURNS ltree
AS '$libdir/ltree'
LANGUAGE 'C' WITH (isstrict,iscachable);

CREATE OPERATOR ?@ (
        LEFTARG = _ltree,
	RIGHTARG = ltxtquery,
	PROCEDURE = _ltxtq_extract_exec
);

--GiST support for ltree[]
CREATE FUNCTION _ltree_consistent(internal,internal,int2)
RETURNS bool
AS '$libdir/ltree'
LANGUAGE 'C';
CREATE FUNCTION _ltree_compress(internal)
RETURNS internal
AS '$libdir/ltree'
LANGUAGE 'C';
CREATE FUNCTION _ltree_penalty(internal,internal,internal)
RETURNS internal
AS '$libdir/ltree'
LANGUAGE 'C' WITH(isstrict);
CREATE FUNCTION _ltree_picksplit(internal, internal)
RETURNS internal
AS '$libdir/ltree'
LANGUAGE 'C';
CREATE FUNCTION _ltree_union(internal, internal)
RETURNS int4
AS '$libdir/ltree'
LANGUAGE 'C';
CREATE FUNCTION _ltree_same(internal, internal, internal)
RETURNS internal
AS '$libdir/ltree'
LANGUAGE 'C';

CREATE OPERATOR CLASS gist__ltree_ops
    DEFAULT FOR TYPE _ltree USING gist AS
	OPERATOR	10	<@ (_ltree, ltree)	RECHECK ,
	OPERATOR	11	@> (ltree, _ltree)	RECHECK ,
	OPERATOR	12	~ (_ltree, lquery)	RECHECK ,
	OPERATOR	13	~ (lquery, _ltree)	RECHECK ,
	OPERATOR	14	@ (_ltree, ltxtquery)	RECHECK ,
	OPERATOR	15	@ (ltxtquery, _ltree)	RECHECK ,
	OPERATOR	16	? (_ltree, _lquery)	RECHECK ,
	OPERATOR	17	? (_lquery, _ltree)	RECHECK ,
	FUNCTION	1	_ltree_consistent (internal, internal, int2),
	FUNCTION	2	_ltree_union (internal, internal),
	FUNCTION	3	_ltree_compress (internal),
	FUNCTION	4	ltree_decompress (internal),
	FUNCTION	5	_ltree_penalty (internal, internal, internal),
	FUNCTION	6	_ltree_picksplit (internal, internal),
	FUNCTION	7	_ltree_same (internal, internal, internal),
	STORAGE		ltree_gist;
