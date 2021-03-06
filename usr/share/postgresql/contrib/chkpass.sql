--
--	PostgreSQL code for CHKPASS.
--  Written by D'Arcy J.M. Cain
--  darcy@druid.net
--  http://www.druid.net/darcy/
-- 
--  $PostgreSQL: pgsql/contrib/chkpass/chkpass.sql.in,v 1.5.4.1 2005/01/29 22:35:16 tgl Exp $
--
--  best viewed with tabs set to 4
--

--
--	Input and output functions and the type itself:
--

-- Adjust this setting to control where the objects get created.
SET search_path = public;

CREATE FUNCTION chkpass_in(cstring)
	RETURNS chkpass
	AS '$libdir/chkpass'
	LANGUAGE C STRICT;

CREATE FUNCTION chkpass_out(chkpass)
	RETURNS cstring
	AS '$libdir/chkpass'
	LANGUAGE C STRICT;

CREATE TYPE chkpass (
	internallength = 16,
	externallength = 13,
	input = chkpass_in,
	output = chkpass_out
);

CREATE FUNCTION raw(chkpass)
	RETURNS text
	AS '$libdir/chkpass', 'chkpass_rout'
	LANGUAGE C STRICT;

--
--	The various boolean tests:
--

CREATE FUNCTION eq(chkpass, text)
	RETURNS bool
	AS '$libdir/chkpass', 'chkpass_eq'
	LANGUAGE C STRICT;

CREATE FUNCTION ne(chkpass, text)
	RETURNS bool
	AS '$libdir/chkpass', 'chkpass_ne'
	LANGUAGE C STRICT;

--
--	Now the operators.  Note how some of the parameters to some
--	of the 'create operator' commands are commented out.  This
--	is because they reference as yet undefined operators, and
--	will be implicitly defined when those are, further down.
--

CREATE OPERATOR = (
	leftarg = chkpass,
	rightarg = text,
	commutator = =,
--	negator = <>,
	procedure = eq
);

CREATE OPERATOR <> (
	leftarg = chkpass,
	rightarg = text,
	negator = =,
	procedure = ne
);

COMMENT ON TYPE chkpass IS 'password type with checks';

--
--	eof
--
