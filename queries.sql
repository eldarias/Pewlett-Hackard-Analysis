SELECT * FROM departments;


-- 7.3.1 Queries:

-- Retirement eligibility
SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1952-01-01' AND '1955-12-31';

SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1952-01-01' AND '1952-12-31';
select count(*) from employees where birth_date between '1952-01-01' and '1952-12-31';

SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1953-01-01' AND '1953-12-31';

select count(*) from employees where birth_date between '1953-01-01' and '1953-12-31';

SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1954-01-01' AND '1954-12-31';
select count(*) from employees where birth_date between '1954-01-01' and '1954-12-31';


- Retirement eligibility
SELECT first_name, last_name
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

-- Number of employees retiring
SELECT COUNT(first_name)
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

SELECT first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

select * from retirement_info;


SELECT first_name, last_name, title
FROM employees as e
LEFT JOIN titles as t ON e.emp_no = t.emp_no

select * from retirement_info;


-- Deleting the retirement_info table so it can be recreated:
DROP TABLE retirement_info;

-- Create new table for retiring employees
SELECT emp_no, first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');


-- Check the table
SELECT * FROM retirement_info;


-- Joining departments and dept_manager tables using INNER JOIN:
SELECT departments.dept_name,
     dept_manager.emp_no,
     dept_manager.from_date,
     dept_manager.to_date
FROM departments
INNER JOIN dept_manager
ON departments.dept_no = dept_manager.dept_no;

-- Joining departments and dept_manager tables using INNER JOIN & ALIASES:
SELECT d.dept_name,
     dm.emp_no,
     dm.from_date,
     dm.to_date
FROM departments as d
INNER JOIN dept_manager as dm
ON d.dept_no = dm.dept_no;


-- Joining retirement_info and dept_emp tables using LEFT JOIN
SELECT retirement_info.emp_no,
    retirement_info.first_name,
	retirement_info.last_name,
    dept_emp.to_date
FROM retirement_info
LEFT JOIN dept_emp
ON retirement_info.emp_no = dept_emp.emp_no;


-- Joining retirement_info and dept_emp tables using LEFT JOIN & aliases:
SELECT ri.emp_no,
    ri.first_name,
	ri.last_name,
    de.to_date
FROM retirement_info as ri
LEFT JOIN dept_emp as de
ON ri.emp_no = de.emp_no;


-- Use Left Join for retirement_info and dept_emp tables then create a new table to hold the information:
SELECT ri.emp_no,
    ri.first_name,
    ri.last_name,
de.to_date
INTO current_emp
FROM retirement_info as ri
LEFT JOIN dept_emp as de
ON ri.emp_no = de.emp_no
WHERE de.to_date = ('9999-01-01');


select count(*) from current_emp;
select * from current_emp;


-- Employee count by department number using COUNT and GROUP BY:
SELECT COUNT(ce.emp_no), de.dept_no
FROM current_emp as ce
LEFT JOIN dept_emp as de
ON ce.emp_no = de.emp_no
GROUP BY de.dept_no;

-- Employee count by department number using COUNT, GROUP BY and ORDER BY:
SELECT COUNT(ce.emp_no), de.dept_no
FROM current_emp as ce
LEFT JOIN dept_emp as de
ON ce.emp_no = de.emp_no
GROUP BY de.dept_no
ORDER BY de.dept_no;

-- Employee count by department number using COUNT, GROUP BY and ORDER BY and SAVE To NEW TABLE:
SELECT COUNT(ce.emp_no), de.dept_no
INTO emp_dept_count
FROM current_emp as ce
LEFT JOIN dept_emp as de
ON ce.emp_no = de.emp_no
GROUP BY de.dept_no
ORDER BY de.dept_no;



-- 7.3.5 - Create Additional Lists
-- 1) Employee Information:
-- - A list of employees containing their unique employee number, their last name, first name, gender, and salary

-- My first code:
select emp.emp_no,
	emp.first_name,
	emp.last_name,
	emp.gender,
	sal.to_date,
	sal.salary
FROM employees as emp
Left JOIN salaries as sal
on emp.emp_no = sal.emp_no;

SELECT * FROM salaries
ORDER BY to_date DESC;

-- Quering and exporting to emp_info table, but just example, dont run as there is more data to export:
SELECT emp_no,
	first_name,
	last_name,
	gender
INTO emp_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

-- #1 completed, joined 3 tables and exported results to a new table:
SELECT e.emp_no,
	e.first_name,
	e.last_name,
	e.gender,
	s.salary,
	de.to_date
INTO emp_info
FROM employees as e
INNER JOIN salaries as s
ON (e.emp_no = s.emp_no)
INNER JOIN dept_emp as de
ON (e.emp_no = de.emp_no)

WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
	AND (e.hire_date BETWEEN '1985-01-01' AND '1988-12-31')
	AND (de.to_date = '9999-01-01');

-- Query Results:
SELECT * FROM emp_info;
	
	
-- #2 - List 2: Management
-- 2) Management: A list of managers for each department, including the department number, name, and the manager's employee number, last name, first name, and the starting and ending employment dates

-- List of managers per department
SELECT  dm.dept_no,
        d.dept_name,
        dm.emp_no,
        ce.last_name,
        ce.first_name,
        dm.from_date,
        dm.to_date
INTO manager_info
FROM dept_manager AS dm
    INNER JOIN departments AS d
        ON (dm.dept_no = d.dept_no)
    INNER JOIN current_emp AS ce
        ON (dm.emp_no = ce.emp_no);
		

-- #3 - List 3: Department Retirees

select * from current_emp;

-- QUery the data from three different tables using INNER JOIN then save it into a new table: dept_info
SELECT ce.emp_no,
	ce.first_name,
	ce.last_name,
	d.dept_name
INTO dept_info
FROM current_emp AS ce
	INNER JOIN dept_emp AS de
	ON (ce.emp_no = de.emp_no)
	
	INNER JOIN departments as d
	ON (de.dept_no = d.dept_no);

select * from dept_info

select * from retirement_info;

-- 7.3.6 SKILL DRILL 1
SELECT ri.emp_no,
	ri.first_name,
	ri.last_name,
	d.dept_name
INTO retirement_info_sales
FROM retirement_info AS ri
	INNER JOIN dept_emp AS de
	ON (ri.emp_no = de.emp_no)
	INNER JOIN departments AS d
	ON (de.dept_no = d.dept_no)
WHERE d.dept_name = 'Sales';

-- 7.3.6 SKILL DRILL 2
-- USING OR CONDITION:
SELECT ri.emp_no,
	ri.first_name,
	ri.last_name,
	d.dept_name
-- INTO retirement_info_sales
FROM retirement_info AS ri
	INNER JOIN dept_emp AS de
	ON (ri.emp_no = de.emp_no)
	INNER JOIN departments AS d
	ON (de.dept_no = d.dept_no)
WHERE d.dept_name = 'Sales' or d.dept_name = 'Development';


-- USING IN CONDITION:
SELECT ri.emp_no,
	ri.first_name,
	ri.last_name,
	d.dept_name
INTO retirement_info_sales_dev
FROM retirement_info AS ri
	INNER JOIN dept_emp AS de
	ON (ri.emp_no = de.emp_no)
	INNER JOIN departments AS d
	ON (de.dept_no = d.dept_no)
WHERE d.dept_name in ('Sales', 'Development');


select count(*) from retirement_info_sales_dev;




	




