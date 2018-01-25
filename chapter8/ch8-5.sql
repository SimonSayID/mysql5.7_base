USE `cookbook`;

-- Using Triggers to Implement Dynamic Default Column Values

DROP TABLE IF EXISTS cust_invoice;

CREATE TABLE cust_invoice
(
	id			INT NOT NULL AUTO_INCREMENT,
	state		CHAR(2),
	amount		DECIMAL(10, 2),
	tax_rate	DECIMAL(3, 2),
	PRIMARY KEY (id)
);

DROP TRIGGER IF EXISTS bi_cust_invoice;
CREATE TRIGGER bi_cust_invoice BEFORE INSERT ON cust_invoice
FOR EACH ROW SET NEW.tax_rate = sales_tax_rate(NEW.state);

INSERT INTO cust_invoice (state, amount) VALUES ('NY', 100);
SELECT * FROM cust_invoice WHERE id = LAST_INSERT_ID();

-- Using Triggers to Simulate Function-Based Indexes
DROP TABLE IF EXISTS expdata;

CREATE TABLE expdata
(
	id 			INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	value 		FLOAT,
	log10_value FLOAT,
	INDEX (value),
	INDEX (log10_value)
);

DROP TRIGGER IF EXISTS bi_expdata;
CREATE TRIGGER bi_expdata BEFORE INSERT ON expdata
FOR EACH ROW SET NEW.log10_value = LOG10(NEW.value);

DROP TRIGGER IF EXISTS bu_expdata;
CREATE TRIGGER bu_expdata BEFORE UPDATE ON expdata
FOR EACH ROW SET NEW.log10_value = LOG10(NEW.value);

INSERT INTO expdata (value)
	VALUES (.01), (.1), (1), (10), (100);

SELECT * FROM expdata;

UPDATE expdata SET value = value * 10;
SELECT * FROM expdata;