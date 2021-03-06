-- Adjust this setting to control where the objects get created.
SET search_path = public;

--
-- The aggregate transition state (denoted INT4 in caps below) is really
-- an array, ie, int4[].  We have to lie and pretend it is a pass-by-value
-- datatype so that nodeAgg.c will not try to do memory management for it.
--

-- Internal function for the aggregate
-- Is called for each item in an aggregation
CREATE OR REPLACE FUNCTION int_agg_state (INT4, int4)
RETURNS INT4
AS '$libdir/int_aggregate','int_agg_state'
LANGUAGE 'C' STRICT;

-- Internal function for the aggregate
-- Is called at the end of the aggregation, and returns an array.
CREATE OR REPLACE FUNCTION int_agg_final_array (INT4)
RETURNS int4[]
AS '$libdir/int_aggregate','int_agg_final_array'
LANGUAGE 'C' STRICT;

-- The aggregate function itself
-- uses the above functions to create an array of integers from an aggregation.
CREATE AGGREGATE int_array_aggregate (
	BASETYPE = int4,
	SFUNC = int_agg_state,
	STYPE = INT4,
	FINALFUNC = int_agg_final_array,
	INITCOND = 0
);

-- The aggregate component functions are not designed to be called
-- independently, so disable public access to them
REVOKE ALL ON FUNCTION int_agg_state (INT4, int4) FROM PUBLIC;
REVOKE ALL ON FUNCTION int_agg_final_array (INT4) FROM PUBLIC;

-- The enumeration function
-- returns each element in a one dimensional integer array
-- as a row.
CREATE OR REPLACE FUNCTION int_array_enum(int4[])
RETURNS setof integer
AS '$libdir/int_aggregate','int_enum'
LANGUAGE 'C' IMMUTABLE STRICT;
