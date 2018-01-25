USE `cookbook`;

DROP TABLE IF EXISTS t;
CREATE TABLE t (c CHAR(3) CHARACTER SET latin1);
INSERT INTO t (c) VALUES ('AAA'), ('bbb'), ('aaa'), ('BBB');
SELECT c FROM t;

SELECT c FROM t ORDER BY c COLLATE latin1_swedish_ci;
SELECT c FROM t ORDER BY c COLLATE latin1_general_cs;
SELECT c FROM t ORDER BY c COLLATE latin1_bin;

DROP TABLE IF EXISTS t;
CREATE TABLE t (c CHAR(3) CHARACTER SET utf8);
INSERT INTO t (c) VALUES ('ci'), ('ch'), ('ll'), ('cg'), ('lk'), ('lm');

-- To use the traditional Spanish ordering that
-- treats ch and ll as single characters that follow c and l, 
-- respectively, specify the utf8_spanish2_ci collation.
-- characters that follow c and l , respectively, specify the utf8_spanish2_ci collation
SELECT c FROM t ORDER BY c COLLATE utf8_general_ci;
SELECT c FROM t ORDER BY c COLLATE utf8_spanish2_ci;

DROP TABLE IF EXISTS t;