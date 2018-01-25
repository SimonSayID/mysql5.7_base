USE `cookbook`;

-- Raising Errors
DROP FUNCTION IF EXISTS divide;

DELIMITER $$
CREATE FUNCTION divide (numerator FLOAT, divisor FLOAT)
RETURNS FLOAT DETERMINISTIC
BEGIN
	IF divisor = 0 THEN
		SIGNAL SQLSTATE '22012'
			SET MYSQL_ERRNO = 1365,
			MESSAGE_TEXT = 'unexpected 0 divisor';
	END IF;
	RETURN numerator / divisor;
END;
$$
DELIMITER ;

SELECT divide(1, 0);
-- result:
-- ERROR 1365 (22012) at line 19: unexpected 0 divisor
