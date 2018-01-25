USE `cookbook`;

-- Preventing Duplicates from Occurring in a Table
DROP TABLE IF EXISTS p_1;

CREATE TABLE p_1
(
	last_name 	CHAR(20) NOT NULL,
	first_name 	CHAR(20) NOT NULL,
	address 	CHAR(40),
	PRIMARY KEY (first_name)
);

-- UNIQUE index can be created on columns that permit NULL values.
-- DROP TABLE IF EXISTS p_2

-- CREATE TABLE p_2
-- (
-- 	last_name 	CHAR(20),
-- 	first_name 	CHAR(20),
-- 	address 	CHAR(40),
-- 	UNIQUE (last_name, first_name)
-- );

-- Dealing with Duplicates When Loading Rows into a Table
INSERT INTO p_1 (last_name, first_name)
	VALUES ('X1', 'Y1');

-- The row count value indicates whether the row 
-- was inserted or ignored.
INSERT IGNORE INTO p_1 (last_name, first_name)
	VALUES ('X2', 'Y1');

-- replace the original row with the new one when a duplicate
-- occurs
-- If the row is new, it’s inserted just as with INSERT . If it’s
-- a duplicate, the new row replaces the old one
REPLACE INTO p_1 (last_name, first_name)
	VALUES ('X2', 'Y2');

REPLACE INTO p_1 (last_name, first_name)
	VALUES ('X3', 'Y2');
-- The rows-affected value in the second case is 2 because 
-- the original row is deleted and the new row is inserted
-- in its place

SELECT * FROM p_1;

-- INSERT IGNORE is more efficient than REPLACE because it 
-- doesn’t actually insert duplicates.
-- REPLACE , on the other hand, is often more appropriate for 
-- tables in which other nonkey columns need to be replaced.
-- INSERT ... ON DUPLICATE KEY UPDATE is appropriate when you 
-- must insert a record if it doesn’t exist, but just update
-- some of its columns if the new record is a duplicate in 
-- the indexed columns.

DROP TABLE IF EXISTS poll_vote;

CREATE TABLE poll_vote
(
	poll_id 		INT UNSIGNED NOT NULL AUTO_INCREMENT,
	candidate_id 	INT UNSIGNED,
	vote_count 		INT UNSIGNED,
	PRIMARY KEY (poll_id, candidate_id)
);

-- Neither INSERT IGNORE nor REPLACE are appropriate here 
-- because for all votes except the first, you don’t know 
-- what the vote count should be. INSERT ... ON DUPLICATE KEY
-- UPDATE works better here.

INSERT INTO poll_vote (poll_id, candidate_id, vote_count)
	VALUES (14, 3, 1)
	ON DUPLICATE KEY UPDATE vote_count = vote_count + 1;

SELECT * FROM poll_vote;

INSERT INTO poll_vote (poll_id, candidate_id, vote_count)
	VALUES (14, 3, 1)
	ON DUPLICATE KEY UPDATE vote_count = vote_count + 1;

SELECT * FROM poll_vote;