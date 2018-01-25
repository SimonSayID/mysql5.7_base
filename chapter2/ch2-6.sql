USE `cookbook`;

SELECT * FROM profile_contact ORDER BY profile_id, service;

SELECT * FROM profile;

SELECT id, name, service, contact_name
	FROM profile INNER JOIN profile_contact ON id = profile_id;

SELECT id, name, service, contact_name
	FROM profile LEFT JOIN profile_contact ON id = profile_id;

SELECT id, name, service, contact_name
	FROM profile RIGHT JOIN profile_contact ON id = profile_id;

SELECT * FROM profile_contact 
	WHERE profile_id = (SELECT id FROM profile WHERE name = 'Nancy');


SELECT * FROM profile LIMIT 1;

SELECT * FROM profile ORDER BY birth DESC LIMIT 1;

SELECT name, DATE_FORMAT(birth, '%m-%d') AS birthday
	FROM profile ORDER BY birthday LIMIT 1;

SELECT * FROM profile ORDER BY birth;

SELECT * FROM profile ORDER BY birth LIMIT 2,1;

SELECT * FROM profile ORDER BY birth DESC LIMIT 2,1;

SELECT SQL_CALC_FOUND_ROWS * FROM profile ORDER BY name LIMIT 4;
SELECT FOUND_ROWS();

SELECT * FROM
	(SELECT name, birth FROM profile ORDER BY birth DESC LIMIT 4) AS t
	ORDER BY birth;