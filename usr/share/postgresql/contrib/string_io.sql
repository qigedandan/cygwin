-- string_io.sql --
--
-- SQL code to define the new string I/O functions
--
-- Copyright (c) 1998, Massimo Dal Zotto <dz@cs.unitn.it>
--
-- This file is distributed under the GNU General Public License
-- either version 2, or (at your option) any later version.

-- Define the new output functions.
--
CREATE FUNCTION c_charout(bpchar)
RETURNS cstring
AS '$libdir/string_io' 
LANGUAGE 'C';

CREATE FUNCTION c_textout(text)
RETURNS cstring
AS '$libdir/string_io' 
LANGUAGE 'C';

CREATE FUNCTION c_varcharout(varchar)
RETURNS cstring
AS '$libdir/string_io' 
LANGUAGE 'C';

-- This is not needed because escapes are handled by the parser
--
-- CREATE FUNCTION c_textin(cstring)
-- RETURNS text
-- AS '$libdir/string_io' 
-- LANGUAGE 'c';

-- Define a function which sets the new output routines for char types.
--
--   SELECT c_mode();
--
CREATE FUNCTION c_mode()
RETURNS text
AS '  UPDATE pg_type SET typoutput=''c_textout''    WHERE typname=''SET'';
      UPDATE pg_type SET typoutput=''c_varcharout'' WHERE typname=''bpchar'';
      UPDATE pg_type SET typoutput=''c_textout''    WHERE typname=''bytea'';
      UPDATE pg_type SET typoutput=''c_charout''    WHERE typname=''char'';
      UPDATE pg_type SET typoutput=''c_textout''    WHERE typname=''text'';
      UPDATE pg_type SET typoutput=''c_textout''    WHERE typname=''unknown'';
      UPDATE pg_type SET typoutput=''c_varcharout'' WHERE typname=''varchar'';
      select ''c_mode''::text;'
LANGUAGE 'SQL';

-- Define a function which restores the standard routines for char types.
--
--   SELECT pg_mode();
--
CREATE FUNCTION pg_mode()
RETURNS text
AS '  UPDATE pg_type SET typoutput=''textout''    WHERE typname=''SET'';
      UPDATE pg_type SET typoutput=''varcharout'' WHERE typname=''bpchar'';
      UPDATE pg_type SET typoutput=''textout''    WHERE typname=''bytea'';
      UPDATE pg_type SET typoutput=''charout''    WHERE typname=''char'';
      UPDATE pg_type SET typoutput=''textout''    WHERE typname=''text'';
      UPDATE pg_type SET typoutput=''textout''    WHERE typname=''unknown'';
      UPDATE pg_type SET typoutput=''varcharout'' WHERE typname=''varchar'';
      select ''pg_mode''::text;'
LANGUAGE 'SQL';

-- Use these to do the changes manually.
--
-- UPDATE pg_type SET typoutput='textout'    WHERE typname='SET';
-- UPDATE pg_type SET typoutput='varcharout' WHERE typname='bpchar';
-- UPDATE pg_type SET typoutput='textout'    WHERE typname='bytea';
-- UPDATE pg_type SET typoutput='charout'    WHERE typname='char';
-- UPDATE pg_type SET typoutput='textout'    WHERE typname='text';
-- UPDATE pg_type SET typoutput='textout'    WHERE typname='unknown';
-- UPDATE pg_type SET typoutput='varcharout' WHERE typname='varchar';
--
-- UPDATE pg_type SET typoutput='c_textout'    WHERE typname='SET';
-- UPDATE pg_type SET typoutput='c_varcharout' WHERE typname='bpchar';
-- UPDATE pg_type SET typoutput='c_textout'    WHERE typname='bytea';
-- UPDATE pg_type SET typoutput='c_charout'    WHERE typname='char';
-- UPDATE pg_type SET typoutput='c_textout'    WHERE typname='text';
-- UPDATE pg_type SET typoutput='c_textout'    WHERE typname='unknown';
-- UPDATE pg_type SET typoutput='c_varcharout' WHERE typname='varchar';

-- end of file
