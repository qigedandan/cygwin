-- Adjust this setting to control where the objects get created.
SET search_path = public;

CREATE OR REPLACE FUNCTION digest(text, text)
RETURNS bytea
AS '$libdir/pgcrypto', 'pg_digest'
LANGUAGE 'C';

CREATE OR REPLACE FUNCTION digest(bytea, text)
RETURNS bytea
AS '$libdir/pgcrypto', 'pg_digest'
LANGUAGE 'C';

CREATE OR REPLACE FUNCTION digest_exists(text)
RETURNS bool
AS '$libdir/pgcrypto', 'pg_digest_exists'
LANGUAGE 'C';

CREATE OR REPLACE FUNCTION hmac(text, text, text)
RETURNS bytea
AS '$libdir/pgcrypto', 'pg_hmac'
LANGUAGE 'C';

CREATE OR REPLACE FUNCTION hmac(bytea, bytea, text)
RETURNS bytea
AS '$libdir/pgcrypto', 'pg_hmac'
LANGUAGE 'C';

CREATE OR REPLACE FUNCTION hmac_exists(text)
RETURNS bool
AS '$libdir/pgcrypto', 'pg_hmac_exists'
LANGUAGE 'C';

CREATE OR REPLACE FUNCTION crypt(text, text)
RETURNS text
AS '$libdir/pgcrypto', 'pg_crypt'
LANGUAGE 'C';

CREATE OR REPLACE FUNCTION gen_salt(text)
RETURNS text
AS '$libdir/pgcrypto', 'pg_gen_salt'
LANGUAGE 'C';

CREATE OR REPLACE FUNCTION gen_salt(text, int4)
RETURNS text
AS '$libdir/pgcrypto', 'pg_gen_salt_rounds'
LANGUAGE 'C';

CREATE OR REPLACE FUNCTION encrypt(bytea, bytea, text)
RETURNS bytea
AS '$libdir/pgcrypto', 'pg_encrypt'
LANGUAGE 'C';

CREATE OR REPLACE FUNCTION decrypt(bytea, bytea, text)
RETURNS bytea
AS '$libdir/pgcrypto', 'pg_decrypt'
LANGUAGE 'C';

CREATE OR REPLACE FUNCTION encrypt_iv(bytea, bytea, bytea, text)
RETURNS bytea
AS '$libdir/pgcrypto', 'pg_encrypt_iv'
LANGUAGE 'C';

CREATE OR REPLACE FUNCTION decrypt_iv(bytea, bytea, bytea, text)
RETURNS bytea
AS '$libdir/pgcrypto', 'pg_decrypt_iv'
LANGUAGE 'C';

CREATE OR REPLACE FUNCTION cipher_exists(text)
RETURNS bool
AS '$libdir/pgcrypto', 'pg_cipher_exists'
LANGUAGE 'C';


