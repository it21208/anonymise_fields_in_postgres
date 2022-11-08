-- Static Masking --> will destroy original data
-- 1. Installation
-- https://postgresql-anonymizer.readthedocs.io/en/latest/INSTALL/
-- (is compatible with PostgreSQL 9.6 or later)
-- 2.Enable anonymizer
CREATE EXTENSION anon CASCADE;
SELECT anon.init();

-- 3.Declare masking rules --for fields
-- #username
SECURITY LABEL FOR anon ON COLUMN auth_user.username
IS 'MASKED WITH FUNCTION anon.fake_first_name() || '' '' || anon.fake_last_name()';

--#first_name
SECURITY LABEL FOR anon ON COLUMN auth_user.firstname
IS 'MASKED WITH FUNCTION anon.fake_first_name()';

-- #last_name
SECURITY LABEL FOR anon ON COLUMN auth_user.lastname
IS 'MASKED WITH FUNCTION anon.fake_last_name()';

-- #email
SECURITY LABEL FOR anon ON COLUMN auth_user.email
IS 'MASKED WITH FUNCTION anon.fake_email()';
 
-- 4.Anonymize Table
SELECT anon.anonymize_table('auth_user');

-- 5.Verify anonymization
select * from auth_user;