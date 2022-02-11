-- Challenge#1 - Steps 1-6 - Retreive data from two tables and export filtered data to a new one:
SELECT e.emp_no,
	e.first_name,
	e.last_name,
	t.title,
	t.from_date,
	t.to_date
INTO retirement_titles
FROM employees AS e
INNER JOIN titles as t
ON (e.emp_no = t.emp_no)
WHERE e.birth_date BETWEEN '1952-01-01' and '1955-12-31'
ORDER BY e.emp_no

-- Challenge#1 - Step 7 - View Table:
SELECT * FROM retirement_titles

-- Challenge#1 - Steps 8 - 14
-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (emp_no) emp_no,
first_name,
last_name,
title

INTO unique_titles
FROM retirement_titles
WHERE to_date = '9999-01-01'
ORDER BY emp_no, to_date DESC;

-- Challenge#1 - Step 15 - View Table:
SELECT * FROM unique_titles;


-- Challenge#1 - Step 16
SELECT COUNT(emp_no) as count, title
INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY count DESC;

-- Challenge#1 - Step 21 - View Table:
SELECT * FROM retiring_titles;
