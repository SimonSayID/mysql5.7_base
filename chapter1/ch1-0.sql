CREATE USER 'cbuser'@'localhost' IDENTIFIED BY 'cbpass';

GRANT ALL ON cookbook.* TO 'cbuser'@'localhost';