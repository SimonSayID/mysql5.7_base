USE `cookbook`;

DROP TABLE IF EXISTS sales_region;

CREATE TABLE sales_region
(
	region_id 	INT UNSIGNED NOT NULL,
	name 		VARCHAR(30) NOT NULL,
	PRIMARY KEY (region_id)
);

DROP TABLE IF EXISTS sales_volume;

CREATE TABLE sales_volume
(
	region_id 	INT UNSIGNED NOT NULL,
	year 		INT NOT NULL,
	quarter 	INT NOT NULL,
	volume 		INT NOT NULL
);

INSERT INTO sales_region (region_id, name)
	VALUES
		(1, 'London, United Kingdom'),
		(2, 'Madrid, Spain'),
		(3, 'Berlin, Germany'),
		(4, 'Athens, Greece')
;

INSERT INTO sales_volume (region_id, year, quarter, volume)
	VALUES
		(1, 2014, 1, 100400),
		(1, 2014, 2, 120000),
		(3, 2014, 1, 280000),
		(3, 2014, 2, 250000),
		(5, 2014, 1, 18000),
		(5, 2014, 2, 32000)
;

SELECT * FROM sales_region;

SELECT * FROM sales_volume;