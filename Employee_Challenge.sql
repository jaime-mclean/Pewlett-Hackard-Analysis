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