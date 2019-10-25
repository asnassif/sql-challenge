-- Creating Tables and importoing data section:
----------------------------------------------- 
-- ** Ensure that all tables didn't previously exist by running the drop command for all tables 
-- drop table departments
-- drop table dept_emp
-- drop table dept_manager
-- drop table employees
-- drop table salaries
-- drop table titles


----------------------------------------------
-- A) Create and Import Tables from csv files:
----------------------------------------------


-- 1) Create Employee Table:
-----------------------------

create table employees (
	employee_no int,
	birth_date date,
	first_name varchar(255),
	last_name varchar(255),
	gender varchar(1),
	hire_date date);
	
select * from employees;	
	
--2) Create Salaries Table:
---------------------------

create table salaries(
	emp_no int,
	salary int,
	from_date date,
	to_date date); 
	
select * from salaries;


--3) Create Titles Table:
-------------------------

create table titles (
	emp_no int,
	title varchar(255),
	from_date date,
	to_date date);

select * from titles;
	

-- 4) Create dept_emp Table:
----------------------------

create table dept_emp(
	emp_no int,
	dept_no varchar (255),
	from_date date,
	to_date date
);

select * from dept_emp;


-- 5) Create departments Table:
------------------------------

create table departments (
	dept_no varchar(255),
	dept_name varchar (255));

Select * from departments;

drop table departments;

-- 6) Create dept_manager Table:
--------------------------------

create table dept_manager (
	dept_no varchar(255),
	emp_no int,
	from_date date,
	to_date date);

select * from dept_manager;


---------------------------------------------------------
-- B) Adjusting created tables to match the requirements:
---------------------------------------------------------

-- 1) Adjusted employees table:

CREATE TABLE employees_adjusted AS SELECT * FROM employees;

select * from employees_adjusted

ALTER TABLE employees_adjusted  RENAME COLUMN employee_no TO employee_id;

ALTER TABLE employees_adjusted ADD PRIMARY KEY (employee_id);

-- 2) Adjusted salaries table:

CREATE TABLE salaries_adjusted AS SELECT * FROM salaries;

select * from salaries_adjusted;

ALTER TABLE salaries_adjusted  RENAME COLUMN emp_no TO employee_id;

ALTER TABLE salaries_adjusted ADD PRIMARY KEY (employee_id);

-- 3) Adjusted Titles Table:

CREATE TABLE titles_adjusted AS SELECT * FROM titles;

select * from titles_adjusted;

ALTER TABLE titles_adjusted  RENAME COLUMN emp_no TO employee_id;

ALTER TABLE titles_adjusted ADD PRIMARY KEY (employee_id);


-- 4) Adjusted dept_emp Table:
CREATE TABLE dept_emp_adjusted AS SELECT * FROM dept_emp;

select * from dept_emp_adjusted;

ALTER TABLE dept_emp_adjusted  RENAME COLUMN emp_no TO employee_id;
ALTER TABLE dept_emp_adjusted  RENAME COLUMN dept_no TO dept_id;
ALTER TABLE dept_emp_adjusted ADD PRIMARY KEY (dept_id);


-- 5) Adjusted dept_manager Table:

CREATE TABLE dept_manager_adjusted AS SELECT * FROM dept_manager;

select * from dept_manager_adjusted;

ALTER TABLE dept_manager_adjusted  RENAME COLUMN manager_employee_id TO employee_id;

ALTER TABLE dept_manager_adjusted  RENAME COLUMN dept_no TO dept_id;

ALTER TABLE dept_manager_adjusted ADD PRIMARY KEY (manager_id);


-- 6) Adjusted departments Table:

CREATE TABLE departments_adjusted AS SELECT * FROM departments;

select * from departments_adjusted;

ALTER TABLE departments_adjusted RENAME COLUMN dept_no TO dept_id;

ALTER TABLE departments_adjusted ADD PRIMARY KEY (dept_id);


