USE `cookbook`;

-- Assigning Ranks

SET @rownum = 0;

SELECT @rownum := @rownum + 1 AS rank, score 
	FROM testscore ORDER BY score DESC;

SET @rank = 0, @prev_val = NULL;
SELECT @rank := IF(@prev_val=score, @rank, @rank + 1) AS rank,
	@prev_val := score AS score
	FROM testscore ORDER BY score DESC;

SET @rownum = 0, @rank = 0, @prev_val = NULL;
SELECT @rownum := @rownum + 1 AS row,
	@rank := IF(@prev_val<>score, @rownum,@rank) AS rank,
	@prev_val := score AS score
	FROM testscore ORDER BY score DESC;

DROP TABLE IF EXISTS al_winner;

CREATE TABLE al_winner
(
	name 	CHAR(30),
	wins 	INT
);

LOAD DATA LOCAL INFILE 'al_winner-2001.txt' INTO TABLE al_winner;

SET @rownum = 0, @rank = 0, @prev_val = NULL;
SELECT @rownum := @rownum + 1 AS row,
	@rank := IF(@prev_val<>wins, @rownum, @rank) AS rank,
	name, @prev_val := wins AS wins
	FROM al_winner ORDER BY wins DESC;