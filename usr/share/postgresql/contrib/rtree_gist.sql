-- Adjust this setting to control where the objects get created.
SET search_path = public;

--
--
--
-- BOX ops
--
--
--
-- define the GiST support methods
CREATE FUNCTION gbox_consistent(internal,box,int4)
RETURNS bool
AS '$libdir/rtree_gist'
LANGUAGE 'C';

CREATE FUNCTION gbox_compress(internal)
RETURNS internal
AS '$libdir/rtree_gist'
LANGUAGE 'C';

CREATE FUNCTION rtree_decompress(internal)
RETURNS internal
AS '$libdir/rtree_gist'
LANGUAGE 'C';

CREATE FUNCTION gbox_penalty(internal,internal,internal)
RETURNS internal
AS '$libdir/rtree_gist'
LANGUAGE 'C' with (isstrict);

CREATE FUNCTION gbox_picksplit(internal, internal)
RETURNS internal
AS '$libdir/rtree_gist'
LANGUAGE 'C';

CREATE FUNCTION gbox_union(internal, internal)
RETURNS box
AS '$libdir/rtree_gist'
LANGUAGE 'C';

CREATE FUNCTION gbox_same(box, box, internal)
RETURNS internal
AS '$libdir/rtree_gist'
LANGUAGE 'C';

-- create the operator class
CREATE OPERATOR CLASS gist_box_ops
DEFAULT FOR TYPE box USING gist
AS
	OPERATOR	1	<< ,
	OPERATOR	2	&< ,
	OPERATOR	3	&& ,
	OPERATOR	4	&> ,
	OPERATOR	5	>> ,
	OPERATOR	6	~= ,
	OPERATOR	7	~ ,
	OPERATOR	8	@ ,
	FUNCTION	1	gbox_consistent (internal, box, int4),
	FUNCTION	2	gbox_union (internal, internal),
	FUNCTION	3	gbox_compress (internal),
	FUNCTION	4	rtree_decompress (internal),
	FUNCTION	5	gbox_penalty (internal, internal, internal),
	FUNCTION	6	gbox_picksplit (internal, internal),
	FUNCTION	7	gbox_same (box, box, internal);


--
--
--
-- POLYGON ops
--
--
--
-- define the GiST support methods
CREATE FUNCTION gpoly_consistent(internal,polygon,int4)
RETURNS bool
AS '$libdir/rtree_gist'
LANGUAGE 'C';

CREATE FUNCTION gpoly_compress(internal)
RETURNS internal
AS '$libdir/rtree_gist'
LANGUAGE 'C';

-- create the operator class
CREATE OPERATOR CLASS gist_poly_ops
DEFAULT FOR TYPE polygon USING gist 
AS
	OPERATOR	1	<<	RECHECK,
	OPERATOR	2	&<	RECHECK,
	OPERATOR	3	&&	RECHECK,
	OPERATOR	4	&>	RECHECK,
	OPERATOR	5	>>	RECHECK,
	OPERATOR	6	~=	RECHECK,
	OPERATOR	7	~	RECHECK,
	OPERATOR	8	@	RECHECK,
	FUNCTION	1	gpoly_consistent (internal, polygon, int4),
	FUNCTION	2	gbox_union (internal, internal),
	FUNCTION	3	gpoly_compress (internal),
	FUNCTION	4	rtree_decompress (internal),
	FUNCTION	5	gbox_penalty (internal, internal, internal),
	FUNCTION	6	gbox_picksplit (internal, internal),
	FUNCTION	7	gbox_same (box, box, internal),
	STORAGE		box;
