USE `cookbook`;

DROP PROCEDURE IF EXISTS show_version;

CREATE PROCEDURE show_version()
SELECT VERSION() AS 'Mysql Version';

CALL cookbook.show_version();

-- Compound-Statement Objects
DROP FUNCTION IF EXISTS avg_mail_size;

DELIMITER $$
CREATE FUNCTION avg_mail_size(user VARCHAR(8))
RETURNS FLOAT READS SQL DATA
BEGIN
	DECLARE avg FLOAT;
	IF user IS NULL
	THEN
		SET avg = (SELECT AVG(size) FROM mail);
	ELSE
		SET avg = (SELECT AVG(size) FROM mail WHERE srcuser = user);
	END IF;
	RETURN avg;
END;
$$
DELIMITER ;

SELECT avg_mail_size(NULL), avg_mail_size('barb');