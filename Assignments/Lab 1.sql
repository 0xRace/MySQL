/* Question 1 */

-- select items from the ischool database
USE ischool;

-- choose which items and format the Column names
SELECT concat(street, ", ",city) AS "Street/City", state AS "State", zipcode AS "Zipcode", country AS "Country", substring(main_phone, 9,4) AS "Last 4 Digits of Phone"

-- select which table to use 
FROM addresses

-- make sure zipcode is >= 0 and only countries after and including japan 
WHERE zipcode >= 0 AND country >= "Japan"

-- order returned values 
ORDER BY state, country 