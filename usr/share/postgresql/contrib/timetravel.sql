-- Adjust this setting to control where the objects get created.
SET search_path = public;

SET autocommit TO 'on';

CREATE OR REPLACE FUNCTION timetravel() 
RETURNS trigger 
AS '$libdir/timetravel'
LANGUAGE 'C';

CREATE OR REPLACE FUNCTION set_timetravel(name, int4) 
RETURNS int4 
AS '$libdir/timetravel'
LANGUAGE 'C' WITH (isStrict);

CREATE OR REPLACE FUNCTION get_timetravel(name) 
RETURNS int4 
AS '$libdir/timetravel'
LANGUAGE 'C' WITH (isStrict);
