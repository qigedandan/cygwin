-- Create the user-defined type for N-dimensional boxes
-- 

-- Adjust this setting to control where the objects get created.
SET search_path = public;

CREATE OR REPLACE FUNCTION cube_in(cstring)
RETURNS cube
AS '$libdir/cube'
LANGUAGE 'C' IMMUTABLE STRICT;

CREATE OR REPLACE FUNCTION cube_out(cube)
RETURNS cstring
AS '$libdir/cube'
LANGUAGE 'c'IMMUTABLE STRICT;

CREATE TYPE cube (
	INTERNALLENGTH = variable,
	INPUT = cube_in,
	OUTPUT = cube_out
);

COMMENT ON TYPE cube IS 'multi-dimensional cube ''(FLOAT-1, FLOAT-2, ..., FLOAT-N), (FLOAT-1, FLOAT-2, ..., FLOAT-N)''';

-- Convert from text to cube

CREATE OR REPLACE FUNCTION cube(text) RETURNS cube
AS '$libdir/cube'
LANGUAGE 'C' IMMUTABLE STRICT;

COMMENT ON FUNCTION cube(text) IS 'convert text to cube';

CREATE CAST (text AS cube) WITH FUNCTION cube(text) AS ASSIGNMENT;

--
-- External C-functions for R-tree methods
--

-- Left/Right methods

CREATE OR REPLACE FUNCTION cube_over_left(cube, cube)
RETURNS bool
AS '$libdir/cube'
LANGUAGE 'C' IMMUTABLE STRICT;

COMMENT ON FUNCTION cube_over_left(cube, cube) IS 'is over and left of (NOT IMPLEMENTED)';

CREATE OR REPLACE FUNCTION cube_over_right(cube, cube)
RETURNS bool
AS '$libdir/cube'
LANGUAGE 'C' IMMUTABLE STRICT;

COMMENT ON FUNCTION cube_over_right(cube, cube) IS 'is over and right of (NOT IMPLEMENTED)';

CREATE OR REPLACE FUNCTION cube_left(cube, cube)
RETURNS bool
AS '$libdir/cube'
LANGUAGE 'C' IMMUTABLE STRICT;

COMMENT ON FUNCTION cube_left(cube, cube) IS
'is left of (NOT IMPLEMENTED)';

CREATE OR REPLACE FUNCTION cube_right(cube, cube)
RETURNS bool
AS '$libdir/cube'
LANGUAGE 'C' IMMUTABLE STRICT;

COMMENT ON FUNCTION cube_right(cube, cube) IS 'is right of (NOT IMPLEMENTED)';


-- Comparison methods

CREATE OR REPLACE FUNCTION cube_eq(cube, cube)
RETURNS bool
AS '$libdir/cube'
LANGUAGE 'C' IMMUTABLE STRICT;

COMMENT ON FUNCTION cube_eq(cube, cube) IS 'same as';

CREATE OR REPLACE FUNCTION cube_ne(cube, cube)
RETURNS bool
AS '$libdir/cube'
LANGUAGE 'C' IMMUTABLE STRICT;

COMMENT ON FUNCTION cube_ne(cube, cube) IS 'different';

CREATE OR REPLACE FUNCTION cube_lt(cube, cube)
RETURNS bool
AS '$libdir/cube'
LANGUAGE 'C' IMMUTABLE STRICT;

COMMENT ON FUNCTION cube_lt(cube, cube) IS 'lower than';

CREATE OR REPLACE FUNCTION cube_gt(cube, cube)
RETURNS bool
AS '$libdir/cube'
LANGUAGE 'C' IMMUTABLE STRICT;

COMMENT ON FUNCTION cube_gt(cube, cube) IS 'greater than';

CREATE OR REPLACE FUNCTION cube_le(cube, cube)
RETURNS bool
AS '$libdir/cube'
LANGUAGE 'C' IMMUTABLE STRICT;

COMMENT ON FUNCTION cube_le(cube, cube) IS 'lower than or equal to';

CREATE OR REPLACE FUNCTION cube_ge(cube, cube)
RETURNS bool
AS '$libdir/cube'
LANGUAGE 'C' IMMUTABLE STRICT;

COMMENT ON FUNCTION cube_ge(cube, cube) IS 'greater than or equal to';

CREATE OR REPLACE FUNCTION cube_cmp(cube, cube)
RETURNS int4
AS '$libdir/cube'
LANGUAGE 'C' IMMUTABLE STRICT;

COMMENT ON FUNCTION cube_cmp(cube, cube) IS 'btree comparison function';

