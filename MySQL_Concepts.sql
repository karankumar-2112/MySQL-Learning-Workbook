# DDL ( Data Definition Language )

CREATE DATABASE DataAnalyticsDB;
USE DataAnalyticsDB;
CREATE TABLE emp_info(
emp_id INT PRIMARY KEY,
emp_name VARCHAR(50) NOT NULL,
emp_add VARCHAR(50) NOT NULL,
emp_salary DECIMAL(8,2)
);

ALTER TABLE emp_info ADD COLUMN emp_mob INT;
DESCRIBE emp_info;
ALTER TABLE emp_info DROP COLUMN emp_mob;
ALTER TABLE emp_info ADD COLUMN emp_mob INT NOT NULL;
RENAME TABLE emp_info TO EmployeeInfo;


# DML ( Data Manipulation Language )
CREATE TABLE Employees(
emp_id INT PRIMARY KEY AUTO_INCREMENT,
emp_name VARCHAR(50) NOT NULL,
emp_add VARCHAR(100) NOT NULL,
emp_salary DECIMAL(8,2) NOT NULL,
emp_depart VARCHAR(50) NOT NULL
);
desc employees;


INSERT INTO Employees VALUE(101,'Karan','Delhi',84510,'Data Analyst');
SELECT * FROM Employees;
INSERT INTO Employees(emp_name,emp_add,emp_salary,emp_depart) VALUES
('Shruti','Chennai',54781,'Data Science'),
('Rmana','Mumbai',21481,'Data Analyst'),
('Ankit','Punjab',45879,'Data Science'),
('Irfan','Delhi',34698,'Data Science'),
('Rohit','Uttrakhand',79846,'Data Science');
SELECT * FROM Employees;


SET SQL_SAFE_UPDATES = 0;
UPDATE Employees SET emp_depart='Developer' WHERE emp_id=104;
DELETE FROM Employees WHERE emp_id=106;
SELECT * FROM Employees;
UPDATE Employees SET emp_depart='HR' WHERE emp_id=102;
SELECT * FROM Employees;


/*
JOIN
TYPES OF JOIN
JOIN / INNER JOIN
LEFT JOIN / LEFT OUTER JOIN
RIGHT JOIN / RIGHT OUTER JOIN
*/

CREATE TABLE Customers(
cus_id INT PRIMARY KEY AUTO_INCREMENT,
cus_name VARCHAR(50) NOT NULL,
cus_mail VARCHAR(50) NOT NULL,
cus_add VARCHAR(50) NOT NULL
);


INSERT INTO Customers VALUES
(101,'Karan','karan33@gmail.com','Delhi'),
(102,'Shubham','shubham12@gmail.com','Mumbai'),
(103,'Ravi','Ravi36@gmail.com','Kerala'),
(104,'Varun','Varun1254@gmail.com','Bihar'),
(105,'Irfan','Irfan4587@gmail.com','Delhi'),
(106,'Deepak','Deepak0211@gmail.com','Kolkata');
SELECT * FROM Customers;

CREATE TABLE Products(
pro_id INT PRIMARY KEY AUTO_INCREMENT,
pro_name VARCHAR(50) NOT NULL,
pro_price DECIMAL(8,2),
pro_desc VARCHAR(50) NOT NULL
);


INSERT INTO Products VALUES
(501,'Monitor',25478,'Full HD LED monitor'),
(502,'Mouse',1500,'Wireless optical computer mouse'),
(503,'Keyboard',3000,'Mechanical RGB gaming keyboard'),
(504,'CPU',6054,'High-performance desktop processor'),
(505,'Cabinet',4587,'Mid-tower computer cabinet'),
(506,'SSD',2975,'High-speed NVMe SSD');
SELECT * FROM Products;

CREATE TABLE Orders(
oid INT PRIMARY KEY AUTO_INCREMENT,
cus_id INT,
pro_id INT,
qty INT DEFAULT 1
);

INSERT INTO Orders(cus_id,pro_id,qty) VALUES
(101,503,1),
(104,502,2),
(106,508,1),
(102,501,3),
(105,505,4),
(104,507,1),
(108,502,2);


#JOIN /INNER JOIN (SHOW ONLY COMMON VALUE)

SELECT * FROM Customers
JOIN Orders
ON Customers.cus_id = Orders.cus_id;

SELECT * FROM Customers
JOIN Orders
ON Customers.cus_id = Orders.cus_id
JOIN Products
ON Products.pro_id = Orders.pro_id;


