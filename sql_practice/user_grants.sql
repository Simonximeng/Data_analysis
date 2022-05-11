-- create user user1 with localhost and password: user1

CREATE USER IF NOT EXISTS 'user1'@'localhost' IDENTIFIED BY 'user1';

-- 


-- grant privileges for 'test' database

GRANT ALL PRIVILEGES ON 'test'.* TO 'user1'@'localhost';


SELECT user, host, password, select_priv, insert_priv, shutdown_priv, grant_priv FROM mysql.user;
