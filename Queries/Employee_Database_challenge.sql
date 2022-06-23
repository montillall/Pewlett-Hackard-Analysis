SELECT * FROM employees;

-- Deliverable 1: The Number of Retiring Employees by Title
SELECT e.emp_no, 
	e.first_name,
	e.lat_name,
	ti.title,
	ti.from_date,
	ti.to_date
INTO retirement_titles
FROM employees AS e
	INNER JOIN titles AS ti
		ON (e.emp_no = ti.emp_no)
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY emp_no;
	
SELECT * FROM retirement_titles;		
	

-- Use Distinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (re_ti.emp_no) re_ti.emp_no,
	re_ti.first_name,
	re_ti.lat_name,
	re_ti.title
INTO unique_titles
FROM retirement_titles AS re_ti
WHERE to_date = '9999-01-01'
ORDER BY emp_no, from_date DESC;

-- Retrieve numbers of employees by their most recent job title about to retire
SELECT COUNT (un_ti.title) AS "count", un_ti.title
INTO retiring_titles
FROM unique_titles AS un_ti
GROUP BY title
ORDER BY "count" DESC;


-- Employees eligible to participate in a mentorship program
SELECT DISTINCT ON (e.emp_no) e.emp_no,
	e.first_name,
	e.lat_name,
	e.birth_date,
	de.from_date,
	de.to_date,
	ti.title
INTO mentorship_eligibility
FROM employees AS e
	INNER JOIN dept_emp AS de
		ON (e.emp_no = de.emp_no)
	INNER JOIN titles as ti
		ON (e.emp_no = ti.emp_no)
WHERE (de.to_date = '9999-01-01')
AND (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY emp_no;