SELECT Customers.cus_id,cus_name,cus_mail,cus_add,pro_name,pro_desc,qty,pro_price,pro_price*qty AS Amount,pro_price*qty*0.18 AS GST,pro_price*qty+pro_price*qty*0.18 AS Net_Amount FROM Customers
JOIN Orders
ON Customers.cus_id = Orders.cus_id
JOIN Products
ON Products.pro_id = Orders.pro_id;


#LEFT JOIN
SELECT Customers.cus_id,cus_name,cus_add,pro_id,qty FROM Customers
LEFT JOIN Orders
ON Customers.cus_id = Orders.cus_id;

#RIGHT JOIN
SELECT Customers.cus_id,cus_name,cus_add,pro_id,qty FROM Customers
RIGHT JOIN Orders
ON Customers.cus_id = Orders.cus_id;

#UNION
SELECT Customers.cus_id,cus_name,cus_add,pro_id,qty FROM Customers
LEFT JOIN Orders
ON Customers.cus_id = Orders.cus_id
UNION
SELECT Customers.cus_id,cus_name,cus_add,pro_id,qty FROM Customers
RIGHT JOIN Orders
ON Customers.cus_id = Orders.cus_id;


#(AGGREGATE FUNCTIONS) COUNT, SUM, MIN, MAX, AVG
SELECT * FROM Employees;
SELECT COUNT(*) FROM Employees;
SELECT SUM(emp_salary) FROM Employees;
SELECT MIN(emp_salary) FROM Employees;
SELECT MAX(emp_salary) FROM Employees;
SELECT AVG(emp_salary) FROM Employees;



#ORDER BY
SELECT * FROM Employees;
SELECT * FROM Employees ORDER BY emp_salary ASC; 
SELECT * FROM Employees ORDER BY emp_salary DESC;
SELECT * FROM Employees ORDER BY emp_name ASC;

#GROUP BY
SELECT emp_depart,COUNT(*) FROM Employees GROUP BY emp_depart; 
SELECT emp_depart,SUM(emp_salary) FROM Employees GROUP BY emp_depart;


#WILECARDS % , _
SELECT * FROM Employees WHERE emp_name LIKE "K%";
SELECT * FROM Employees WHERE emp_name LIKE "R_m%";


#SUB QUERY
SELECT MAX(emp_salary) FROM Employees WHERE emp_salary<(SELECT MAX(emp_salary) FROM Employees WHERE emp_salary);
SELECT MIN(emp_salary) FROM Employees WHERE emp_salary>(SELECT MIN(emp_salary) FROM Employees WHERE emp_salary);
SELECT SUM(emp_salary) FROM Employees WHERE emp_salary<(SELECT AVG(emp_salary) FROM Employees WHERE emp_salary);


#LIMIT , OFFSET

SELECT * FROM Employees ORDER BY emp_salary DESC LIMIT 2;
SELECT * FROM Employees ORDER BY emp_salary DESC LIMIT 1 OFFSET 1;


# SCALER FUNCTIONS
# LOWER, UPPER, LENGTH/LEN, SUBSTRING,
# REPLACE, CONCAT, TRIM

SELECT LOWER(emp_name) FROM Employees;
SELECT UPPER(emp_name) FROM Employees;
SELECT LENGTH(emp_add) FROM Employees;
SELECT SUBSTRING(emp_name,1,4) FROM Employees;

SELECT "Hello India";
SELECT REPLACE('Hello India','India','World');
SELECT CONCAT('Hello',' ','World');
SELECT TRIM('     MYSQL     ');

# MATHEMATICAL FORMULA
# FLOOR, CEIL, ROUND, ABS, POWER, SQRT
SELECT emp_salary*0.177 FROM Employees;
SELECT emp_salary*0.177, FLOOR(emp_salary*0.177),CEIL(emp_salary*0.177),ROUND(emp_salary*0.177) FROM Employees;
SELECT ABS(-10000);
SELECT emp_salary, ABS(emp_salary-10000) AS Distance FROM Employees;
SELECT POWER(5,2);
SELECT SQRT(9);


#INDEX / INDEX COMPOSITE KEY
CREATE INDEX dept_index ON Employees(emp_depart);
SELECT * FROM Employees WHERE emp_depart='Data Analyst';

#COMPOSITE KEY
CREATE INDEX info_index ON Employees(emp_name,emp_add);
SELECT * FROM Employees WHERE emp_name='Karan' AND emp_add='Meghalaya';



#FOREIGN KEY

USE DataAnalyticsDB;
CREATE TABLE Course(
co_id INT PRIMARY KEY AUTO_INCREMENT,
co_name VARCHAR(50) NOT NULL,
co_fee DECIMAL(8,2) DEFAULT 8000
);


