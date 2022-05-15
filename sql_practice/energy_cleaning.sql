-- show number of rows 
SELECT COUNT(*)
FROM energy2016;


-- show number of columns
SELECT COUNT(*) 
FROM information_schema.columns
WHERE TABLE_NAME = 'energy2016';

-- show the types of columns 
DESCRIBE energy2016;

SELECT * 
FROM energy2016;

-- use `` (top left) to select field with blanks
SELECT e.`Property Id` 
FROM energy2016 e;

SELECT COUNT(DISTINCT `Property Id`)
FROM energy2016;

-- Find duplicate values

SELECT *,
COUNT(*)
FROM energy2016 e
GROUP BY 1
HAVING COUNT(*) > 1;

-- seems that almost every row is duplicated by accident 
-- removing duplicated rows, it is easier to just create a clean table

SELECT DISTINCT * 
FROM energy2016;

-- create table that have same columns 
TRUNCATE TABLE c_energy2016;

CREATE TABLE c_energy2016(LIKE energy2016);

INSERT INTO c_energy2016
	SELECT DISTINCT * FROM energy2016;
	
SELECT * FROM c_energy2016;

-- handling missing data 

SELECT `ENERGY STAR Score`
FROM c_energy2016 c;

-- since we are modifying the table, it is better to use transaction to be able to rollback in case of mistakes 
-- Syntax is in MariaDB
BEGIN;
UPDATE c_energy2016 
SET `ENERGY STAR Score` = NULL 
WHERE `ENERGY STAR Score` = 'Not Available';
COMMIT;
-- ROLLBACK;

SELECT `ENERGY STAR Score`
FROM c_energy2016 c;

-- change data types 
-- The `ENERGY STAR Score` should be int 

DESCRIBE c_energy2016 `ENERGY STAR Score`;

ALTER TABLE c_energy2016 MODIFY `ENERGY STAR Score` int;
ALTER TABLE c_energy2016 MODIFY `Order` int PRIMARY KEY;

/*
ALTER TABLE table MODIFY columns NOT NULL;
ALTER TABLE table MODIFY columns int PRIMARY KEY;
ALTER TABLE table MODIFY columns int DEFAULT NULL;
*/

DESCRIBE c_energy2016;

SELECT * 
FROM c_energy2016;