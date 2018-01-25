USE `cookbook`;

-- Simulating TIMESTAMP Properties for Other Date and Time Types

DROP TABLE IF EXISTS ts_emulate;

CREATE TABLE ts_emulate 
(
	data 	CHAR(10),
	d 		DATE,
	t 		TIME,
	a 		DATE,
	b 		TIME
);

DROP TRIGGER IF EXISTS bi_ts_emulate;
CREATE TRIGGER bi_ts_emulate BEFORE INSERT ON ts_emulate
FOR EACH ROW SET NEW.d = CURDATE(), NEW.t = CURTIME();

DROP TRIGGER IF EXISTS bu_ts_emulate;

DELIMITER $$
CREATE TRIGGER bu_ts_emulate BEFORE UPDATE ON ts_emulate
FOR EACH ROW
	IF NEW.data <> OLD.DATA THEN
		SET NEW.d = CURDATE(), NEW.t = CURTIME();
	END IF;
$$
DELIMITER ;

INSERT INTO ts_emulate (data) VALUES ('cat');

SELECT SLEEP(1);

INSERT INTO ts_emulate (data) VALUES ('dog');

SELECT * FROM ts_emulate;

SELECT SLEEP(1);

UPDATE ts_emulate SET data = 'axolotl' WHERE data = 'cat';

SELECT * FROM ts_emulate;

SELECT SLEEP(1);

UPDATE ts_emulate SET data = data;

SELECT * FROM ts_emulate;