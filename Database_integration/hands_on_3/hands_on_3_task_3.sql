USE college_db;

-- Step 44
DELIMITER $$

CREATE PROCEDURE sp_enroll_student(
    IN p_student_id INT,
    IN p_course_id INT,
    IN p_enrollment_date DATE
)
BEGIN
    IF EXISTS (
        SELECT 1
        FROM enrollments
        WHERE student_id = p_student_id
          AND course_id = p_course_id
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Student already enrolled in this course';
    ELSE
        INSERT INTO enrollments(student_id, course_id, enrollment_date)
        VALUES (p_student_id, p_course_id, p_enrollment_date);
    END IF;
END$$

DELIMITER ;

CALL sp_enroll_student(1, 3, '2024-01-10');

-- Step 45
CREATE TABLE department_transfer_log (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT,
    old_department_id INT,
    new_department_id INT,
    transfer_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

DELIMITER $$

CREATE PROCEDURE sp_transfer_student(
    IN p_student_id INT,
    IN p_new_department INT
)
BEGIN
    DECLARE v_old_department INT;

    START TRANSACTION;

    SELECT department_id
    INTO v_old_department
    FROM students
    WHERE student_id = p_student_id;

    UPDATE students
    SET department_id = p_new_department
    WHERE student_id = p_student_id;

    INSERT INTO department_transfer_log(student_id, old_department_id, new_department_id)
    VALUES(p_student_id, v_old_department, p_new_department);

    COMMIT;
END$$

DELIMITER ;

CALL sp_transfer_student(1,2);

-- Step 46
START TRANSACTION;

UPDATE students
SET department_id = 999
WHERE student_id = 2;

INSERT INTO department_transfer_log(student_id, old_department_id, new_department_id)
VALUES(2,1,999);

ROLLBACK;

-- Step 47
START TRANSACTION;

INSERT INTO enrollments(student_id, course_id, enrollment_date)
VALUES(2,2,CURDATE());

SAVEPOINT sp1;

INSERT INTO enrollments(student_id, course_id, enrollment_date)
VALUES(999,2,CURDATE());

ROLLBACK TO sp1;

COMMIT;