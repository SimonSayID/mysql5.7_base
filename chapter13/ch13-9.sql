USE `cookbook`;

-- Computing Team Standings
DROP TABLE IF EXISTS standings1;

CREATE TABLE standings1
(
	team 	CHAR(20),
	wins 	INT,
	losses 	INT
);

INSERT INTO standings1 (team, wins, losses)
	VALUES
		('Winnipeg',37,20),
		('Crookston',31,25),
		('Fargo',30,26),
		('Grand Forks',28,26),
		('Devils Lake',19,31),
		('Cavalier',15,32);

SELECT team, wins, losses FROM standings1
	ORDER BY wins-losses DESC;

SET @wl_diff = (SELECT MAX(wins-losses) FROM standings1);

SELECT team, wins AS W, losses AS L,
	wins / (wins + losses) AS PCT,
	(@wl_diff - (wins-losses)) / 2 AS GB
	FROM standings1 ORDER BY wins-losses DESC, PCT DESC;

SELECT team, wins AS W, losses AS L,
	TRUNCATE(wins / (wins + losses), 3) AS PCT,
	IF
	(
		@wl_diff = wins-losses, '-', 
		TRUNCATE((@wl_diff - (wins - losses)) / 2, 1)
	) AS GB
	FROM standings1 ORDER BY wins-losses DESC, PCT DESC;

DROP TABLE IF EXISTS standings2;

CREATE TABLE standings2
(
	half 		INT,
	division 	CHAR(10),
	team 		CHAR(20),
	wins 		INT,
	losses 		INT
);

INSERT INTO standings2 (half, division, team, wins, losses)
  VALUES 
  	(1,'Eastern','St. Paul',24,18),
	(1,'Eastern','Thunder Bay',18,24),
	(1,'Eastern','Duluth-Superior',17,24),
	(1,'Eastern','Madison',15,27),
	(1,'Western','Winnipeg',29,12),
	(1,'Western','Sioux City',28,14),
	(1,'Western','Fargo-Moorhead',21,21),
	(1,'Western','Sioux Falls',15,27),
	(2,'Eastern','Duluth-Superior',22,20),
	(2,'Eastern','St. Paul',21,21),
	(2,'Eastern','Madison',19,23),
	(2,'Eastern','Thunder Bay',18,24),
	(2,'Western','Fargo-Moorhead',26,16),
	(2,'Western','Winnipeg',24,18),
	(2,'Western','Sioux City',22,20),
	(2,'Western','Sioux Falls',16,26);

SELECT half, division, team, wins, losses FROM standings2
	ORDER BY half, division, wins-losses DESC;

CREATE TEMPORARY TABLE firstplace
SELECT half, division, MAX(wins-losses) AS wl_diff
FROM standings2 GROUP BY half, division;

SELECT wl.half, wl.division, wl.team, wl.wins AS W, wl.losses AS L,
	TRUNCATE(wl.wins/(wl.wins + losses), 3) AS PCT,
	IF
	(
		fp.wl_diff = wl.wins - wl.losses, '-',
		TRUNCATE((fp.wl_diff - (wl.wins - wl.losses)) / 2, 1)
	) AS GB
	FROM standings2 AS wl JOIN firstplace AS fp
	ON wl.half = fp.half AND wl.division = fp.division
	ORDER BY wl.half, wl.division, wl.wins-wl.losses DESC, PCT DESC;