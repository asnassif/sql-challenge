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




-- Question 1:List the following details of each employee: employee number, last name, first name, gender, and salary.

SELECT employees_adjusted.employee_id, employees_adjusted.last_name, employees_adjusted.first_name, employees_adjusted.gender, salaries_adjusted.salary
FROM employees_adjusted
right JOIN salaries_adjusted ON
employees_adjusted.employee_id = salaries_adjusted.employee_id;


-- Question 2: List employees who were hired in 1986.

SELECT employee_id, last_name, first_name,gender,hire_date FROM employees_adjusted -- added all employee related data
WHERE hire_date >= '1986-01-01'
AND hire_date <= '1986-12-31' ;


-- Question 3:List the manager of each department with the following information: 
-- department number, department name, the manager's employee number, last name, first name, and start and end employment dates.


/*
SELECT shows you columns that you want to see

WHERE find rows that you want to see
*/

select dept_id, 

(select dept_name 
From departments_adjusted AS a WHERE d.dept_id = a.dept_id) AS "dept_name",

(select first_name 
FROM employees_adjusted AS a WHERE a.employee_id = d.employee_id) AS "first_name",

(select last_name
From employees_adjusted a WHERE a.employee_id = d.employee_id) AS "last_name",

(select from_date
FROM dept_manager_adjusted b WHERE b.employee_id = d.employee_id) AS "from_date",

(select to_date
FROM dept_manager_adjusted b WHERE b.employee_id = d.employee_id) AS "to_date",

employee_id

	from dept_manager_adjusted d
	where employee_id
	IN (
		select employee_id 
		from titles_adjusted where title='Manager'
	);

					
-- Question 4:List the department of each employee with the following information: employee number, last name, first name, and department name.


select employees_adjusted.employee_id, employees_adjusted.last_name, employees_adjusted.first_name,departments_adjusted.dept_name
from employees_adjusted
Left Join dept_emp_adjusted
ON employees_adjusted.employee_id = dept_emp_adjusted.employee_id
left Join departments_adjusted
on dept_emp_adjusted.dept_id = departments_adjusted.dept_id;



-- Question 5:List all employees whose first name is "Hercules" and last names begin with "B."

select  first_name, last_name from employees_adjusted where first_name='Hercules' and Last_name like 'B%';


-- Question 6:List all employees in the Sales department, including their employee number, last name, first name, and department name.

select employees_adjusted.employee_id ,employees_adjusted.last_name, employees_adjusted.first_name,departments_adjusted.dept_name
from employees_adjusted
Left Join dept_emp_adjusted
ON employees_adjusted.employee_id = dept_emp_adjusted.employee_id
Left Join departments_adjusted
on dept_emp_adjusted.dept_id = departments_adjusted.dept_id
WHERE departments_adjusted.dept_name='Sales';


-- Question 7: List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.

select  employees_adjusted.employee_id ,employees_adjusted.last_name, employees_adjusted.first_name,departments_adjusted.dept_name
from employees_adjusted
Left Join dept_emp_adjusted
ON employees_adjusted.employee_id = dept_emp_adjusted.employee_id
Left Join departments_adjusted
on dept_emp_adjusted.dept_id = departments_adjusted.dept_id
WHERE departments_adjusted.dept_name IN ('Sales','Development');


-- Question 8: In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.

select  last_name, count(last_name)  from employees_adjusted
group by last_name
ORDER BY count DESC;



