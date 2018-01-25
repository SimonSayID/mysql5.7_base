USE `cookbook`;


DROP TABLE IF EXISTS test_transaction;

CREATE TABLE test_transaction (i INT);
SET autocommit = 0;
INSERT INTO test_transaction (i) VALUES (1);

SELECT * FROM test_transaction;

ROLLBACK;

INSERT INTO test_transaction (i) VALUES (3);
COMMIT;

SELECT * FROM test_transaction;

SET autocommit = 1;