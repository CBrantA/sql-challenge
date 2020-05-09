CREATE TABLE employees (
	emp_no VARCHAR (30) NOT NULL,
	emp_title_id VARCHAR (30) NOT NULL,
	birth_date VARCHAR (30) NOT NULL,
	first_name VARCHAR (64) NOT NULL,
	last_name VARCHAR (64) NOT NULL,
	sex VARCHAR (10) NOT NULL,
	hire_date VARCHAR (30) NOT NULL,
	PRIMARY KEY (emp_no)
	);
	
SELECT * FROM employees;

CREATE TABLE dept_emp (
	emp_no VARCHAR (30) NOT NULL,
	dept_no VARCHAR (30) NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);
	
SELECT * FROM dept_emp;

CREATE TABLE dept_manager (
	dept_no VARCHAR (30) NOT NULL,
	emp_no VARCHAR (30) NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
	);

SELECT * FROM dept_manager;

CREATE TABLE salaries (
	emp_no VARCHAR (30) NOT NULL,
	salary INT NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
	);
	
SELECT * FROM salaries;


CREATE TABLE departments (
  dept_no VARCHAR(30) NOT NULL,
  dept_name VARCHAR(64) NOT NULL
  );
  
SELECT * FROM departments;

CREATE TABLE titles (
	title_id VARCHAR (30) NOT NULL,
	title VARCHAR (30) NOT NULL);
	
SELECT * FROM titles;

--to list employee number, last name, first name, sex, salary
SELECT employees.emp_no, employees.last_name, employees.first_name, employees.sex, salaries.salary 
FROM employees
INNER JOIN salaries ON 
salaries.emp_no = employees.emp_no

--to list first name, last name, hire date for employees hired in 1986
SELECT employees.first_name, employees.last_name, employees.hire_date 
FROM employees
WHERE hire_date LIKE '%86'

--to list the manager of each department with: department number, department name, 
--the manager's employee number, last name, first name.
SELECT departments.dept_no, departments.dept_name, dept_manager.emp_no, employees.last_name, employees.first_name
FROM ((departments
INNER JOIN dept_manager ON departments.dept_no = dept_manager.dept_no)
INNER JOIN employees ON dept_manager.emp_no = employees.emp_no);

--to list employee number, last name, first name, dept name
SELECT employees.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM ((departments
INNER JOIN dept_emp ON departments.dept_no = dept_emp.dept_no)
INNER JOIN employees ON dept_emp.emp_no = employees.emp_no);

--to list first name, last name, sex of employees named Hercules B_
SELECT first_name, last_name, sex 
FROM employees
WHERE first_name='Hercules' AND last_name LIKE 'B%'

--to list employee number, last name, first name, dept name of everyone in Sales
SELECT employees.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM ((departments
INNER JOIN dept_emp ON departments.dept_no = dept_emp.dept_no)
INNER JOIN employees ON dept_emp.emp_no = employees.emp_no)
WHERE departments.dept_name='Sales';

--to list employee number, last name, first name, dept name of everyone in Sales and Development
SELECT employees.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM ((departments
INNER JOIN dept_emp ON departments.dept_no = dept_emp.dept_no)
INNER JOIN employees ON dept_emp.emp_no = employees.emp_no)
WHERE departments.dept_name='Sales' or departments.dept_name='Development';

--to list frequency count of employee last names in descending order
SELECT last_name, COUNT(*) AS frequency
FROM employees
GROUP BY last_name
ORDER BY frequency DESC;

