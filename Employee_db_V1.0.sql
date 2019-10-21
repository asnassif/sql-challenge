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



-- Question 1:List the following details of each employee: employee number, last name, first name, gender, and salary.

SELECT employees_adjusted.employee_id, employees_adjusted.last_name, employees_adjusted.first_name, employees_adjusted.gender, salaries_adjusted.salary
FROM employees_adjusted
right JOIN salaries_adjusted ON
employees_adjusted.employee_id = salaries_adjusted.employee_id;


-- Question 2: List employees who were hired in 1986.

SELECT employee_id, last_name, first_name,gender,hire_date FROM employees_adjusted
WHERE hire_date >= '1986-01-01'
AND hire_date <= '1986-12-31' ;


-- Question 3:List the manager of each department with the following information: 
-- department number, department name, the manager's employee number, last name, first name, and start and end employment dates.

-- i) we have to identify the Employee ID numbers associated with Managers:
--------------------------------------------------------------------------------
-- SELECT employee_id,from_date, to_date
-- FROM titles_adjusted
-- where title ='Manager';




select last_name,first_name
from employees_adjusted
where employee_id
IN (
	select employee_id
	from dept_manager_adjusted
	where dept_id
	IN (
		select dept_id
		from departments_adjusted
		where dept_id
		IN (
			select dept_id
			from dept_manager_adjusted
			where employee_id
			IN (
				SELECT employee_id
				FROM titles_adjusted
				where title ='Manager'
				)
		)
	)
);
					
					
SELECT departments_adjusted.dept_id,departments_adjusted.dept_name,dept_manager_adjusted.employee_id, 
dept_manager_adjusted.from_date,dept_manager_adjusted.to_date
FROM dept_manager_adjusted
LEFT JOIN departments_adjusted
ON departments_adjusted.dept_id=dept_manager_adjusted.dept_id


-- Question 4:List the department of each employee with the following information: employee number, last name, first name, and department name.


select employee_id, last_name, first_name
from  employees_adjusted
where employee_id
IN ( 	
	select employee_id
	from dept_emp_adjusted
	where dept_id
	IN (
		select dept_id
		from departments_adjusted
		where dept_name
		IN (
			select dept_name
			from departments_adjusted
			GROUP BY dept_name
		)
	)
);
	
	

-- Question 5:List all employees whose first name is "Hercules" and last names begin with "B."

select  first_name, last_name from employees_adjusted where first_name='Hercules' and Last_name like 'B%';


-- Question 6:List all employees in the Sales department, including their employee number, last name, first name, and department name.

select last_name, first_name
from employees_adjusted
where employee_id
IN (
	select employee_id
	from dept_emp_adjusted
	where dept_id
	IN (
		select dept_id
		from departments_adjusted
		where dept_name
		IN (
			select dept_name
			from departments_adjusted
			where dept_name ='Sales'
		)
	)
);




-- Question 7: List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.

select last_name, first_name
from employees_adjusted
where employee_id
IN (
	select employee_id
	from dept_emp_adjusted
	where dept_id
	IN (
		select dept_id
		from departments_adjusted
		where dept_name
		IN (
			select dept_name
			from departments_adjusted
			where dept_name= 'Development'
			
		)
	)
);

Question 8: In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.









	
	