CREATE TABLE Students(
s_id INT PRIMARY KEY AUTO_INCREMENT,
s_name VARCHAR(50) NOT NULL,
s_add VARCHAR(50) NOT NULL,
co_id INT NOT NULL,
FOREIGN KEY (co_id) REFERENCES Course(co_id)
ON UPDATE CASCADE ON DELETE CASCADE
);

INSERT INTO Course VALUES
(501,'Data Analytics',26401),
(502,'Python Full Stack',15401),
(503,'Data Science',18451),
(504,'Java',34510),
(505,'Machine Learning',22401);


INSERT INTO Students VALUES
(101,'Karan','Delhi',501),
(102,'Mohan','Noida',504),
(103,'Irfan','Noida',501),
(104,'Deepak','Kolkata',505),
(105,'Shruti','Chennai',505);

SELECT * FROM Students
JOIN Course
ON Students.co_id = Course.co_id;

UPDATE Course SET co_id=4 WHERE co_id=504;
SELECT * FROM Course;
DELETE FROM Course WHERE co_id=4;
SELECT * FROM Students;



# TRIGGERS
# BEFORE INSERT       BEFORE DELETE      BEFORE UPDATE
# AFTER INSERT        AFTER DELETE       AFTER UPADTE

CREATE TABLE EMP_SALARY_LOG(
log_id INT PRIMARY KEY AUTO_INCREMENT,
emp_id INT,
emp_old_salary DECIMAL(8,2) NOT NULL,
emp_new_salary DECIMAL(8,2) NOT NULL
);

DELIMITER $$
CREATE TRIGGER update_salary
BEFORE UPDATE ON Employees
FOR EACH ROW
BEGIN
	INSERT EMP_SALARY_LOG(emp_name,emp_old_salary,emp_new_salary)
    VALUE(OLD.emp_id,OLD.emp_salary,NEW.emp_salary);
END $$
DELIMITER ;

SELECT * FROM Employees;
UPDATE Employees SET emp_salary=85213 WHERE emp_id=101;
UPDATE Employees SET emp_salary=32541 WHERE emp_id=105;
SELECT * FROM EMP_SALARY_LOG;

CREATE TABLE NEW_EMP_LOG(
log_id INT PRIMARY KEY AUTO_INCREMENT,
emp_id INT,
emp_name VARCHAR(50) NOT NULL,
time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
status VARCHAR(20) NOT NULL
);


DELIMITER $$
CREATE TRIGGER emp_insert_log
AFTER INSERT ON Employees
FOR EACH ROW
BEGIN
	INSERT INTO NEW_EMP_LOG(emp_id,emp_name,status)
    VALUE(NEW.emp_id,NEW.emp_name,"NEW_EMPLOYEE");
END $$
DELIMITER ;


INSERT INTO Employees VALUE(108,'Mohan','Kerala',63215,'Data Science');
SELECT * FROM Employees;
SELECT * FROM NEW_EMP_LOG;

CREATE TABLE EX_EMPLOYEE(
log_id INT PRIMARY KEY AUTO_INCREMENT,
emp_id INT,
emp_name VARCHAR(50) NOT NULL,
emp_depart VARCHAR(50) NOT NULL,
status VARCHAR(20) NOT NULL
);

DELIMITER $$
CREATE TRIGGER emp_delete_log
BEFORE DELETE ON Employees
FOR EACH ROW
BEGIN
	INSERT EX_EMPLOYEE(emp_id,emp_name,emp_depart,status)
    VALUE(OLD.emp_id,OLD.emp_name,OLD.emp_depart,"DELETED");
END $$
DELIMITER ;

SELECT * FROM Employees;
DELETE FROM Employees WHERE emp_id=108;
SELECT * FROM EX_EMPLOYEE;


#PROCEDURES

DELIMITER $$
CREATE PROCEDURE employees_data()
BEGIN
	SELECT * FROM Employees;
END $$
DELIMITER ;

CALL employees_data();


SELECT * FROM EMPLOYEES;
DELIMITER $$
CREATE PROCEDURE emp_by_depart(IN depart VARCHAR(50))
BEGIN
	SELECT * FROM Employees WHERE emp_depart=depart;
END $$
DELIMITER ;

CALL emp_by_depart("Data Analyst");

DROP PROCEDURE emp_by_depart;


#HAVING

SELECT emp_depart,COUNT(*) FROM Employees GROUP BY
emp_depart HAVING COUNT(*)>1;

SELECT emp_depart,SUM(emp_salary) FROM Employees GROUP BY
emp_depart HAVING SUM(emp_salary)>MIN(emp_salary);
