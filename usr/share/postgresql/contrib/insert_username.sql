-- Adjust this setting to control where the objects get created.
SET search_path = public;

CREATE OR REPLACE FUNCTION insert_username() 
RETURNS trigger 
AS '$libdir/insert_username'
LANGUAGE 'C';
