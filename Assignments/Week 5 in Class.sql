
-- Week 5 Lecture - Subqueries 
-- Try it 1
USE iSchool;
SELECT section_number AS 'INST327', meeting_days, start_time, end_time
FROM course_sections
JOIN courses
USING (course_id)
WHERE course_number = '327'
ORDER BY section_number;

-- Try it 2
USE iSchool;
SELECT section_number AS 'INST327', meeting_days, start_time, end_time
FROM course_sections
WHERE course_id IN (
	SELECT course_id
		FROM courses
		WHERE course_number = '327'
    )
-- Select clause can only match one column, equal to is a single item 
-- Subquery in where, from, having, select
 
ORDER BY section_number;

-- Select in a from 

