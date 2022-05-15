-- Create user: sample1@localhost with password 123 if not exist
CREATE USER IF NOT EXISTS sample1@localhost IDENTIFIED BY '123';

-- show grants/privileges for the current user
SHOW GRANTS;

SHOW GRANTS FOR sample1@localhost;


-- Specific task level 
GRANT UPDATE, DELETE, INSERT
ON mock_staff.staff
TO sample1@localhost;

-- global task level
-- SELECT, INSERT, UPDATE, DELETE, REFERENCES, ALTER, ALL...
GRANT SELECT
ON *.*
TO sample1@localhost;

-- Table privilege level 
GRANT ALL ON mock_staff.staff TO sample1@localhost;



-- Database privilege level
GRANT ALL ON energy.* TO sample1@localhost;

-- Privileges for creating database (may not work yet)
GRANT CREATE TO sample1@localhost;

-- Revoke Privileges
REVOKE privileges ON energy.* TO sample1@localhost;


