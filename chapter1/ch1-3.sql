USE `cookbook`;

SELECT * from limbs;

SELECT @max_limbs :=MAX(arms+legs) FROM limbs;

SELECT * from limbs WHERE arms+legs = @max_limbs;

SELECT @last_id := LAST_INSERT_ID();

SELECT @name := thing FROM limbs WHERE legs = 0;

SELECT @name;

SELECT @name2 := thing FROM limbs WHERE legs < 0;

SELECT @name2;

SET @sum = 4 + 7;

SELECT @sum;

SET @max_limbs = 0;

SET @max_limbs = (SELECT MAX(arms+legs) FROM limbs);

SELECT @max_limbs;

#user variable names are not case sensitive

SET @x = 1, @X = 2;

SELECT @X, @X;

#user variable can appear only where expressions are permitted,
#not where constants or literal identifiers must be provided.