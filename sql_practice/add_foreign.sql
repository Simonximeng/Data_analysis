-- set the region_id in staff table as foreign key to company_regions.region_id 

USE mock_staff;

ALTER TABLE staff 
ADD FOREIGN KEY (region_id) REFERENCES company_regions(region_id);

ALTER TABLE staff 
ADD FOREIGN KEY (department) REFERENCES company_divisions(department);

DESCRIBE staff;

DESCRIBE company_divisions;

DESCRIBE company_regions ;

/*
The original data lacks Books division is company_divisions such that did not allow staff.department to be foreign key 

SELECT DISTINCT department FROM staff ORDER BY 1 ASC;
SELECT department FROM company_divisions ORDER BY 1 ASC;

INSERT INTO company_divisions values ('Books', 'Domestic')

*/
