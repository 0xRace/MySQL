-- -------------------------------------------------- 
-- Using Functions to work with data types
-- -------------------------------------------------- 
USE my_guitar_shop;

-- Create a query that returns 4 columns from the orders table
-- where the tax_amount is greater than zero.
-- * tax_amount
-- * A column that uses the ROUND function to return the tax_amount with 1 decimal digit
-- * A column that uses the ROUND function to return the tax_amount with no decimals
-- * A column that uses the TRUNCATE function to return the tax_amount with no decimals

SELECT tax_amount, ROUND(tax_amount, 1) AS one_digit, 
    ROUND(tax_amount, 0) AS zero_digits_round,
    TRUNCATE(tax_amount, 0) AS zero_digits_truncate
FROM orders
WHERE tax_amount > 0;

-- Create a query that returns 4 columns from the orders table.
-- * ship_date
-- * A column that uses the DATE_FORMAT function to return the ship_date in the example structure APR/03/15
-- * A column that uses the DATE_FORMAT function to return the ship_date in the example structure 4/3/15
-- * A column that uses the DATE_FORMAT function to return the ship_date in the example structure 4/3/15 12:45 PM

SELECT ship_date, 
    DATE_FORMAT(ship_date, '%b/%d/%y') AS format1, 
    DATE_FORMAT(ship_date, '%c/%e/%y') AS format2, 
    DATE_FORMAT(ship_date, '%c/%e/%y %l:%i %p') AS format3 
FROM orders;

-- Create a query that returns 4 columns from the orders table.
-- * city
-- * The city in all capital letters
-- * The phone column
-- * A column that shows the last four digits of each phone number

SELECT city,
    UPPER(city) AS city_upper,
    phone,
    SUBSTRING(phone, 9) AS last_digits
FROM addresses;

-- Create a query that returns these columns from the orders table.
-- * order_id
-- * order_date
-- * order_date plus 30 days
-- * ship_date
-- * A column named days_to_ship that shows the number of days
--      between the order_date and the payment_date
-- * The number of the order_date's month
-- * The 4 digit year of the order_date

SELECT order_id,
       order_date,
       DATE_ADD(order_date, INTERVAL 30 DAY) AS date_plus_30_days,
       ship_date,
       DATEDIFF(ship_date, order_date) AS days_to_ship,
       MONTH(order_date) AS "month",
       YEAR(order_date) AS "year"
FROM orders
WHERE order_date > '2015-03-01' AND order_date < '2015-03-30';