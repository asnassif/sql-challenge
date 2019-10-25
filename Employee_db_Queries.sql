

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



