USE `cookbook`;

DROP TABLE IF EXISTS t;
CREATE TABLE t (ts TIMESTAMP);
INSERT INTO t (ts) VALUES('2014-06-01 12:30:00');
SELECT ts FROM t;

-- if return SYSTEM, it means every MySQL function call that requires a 
-- timezone calculation makes a system library call to determine the
-- current system timezone
SELECT @@global.time_zone, @@session.time_zone;

-- need super privilege
SET GLOBAL time_zone = '+06:00';
SET SESSION time_zone = '+06:00';
SELECT @@global.time_zone, @@session.time_zone;

SELECT ts FROM t;

SET SESSION time_zone = '+04:00';
SELECT @@global.time_zone, @@session.time_zone;

SELECT ts FROM t;

SET GLOBAL time_zone = 'SYSTEM';
SET SESSION time_zone = 'SYSTEM';

SELECT @@global.time_zone, @@session.time_zone;

SELECT ts FROM t;