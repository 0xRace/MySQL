/*Answer 1*/
USE ischool;
SET SQL_SAFE_UPDATES = 0;
DROP TABLE IF EXISTS people_copy, enrollments_copy;
CREATE TABLE people_copy LIKE people;
INSERT INTO people_copy
    SELECT *
    FROM people;
CREATE TABLE enrollments_copy LIKE enrollments;
INSERT INTO enrollments_copy
	SELECT *
    FROM enrollments;
INSERT INTO people_copy
	-- person_id, lname, fname, pronoun_id, email, college, department, title, start_date
	VALUES (DEFAULT, 'Smith', 'Richard', 2, 'rsmith@umd.edu', 'College of Information Studies', 'BSIS', NULL, CURRENT_TIMESTAMP);
-- section_id 55, 46
INSERT INTO enrollments_copy
SELECT 
   person_id, 55 
FROM 
   people_copy
WHERE
   people_copy.email = 'rsmith@umd.edu';
INSERT INTO enrollments_copy
SELECT 
   person_id, 46
FROM 
   people_copy
WHERE
   people_copy.email = 'rsmith@umd.edu';

-- first select testing people_copy
SELECT * FROM ischool.people_copy;
-- second select testing enrollments_copy
SELECT * FROM ischool.enrollments_copy;

/*Answer 2*/
-- update to 47
UPDATE enrollments_copy
SET section_id = 47
WHERE section_id = 46 AND person_id = (
SELECT 
   person_id
FROM 
   people_copy
WHERE
   people_copy.email = 'rsmith@umd.edu') ;
-- select statement student_name, course, section_number, semester_year
SELECT CONCAT(fname, ' ', lname) as student_name, 
	CONCAT(course_code, course_number) AS course, 
    section_number,
	CONCAT(semester, ' ', year) AS semester_year
FROM people_copy
JOIN enrollments_copy USING (person_id)
JOIN course_sections using (section_id)
JOIN courses USING (course_id)
WHERE fname = 'Richard' AND lname = 'Smith';

/*Answer 3*/
-- select query
SELECT CONCAT(fname, ' ', lname) as student_name, 
	CONCAT(course_code, course_number) AS course, 
    section_number,
    section_id,
    (SELECT CONCAT(fname, ' ',lname)
    FROM people_copy
    WHERE instructor_id = person_id) as instructor_name
FROM people_copy
JOIN enrollments_copy USING (person_id)
JOIN course_sections using (section_id)
JOIN courses USING (course_id)
WHERE course_code = 'INST' AND course_number = 327;

-- delete statement 
DELETE 
FROM enrollments_copy
WHERE section_id = 54 OR section_id =55;
-- select query
SELECT CONCAT(fname, ' ', lname) as student_name, 
	CONCAT(course_code, course_number) AS course, 
    section_number,
    section_id,
    (SELECT CONCAT(fname, ' ',lname)
    FROM people_copy
    WHERE instructor_id = person_id) as instructor_name
FROM people_copy
JOIN enrollments_copy USING (person_id)
JOIN course_sections using (section_id)
JOIN courses USING (course_id)
WHERE course_code = 'INST' AND course_number = 327;


