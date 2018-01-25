USE `cookbook`;

-- You must have the MySQL FILE privilege to execute the
-- SELECT ... INTO OUTFILE statement.

-- mysql> SHOW VARIABLES LIKE "secure_file_priv";
-- +------------------+-----------------------+
-- | Variable_name    | Value                 |
-- +------------------+-----------------------+
-- | secure_file_priv | /var/lib/mysql-files/ |
-- +------------------+-----------------------+
-- 1 row in set (0.01 sec)

-- set my.cnf secure_file_priv option to ""
-- file can't be already exist
-- result location: /var/lib/mysql/cookbook/profile.txt

SELECT * FROM profile INTO OUTFILE 'profile_1.txt';

-- 1	Sybil	1970-04-13	black	lutefisk,fadge,pizza	0
-- 2	Nancy	1969-09-30	white	burrito,curry,eggroll	3
-- 3	Ralph	1973-11-02	red	eggroll,pizza	4
-- 4	Lothair	1963-07-04	blue	burrito,curry	5
-- 5	Henry	1965-02-14	red	curry,fadge	1
-- 6	Aaron	1968-09-17	green	lutefisk,fadge	1
-- 7	Joanna	1952-08-20	green	lutefisk,fadge	0
-- 8	Stephen	1960-05-01	white	burrito,pizza	0

SELECT * FROM profile INTO OUTFILE 'profile_2.txt'
	FIELDS TERMINATED BY ',' ENCLOSED BY '"'
	LINES TERMINATED BY '\r\n';

-- "1","Sybil","1970-04-13","black","lutefisk,fadge,pizza","0"
-- "2","Nancy","1969-09-30","white","burrito,curry,eggroll","3"
-- "3","Ralph","1973-11-02","red","eggroll,pizza","4"
-- "4","Lothair","1963-07-04","blue","burrito,curry","5"
-- "5","Henry","1965-02-14","red","curry,fadge","1"
-- "6","Aaron","1968-09-17","green","lutefisk,fadge","1"
-- "7","Joanna","1952-08-20","green","lutefisk,fadge","0"
-- "8","Stephen","1960-05-01","white","burrito,pizza","0"