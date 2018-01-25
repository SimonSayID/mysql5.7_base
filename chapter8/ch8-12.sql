USE `cookbook`;

-- Raising Warnings
DROP PROCEDURE IF EXISTS drop_user_warn;

DELIMITER $$
CREATE PROCEDURE drop_user_warn (user TEXT, host TEXT)
BEGIN
	DECLARE account TEXT;
	DECLARE CONTINUE HANDLER FOR 1396
	BEGIN
		DECLARE msg TEXT;
		SET msg = CONCAT('Unknown user: ', account);
		SIGNAL SQLSTATE '01000' 
		SET MYSQL_ERRNO = 1642, MESSAGE_TEXT = msg;
	END;
	SET account = CONCAT(QUOTE(user), '@', QUOTE(host));
	CALL exec_stmt(CONCAT('DROP USER ', account));
END;
$$

CALL drop_user_warn('bad-user', 'localhost');

SHOW WARNINGS;