USE `cookbook`;

SELECT ENGINE FROM INFORMATION_SCHEMA.ENGINES
	WHERE SUPPORT IN ('YES', 'DEFAULT') 
		AND TRANSACTIONS = 'YES';

-- If MySQL Cluster is enabled, you’ll also see a 
-- line that says ndbcluster

DROP TABLE IF EXISTS test_transaction;

CREATE TABLE test_transaction (i INT);

START TRANSACTION;
INSERT INTO test_transaction (i) VALUES (1);
INSERT INTO test_transaction (i) VALUES (2);
COMMIT;

SELECT * FROM test_transaction;
-- +------+
-- | i    |
-- +------+
-- |    1 |
-- |    2 |
-- +------+

-- use this way to execute SQL, when error occurs the rest of code
-- doesn't continue

-- START TRANSACTION;
-- INSERT INTO test_transaction (i) VALUES (3);
-- create a error
-- INSERT INTO test_transaction (x) VALUES (2);
-- ROLLBACK;

-- SELECT * FROM test_transaction;
-- +------+
-- | i    |
-- +------+
-- |    1 |
-- |    2 |
-- +------+

