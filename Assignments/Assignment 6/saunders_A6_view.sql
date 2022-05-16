/* Create views */
USE ischool;

CREATE OR REPLACE VIEW course_locations AS
	SELECT concat(course_code," ",course_number) AS course, section_number, concat(semester, " ", year) as semester,
    concat(fname, " ",lname) AS instructor,
     CONCAT(building_code ," ",room_number) AS location, building_name
    
    
    FROM courses
	JOIN course_sections ON(courses.course_id = course_sections.course_id AND format_id = 1)
    JOIN people ON instructor_id =person_id
	 LEFT JOIN locations USING(location_id);

SELECT * FROM course_locations