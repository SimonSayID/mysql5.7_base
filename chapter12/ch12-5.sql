USE `cookbook`;

-- find sales regions for which there are no sales volume rows
SELECT sales_region.region_id AS 'unmatched region row IDs'
	FROM sales_region LEFT JOIN sales_volume
	ON sales_region.region_id = sales_volume.region_id
	WHERE sales_volume.region_id IS NULL;

-- find sales volume rows that are not associated with 
-- any known region
SELECT DISTINCT 
	sales_volume.region_id AS 'unmatched volume row IDs'
	FROM sales_volume LEFT JOIN sales_region
	ON sales_volume.region_id = sales_region.region_id
	WHERE sales_region.region_id IS NULL;

-- using NOT IN 
SELECT region_id AS 'unmatched region row IDs'
	FROM sales_region WHERE region_id NOT IN
	(SELECT region_id FROM sales_volume);

SELECT DISTINCT region_id AS 'unmatched volume row IDs'
	FROM sales_volume WHERE region_id NOT IN
	(SELECT region_id FROM sales_region);

-- delete unmatched row
-- DELETE FROM sales_region WHERE region_id NOT IN
-- 	(SELECT region_id FROM sales_volume);

-- DELETE FROM sales_volume WHERE region_id NOT IN
-- 	(SELECT region_id FROM sales_region);