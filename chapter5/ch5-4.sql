USE `cookbook`;

-- Chicago, Illinois, US US/Central
-- Berlin, Germany Europe/Berlin
-- London, United Kingdom Europe/London
-- Edmonton, Alberta, Canada America/Edmonton
-- Brisbane, Australia Australia/Brisbane

-- need to set up mysql time_zone table
SET @dt = '2014-11-23 09:00:00';
SELECT @dt AS Chicago,
	CONVERT_TZ(@dt, 'US/Central', 'Europe/Berlin') AS Berlin,
	CONVERT_TZ(@dt, 'US/Central', 'Europe/London') AS London,
	CONVERT_TZ(@dt, 'US/Central', 'America/Edmonton') AS Edmonton,
	CONVERT_TZ(@dt, 'US/Central', 'Australia/Brisbane') AS Brisbane\G

SELECT @dt AS Chicagi,
	CONVERT_TZ(@dt, '-06:00', '+01:00') AS Berlin,
	CONVERT_TZ(@dt, '-06:00', '+00:00') AS London,
	CONVERT_TZ(@dt, '-06:00', '-07:00')	AS Edmonton,
	CONVERT_TZ(@dt, '-06:00', '+10:00') AS Brisbane\G

SELECT CURDATE(), CURTIME(), NOW();

SELECT UTC_DATE(), UTC_TIME(), UTC_TIMESTAMP();

-- For the first TIMESTAMP column in a table, if neither of the 
-- DEFAULT or ON UPDATE attributes are specified, the column is
-- implicitly defined with both. For DATETIME ,automatic properties
-- never apply implicitly; only those specified explicitly. (To
-- suppress implicit attribute definition for TIMESTAMP columns, 
-- enable the explicit_defaults_for_timestamp system variable.)

-- in ts_update, if writes 'TIMESTAMP NULL DEFAULT NULL',
-- the ts_update result is both NULL.
DROP TABLE IF EXISTS tsdemo;
CREATE TABLE tsdemo
(
	val INT,
	-- auto-initializes and auto-updates
	ts_both		TIMESTAMP DEFAULT CURRENT_TIMESTAMP 
					ON UPDATE CURRENT_TIMESTAMP,
	-- auto-initializes
	ts_create	TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	-- auto-updates
	ts_update	TIMESTAMP DEFAULT '1970-01-01 00:00:01'
					 ON UPDATE CURRENT_TIMESTAMP
);

INSERT INTO tsdemo (val) VALUES(5);
INSERT INTO tsdemo (val, ts_both, ts_create, ts_update)
				VALUES (10, NULL, NULL, NULL);

SELECT * FROM tsdemo;

SELECT SLEEP(2);

UPDATE tsdemo SET val = 11 WHERE val = 10;
SELECT * FROM tsdemo;

SELECT SLEEP(2);

UPDATE tsdemo SET val = val + 1;
SELECT * FROM tsdemo;

SELECT SLEEP(2);
-- An UPDATE statement that doesn’t actually change any value in a row
-- doesn’t modify auto-update columns
UPDATE tsdemo SET val = val;
SELECT * FROM tsdemo;

