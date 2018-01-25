USE `cookbook`;

-- Using Triggers to Log Changes to a Table

DROP TABLE IF EXISTS auction;

CREATE TABLE auction
(
	id 		INT UNSIGNED NOT NULL AUTO_INCREMENT,
	ts 		TIMESTAMP 
				DEFAULT CURRENT_TIMESTAMP 
				ON UPDATE CURRENT_TIMESTAMP,
	item	VARCHAR(30) NOT NULL,
	bid		DECIMAL(10, 2) NOT NULL,
	PRIMARY KEY (id)
);

DROP TABLE IF EXISTS auction_log;

CREATE TABLE auction_log
(
	action 		ENUM('create', 'update', 'delete'),
	id			INT UNSIGNED NOT NULL,
	ts 			TIMESTAMP DEFAULT CURRENT_TIMESTAMP
							ON UPDATE CURRENT_TIMESTAMP,
	item 		VARCHAR(30) NOT NULL,
	bid			DECIMAL(10, 2) NOT NULL,
	INDEX (id)
);

DROP TRIGGER IF EXISTS ai_auction;
CREATE TRIGGER ai_auction AFTER INSERT ON auction
FOR EACH ROW
	INSERT INTO auction_log (action, id, ts, item, bid)
	VALUES ('create', NEW.id, NOW(), NEW.item, NEW.bid);

DROP TRIGGER IF EXISTS au_auction;
CREATE TRIGGER au_auction AFTER UPDATE ON auction
FOR EACH ROW
	INSERT INTO auction_log (action, id, ts, item, bid)
	VALUES ('update', NEW.id, NOW(), NEW.item, NEW.bid);

DROP TRIGGER IF EXISTS ad_auction;
CREATE TRIGGER ad_auction AFTER DELETE ON auction
FOR EACH ROW
	INSERT INTO auction_log (action, id, ts, item, bid)
	VALUES ('delete', OLD.id, NOW(), OLD.item, OLD.bid);


INSERT INTO auction (item, bid) VALUES ('chintz pillows', 5.00);
SELECT LAST_INSERT_ID();

SELECT * FROM auction;
SELECT * FROM auction_log WHERE id = LAST_INSERT_ID();