CREATE OR REPLACE FUNCTION cube_contains(cube, cube)
RETURNS bool
AS '$libdir/cube'
LANGUAGE 'C' IMMUTABLE STRICT;

COMMENT ON FUNCTION cube_contains(cube, cube) IS 'contains';

CREATE OR REPLACE FUNCTION cube_contained(cube, cube)
RETURNS bool
AS '$libdir/cube'
LANGUAGE 'C' IMMUTABLE STRICT;

COMMENT ON FUNCTION cube_contained(cube, cube) IS 'contained in';

CREATE OR REPLACE FUNCTION cube_overlap(cube, cube)
RETURNS bool
AS '$libdir/cube'
LANGUAGE 'C' IMMUTABLE STRICT;

COMMENT ON FUNCTION cube_overlap(cube, cube) IS 'overlaps';

-- support routines for indexing

CREATE OR REPLACE FUNCTION cube_union(cube, cube)
RETURNS cube
AS '$libdir/cube'
LANGUAGE 'C' IMMUTABLE STRICT;

CREATE OR REPLACE FUNCTION cube_inter(cube, cube)
RETURNS cube
AS '$libdir/cube'
LANGUAGE 'C' IMMUTABLE STRICT;

CREATE OR REPLACE FUNCTION cube_size(cube)
RETURNS float8
AS '$libdir/cube'
LANGUAGE 'C' IMMUTABLE STRICT;


-- Misc N-dimensional functions

-- proximity routines

CREATE OR REPLACE FUNCTION cube_distance(cube, cube)
RETURNS float8
AS '$libdir/cube'
LANGUAGE 'C' IMMUTABLE STRICT;

-- Extracting elements functions

CREATE OR REPLACE FUNCTION cube_dim(cube)
RETURNS int4
AS '$libdir/cube'
LANGUAGE 'C' IMMUTABLE STRICT;

CREATE OR REPLACE FUNCTION cube_ll_coord(cube, int4)
RETURNS float8
AS '$libdir/cube'
LANGUAGE 'C' IMMUTABLE STRICT;

CREATE OR REPLACE FUNCTION cube_ur_coord(cube, int4)
RETURNS float8
AS '$libdir/cube'
LANGUAGE 'C' IMMUTABLE STRICT;

CREATE OR REPLACE FUNCTION cube(float8) RETURNS cube
AS '$libdir/cube', 'cube_f8'
LANGUAGE 'C' IMMUTABLE STRICT;

CREATE OR REPLACE FUNCTION cube(float8, float8) RETURNS cube
AS '$libdir/cube', 'cube_f8_f8'
LANGUAGE 'C' IMMUTABLE STRICT;

CREATE OR REPLACE FUNCTION cube(cube, float8) RETURNS cube
AS '$libdir/cube', 'cube_c_f8'
LANGUAGE 'C' IMMUTABLE STRICT;

CREATE OR REPLACE FUNCTION cube(cube, float8, float8) RETURNS cube
AS '$libdir/cube', 'cube_c_f8_f8'
LANGUAGE 'C' IMMUTABLE STRICT;

-- Test if cube is also a point

CREATE OR REPLACE FUNCTION cube_is_point(cube)
RETURNS bool
AS '$libdir/cube'
LANGUAGE 'C' IMMUTABLE STRICT;

-- Increasing the size of a cube by a radius in at least n dimensions

CREATE OR REPLACE FUNCTION cube_enlarge(cube, float8, int4)
RETURNS cube
AS '$libdir/cube'
LANGUAGE 'C' IMMUTABLE STRICT;

--
-- OPERATORS
--

CREATE OPERATOR < (
	LEFTARG = cube, RIGHTARG = cube, PROCEDURE = cube_lt,
	COMMUTATOR = '>', NEGATOR = '>=',
	RESTRICT = scalarltsel, JOIN = scalarltjoinsel
);

CREATE OPERATOR > (
	LEFTARG = cube, RIGHTARG = cube, PROCEDURE = cube_gt,
	COMMUTATOR = '<', NEGATOR = '<=',
	RESTRICT = scalargtsel, JOIN = scalargtjoinsel
);

CREATE OPERATOR <= (
	LEFTARG = cube, RIGHTARG = cube, PROCEDURE = cube_le,
	COMMUTATOR = '>=', NEGATOR = '>',
	RESTRICT = scalarltsel, JOIN = scalarltjoinsel
);

CREATE OPERATOR >= (
	LEFTARG = cube, RIGHTARG = cube, PROCEDURE = cube_ge,
	COMMUTATOR = '<=', NEGATOR = '<',
	RESTRICT = scalargtsel, JOIN = scalargtjoinsel
);

