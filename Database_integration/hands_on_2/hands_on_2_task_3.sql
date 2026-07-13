USE college_db;

-- Step 25
SELECT
    CONCAT(s.first_name, ' ', s.last_name) AS student_name,
    d.dept_name AS department_name
FROM students s
JOIN departments d
    ON s.department_id = d.department_id;

-- Step 26
SELECT
    e.enrollment_id,
    CONCAT(s.first_name, ' ', s.last_name) AS student_name,
    c.course_name,
    e.enrollment_date,
    e.grade
FROM enrollments e
JOIN students s
    ON e.student_id = s.student_id
JOIN courses c
    ON e.course_id = c.course_id;

-- Step 27
SELECT
    s.student_id,
    CONCAT(s.first_name, ' ', s.last_name) AS student_name,
    s.email
FROM students s
LEFT JOIN enrollments e
    ON s.student_id = e.student_id
WHERE e.enrollment_id IS NULL;

-- Step 28
SELECT
    c.course_id,
    c.course_name,
    COUNT(e.student_id) AS student_count
FROM courses c
LEFT JOIN enrollments e
    ON c.course_id = e.course_id
GROUP BY
    c.course_id,
    c.course_name
ORDER BY c.course_id;

-- Step 29
SELECT
    d.department_id,
    d.dept_name,
    p.prof_name,
    p.salary
FROM departments d
LEFT JOIN professors p
    ON d.department_id = p.department_id
ORDER BY
    d.department_id,
    p.prof_name;