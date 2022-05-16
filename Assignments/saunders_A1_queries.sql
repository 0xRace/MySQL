/* Question 1 */

-- select items from the ischool database
USE ischool;

-- choose which items and format the Column names
SELECT concat(street, ", ",city) AS "Street/City", state AS "State", zipcode AS "Zipcode", country AS "Country", substring(main_phone, 9,4) AS "Last 4 Digits of Phone"

-- select which table to use 
FROM addresses

-- make sure zipcode is >= 0 and only countries after and including japan 
WHERE zipcode >= 0 AND country >= "J"

-- order returned values 
ORDER BY state, country;

/* Question 2*/

USE ischool;
UPDATE people
SET title = "Student" 
WHERE title IS NULL;
SELECT concat(lname, ", ", fname) AS "person_name", start_date, department, title AS "Student"
FROM people
	WHERE start_date > "2020-03-12" 
		AND start_date < "2021-08-01" 
		AND title IS NOT NULL 
        AND title >= "Sf"
ORDER BY start_date DESC, person_name DESC;