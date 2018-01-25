USE `cookbook`;

SELECT * FROM mail WHERE srcuser = 'phil';

SELECT * FROM mail WHERE srcuser = 'phil' ORDER BY t DESC;

SELECT * FROM mail ORDER BY TIME(t);

DROP TABLE IF EXISTS occasion;
CREATE TABLE occasion
(
	date			DATE,
	description 	VARCHAR(255)
);

INSERT INTO occasion (date, description)
	VALUES
		('1789-07-04', 'US Independence Day'),
		('1776-07-14','Bastille Day'),
    	('1957-10-04','Sputnik launch date'),
    	('1919-06-28','Signing of the Treaty of Versailles'),
    	('1732-02-22','George Washington\'s birthday'),
    	('1989-11-09','Opening of the Berlin Wall'),
    	('1944-06-06','D-Day at Normandy Beaches'),
    	('1215-06-15','Signing of the Magna Carta'),
    	('1809-02-12','Abraham Lincoln\'s birthday')
;

SELECT * FROM occasion ORDER BY date;

-- calendar order
SELECT * FROM occasion ORDER BY MONTH(date), DAYOFMONTH(date);

-- DAYOFYEAR() can generate the same value for different calendar days
-- This means that DAYOFYEAR() can group dates that actually 
-- occur on different calendar days
SELECT DAYOFYEAR('1996-02-29'), DAYOFYEAR('1997-03-01');

-- sort in day-of-week order using DAYOFWEEK() , which returns numeric
-- values from 1 to 7 for Sunday through Saturday
SELECT DAYNAME(date) AS day, date, description FROM occasion
	ORDER BY DAYOFWEEK(date);

-- To sort rows in day-of-week order but treat Monday as the first day of
-- the week and Sunday as the last, use the MOD() function to map Monday
-- to 0, Tuesday to 1, ..., Sunday to 6
SELECT DAYNAME(date), date, description FROM occasion
	ORDER BY MOD(DAYOFWEEK(date)+5, 7);

-- Sunday DAYOFWEEK(date)
-- Monday MOD(DAYOFWEEK(date)+5, 7)
-- Tuesday MOD(DAYOFWEEK(date)+4, 7)
-- Wednesday MOD(DAYOFWEEK(date)+3, 7)
-- Thursday MOD(DAYOFWEEK(date)+2, 7)
-- Friday MOD(DAYOFWEEK(date)+1, 7)
-- Saturday MOD(DAYOFWEEK(date)+0, 7)