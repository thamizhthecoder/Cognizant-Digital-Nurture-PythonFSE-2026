USE college_db;

-- Step 30
SELECT
    c.course_name,
    COUNT(e.enrollment_id) AS enrollment_count
FROM courses c
LEFT JOIN enrollments e
    ON c.course_id = e.course_id
GROUP BY
    c.course_id,
    c.course_name;

-- Step 31
SELECT
    d.dept_name,
    ROUND(AVG(p.salary), 2) AS average_salary
FROM departments d
LEFT JOIN professors p
    ON d.department_id = p.department_id
GROUP BY
    d.department_id,
    d.dept_name;

-- Step 32
SELECT
    dept_name,
    SUM(budget) AS total_budget
FROM departments
GROUP BY
    department_id,
    dept_name
HAVING SUM(budget) > 600000;

-- Step 33
SELECT
    e.grade,
    COUNT(*) AS grade_count
FROM enrollments e
JOIN courses c
    ON e.course_id = c.course_id
WHERE c.course_code = 'CS101'
GROUP BY e.grade
ORDER BY e.grade;

-- Step 34
SELECT
    d.department_id,
    d.dept_name,
    COUNT(DISTINCT e.student_id) AS total_students
FROM departments d
JOIN courses c
    ON d.department_id = c.department_id
JOIN enrollments e
    ON c.course_id = e.course_id
GROUP BY
    d.department_id,
    d.dept_name
HAVING COUNT(DISTINCT e.student_id) > 2;