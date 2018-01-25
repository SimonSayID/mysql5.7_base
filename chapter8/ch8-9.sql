USE `cookbook`;

-- Writing Helper Routines for Executing Dynamic SQL
DROP PROCEDURE IF EXISTS exec_stmt;

DELIMITER $$
CREATE PROCEDURE exec_stmt (stmt_str TEXT)
BEGIN
	SET @_stmt_str = stmt_str;
	PREPARE stmt FROM @_stmt_str;
	EXECUTE stmt;
	DEALLOCATE PREPARE stmt;
END;
$$
DELIMITER ;

SET @tbl_name = 'abs';
SET @val = 5;

CALL exec_stmt(
	CONCAT('CREATE TABLE ', @tbl_name, ' (i  INT)'));
CALL exec_stmt(
	CONCAT('INSERT INTO ', @tbl_name, ' (i) VALUES(',@val,')'));

SELECT * FROM abs;

DROP TABLE abs;