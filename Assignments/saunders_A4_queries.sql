/*Answer 1*/ 
-- aggregate functions 
-- columns student_name, credit_count, enrollments, latest_start
-- insert a final row that gives subtotals for each row 
USE ischool;
SELECT CONCAT(fname, " ", lname) AS student_name, SUM(credits) AS credit_count, COUNT(course_id) AS enrollments, TIME_FORMAT(MAX(start_time), "%h:%i:%s %p") AS latest_start
FROM people
JOIN enrollments USING(person_id)
JOIN course_sections USING (section_id)
JOIN courses USING (course_id)
GROUP BY CONCAT(fname, " ", lname)
UNION
  SELECT NULL, SUM(credits) , COUNT(course_id) , TIME_FORMAT(MAX(start_time), "%h:%i:%s %p")
  FROM people
  JOIN enrollments USING(person_id)
  JOIN course_sections USING (section_id)
  JOIN courses USING (course_id)
ORDER BY student_name IS NULL, student_name;
 
 /*Answer 2*/ 
 -- I chose to use CTE's because I found it easy to visualize and then combine the different tables and elements that I wanted. Because you can reference cte's in subsequent cte's, this worked especially well.
 -- columns are course, credits, section_count, enrollment_count 
WITH sections AS (
SELECT course_id, CONCAT(Course_code, course_number) as course,credits, COUNT(section_id) as section_count
FROM courses
JOIN course_sections USING (course_id)
GROUP BY course_id
),
 enrollments AS (
SELECT course_id, NULLIF(COUNT(person_id),0) AS enrollment_count
FROM courses
JOIN course_sections USING (course_id)
LEFT JOIN enrollments USING (section_id)
GROUP BY course_number
)

SELECT course, credits, section_count,  enrollment_count
FROM sections
JOIN enrollments  USING (course_id)
ORDER BY enrollment_count DESC, section_count DESC


 