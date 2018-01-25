USE `cookbook`;

-- REGEXP works only for single-byte character sets

SELECT name FROM metal WHERE name REGEXP '^me';

SELECT name FROM metal WHERE name REGEXP 'old$';

SELECT name FROM metal WHERE name REGEXP 'in';

SELECT name FROM metal WHERE name REGEXP '^..at';

-- matches values that contain any hexadecimal digit character
SELECT name, name REGEXP '[[:xdigit:]]' FROM metal;

SELECT name FROM metal WHERE name REGEXP '^[aeiou]|d$';

SELECT '0m' REGEXP '^[[:digit:]]+|[[:alpha:]]+$';

SELECT '0m' REGEXP '^([[:digit:]]+|[[:alpha:]]+)$';

SELECT '00' REGEXP '^([[:digit:]]+|[[:alpha:]]+)$';

SELECT 'mm' REGEXP '^([[:digit:]]+|[[:alpha:]]+)$';

SELECT NULL REGEXP '.*', NULL NOT REGEXP '.*';