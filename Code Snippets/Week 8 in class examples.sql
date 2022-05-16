/* Code Examples - Week 08
Database Creation

Create / Drop Database
*/

CREATE DATABASE IF NOT EXISTS sample;

DROP DATABASE IF EXISTS sample;
-- Create / Drop Table

CREATE TABLE sample
(
  sample_id    INT          PRIMARY KEY   AUTO_INCREMENT,
  sample_name  VARCHAR(50)  NOT NULL      UNIQUE
);
-- Alter Table

ALTER TABLE sample
MODIFY sample_name VARCHAR(100) NOT NULL UNIQUE; 
-- Rename / Truncate / Drop Table

RENAME TABLE sample TO sample_two;

INSERT INTO sample_two
VALUES 
   (1, 'THIS IS A TEST'),
   (2, 'THIS IS ALSO A TEST');

SELECT * FROM sample_two;

TRUNCATE TABLE sample_two;

SELECT * FROM sample_two;

DROP TABLE sample_two; 