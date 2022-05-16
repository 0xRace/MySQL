-- ------------------------------------------------
-- Why do we need subqueries
-- List the invoices that have an invoice_total 
-- that is higher than the average invoice_total
-- The subquery retrieves a single cell of value
-- ------------------------------------------------
USE ap;

SELECT AVG(invoice_total)
  FROM invoices;
  
SELECT ROUND(AVG(invoice_total), 2)
  FROM invoices;  
  
SELECT invoice_id, invoice_date, invoice_total
  FROM invoices
  WHERE invoice_total > 1879.74;

SELECT invoice_id, invoice_date, invoice_total
  FROM invoices
  WHERE invoice_total > 1879.74
  ORDER BY invoice_total DESC;  
  
SELECT invoice_id, invoice_date, invoice_total
  FROM invoices
  WHERE invoice_total > (
		SELECT AVG(invoice_total)
		  FROM invoices)
  ORDER BY invoice_total DESC;

-- ------------------------------------------------
-- Three types of result sets returned by a SELECT statement 
-- 1. A single value (one column, one and only one row)
-- 2. A column of values (one column, one or many rows)
-- 3. A table of values (more than one column, one or many rows)
-- ------------------------------------------------

-- ------------------------------------------------
-- JOIN vs Subquery example
-- List the invoices from vendors located in CA
-- The subquery retrieves a column of values
-- ------------------------------------------------
SELECT invoice_number, invoice_date, invoice_total
  FROM invoices JOIN vendors
    USING(vendor_id)
  WHERE vendor_state = 'CA'
  ORDER BY invoice_date;  
  
-- Subquery  
SELECT vendor_id
  FROM vendors
  WHERE vendor_state = 'CA'  
  
  
SELECT invoice_number, invoice_date, invoice_total
FROM invoices
WHERE vendor_id IN
   (SELECT vendor_id
    FROM vendors
    WHERE vendor_state = 'CA')
ORDER BY invoice_date;  

-- ------------------------------------------------
-- List the vendors who sent at least one invoice
-- The subquery retrieves a column of values
-- ------------------------------------------------
SELECT vendor_id, vendor_name, vendor_state
FROM vendors
WHERE vendor_id IN
   (SELECT DISTINCT vendor_id
   FROM invoices)
ORDER BY vendor_id;

-- ------------------------------------------------
-- Four ways to introduce a subquery in a SELECT statement
-- 1. In a WHERE clause as a search condition
-- 2. In a HAVING clause as a search condition
-- 3. In the FROM clause as a table specification
-- 4. In the SELECT clause as a column specification
-- ------------------------------------------------

-- ------------------------------------------------
-- HAVING + FROM example
-- List vendors whose vendor_invoice_total is 
-- greater than the average vendor invoice_total
-- ------------------------------------------------
-- Three steps:
-- 1. Find vendor_invoice_totals (VIT)
-- 2. Find the average vendor_invoice_total
-- 3. Filter in vendors with VIT > AVG(VIT) 
-- ------------------------------------------------
SELECT vendor_id, SUM(invoice_total) vendor_invoice_total
  FROM invoices 
  GROUP BY vendor_id
  ORDER BY vendor_invoice_total DESC;

SELECT AVG(vendor_invoice_total) 
  FROM (SELECT vendor_id, SUM(invoice_total) vendor_invoice_total
          FROM invoices 
          GROUP BY vendor_id) t1;
		  
SELECT vendor_id, SUM(invoice_total) vendor_invoice_total
  FROM invoices 
  GROUP BY vendor_id
  HAVING vendor_invoice_total > 
      (SELECT AVG(vendor_invoice_total) 
		 FROM
           (SELECT vendor_id, SUM(invoice_total) vendor_invoice_total
              FROM invoices 
              GROUP BY vendor_id) t1)
  ORDER BY vendor_invoice_total DESC		  



SELECT vendor_name, SUM(invoice_total) vendor_invoice_total
  FROM invoices JOIN vendors 
    USING(vendor_id)
  GROUP BY vendors.vendor_id
  ORDER BY vendor_invoice_total DESC;


-- ------------------------------------------------
-- List the invoices that have an invoice_total 
-- that is higher than the average invoice_total
-- for each vendor
-- We need a correlated subquery
-- ------------------------------------------------
SELECT vendor_id, invoice_number, invoice_total
FROM invoices i
WHERE invoice_total >
    (SELECT AVG(invoice_total)
     FROM invoices
     WHERE vendor_id = i.vendor_id)
ORDER BY vendor_id, invoice_total

-- ------------------------------------------------
-- The subquery can be run for a given vendor_id
-- ------------------------------------------------
SELECT AVG(invoice_total)
     FROM invoices
     WHERE vendor_id = 95

