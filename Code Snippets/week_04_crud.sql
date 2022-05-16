USE ap;

INSERT INTO terms
  VALUES (6, 'Net due 120 days', 120);
  
INSERT INTO terms
    (terms_description, terms_due_days)
  VALUES ('Net due 120 days', 120);
  
ALTER TABLE terms AUTO_INCREMENT = 6;  

UPDATE terms
  SET terms_description = 'Net due 125 days',
      terms_due_days = 125
  WHERE terms_id = 6;    

DELETE FROM terms  
  WHERE terms_id = 6;    
  
  
INSERT INTO terms
  (terms_description, terms_due_days)
  VALUES ('Net due 120 days', 120);
  
UPDATE terms
  SET terms_description = 'Net due 125 days',
      terms_due_days = 125
  WHERE terms_id > 3;
  
DELETE FROM terms
  WHERE terms_id = 6;  
  
UPDATE Persons
SET  Persons.PersonCityName=(SELECT AddressList.PostCode
                            FROM AddressList
                            WHERE AddressList.PersonId = Persons.PersonId);
                            
UPDATE Per
SET 
Per.PersonCityName=Addr.City, 
Per.PersonPostCode=Addr.PostCode
FROM Persons Per
INNER JOIN
AddressList Addr
ON Per.PersonId = Addr.PersonId