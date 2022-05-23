-- Adjust this setting to control where the objects get created.
SET search_path = public;

CREATE OR REPLACE FUNCTION moddatetime()
RETURNS trigger
AS '$libdir/moddatetime'
LANGUAGE 'C';
