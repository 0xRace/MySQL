/*Answer 1

*/
USE ischool;
SELECT CONCAT(lname, ', ', fname) AS person_name, person_id, department, title, pronoun, race
FROM people
JOIN pronouns USING (pronoun_id)
JOIN person_race USING (person_id)
JOIN race USING (race_id)
WHERE title IS NOT NULL
	UNION 
SELECT CONCAT( lname, ', ', fname) AS person_name, person_id, department, 'Student' AS title, pronoun, race
FROM people
JOIN pronouns USING (pronoun_id)
JOIN person_race USING (person_id)
JOIN race USING (race_id)
WHERE title IS NULL
ORDER BY department DESC, person_name;

/* 
Answer 2
*/
SELECT CONCAT(course_code,course_number)AS course,CONCAT (semester, " ", year,'-',section_number) AS section, CONCAT( lname, ', ', fname) AS student_name, course_description 
FROM courses
LEFT JOIN course_sections USING (course_id)
LEFT JOIN enrollments USING (section_id)
LEFT JOIN people USING (person_id)
ORDER BY course DESC, year, section_number, lname;

	


  
 

