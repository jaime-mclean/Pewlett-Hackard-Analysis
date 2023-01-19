SELECT * FROM departments;

SELECT first_name, last_name
FROM employees
WHERE (birthdate BETWEEN '1952-01-01' AND '1955-12-31') AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

SELECT COUNT(first_name)
FROM employees
WHERE (birthdate BETWEEN '1952-01-01' AND '1955-12-31') 
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

SELECT first_name, last_name
INTO retirement_info
FROM employees
WHERE (birthdate BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

SELECT * FROM retirement_info;

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

SELECT * FROM retirement_info;

-- Create new table for retiring employees
SELECT emp_no, first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');
-- Check the table
SELECT * FROM retirement_info;

-- Joining departments and dept_manager tables
SELECT departments.dept_name,
     dept_manager.emp_no,
     dept_manager.from_date,
     dept_manager.to_date
FROM departments
INNER JOIN dept_manager
ON departments.dept_no = dept_manager.dept_no;

-- Joining retirement_info and dept_emp tables
SELECT retirement_info.emp_no,
    retirement_info.first_name,
retirement_info.last_name,
    dept_employees.to_date
FROM retirement_info
LEFT JOIN dept_emp
ON retirement_info.emp_no = dept_employees.emp_no;

SELECT ri.emp_no,
    ri.first_name,
ri.last_name,
    de.to_date
FROM retirement_info as ri
LEFT JOIN dept_employees as de
ON ri.emp_no = de.emp_no;

SELECT ri.emp_no,
    ri.first_name,
    ri.last_name,
de.to_date
INTO current_emp
FROM retirement_info as ri
LEFT JOIN dept_employees as de
ON ri.emp_no = de.emp_no
WHERE de.to_date = ('9999-01-01');

-- Employee count by department number
SELECT COUNT(ce.emp_no), de.dept_no
FROM current_emp as ce
LEFT JOIN dept_emp as de
ON ce.emp_no = de.emp_no
GROUP BY de.dept_no
ORDER BY de.dept_no;

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
INNER JOIN dept_employees as de
ON (e.emp_no = de.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
     AND (e.hire_date BETWEEN '1985-01-01' AND '1988-12-31')
	   AND (de.to_date = '9999-01-01');
	 
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
		
SELECT ce.emp_no,
ce.first_name,
ce.last_name,
d.dept_name		
-- INTO dept_info
FROM current_emp as ce
INNER JOIN dept_emp AS de
ON (ce.emp_no = de.emp_no)
INNER JOIN departments AS d
ON (de.dept_no = d.dept_no);


SELECT ri.emp_no,
    ri.first_name,
    ri.last_name,
	di.dept_name
INTO sales_emp
FROM retirement_info as ri
LEFT JOIN dept_info as di
ON ri.emp_no = di.emp_no
WHERE di.dept_name =('Sales');

SELECT ri.emp_no,
    ri.first_name,
    ri.last_name,
	di.dept_name
INTO sales_dev_emp
FROM retirement_info as ri
LEFT JOIN dept_info as di
ON ri.emp_no = di.emp_no
WHERE di.dept_name = ('Development') OR di.dept_name =('Sales');

SELECT * FROM retirement_info;
SELECT * FROM dept_info;
SELECT * FROM emp_info;
SELECT * FROM sales_emp;


--Challenge

--DELIVERABLE 1

--Retirees and titles

SELECT  e.emp_no,
e.first_name,
e.last_name,
ti.title,
ti.from_date,
ti.to_date

INTO retirement_titles
FROM employees as e
    INNER JOIN titles as ti
        ON (e.emp_no = ti.emp_no)
WHERE (e.birthdate BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY e.emp_no;

--Retirees and current titles
SELECT DISTINCT ON (rt.emp_no) rt.emp_no,
rt.first_name,
rt.last_name,
rt.title

INTO unique_titles
FROM retirement_titles as rt
WHERE (rt.to_date = '9999-01-01')
ORDER BY rt.emp_no, rt.to_date DESC;

--Count of retirees current titles
SELECT COUNT(title), title
INTO retiring_titles
FROM unique_titles 
GROUP BY title
ORDER BY 1 DESC;

-- DELIVERABLE 2

-- Mentorship eligibility
SELECT DISTINCT ON (e.emp_no) e.emp_no,
e.first_name,
e.last_name,
e.birthdate,
de.from_date,
de.to_date,
ti.title

INTO mentorship_eligibility
FROM employees as e
    INNER JOIN dept_employees as de
        ON (e.emp_no = de.emp_no)
    INNER JOIN titles as ti
        ON  (e.emp_no = ti.emp_no)   
WHERE (e.birthdate BETWEEN '1965-01-01' AND '1965-12-31')
AND (ti.to_date = '9999-01-01')
ORDER BY e.emp_no, ti.to_date DESC;
