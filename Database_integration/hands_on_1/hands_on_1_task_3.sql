USE college_db;

-- Step 10
ALTER TABLE students
ADD COLUMN phone_number VARCHAR(15);

-- Step 11
ALTER TABLE courses
ADD COLUMN max_seats INT DEFAULT 60;

-- Step 12
ALTER TABLE enrollments
ADD CONSTRAINT chk_grade
CHECK (grade IN ('A', 'B', 'C', 'D', 'F') OR grade IS NULL);

-- Step 13
ALTER TABLE departments
RENAME COLUMN hod_name TO head_of_dept;

-- Step 14
ALTER TABLE students
DROP COLUMN phone_number;
