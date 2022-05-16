/* Week 3 - Lecture */

-- TRY IT #1
USE iSchool;
SELECT course_code, course_number, section_number, 
	meeting_days, start_time, end_time
	FROM courses
		JOIN course_sections
			ON courses.course_id = course_sections.course_id
	WHERE course_number = '326'
    ORDER BY course_code, course_number, section_number;

-- With instructors  
SELECT course_code, course_number, section_number, 
	meeting_days, start_time, end_time,
    CONCAT(lname, ', ', fname) AS instructor
	FROM courses
		JOIN course_sections
			ON courses.course_id = course_sections.course_id
		JOIN people
			ON instructor_id = person_id
	WHERE course_number = '327'
    ORDER BY course_code, course_number, section_number;

-- With USING instead of ON  
SELECT course_code, course_number, section_number, 
	meeting_days, start_time, end_time,
    CONCAT(lname, ', ', fname) AS instructor
	FROM courses
		JOIN course_sections
            USING(course_id)
		JOIN people
			ON instructor_id = person_id  
            -- WHY CAN'T I USE 'USING' HERE?
	WHERE course_number = '327'
    ORDER BY course_code, course_number, section_number;

-- TRY IT #2 - UNION
-- Let's build this a piece at a time
-- FIRST, create the first query
SELECT CONCAT(course_code, course_number) AS 'Course', 
	course_prereq AS prerequisite
	FROM iSchool.courses
    WHERE course_number LIKE '3%' AND course_prereq IS NOT NULL;

-- SECOND, create the second query
SELECT CONCAT(course_code, course_number) AS 'Course', 
	' No Prereq' AS prerequisite
	FROM iSchool.courses
    WHERE course_number LIKE '3%' AND course_prereq IS NULL;

-- THIRD, Let's put things together.
-- 		Combine the result sets of the two queries using the UNION
SELECT CONCAT(course_code, course_number) AS 'Course', 
	course_prereq AS prerequisite
	FROM iSchool.courses
    WHERE course_number LIKE '3%' AND course_prereq IS NOT NULL
UNION
SELECT CONCAT(course_code, course_number) AS 'Course', 
	' No Prereq' AS prerequisite
	FROM iSchool.courses
    WHERE course_number LIKE '3%' AND course_prereq IS NULL;

-- FOURTH, Now add an ORDER BY to sort the results
SELECT CONCAT(course_code, course_number) AS 'Course', 
	course_prereq AS prerequisite
	FROM iSchool.courses
    WHERE course_number LIKE '3%' AND course_prereq IS NOT NULL
UNION
SELECT CONCAT(course_code, course_number) AS 'Course', 
	' No Prereq' AS prerequisite
	FROM iSchool.courses
    WHERE course_number LIKE '3%' AND course_prereq IS NULL
ORDER BY prerequisite;

