USE `cookbook`;

-- Handling Errors Within Stored Programs

DROP PROCEDURE IF EXISTS us_population;

DELIMITER $$
CREATE PROCEDURE us_population()
BEGIN
	DECLARE done BOOLEAN DEFAULT FALSE;
	DECLARE state_pop, total_pop BIGINT DEFAULT 0;
	DECLARE cur CURSOR FOR SELECT pop FROM states;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

	OPEN cur;
	fetch_loop: LOOP
		FETCH cur INTO state_pop;
		IF done THEN
			LEAVE fetch_loop;
		END IF;
		SET total_pop = total_pop + state_pop;
	END LOOP;
	CLOSE cur;
	SELECT total_pop AS 'Total U.S. Population';
END;
$$
DELIMITER ;

CALL us_population();

SELECT SUM(pop) AS 'Total U.S. Population' FROM states;

DROP PROCEDURE IF EXISTS drop_user;
-- the exec_stmt procedure need to be create by root and run by root
-- ERROR 1396 (HY000): Operation DROP USER failed
DELIMITER $$
CREATE PROCEDURE drop_user(user TEXT, host TEXT)
DETERMINISTIC
BEGIN
	DECLARE account TEXT;
	DECLARE CONTINUE HANDLER FOR 1396
		SELECT CONCAT('Unknown user: ', account) AS Message;
	SET account = CONCAT(QUOTE(user), '@', QUOTE(host));
	CALL exec_stmt(CONCAT('DROP USER ', account));
END;
$$
DELIMITER ;

CALL drop_user('bad_user', 'localhost');

-- To ignore the error completely, write the handler using 
-- an empty BEGIN ... END block:
-- DECLARE CONTINUE HANDLER FOR 1396 BEGIN END;