-- Adjust this setting to control where the objects get created.
SET search_path = public;

CREATE OR REPLACE FUNCTION fti() RETURNS trigger AS
	'$libdir/fti', 'fti'
	LANGUAGE 'C' VOLATILE CALLED ON NULL INPUT;
