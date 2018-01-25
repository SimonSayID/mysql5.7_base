USE `cookbook`;

DROP TABLE IF EXISTS expt;

CREATE TABLE expt 
(
	subject VARCHAR(10),
	test	VARCHAR(5),
	score	INT,

	INDEX	(subject)
);

INSERT INTO expt (subject, test, score) 
	VALUES
		('Jane', 'A',47),
		('Jane', 'B', 50),
		('Jane', 'C', NULL),
		('Jane', 'D', NULL),
		('Marvin', 'A', 52),
		('Marvin', 'B', 45),
		('Marvin', 'C', 53),
		('Marvin', 'D', NULL)
;