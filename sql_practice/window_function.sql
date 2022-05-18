/******** Windows Functions and Ordered Data ************/

USE mock_staff;
--------------------- OVER (PARTITION BY) ---------------------------

/* employee salary vs average salary of his/her department */
SELECT 
	department, 
	last_name, 
	salary,
	start_date,
	AVG(salary) OVER (PARTITION BY department) AS department_average,
	MAX(salary) OVER (PARTITION BY department) AS department_max,
	MIN(salary) OVER (PARTITION BY department) AS department_min
FROM staff;

SELECT * FROM staff


---------------------  FIRST_VALUE()  ---------------------------
-- FIRST_VALUE returns first value of the partition conditions, in this case decending order of salary group by department

SELECT
	department,
	last_name,
	salary,
	FIRST_VALUE(salary) OVER (PARTITION BY department ORDER BY salary DESC)
FROM staff;


/* this is same as above one, but above query is much cleaner and shorter */
SELECT
	department,
	last_name,
	salary,
	MAX(salary) OVER (PARTITION BY department)
FROM staff
ORDER BY department ASC, salary DESC;

-- if use group by, then the aggregated value (MAX() here) is the same
-- but all other, original values are missed.
SELECT
	department,
	last_name,
	salary,
	MAX(salary) 
FROM staff
GROUP BY department
ORDER BY department ASC, salary DESC;


---------------

/* compare with the salary of person whose last name is in ascenidng in that department */
SELECT
	department,
	last_name,
	salary,
	FIRST_VALUE(salary) OVER (PARTITION BY department ORDER BY last_name ASC)
FROM staff;


---------------------  RANK(), DENSE_RANK(), ROW_NUMBER()   ---------------------------

-- give the rank by salary decending oder withint the specific department group.
-- the ranking 1, 2, 3 will restart when it reaches to another unique group.
-- works same as Row_Number Function
-- RANK() and DENSE_RANK() are similar except when there is tie:
-- RANK(): 1, 2, 2, 4,,,
-- DENSE_RANK(): 1, 2, 2, 3, 4,,,
-- ROW_NUMBER(): 1, 2, 3, 4 ,,, arbitarily assigned numbers when tie

WITH T(StyleID, ID)
     AS (SELECT 1,1 UNION ALL
         SELECT 1,1 UNION ALL
         SELECT 1,1 UNION ALL
         SELECT 1,2)
SELECT *,
       RANK() OVER(PARTITION BY StyleID ORDER BY ID)       AS 'RANK',
       ROW_NUMBER() OVER(PARTITION BY StyleID ORDER BY ID) AS 'ROW_NUMBER',
       DENSE_RANK() OVER(PARTITION BY StyleID ORDER BY ID) AS 'DENSE_RANK'
FROM   T ;


SELECT
	department,
	last_name,
	salary,
	DENSE_RANK() OVER (PARTITION BY department ORDER BY salary DESC) as dense_rank_within_department,
	RANK() OVER (PARTITION BY department ORDER BY salary DESC) as rank_within_department,
	ROW_NUMBER() OVER (PARTITION BY department ORDER BY salary DESC) as rownumber
FROM staff;





--------------------- LAG() function ---------------------------
-- to reference rows relative to the currently processed rows.
-- LAG() allows us to compare condition with the previous row of current row.

/* we want to know person's salary and next lower salary in that department */
/* that is an additional column LAG. First row has no value because there is no previous value to compare.
So it continues to next row and lag value of that second row will be the value of previous row, etc.
It will restart again when we reache to another department.
*/
SELECT 
	department,
	last_name,
	salary,
	LAG(salary) OVER(PARTITION BY department ORDER BY salary DESC)
FROM staff;



--------------------- LEAD() function ---------------------------
-- opposite of LAG()
-- LEAD() allows us to compare condition with the next row of current row.
-- now the last line of that department's LEAD value is empty because there is no next row value to compare.
SELECT 
	department,
	last_name,
	salary,
	LEAD(salary) OVER(PARTITION BY department ORDER BY salary DESC)
FROM staff;


--------------------- NTILE(bins number) function ---------------------------
-- allows to create bins/ bucket

/* there are bins (1-10) assigned each employees based on the decending salary of specific department
and bin number restart for another department agian */
SELECT                           
	department,
	last_name,
	salary,
	NTILE(10) OVER(PARTITION BY department ORDER BY salary DESC)
FROM staff;

WITH T AS (
	SELECT id, last_name
	FROM staff
	ORDER BY id
)
SELECT * FROM T;


