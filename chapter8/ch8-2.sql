USE `cookbook`;

DROP TABLE IF EXISTS sales_tax_rate;

CREATE TABLE sales_tax_rate
(
	state 		CHAR(2) NOT NULL,
	tax_rate 	DECIMAL(3,2), # Tax rate (0.00 .. 1.00)
	PRIMARY	KEY (state)
);

LOAD DATA LOCAL INFILE 'sales_tax_rate.txt' INTO TABLE sales_tax_rate;