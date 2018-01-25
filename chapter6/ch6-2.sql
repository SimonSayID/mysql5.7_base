USE `cookbook`;

SELECT * FROM driver_log ORDER BY name;

SELECT * FROM driver_log ORDER BY name ASC;

SELECT * FROM driver_log ORDER BY name DESC;

SELECT * FROM driver_log ORDER BY name, trav_date;

SELECT * FROM driver_log ORDER BY name DESC, trav_date;

SELECT name, trav_date, miles AS distance 
	FROM driver_log ORDER BY distance;