USE college_db;

-- Step 20
SELECT *
FROM students
WHERE enrollment_year = 2022
ORDER BY last_name ASC;

-- Step 21
SELECT *
FROM courses
WHERE credits > 3
ORDER BY credits DESC;

-- Step 22
SELECT *
FROM professors
WHERE salary BETWEEN 80000 AND 95000;

-- Step 23
SELECT *
FROM students
WHERE email LIKE '%@college.edu';

-- Step 24
SELECT
    enrollment_year,
    COUNT(*) AS total_students
FROM students
GROUP BY enrollment_year
ORDER BY enrollment_year;