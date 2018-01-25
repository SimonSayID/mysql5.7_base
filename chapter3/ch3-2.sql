USE `cookbook`;

-- "hides" the permanent table for the duration
-- of its existence.
-- if use LIKE mail
-- ERROR 1066 (42000) at line 41: Not unique table/alias: 'mail'
CREATE TEMPORARY TABLE mail SELECT * FROM mail;

SELECT COUNT(*) FROM mail;

DELETE FROM mail;
SELECT COUNT(*) FROM mail;

DROP TEMPORARY TABLE mail;
SELECT COUNT(*) FROM mail;

SELECT CONNECTION_ID();
SET @tbl_name = CONCAT('tmp_tbl_', CONNECTION_ID());
SET @stmt = CONCAT('DROP TABLE IF EXISTS ', @tbl_name);
PREPARE stmt FROM @stmt;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;
SET @stmt = CONCAT('CREATE TABLE ', @tbl_name, ' (i INT)');
PREPARE stmt FROM @stmt;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

SET @stmt = CONCAT('DESCRIBE ', @tbl_name);
PREPARE stmt FROM @stmt;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

SET @stmt = CONCAT('DROP TABLE ', @tbl_name);
PREPARE stmt FROM @stmt;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;