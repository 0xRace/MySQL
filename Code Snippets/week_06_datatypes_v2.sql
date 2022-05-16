-- -------------------------------------------------- 
-- What are the major SQL data types
-- Character: CHAR and VARCHAR
-- Numeric: INT, DECIMAL, FLOAT, and DOUBLE
-- Date: DATETIME, DATE, TIME, YEAR, and TIMESTAMP
-- Boolean: BOOLEAN and TINYINT
-- Large Object: BLOB and TEXT
-- Spatial: geographical values
-- JSON: JSON documents
-- -------------------------------------------------- 

USE my_guitar_shop;
SELECT *
	FROM orders;


SELECT CONCAT(card_type, ', ', card_number, ', ', card_expires) AS card_info
	FROM orders;


-- Explicit conversion of data types
SELECT order_id, order_date, tax_amount,
    CAST(order_date AS CHAR(10)) AS char_date,
    CAST(tax_amount AS SIGNED) AS integer_total
FROM orders;


-- Data types into which values can be converted using CAST()
-- CHAR 	Converts value to CHAR (a fixed length string)
-- NCHAR 	Converts value to NCHAR (like CHAR, but produces a string with the national character set)
-- SIGNED 	Converts value to SIGNED (a signed 64-bit integer)
-- UNSIGNED Converts value to UNSIGNED (an unsigned 64-bit integer)
-- DECIMAL 	Converts value to DECIMAL. Use the optional M and D parameters to specify the maximum number of digits (M) and the number of digits following the decimal point (D).
-- DATE 	Converts value to DATE. Format: "YYYY-MM-DD"
-- DATETIME Converts value to DATETIME. Format: "YYYY-MM-DD HH:MM:SS"
-- TIME 	Converts value to TIME. Format: "HH:MM:SS"
-- BINARY 	Converts value to BINARY (a binary string)
-- JSON		Produces a JSON value

 
-- Implicit conversion from numeric to string
SELECT ship_amount, tax_amount, CONCAT('$', ship_amount + tax_amount) AS shipping
	FROM orders;

    
-- Implicit conversion from integer to decimal
-- fyi, we can implicitly convert from integer to decimal but not the other way
SELECT 2 + 1.5 AS total;


-- Implicit conversion from string to numeric
SELECT card_expires, card_expires + 1 AS card_info
	FROM orders;

    
-- Implicit conversion from date to number
SELECT ship_date, order_date, ship_date - order_date AS 'Number of Days to Ship', ship_date + 1 AS ship_plus
FROM orders;


-- IMPROVED - STEP 1: Implicit conversion from date to number
SELECT ship_date, order_date, ship_date - order_date AS 'Number of Days to Ship', CAST(ship_date AS DATE) + 1 AS ship_plus
FROM orders;


-- IMPROVED - STEP 2: Implicit conversion from date to number
SELECT ship_date, order_date, ship_date - order_date AS 'Number of Days to Ship', CAST((CAST(ship_date AS DATE) + 1) AS DATE) AS ship_plus
FROM orders;


-- Implicit conversion from date to number
USE ap;
SELECT invoice_date, invoice_due_date, payment_date, payment_date - invoice_due_date AS 'Number of Days Paid Overdue', payment_date + 1 AS payment_plus
FROM invoices;


-- IMPROVED: Implicit conversion from number to date
USE ap;
SELECT invoice_date, invoice_due_date, payment_date, payment_date - invoice_due_date AS 'Number of Days Paid Overdue', CAST((payment_date + 1) AS DATE) AS payment_plus
FROM invoices;




-- Create a query that returns the following 3 columns from the 
-- order_items table.
--  * The item_price column
--  * A column that uses the FORMAT function to return the item_price with 1 digit to the right of the decimal
--  * A column that uses the CAST function to return the item_price as an integer
USE my_guitar_shop;
SELECT item_price,
       FORMAT(item_price, 1) AS total_format,
       CAST(item_price AS SIGNED) AS total_cast
FROM order_items;

-- Create a query that returns the following 3 columns from the
-- orders table.
--  * order_date column
--  * A column that uses the CAST function to return the order_date with only the date information
--  * A column that uses the CAST function to return the order_date with just the year and month
USE my_guitar_shop;
SELECT order_date, 
       CAST(order_date AS DATE) AS invoice_datetime, 
       CAST(order_date AS CHAR(7)) AS invoice_char7
FROM orders;
