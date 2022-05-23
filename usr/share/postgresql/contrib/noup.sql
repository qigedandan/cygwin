-- Adjust this setting to control where the objects get created.
SET search_path = public;

CREATE OR REPLACE FUNCTION noup ()
RETURNS trigger
AS '$libdir/noup'
LANGUAGE 'C';
