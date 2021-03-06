CREATE OR REPLACE FUNCTION dblink_connect (text)
RETURNS text
AS '$libdir/dblink','dblink_connect'
LANGUAGE 'C' STRICT;

CREATE OR REPLACE FUNCTION dblink_connect (text, text)
RETURNS text
AS '$libdir/dblink','dblink_connect'
LANGUAGE 'C' STRICT;

CREATE OR REPLACE FUNCTION dblink_disconnect ()
RETURNS text
AS '$libdir/dblink','dblink_disconnect'
LANGUAGE 'C' STRICT;

CREATE OR REPLACE FUNCTION dblink_disconnect (text)
RETURNS text
AS '$libdir/dblink','dblink_disconnect'
LANGUAGE 'C' STRICT;

CREATE OR REPLACE FUNCTION dblink_open (text,text)
RETURNS text
AS '$libdir/dblink','dblink_open'
LANGUAGE 'C' STRICT;

CREATE OR REPLACE FUNCTION dblink_open (text,text,bool)
RETURNS text
AS '$libdir/dblink','dblink_open'
LANGUAGE 'C' STRICT;

CREATE OR REPLACE FUNCTION dblink_open (text,text,text)
RETURNS text
AS '$libdir/dblink','dblink_open'
LANGUAGE 'C' STRICT;

CREATE OR REPLACE FUNCTION dblink_open (text,text,text,bool)
RETURNS text
AS '$libdir/dblink','dblink_open'
LANGUAGE 'C' STRICT;

CREATE OR REPLACE FUNCTION dblink_fetch (text,int)
RETURNS setof record
AS '$libdir/dblink','dblink_fetch'
LANGUAGE 'C' STRICT;

CREATE OR REPLACE FUNCTION dblink_fetch (text,int,bool)
RETURNS setof record
AS '$libdir/dblink','dblink_fetch'
LANGUAGE 'C' STRICT;

CREATE OR REPLACE FUNCTION dblink_fetch (text,text,int)
RETURNS setof record
AS '$libdir/dblink','dblink_fetch'
LANGUAGE 'C' STRICT;

CREATE OR REPLACE FUNCTION dblink_fetch (text,text,int,bool)
RETURNS setof record
AS '$libdir/dblink','dblink_fetch'
LANGUAGE 'C' STRICT;

CREATE OR REPLACE FUNCTION dblink_close (text)
RETURNS text
AS '$libdir/dblink','dblink_close'
LANGUAGE 'C' STRICT;

CREATE OR REPLACE FUNCTION dblink_close (text,bool)
RETURNS text
AS '$libdir/dblink','dblink_close'
LANGUAGE 'C' STRICT;

CREATE OR REPLACE FUNCTION dblink_close (text,text)
RETURNS text
AS '$libdir/dblink','dblink_close'
LANGUAGE 'C' STRICT;

CREATE OR REPLACE FUNCTION dblink_close (text,text,bool)
RETURNS text
AS '$libdir/dblink','dblink_close'
LANGUAGE 'C' STRICT;

CREATE OR REPLACE FUNCTION dblink (text,text)
RETURNS setof record
AS '$libdir/dblink','dblink_record'
LANGUAGE 'C' STRICT;

CREATE OR REPLACE FUNCTION dblink (text,text,bool)
RETURNS setof record
AS '$libdir/dblink','dblink_record'
LANGUAGE 'C' STRICT;

CREATE OR REPLACE FUNCTION dblink (text)
RETURNS setof record
AS '$libdir/dblink','dblink_record'
LANGUAGE 'C' STRICT;

CREATE OR REPLACE FUNCTION dblink (text,bool)
RETURNS setof record
AS '$libdir/dblink','dblink_record'
LANGUAGE 'C' STRICT;

CREATE OR REPLACE FUNCTION dblink_exec (text,text)
RETURNS text
AS '$libdir/dblink','dblink_exec'
LANGUAGE 'C' STRICT;

CREATE OR REPLACE FUNCTION dblink_exec (text,text,bool)
RETURNS text
AS '$libdir/dblink','dblink_exec'
LANGUAGE 'C' STRICT;

CREATE OR REPLACE FUNCTION dblink_exec (text)
RETURNS text
AS '$libdir/dblink','dblink_exec'
LANGUAGE 'c' STRICT;

CREATE OR REPLACE FUNCTION dblink_exec (text,bool)
RETURNS text
AS '$libdir/dblink','dblink_exec'
LANGUAGE 'c' STRICT;

CREATE TYPE dblink_pkey_results AS (position int4, colname text);

CREATE OR REPLACE FUNCTION dblink_get_pkey (text)
RETURNS setof dblink_pkey_results
AS '$libdir/dblink','dblink_get_pkey'
LANGUAGE 'c' STRICT;

CREATE OR REPLACE FUNCTION dblink_build_sql_insert (text, int2vector, int4, _text, _text)
RETURNS text
AS '$libdir/dblink','dblink_build_sql_insert'
LANGUAGE 'C' STRICT;

CREATE OR REPLACE FUNCTION dblink_build_sql_delete (text, int2vector, int4, _text)
RETURNS text
AS '$libdir/dblink','dblink_build_sql_delete'
LANGUAGE 'C' STRICT;

CREATE OR REPLACE FUNCTION dblink_build_sql_update (text, int2vector, int4, _text, _text)
RETURNS text
AS '$libdir/dblink','dblink_build_sql_update'
LANGUAGE 'C' STRICT;

CREATE OR REPLACE FUNCTION dblink_current_query ()
RETURNS text
AS '$libdir/dblink','dblink_current_query'
LANGUAGE 'C';
