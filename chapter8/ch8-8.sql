USE `cookbook`;

-- Using Events to Schedule Database Actions

-- requires the SUPER privilege
SET GLOBAL event_scheduler = 1;

DROP TABLE IF EXISTS mark_log;

CREATE TABLE mark_log
(
	ts 		TIMESTAMP 
				DEFAULT CURRENT_TIMESTAMP
				ON UPDATE CURRENT_TIMESTAMP,
	message	VARCHAR(100)
);

DROP EVENT IF EXISTS mark_insert;

CREATE EVENT mark_insert ON SCHEDULE EVERY 1 SECOND
DO INSERT INTO mark_log (message) VALUES ('-- MARK --');

SHOW VARIABLES LIKE 'event_scheduler';

SELECT SLEEP(3);

ALTER EVENT mark_insert DISABLE;

SELECT * FROM mark_log;

SELECT SLEEP(3);

SELECT * FROM mark_log;

ALTER EVENT mark_insert ENABLE;

SELECT SLEEP(3);

ALTER EVENT mark_insert DISABLE;

SELECT * FROM mark_log;