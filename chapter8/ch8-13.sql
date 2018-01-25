USE `cookbook`;

-- Using Triggers to Preprocess or Reject Data

DROP TABLE IF EXISTS contact_info;

CREATE TABLE contact_info
(
	id 		INT NOT NULL AUTO_INCREMENT,
	name	VARCHAR(30),
	state	CHAR(2),
	email	VARCHAR(50),
	url		VARCHAR(255),
	PRIMARY KEY (id)
);

DROP TRIGGER IF EXISTS bi_contact_info;

DELIMITER $$
CREATE TRIGGER bi_contact_info BEFORE INSERT ON contact_info
FOR EACH ROW
BEGIN
	IF (SELECT COUNT(*) FROM states 
			WHERE abbrev = NEW.state) = 0 THEN
		SIGNAL SQLSTATE 'HY000'
		SET MYSQL_ERRNO = 1525, MESSAGE_TEXT = 'invalid state code';
	END IF;
	IF INSTR(NEW.email, '@') = 0 THEN
		SIGNAL SQLSTATE 'HY000'
		SET MYSQL_ERRNO = 1525, MESSAGE_TEXT = 'invalid email address';
	END IF;
	SET NEW.url = TRIM(LEADING 'http://' FROM NEW.url);
END;
$$
DELIMITER ;

INSERT INTO contact_info (name, state, email, url)
	VALUES
		('Jen', 'NY', 'jen@example.com', 'http://www.example.com');

-- INSERT INTO contact_info (name, state, email, url)
-- 	VALUES
-- 		('Ken', 'XX', 'Ken@example.com', 'http://www.example.com');
-- Result: ERROR 1525 (HY000) at line 39: invalid state code

-- INSERT INTO contact_info (name, state, email, url)
-- 	VALUES
-- 		('Sam', 'NY', 'Sam', 'http://www.example.com');
-- Result: ERROR 1525 (HY000) at line 43: invalid email address

SELECT * FROM contact_info;