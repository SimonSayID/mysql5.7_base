USE `cookbook`;

DROP TABLE IF EXISTS trip_log;

CREATE TABLE trip_log
(
	seq 	INT UNSIGNED NOT NULL AUTO_INCREMENT,
	city 	VARCHAR(30) NOT NULL,
	t 		DATETIME NOT NULL,
	miles 	INT UNSIGNED NOT NULL,
	fuel 	DECIMAL(6, 3),
	PRIMARY KEY (seq)
);

INSERT INTO trip_log (t, city, miles, fuel)
	VALUES
('2013-10-23 05:00:00', 'San Antonio, TX', 0, 0),
('2013-10-23 09:10:00', 'Dallas, TX', 263, 11.375),
('2013-10-23 13:40:00', 'Benton, AR', 566, 12.398),
('2013-10-23 16:51:00', 'Memphis, TN', 745, 6.820),
('2013-10-23 19:06:00', 'Portageville, MO', 745+133, 7.007),
('2013-10-23 23:16:00', 'Champaign, IL', 745+419, 11.354),
('2013-10-24 03:27:00', 'Madison, WI', 745+667, 13.016);

SELECT seq, city, miles FROM trip_log ORDER BY seq;

-- Calculating Successive-Row Differences

-- the differences between each pair of mileage values
SELECT t1.seq AS seq1, t2.seq AS seq2,
	t1.city AS city1, t2.city AS city2,
	t1.miles AS miles1, t2.miles AS miles2,
	t2.miles - t1.miles AS dist
	FROM trip_log AS t1 JOIN trip_log AS t2
	ON t1.seq + 1 = t2.seq 
	ORDER BY t1.seq;

DROP TABLE IF EXISTS player_stats;

CREATE TABLE player_stats
(
	id 		INT UNSIGNED NOT NULL AUTO_INCREMENT,
	date 	DATE NOT NULL,
	ab 		INT UNSIGNED NOT NULL,
	h 		INT UNSIGNED NOT NULL,

	PRIMARY KEY (id)
);

INSERT INTO player_stats (date, ab, h)
	VALUES
		('2013-04-30', 0, 0),
		('2013-05-31', 38, 13),
  		('2013-06-30', 109, 31),
  		('2013-07-31', 196, 49),
  		('2013-08-31', 304, 98)
;

SELECT id, date, ab, h, TRUNCATE(IFNULL(h/ab, 0), 3) AS ba
	FROM player_stats ORDER BY id;

SELECT 
	t1.id AS id1, t2.id AS id2,
	t2.date,
	t1.ab AS ab1, t2.ab AS ab2,
	t1.h AS h1, t2.h AS h2,
	t2.ab - t1.ab AS abdiff,
	t2.h - t1.h AS hdiff,
	TRUNCATE(IFNULL((t2.h-t1.h)/(t2.ab-t1.ab),0),3) AS ba
	FROM player_stats AS t1 JOIN player_stats AS t2
	ON t1.id + 1 = t2.id ORDER BY t1.id;