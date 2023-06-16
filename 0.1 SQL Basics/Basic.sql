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

