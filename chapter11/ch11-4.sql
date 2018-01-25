USE `cookbook`;

DROP TABLE IF EXISTS invoice;

CREATE TABLE invoice
(
	inv_id 		INT UNSIGNED NOT NULL AUTO_INCREMENT,
	date 		DATE NOT NULL,
	customer_id INT UNSIGNED NOT NULL,
	PRIMARY KEY (inv_id)
);

DROP TABLE IF EXISTS inv_item;

CREATE TABLE inv_item
(
	inv_id			INT UNSIGNED NOT NULL,
	item_id 		INT UNSIGNED NOT NULL AUTO_INCREMENT,
	quantity		INT,
	description		VARCHAR(40),

	PRIMARY KEY (item_id),
	INDEX (inv_id)
);

INSERT INTO invoice (inv_id, date, customer_id)
	VALUES (NULL, CURDATE(), 111);

SET @last_item = LAST_INSERT_ID();

INSERT INTO inv_item (inv_id, quantity, description)
	VALUES
		(@last_item, 1, 'hammer'),
		(@last_item, 3, 'nails'),
		(@last_item, 12, 'bandage')
;

SELECT * FROM invoice;

SELECT * FROM inv_item;