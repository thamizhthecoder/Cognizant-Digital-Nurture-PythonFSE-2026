USE college_db;

-- Step 48
EXPLAIN
SELECT
    s.first_name,
    s.last_name,
    c.course_name
FROM enrollments e
JOIN students s
    ON s.student_id = e.student_id
JOIN courses c
    ON c.course_id = e.course_id
WHERE s.enrollment_year = 2022;

-- Step 49
-- Check the EXPLAIN output for Full Table Scan (MySQL) or Sequential Scan (PostgreSQL).

-- Step 50
-- Note the estimated rows examined/cost from the EXPLAIN output.

-- Step 51
CREATE INDEX idx_students_enrollment_year
ON students(enrollment_year);

-- Step 52
CREATE UNIQUE INDEX idx_enrollments_student_course
ON enrollments(student_id, course_id);

-- Step 53
CREATE INDEX idx_courses_course_code
ON courses(course_code);

-- Step 54
EXPLAIN
SELECT
    s.first_name,
    s.last_name,
    c.course_name
FROM enrollments e
JOIN students s
    ON s.student_id = e.student_id
JOIN courses c
    ON c.course_id = e.course_id
WHERE s.enrollment_year = 2022;

-- Compare this EXPLAIN output with Step 48.

-- Step 55
CREATE INDEX idx_enrollments_grade_null
ON enrollments(student_id, grade);