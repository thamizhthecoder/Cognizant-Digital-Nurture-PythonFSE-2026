-- Step 6
-- 1NF: Every column contains atomic values with no repeating groups or multiple values in one field.
-- A hypothetical violation would be storing multiple phone numbers in a single column.

-- Step 7
-- 2NF: Every non-key attribute depends on the complete key.
-- In enrollments, enrollment_date and grade depend on the student_id and course_id candidate key.

-- Step 8
-- 3NF: There are no transitive dependencies.
-- Storing dept_name in students would violate 3NF because dept_name depends on department_id.

-- Step 9
-- enrollments satisfies 3NF because it stores only enrollment-specific attributes.
-- Student details are stored in students and course details are stored in courses.
-- Every non-key attribute depends directly on the enrollment key with no transitive dependency.
