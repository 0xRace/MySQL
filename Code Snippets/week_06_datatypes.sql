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

use my_guitar_shop;
SELECT *
	FROM orders;


SELECT CONCAT(card_type, ', ', card_number, ', ', card_expires) AS card_info
	FROM orders;
 
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


-- Explicit coversion of data types
SELECT order_id, order_date, tax_amount,
    CAST(order_date AS CHAR(10)) AS char_date,
    CAST(tax_amount AS SIGNED) AS integer_total
FROM orders;

-- Create a query that returns the following 3 columns from the 
-- order_items table.
--  * The item_price column
--  * A column that uses the FORMAT function to return the item_price with 1 digit to the right of the decimal
--  * A column that uses the CAST function to return the item_price as an integer
SELECT item_price,
       FORMAT(item_price, 1) AS total_format,
       CAST(item_price AS SIGNED) AS total_cast
FROM order_items;

-- Create a query that returns the following 3 columns from the
-- orders table.
--  * order_date column
--  * A column that uses the CAST function to return the order_date with only the date information
--  * A column that uses the CAST function to return the order_date with just the year and month
SELECT order_date, 
       CAST(order_date AS DATE) AS invoice_datetime, 
       CAST(order_date AS CHAR(7)) AS invoice_char7
FROM orders;
