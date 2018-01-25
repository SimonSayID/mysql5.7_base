USE `cookbook`;

DROP TABLE IF EXISTS sibling;

CREATE TABLE sibling
(
	name 	CHAR(20),
	birth	DATE
);

INSERT INTO sibling (name, birth)
	VALUES
		('Gretchen', '1942-04-14'),
		('Wilbur', '1946-11-28'),
		('Franz', '1953-03-05');


SELECT name, birth, CURDATE() AS today,
	TIMESTAMPDIFF(YEAR, birth, CURDATE()) AS 'age in years',
	TIMESTAMPDIFF(MONTH, birth, CURDATE()) AS 'age in months'
	FROM sibling
;

SELECT name, birth, '1953-03-05' AS 'Franz'' birth',
	TIMESTAMPDIFF(YEAR, birth, '1953-03-05') AS 'age in years',
	TIMESTAMPDIFF(MONTH, birth, '1953-03-05') AS 'age in months'
	FROM sibling WHERE name <> 'Franz';