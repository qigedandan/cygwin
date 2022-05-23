-- Adjust this setting to control where the objects get created.
SET search_path = public;

CREATE FUNCTION levenshtein (text,text)
RETURNS int
AS '$libdir/fuzzystrmatch','levenshtein'
LANGUAGE 'C' WITH (iscachable, isstrict);

CREATE FUNCTION metaphone (text,int)
RETURNS text
AS '$libdir/fuzzystrmatch','metaphone'
LANGUAGE 'C' WITH (iscachable, isstrict);

CREATE FUNCTION soundex(text) RETURNS text
AS '$libdir/fuzzystrmatch', 'soundex'
LANGUAGE 'C' WITH (iscachable, isstrict);

CREATE FUNCTION text_soundex(text) RETURNS text
AS '$libdir/fuzzystrmatch', 'soundex'
LANGUAGE 'C' WITH (iscachable, isstrict);

CREATE FUNCTION dmetaphone (text) RETURNS text 
LANGUAGE C IMMUTABLE STRICT
AS '$libdir/fuzzystrmatch', 'dmetaphone';

CREATE FUNCTION dmetaphone_alt (text) RETURNS text 
LANGUAGE C IMMUTABLE STRICT
AS '$libdir/fuzzystrmatch', 'dmetaphone_alt';
