-- Question 3
SET SQL_SAFE_UPDATES = 0;
USE om;
CREATE TABLE orders_copy AS
SELECT * 
FROM orders;
CREATE TABLE order_details_copy AS
SELECT *
FROM order_details;
-- Test 2
SELECT *
FROM order_details_copy;
-- Question 4

-- Question 4
USE om;
SET SQL_SAFE_UPDATES = 0;
SELECT *
FROM orders_copy
WHERE shipped_date IS NOT NULL;
DELETE FROM orders_copy
WHERE shipped_date IS NOT NULL;
SET SET_SQL_SAFE_UPDATES = 1;
SELECT *
FROM orders_copy;
 
-- Question 5
-- create table again
USE om;
SET SQL_SAFE_UPDATES = 0;
CREATE TABLE order_details_copy AS
SELECT *
FROM order_details;
-- verify the items we want to update
SELECT *
FROM order_details_copy
WHERE order_id = 829 AND item_id = 5;
-- update the items
SET SQL_SAFE_UPDATES = 0;
UPDATE order_details_copy
SET order_qty = order_qty+2
WHERE order_id = 829 AND item_id = 5;

-- Question 6
SET SQL_SAFE_UPDATES = 0;
INSERT INTO customers_copy 
 VALUES (26, 'fname','lname','address','city','ST',0, 111,0);
SELECT *
FROM customers_copy;

-- Question 7
SELECT *, COUNT(*)
FROM order_details_copy
WHERE order_id = 829 ;