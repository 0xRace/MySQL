USE iSchool; 
SELECT course_code, course_number, section_number, meeting_days course_code, start_time, end_time
FROM courses
	JOIN course_sections USING (course_id) -- inner join is default language 
    -- or ON courses.course_id = course_sections.course_id
WHERE course_number = '327'
ORDER BY  course_number, section_number;


SELECT course_code, course_number, section_number, meeting_days course_code, start_time, end_time, CONCAT(lname,', ',fname) AS instructors
FROM courses
	JOIN course_sections USING (course_id) -- inner join is default language 
    -- or ON courses.course_id = course_sections.course_id
    JOIN people ON instructor_id = person_id
WHERE course_number = '327'
ORDER BY  course_number, section_number;



