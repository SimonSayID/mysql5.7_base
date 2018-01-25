USE `cookbook`;

DROP TABLE IF EXISTS hostip;
CREATE TABLE hostip
(
	ip	VARCHAR(64)
);

INSERT INTO hostip (ip)
	VALUES
		('127.0.0.1'),
		('192.168.0.2'),
	    ('192.168.0.10'),
	    ('192.168.1.2'),
	    ('192.168.1.10'),
	    ('255.255.255.255'),
	    ('21.0.0.1')
;

-- lexical order
SELECT * FROM hostip ORDER BY ip;

-- numerically
SELECT * FROM hostip ORDER BY 
	SUBSTRING_INDEX(ip, '.', 1)+0,
	SUBSTRING_INDEX(SUBSTRING_INDEX(ip, '.', '-3'), '.', 1)+0,
	SUBSTRING_INDEX(SUBSTRING_INDEX(ip, '.', '-2'), '.', 1)+0,
	SUBSTRING_INDEX(ip, '.', -1)+0;

SELECT * FROM hostip ORDER BY INET_ATON(ip);

-- The remainder becomes unavailable for sorting purposes, 
-- even though it’s required for a correct ordering
SELECT ip, ip+0 FROM hostip;

-- Use of INET_ATON() in the ORDER BY clause is more efficient 
-- than six SUBSTRING_INDEX() calls.