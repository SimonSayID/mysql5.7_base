USE `cookbook`;

-- Using Stored Functions to Encapsulate Calculations

-- The function handles states not listed using a CONTINUE handler
-- for NOT FOUND , which executes if a No Data condition occurs:
-- if there is no row for the given state_param value, the SELECT
-- statement fails to find a sales tax rate, the CONTINUE handler
-- sets the rate to -1, and continues execution with the next statement
-- after the SELECT .

DROP FUNCTION IF EXISTS sales_tax_rate;

DELIMITER $$
CREATE FUNCTION sales_tax_rate (state_code CHAR(2))
RETURNS DECIMAL(3, 2) READS SQL DATA
BEGIN
	DECLARE rate DECIMAL(3, 2);
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET rate = -1;
	SELECT tax_rate INTO rate FROM sales_tax_rate 
		WHERE state = state_code;
	RETURN rate;
END;
$$
DELIMITER ;

SELECT sales_tax_rate('VT'), sales_tax_rate('NY');

SELECT sales_tax_rate('ZZ');

CREATE FUNCTION sales_tax(state_code CHAR(2), sales_amount DECIMAL(10, 2))
RETURNS DECIMAL(10, 2) READS SQL DATA
RETURN sales_amount * sales_tax_rate(state_code);

SELECT sales_tax('VT', 150), sales_tax('NY', 150);