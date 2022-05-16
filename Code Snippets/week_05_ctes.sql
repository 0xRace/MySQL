-- ------------------------------------------------
-- List the states where vendors who sent at least 
-- one invoice are located
-- The subquery retrieves a column of values
-- ------------------------------------------------
SELECT vendor_id, vendor_name, vendor_state
FROM vendors
WHERE vendor_id IN
    (SELECT DISTINCT vendor_id
    FROM invoices)
  ORDER BY vendor_id;

SELECT DISTINCT vendor_state
FROM vendors
WHERE vendor_id IN
  (SELECT DISTINCT vendor_id
  FROM invoices)
  ORDER BY vendor_state;
  
  
-- ------------------------------------------------
-- List the vendor from each state that has the
-- highest invoice total from that state
-- A bit complex for a subquery solution, use CTE
-- ------------------------------------------------
-- Step 1: 
-- Write a SELECT to SUM invoice_total by vendor
-- ------------------------------------------------
USE ap;

WITH 
summary AS (
SELECT vendor_state, vendor_name, SUM(invoice_total) AS sum_of_invoices
  FROM vendors v JOIN invoices i 
    ON v.vendor_id = i.vendor_id
  GROUP BY vendor_state, vendor_name
),

-- ------------------------------------------------
-- Step 2: 
-- Write a SELECT to identify vendor in each state
-- Use the SELECT from above as a table
-- ------------------------------------------------

top_in_state AS (
   SELECT vendor_state, MAX(sum_of_invoices) AS sum_of_invoices
   FROM summary
   GROUP BY vendor_state
)

-- ------------------------------------------------
-- Step 3: 
-- JOIN the two CTEs you built above to generate 
-- the final result set
-- ------------------------------------------------

SELECT summary.vendor_state, summary.vendor_name, top_in_state.sum_of_invoices
  FROM summary JOIN top_in_state
    ON summary.vendor_state = top_in_state.vendor_state AND
       summary.sum_of_invoices = top_in_state.sum_of_invoices
  ORDER BY summary.vendor_state; 


-- ------------------------------------------------
-- Recursive CTE example:
-- List the employees identifying their level
-- in the supervision hierarchy
-- 
-- We need one non-recursive routine
-- and one recursive routine, joined by a UNION
-- ------------------------------------------------
USE ex;

-- First build the non-recursive routine
WITH RECURSIVE employees_cte AS (
-- Non-recursive query
   SELECT employee_id, 
      CONCAT(first_name, ' ', last_name) AS employee_name, 1 AS ranking
   FROM employees
   WHERE manager_id IS NULL
   
-- Then build the recursive routine using the non-recursive one
-- join the two using a UNION
UNION

-- Recursive query
   SELECT employees.employee_id, CONCAT(first_name, ' ', last_name), ranking + 1
   FROM employees
      JOIN employees_cte
         ON employees.manager_id = employees_cte.employee_id
)   

SELECT *
  FROM employees_cte
  ORDER BY ranking, employee_id;