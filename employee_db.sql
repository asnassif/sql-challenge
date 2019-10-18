-- Creating Tables and importoing data section:
----------------------------------------------- 

-- drop table departments
-- drop table dept_emp
-- drop table dept_manager
-- drop table employees
-- drop table salaries
-- drop table titles


-- create department table:

create table departments (
	dept_no varchar(255),
	dept_name varchar(255)
);
	
select * from departments;


-- create dept_emp table:

create table dept_emp(
	emp_no int,
	dept_no varchar (255),
	from_date date,
	to_date date
);

select * from dept_emp;


-- create dept_manager table:

create table dept_manager (
	dept_no varchar(255),
	emp_no varchar(255),
	from_date date,
	to_date date
);

select * from dept_manager;


-- create titles table;
create table titles (
	emp_no varchar(255),
	title varchar (255),
	from_date date,
	to_date date
);

select * from titles;


-- create employee table:
create table employees (
	emp_no int,
	birth_date date,
	first_name varchar(20),
	last_name varchar(20),
	gender varchar(1),
	hire_date date
	); 
select * from employees;	


-- create salaries table

create table salaries (
	emp_no int,
	salary int,
	from_date date,
	to_date date
);
select * from salaries;

drop table department_analysis 

-- Analysis Section:
---------------------

-- A) Adding Primary Keys and Foreign Keys:
--     1) deparments table:

ALTER TABLE departments ADD COLUMN department_id SERIAL PRIMARY KEY;

select * from departments;


--     2) dep_emp table:

ALTER TABLE dept_emp ADD COLUMN emp_id SERIAL PRIMARY KEY;

select * from dept_emp;


--     3) dep_manager table:

ALTER TABLE dept_manager ADD COLUMN manager_id SERIAL PRIMARY KEY;

select * from dept_manager;

--     4) employees table:

ALTER TABLE employees ADD COLUMN gender_id SERIAL PRIMARY KEY;

select * from employees;


--     5) titles table:
ALTER TABLE titles ADD COLUMN title_id SERIAL PRIMARY KEY;

select * from titles;


-- Since we have many to many relationships then we need to create "Junction Tables":




