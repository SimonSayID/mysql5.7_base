USE `cookbook`;

DROP TABLE IF EXISTS time_val;

CREATE TABLE time_val
(
	t1	TIME,
	t2 	TIME
);

INSERT INTO time_val (t1, t2)
	VALUES
		('15:00:00','15:00:00'),
		('05:01:30','02:30:20'),
		('12:30:20','17:30:45')
;

DROP TABLE IF EXISTS date_val;

CREATE TABLE date_val
(
	d 	DATE
);

INSERT INTO date_val (d)
	VALUES
		('1864-02-28'),
		('1900-01-15'),
		('1999-12-31'),
		('2000-06-04'),
		('2017-03-16')
;

DROP TABLE IF EXISTS datetime_val;

CREATE TABLE datetime_val
(
	dt DATETIME
);

INSERT INTO datetime_val (dt)
	VALUES
		('1970-01-01 00:00:00'),
		('1999-12-31 09:00:00'),
		('2000-06-04 15:45:30'),
		('2017-03-16 12:30:15')
;