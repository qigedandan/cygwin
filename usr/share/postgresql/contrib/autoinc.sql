-- Adjust this setting to control where the objects get created.
SET search_path = public;

CREATE OR REPLACE FUNCTION autoinc() 
RETURNS trigger 
AS '$libdir/autoinc'
LANGUAGE 'C';
