-- What is SQL ?
-- SQL Stands for Structured Query Language which a standard language for accessing and manipulating databases.

-- Categories of SQL commands ?
-- DQL : Data Query Language : SELECT
-- DDL : Data Definition Language : CREATE, ALTER
-- DML : Data Manipulation Language : INSERT, UPDATE
-- DCL : Data Control Language : GRANT, REVOKE

-- Tables In SQL ?
-- A table is a database object which comprises of rows and columns.
-- Field (Column) - A field provides specific information about the data in a table.
-- Record (Row) - Each individual entry in a table is called records.

-- Creating a database
CREATE DATABASE CCE_IIT_M;

-- Using a database
USE CCE_IIT_M;

-- Dropping a database
-- Note : We can't drop a database if it's in use currently.
DROP DATABASE CCE_IIT_M;

-- Constraints
-- Rules for the data in a table can be specified using SQL constraints.
-- The kinds of data that can be entered into a table are restricted by constraints.
-- This validates the realiability and accuracy of the data in the table.

-- Types of constraints
-- NOT NULL : Prevents a column from having a NULL value.
-- UNIQUE : Ensure that each value in a column is unique.
-- PRIMARY KEY : A combination of a NOT NULL and UNIQUE.
-- FOREIGN KEY : A field or column used to create a connection between two tables.
-- CHECK : Check weather the values in a column satisfy a particular requirement.
-- DEFAULT : Sets a default value for a column in the absense of data.

CREATE TABLE Employee(
	employee_id int primary key, -- primary key constraint
	dept_id int,
	first_name varchar(50) NOT NULL, -- not null constraint
	email varchar(50) UNIQUE, -- unique constraint
	hire_data date,
	salary decimal(10,2),
	active bit DEFAULT 1, -- default constraint
	CONSTRAINT chk_salary check(salary>=0), -- check constraint
	CONSTRAINT fk_dept_id FOREIGN KEY(dept_id) REFERENCES Department(dept_id) -- foreign key constraint
);

-- Create Table Department to show the foreign key constraint
CREATE TABLE Department(
	dept_id int primary key,
	dept_name varchar(50) NOT NULL
);

-- Data Types in SQL ?
-- Data type define what type of data a column can hold.
-- Exact Numerics : bigint, int, decimal, bit, money, numeric(8,4), small, smallmoney, tinyint, decimal(10,2)
-- Aprox Numerics : float, real
-- Date Time : date, time, datatime, datetime2, datetimeoffset, smalldatatime
-- Char Strings : char(10), text, varchar(40)

CREATE TABLE Ecom (
    id bigint,
    quantity int,
    price decimal(8,4),
    is_active bit,
    revenue money,
    discount numeric(8,4),
    discount_percentage smallmoney,
    product_code tinyint,
    total_amount decimal(10,2),
    sales_volume float,
    stock_count real,
    order_date date,
    delivery_time time,
    order_datetime datetime,
    order_datetime2 datetime2,
    order_datetimeoffset datetimeoffset,
    creation_date smalldatetime,
    description char(10),
    details text,
    product_name varchar(40)
);

-- DECIMAL(8,4) and NUMERIC(8,4) both indicate a decimal number with a precision of 8 and a scale of 4.
-- 1234.5678 (Total Digit is 8 and Precision is 4).

-- Insert into tables ?
INSERT INTO Department (dept_id,dept_name) VALUES (1001,'Technology');
INSERT INTO Employee VALUES (101,1001,'Tushar','tushar.a.verma@gmail.com','06-Nov-20','20000',1);

-- SELECT from tables ?
SELECT * FROM Department;
SELECT * FROM Employee;
SELECT first_name,active FROM Employee;

-- ALTER Tables ?
-- It is used to add, modify or delete columns in an existing table.
-- Add a column skill with datatype varchar in Employee table

ALTER TABLE EMPLOYEE
ADD skills varchar(50);

-- Remove the column skill from Emploee table

ALTER TABLE EMPLOYEE
DROP COLUMN skills;

-- Update data in SQL tables ?
-- update skill column with 'python' where skill has null value

UPDATE Employee
SET skills = 'Python'
WHERE skills IS NULL;

-- Update top statements
-- The TOP statements to limit the number of rows that are modified in an UPDATE statement.
-- When a TOP(n) clauses is used with UPDATE, the update operation is performed on a random n no of rows.

