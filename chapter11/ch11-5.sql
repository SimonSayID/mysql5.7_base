USE `cookbook`;

DROP TABLE IF EXISTS booksales;

CREATE TABLE booksales
(
	title 	VARCHAR(60) NOT NULL,
	copies 	INT UNSIGNED NOT NULL,
	PRIMARY KEY (title)
);

INSERT INTO booksales (title, copies)
	VALUES ('The Greater Trumps', LAST_INSERT_ID(1))
	ON DUPLICATE KEY UPDATE copies = LAST_INSERT_ID(copies+1);

SELECT * FROM booksales;

INSERT INTO booksales (title, copies)
	VALUES ('The Greater Trumps', LAST_INSERT_ID(1))
	ON DUPLICATE KEY UPDATE copies = LAST_INSERT_ID(copies+1);

SELECT * FROM booksales;

-- By setting and retrieving the copies column this way, 
-- you always get back the value you set it to, even if some 
-- other client updated it in the meantime.

SELECT LAST_INSERT_ID();

-- If you issue the INSERT statement from within an API 
-- that provides a mechanism for fetching the most recent
-- AUTO_INCREMENT value directly, you need not even issue 
-- the SELECT query.
-- lastrowid do the job.