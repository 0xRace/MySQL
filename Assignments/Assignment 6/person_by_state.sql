-- Q2 Solved
-- Partial script for the 'person_by_state' stored procedure
-- Feel free to remove/edit the comments once you have finished the code (in fact, please do)
USE ischool;

DROP PROCEDURE IF EXISTS person_by_state;

DELIMITER //
-- The CREATE statement is below, be sure to create the varchar parameter!
CREATE PROCEDURE  (
	
	)

BEGIN
-- --> The procedure is made up of a select statement with the following columns:
-- --- person which is the person's full name in '(first name) (last name)' format
-- --- department, street, location which is in '(city), (state)' format, 
-- --- and classification.

-- --> Only include people from the state that match the parameter state
-- --- List each person only once
-- --- Order by person DESC, location, street

		

END //

DELIMITER ;

-- --> TEST YOUR CODE:
-- --- Run the statement below to test your code: 
-- --- Do you see the rows with the following values?

-- --- Noni Beatey			BSIS	420 Jay Hill			Newport News, VA	Staff
-- --- Ninetta Chesshire	PHD		018 Buhler Crossing		Arlington, VA		Student
-- --- Natalya Depper		MLIS	8578 Algoma Way			Arlington, VA		Student
-- --- Griselda Oki			BSIS	782 Garrison Pass		Roanoke, VA			Faculty

-- --- If "Yes", you have built the stored procedure as required; 
-- --- if "No", continue working on it.
CALL person_by_state('VA');