UPDATE top(5) Employee
SET skills = 'SQL';

-- Update table with data from another table
-- Create another table summary with column name store having int datatype as primary key, category column as unique.
-- Insert two records in summary table and update the category column of summary table with order_no of store_details.

CREATE TABLE STORE(
	Store int primary key,
	Store_Name varchar(50),
	Sales int,
	Order_No int,
	Store_Location varchar(50),
	City varchar(50),
	Pincode int
);

INSERT INTO STORE VALUES (1, 'Walmart', 100, 246, 'UP','Khurja',203131),
(2, 'Zudio',100,567,'Delhi','Najagarh',203141),
(3, 'Reliance',500,678,'Gujrat','Kemi',904567),
(4, 'Trends',400,789,'Mumbai','Sikandarabad',986405);

CREATE TABLE SUMMARY(
	Store int primary key,
	Category int unique
);

INSERT INTO SUMMARY VALUES (2,100),
(3,600);

UPDATE SUMMARY
SET Category = (SELECT Order_No FROM STORE WHERE Store.Store=SUMMARY.Store)
WHERE EXISTS(SELECT Order_No FROM STORE WHERE STORE.Store=SUMMARY.Store);

-- Add new columns profit and loss & Update top 2 records of Store Table

ALTER TABLE STORE
ADD PROFIT VARCHAR(10),
LOSS VARCHAR(10)

SET ROWCOUNT 2
UPDATE STORE
SET PROFIT='Yes',LOSS='No'
SET ROWCOUNT 0;

SELECT * FROM STORE;

-- MERGE
-- Merge is the combination of INSERT, DELETE and UPDATE Statements.
-- INSERT --> UPDATE --> DELETE
-- If there is a source table and a target table that are to be merged. Then with the help of merge statement, all three operations can be performed at once.

-- Create two table named source table and target table 
-- Column ProductId, ProductName, Price
-- Now Insert the values into the same.

Create Table Source_Table(
	ProductId INT primary key,
	ProductName VARCHAR(50),
	Price INT
);

Create Table Target_Table(
	ProductId INT primary key,
	ProductName VARCHAR(50),
	Price INT
);

INSERT INTO Source_Table VALUES (1,'Table',100),
(2,'Desk',80),
(3,'Chair',50),
(4,'Computer',300);

INSERT INTO Target_Table VALUES (1,'Table',100),
(2,'Desk',180),
(5,'Bed',50),
(6,'Cupboard',300);

SELECT * FROM Source_Table;
SELECT * FROM Target_Table;

-- INSERT (Taking the source rows in Target table)
Begin Transaction
MERGE Target_Table AS Target
USING SOURCE_Table as Source
ON Source.ProductId = Target.ProductId
WHEN NOT MATCHED BY TARGET THEN 
INSERT (ProductId, ProductName, Price) 
VALUES (Source.ProductId, Source.ProductName, Source.Price);
Rollback Transaction

-- UPDATE(Updating the Target Rows using Source Data)
BEGIN TRANSACTION
MERGE TARGET_TABLE AS Target
USING SOURCE_TABLE As Source
ON Source.ProductID = Target.ProductId
WHEN MATCHED THEN
UPDATE SET Target.ProductName = Source.ProductName,
Target.Price = Source.Price;
ROLLBACK TRANSACTION

-- DELETE(Deleting the Target Rows using the Source Data)
BEGIN TRANSACTION
MERGE TARGET_TABLE AS Target
USING SOURCE_TABLE AS Source
ON Source.ProductId = Target.ProductId
WHEN NOT MATCHED BY SOURCE
THEN DELETE;
ROLLBACK TRANSACTION

-- Delete ?
-- It is used to delete existing records in a table
-- Syntax : DELETE FROM table_name WHERE condition;
DELETE FROM STORE
WHERE SALES = 100;

-- Truncate ?
-- It is used to delete an existing data in a table, except the table itself.
Truncate Table STORE;

-- DROP ?
-- It is used to drop an existing table in a database;
DROP TABLE STORE;

-- DELETE only Specific rows - DELETE
-- DELETE All Data Except Schema - TRUNCATE
-- DELETE Everthing (Data+Schema) - DROP