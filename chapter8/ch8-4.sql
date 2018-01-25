USE `cookbook`;

-- Using Stored Procedures to “Return” Multiple Values

-- • An IN parameter is for input only. This is the default if
--   you specify no type.
-- • An INOUT parameter is used to pass a value in, and can also
--   pass a value out.
-- • An OUT parameter is used to pass a value out.

DROP PROCEDURE IF EXISTS mail_sender_stats;

DELIMITER $$
CREATE PROCEDURE mail_sender_stats 
	(
		IN 	user VARCHAR(8),
		OUT message INT,
		OUT total_size INT,
		OUT avg_size INT
	)
BEGIN
	SELECT COUNT(*), IFNULL(SUM(size), 0), IFNULL(AVG(size), 0)
	INTO message, total_size, avg_size
	FROM mail WHERE srcuser = user;
END;
$$
DELIMITER ;

CALL mail_sender_stats('barb', @message, @total_size, @avg_size);
SELECT @message, @total_size, @avg_size;

-- If you call mail_sender_stats() from within a stored program,
-- you can pass variables to it using routine parameters or
-- program local variables, not just user-defined variables.

-- “stored program” refers collectively to stored routines,
-- triggers, and events.