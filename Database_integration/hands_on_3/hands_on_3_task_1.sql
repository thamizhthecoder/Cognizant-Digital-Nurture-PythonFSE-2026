USE college_db;

-- Step 35
SELECT
    s.student_id,
    CONCAT(s.first_name, ' ', s.last_name) AS student_name,
    COUNT(e.enrollment_id) AS course_count
FROM students s
JOIN enrollments e
    ON s.student_id = e.student_id
GROUP BY
    s.student_id,
    s.first_name,
    s.last_name
HAVING COUNT(e.enrollment_id) > (
    SELECT AVG(enrollment_count)
    FROM (
        SELECT
            COUNT(*) AS enrollment_count
        FROM enrollments
        GROUP BY student_id
    ) AS student_enrollment_counts
);

-- Step 36
SELECT
    c.course_id,
    c.course_name,
    c.course_code
FROM courses c
WHERE EXISTS (
    SELECT 1
    FROM enrollments e
    WHERE e.course_id = c.course_id
)
AND NOT EXISTS (
    SELECT 1
    FROM enrollments e
    WHERE e.course_id = c.course_id
      AND (e.grade <> 'A' OR e.grade IS NULL)
);

-- Step 37
SELECT
    p.professor_id,
    p.prof_name,
    p.salary,
    d.dept_name
FROM professors p
JOIN departments d
    ON p.department_id = d.department_id
WHERE p.salary = (
    SELECT MAX(p2.salary)
    FROM professors p2
    WHERE p2.department_id = p.department_id
);

-- Step 38
SELECT
    d.dept_name,
    salary_summary.average_salary
FROM departments d
JOIN (
    SELECT
        department_id,
        AVG(salary) AS average_salary
    FROM professors
    GROUP BY department_id
) AS salary_summary
    ON d.department_id = salary_summary.department_id
WHERE salary_summary.average_salary > 85000;