USE college_db;

-- Step 39
CREATE VIEW vw_student_enrollment_summary AS
SELECT
    s.student_id,
    CONCAT(s.first_name, ' ', s.last_name) AS student_name,
    d.dept_name AS department,
    COUNT(e.enrollment_id) AS courses_enrolled,
    ROUND(
        AVG(
            CASE
                WHEN e.grade = 'A' THEN 4
                WHEN e.grade = 'B' THEN 3
                WHEN e.grade = 'C' THEN 2
                WHEN e.grade = 'D' THEN 1
                WHEN e.grade = 'F' THEN 0
                ELSE NULL
            END
        ),
        2
    ) AS gpa
FROM students s
JOIN departments d
    ON s.department_id = d.department_id
LEFT JOIN enrollments e
    ON s.student_id = e.student_id
GROUP BY
    s.student_id,
    s.first_name,
    s.last_name,
    d.dept_name;

SELECT * FROM vw_student_enrollment_summary;

-- Step 40
CREATE VIEW vw_course_stats AS
SELECT
    c.course_id,
    c.course_name,
    c.course_code,
    COUNT(e.enrollment_id) AS total_enrollments,
    ROUND(
        AVG(
            CASE
                WHEN e.grade = 'A' THEN 4
                WHEN e.grade = 'B' THEN 3
                WHEN e.grade = 'C' THEN 2
                WHEN e.grade = 'D' THEN 1
                WHEN e.grade = 'F' THEN 0
                ELSE NULL
            END
        ),
        2
    ) AS avg_gpa
FROM courses c
LEFT JOIN enrollments e
    ON c.course_id = e.course_id
GROUP BY
    c.course_id,
    c.course_name,
    c.course_code;

SELECT * FROM vw_course_stats;

-- Step 41
SELECT *
FROM vw_student_enrollment_summary
WHERE gpa > 3.0;

-- Step 42
UPDATE vw_student_enrollment_summary
SET student_name = 'Updated Student'
WHERE student_id = 1;
-- Step 42: Update Test
-- The UPDATE operation on vw_student_enrollment_summary fails.
-- This view is generally not updatable because it combines multiple tables.
-- It also contains GROUP BY and aggregate functions such as COUNT() and AVG().
-- The student_name column is derived using CONCAT().
-- The GPA column is calculated using CASE and AVG().
-- Therefore, MySQL cannot map the modified view row directly
-- to one unambiguous row in a single underlying base table.

-- Step 43
DROP VIEW IF EXISTS vw_student_enrollment_summary;
DROP VIEW IF EXISTS vw_course_stats;

CREATE VIEW vw_student_enrollment_summary AS
SELECT
    student_id,
    first_name,
    last_name,
    email,
    date_of_birth,
    department_id,
    enrollment_year
FROM students
WHERE enrollment_year = 2022
WITH CHECK OPTION;

SELECT * FROM vw_student_enrollment_summary;

UPDATE vw_student_enrollment_summary
SET first_name = 'ArjunUpdated'
WHERE student_id = 1;

UPDATE vw_student_enrollment_summary
SET enrollment_year = 2023
WHERE student_id = 1;

-- Invalid update:
-- Expected to fail because the row would
-- no longer satisfy enrollment_year = 2022