CREATE OPERATOR << (
	LEFTARG = cube, RIGHTARG = cube, PROCEDURE = cube_left,
	COMMUTATOR = '>>',
	RESTRICT = positionsel, JOIN = positionjoinsel
);

CREATE OPERATOR &< (
	LEFTARG = cube, RIGHTARG = cube, PROCEDURE = cube_over_left,
	COMMUTATOR = '&>',
	RESTRICT = positionsel, JOIN = positionjoinsel
);

CREATE OPERATOR && (
	LEFTARG = cube, RIGHTARG = cube, PROCEDURE = cube_overlap,
	COMMUTATOR = '&&',
	RESTRICT = positionsel, JOIN = positionjoinsel
);

CREATE OPERATOR &> (
	LEFTARG = cube, RIGHTARG = cube, PROCEDURE = cube_over_right,
	COMMUTATOR = '&<',
	RESTRICT = positionsel, JOIN = positionjoinsel
);

CREATE OPERATOR >> (
	LEFTARG = cube, RIGHTARG = cube, PROCEDURE = cube_right,
	COMMUTATOR = '<<',
	RESTRICT = positionsel, JOIN = positionjoinsel
);

CREATE OPERATOR = (
	LEFTARG = cube, RIGHTARG = cube, PROCEDURE = cube_eq,
	COMMUTATOR = '=', NEGATOR = '<>',
	RESTRICT = eqsel, JOIN = eqjoinsel,
	MERGES
);

CREATE OPERATOR <> (
	LEFTARG = cube, RIGHTARG = cube, PROCEDURE = cube_ne,
	COMMUTATOR = '<>', NEGATOR = '=',
	RESTRICT = neqsel, JOIN = neqjoinsel
);

CREATE OPERATOR @ (
	LEFTARG = cube, RIGHTARG = cube, PROCEDURE = cube_contains,
	COMMUTATOR = '~',
	RESTRICT = contsel, JOIN = contjoinsel
);

CREATE OPERATOR ~ (
	LEFTARG = cube, RIGHTARG = cube, PROCEDURE = cube_contained,
	COMMUTATOR = '@',
	RESTRICT = contsel, JOIN = contjoinsel
);


-- define the GiST support methods
CREATE OR REPLACE FUNCTION g_cube_consistent(internal,cube,int4)
RETURNS bool
AS '$libdir/cube'
LANGUAGE 'C';

CREATE OR REPLACE FUNCTION g_cube_compress(internal)
RETURNS internal 
AS '$libdir/cube'
LANGUAGE 'C';

CREATE OR REPLACE FUNCTION g_cube_decompress(internal)
RETURNS internal 
AS '$libdir/cube'
LANGUAGE 'C';

CREATE OR REPLACE FUNCTION g_cube_penalty(internal,internal,internal)
RETURNS internal
AS '$libdir/cube'
LANGUAGE 'C' STRICT;

CREATE OR REPLACE FUNCTION g_cube_picksplit(internal, internal)
RETURNS internal
AS '$libdir/cube'
LANGUAGE 'C';

CREATE OR REPLACE FUNCTION g_cube_union(internal, internal)
RETURNS cube 
AS '$libdir/cube'
LANGUAGE 'C';

CREATE OR REPLACE FUNCTION g_cube_same(cube, cube, internal)
RETURNS internal 
AS '$libdir/cube'
LANGUAGE 'C';


-- Create the operator classes for indexing

CREATE OPERATOR CLASS cube_ops
    DEFAULT FOR TYPE cube USING btree AS
        OPERATOR        1       < ,
        OPERATOR        2       <= ,
        OPERATOR        3       = ,
        OPERATOR        4       >= ,
        OPERATOR        5       > ,
        FUNCTION        1       cube_cmp(cube, cube);

CREATE OPERATOR CLASS gist_cube_ops
    DEFAULT FOR TYPE cube USING gist AS
	OPERATOR	1	<< ,
	OPERATOR	2	&< ,
	OPERATOR	3	&& ,
	OPERATOR	4	&> ,
	OPERATOR	5	>> ,
	OPERATOR	6	= ,
	OPERATOR	7	@ ,
	OPERATOR	8	~ ,
	FUNCTION	1	g_cube_consistent (internal, cube, int4),
	FUNCTION	2	g_cube_union (internal, internal),
	FUNCTION	3	g_cube_compress (internal),
	FUNCTION	4	g_cube_decompress (internal),
	FUNCTION	5	g_cube_penalty (internal, internal, internal),
	FUNCTION	6	g_cube_picksplit (internal, internal),
	FUNCTION	7	g_cube_same (cube, cube, internal);
