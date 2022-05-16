
USE ischool;

DROP PROCEDURE IF EXISTS person_by_state;


DELIMITER //
CREATE PROCEDURE person_by_state (
		IN pstate	VARCHAR(2)
	)
BEGIN

      SELECT DISTINCT concat(fname, " ",lname) AS person, department, street, concat(city, " ", state) as location, classification
    FROM people
	JOIN person_addresses ON(people.person_id=person_addresses.person_id)
    JOIN person_classifications ON (people.person_id=person_classifications.person_id)
    JOIN classification ON (person_classifications.classification_id = classification.classification_id)
	JOIN addresses ON (person_addresses.address_id=addresses.address_id and pstate = state )
    ORDER BY person DESC, location, street;
   
END ;//

DELIMITER ;


CALL person_by_state('VA');

