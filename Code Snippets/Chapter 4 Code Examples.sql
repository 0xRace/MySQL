-- 01) Remember to connect to the ap database for use
USE ap;

-- 02) A SELECT statement that retrieves two columns from the Vendors and the Invoices tables sorted in ascending sequence by the invoice number 
SELECT invoice_number, vendor_name
    FROM vendors INNER JOIN invoices
        ON vendors.vendor_id = invoices.vendor_id
    ORDER BY invoice_number;

-- 03) A SELECT statement that retrieves four columns and a calculated column from each row, sorted in descending sequence by invoice_due_date. Column
and table aliases are also used 
SELECT invoice_number, vendor_name, invoice_due_date,
        invoice_total - payment_total - credit_total AS balance_due
    FROM vendors v JOIN invoices i
        ON v.vendor_id = i.vendor_id
    WHERE invoice_total - payment_total - credit_total > 0
    ORDER BY invoice_due_date DESC;

-- 04) A SELECT statement that retrieves three columns from the Invoices and Invoice_line_items tables with an alias from only one of the tables
SELECT invoice_number, line_item_amount, line_item_description
    FROM invoices 
        JOIN invoice_line_items line_items
        ON invoices.invoice_id = line_items.invoice_id
    WHERE account_number = 540
    ORDER BY invoice_date;

-- 05) A SELECT statement that retrieves rows by joining to tables in two different databases 
SELECT vendor_name, customer_last_name, customer_first_name,
        vendor_state AS state, vendor_city AS city
    FROM vendors v
        JOIN om.customers c
        ON v.vendor_zip_code = c.customer_zip
    ORDER BY state, city;

-- 06) A SELECT statement using an INNER JOIN with two conditions 
USE ex;

SELECT customer_first_name, customer_last_name
    FROM customers c 
        JOIN employees e 
        ON c.customer_first_name = e.first_name 
            AND c.customer_last_name = e.last_name;

-- 07) A self-join that returns vendors from cities in common with other vendors 
USE ap;

SELECT DISTINCT v1.vendor_name, v1.vendor_city, 
        v1.vendor_state
    FROM vendors v1 JOIN vendors v2
        ON v1.vendor_city = v2.vendor_city AND
            v1.vendor_state = v2.vendor_state AND
            v1.vendor_name <> v2.vendor_name
    ORDER BY v1.vendor_state, v1.vendor_city;

-- 08) A SELECT that joins four tables 
SELECT vendor_name, invoice_number, invoice_date,
    line_item_amount, account_description
    FROM vendors v
        JOIN invoices i 
            ON v.vendor_id = i.vendor_id
        JOIN invoice_line_items li 
            ON i.invoice_id = li.invoice_id
        JOIN general_ledger_accounts gl 
            ON li.account_number = gl.account_number
    WHERE invoice_total - payment_total - credit_total > 0
    ORDER BY vendor_name, line_item_amount DESC;

-- 09) A SELECT statement that joins the Vendors and Invoices tables in an implicit INNER JOIN [Used prior to SQL-92 standards. 
DO NOT use this in practice] 
SELECT *
    FROM vendors v, invoices i
    WHERE v.vendor_id = i.vendor_id
    ORDER BY invoice_number;

-- 10) A SELECT statement with an implicit INNER JOIN -- What happens if you forget the WHERE clause? 
SELECT *
    FROM vendors v, invoices i
    ORDER BY invoice_number;

-- 11) A SELECT statement with an implicit INNER JOIN that creates a Cartesian product 
SELECT invoice_number, vendor_name
    FROM vendors v, invoices i
    ORDER BY invoice_number;

-- 12) The same query constructed properly with an explicit INNER JOIN 
SELECT invoice_number, vendor_name
    FROM vendors v 
        JOIN invoices i
        USING(vendor_id)
    ORDER BY invoice_number;

-- 13) Another example of a Cartesian product because of an implicit INNER JOIN 
SELECT vendor_name, invoice_number, invoice_date,
        line_item_amount, account_description
    FROM  vendors v, invoices i, invoice_line_items li, 
        general_ledger_accounts gl
/*
    WHERE v.vendor_id = i.vendor_id
        AND i.invoice_id = li.invoice_id
        AND li.account_number = gl.account_number
        AND invoice_total - payment_total - credit_total > 0
*/
    ORDER BY vendor_name, line_item_amount DESC;

-- 14) SELECT joining the Vendors and Invoices tables using a left outer join
SELECT vendor_name, invoice_number, invoice_total
    FROM vendors LEFT JOIN invoices
        ON vendors.vendor_id = invoices.vendor_id
    ORDER BY vendor_name;

-- 15) Another left out join example 
USE ex;

SELECT department_name, d.department_number, last_name
    FROM departments d 
        LEFT JOIN employees e
            USING(department_number)
    ORDER BY department_name;

-- 16) SELECT joining the Departments and Employees tables using a right outer join 
SELECT department_name, e.department_number, last_name
    FROM departments d 
        RIGHT JOIN employees e
            USING(department_number)
    ORDER BY department_name;

-- 17) A SELECT statement that joins three tables using left outer joins 
SELECT department_name, last_name, project_number
    FROM departments d
        LEFT JOIN employees e
            USING(department_number)
        LEFT JOIN projects p
            USING(employee_id)
    ORDER BY department_name, last_name;

-- 18) A SELECT statement that combines an outer and an inner join 
SELECT department_name, last_name, project_number
    FROM departments d
        JOIN employees e
            USING(department_number)
        LEFT JOIN projects p
            USING(employee_id)
    ORDER BY department_name, last_name;

-- 19) A SELECT statement joins two tables with the USING keyword (What database should be active?)
SELECT invoice_number, vendor_name
    FROM vendors 
        JOIN invoices USING (vendor_id)
    ORDER BY invoice_number;

-- 20) A SELECT statement joins three tables with the USING keyword (What database should be active?)
SELECT department_name, last_name, project_number
    FROM departments
        JOIN employees USING (department_number)
        LEFT JOIN projects USING (employee_id)
    ORDER BY department_name;

-- 21) A SELECT statement joins two tables with the NATURAL keyword 
USE ap;

SELECT invoice_number, vendor_name
    FROM vendors 
        NATURAL JOIN invoices
    ORDER BY invoice_number;

-- 22) Using the NATURAL keyword in a statement that joins three tables  
USE ex;

SELECT department_name AS dept_name, 
        last_name, 
        project_number
    FROM departments
        NATURAL JOIN employees
        LEFT JOIN projects 
            USING (employee_id)
    ORDER BY department_name;

-- 23) Coding a CROSS JOIN using explicit syntax 
USE ex;

SELECT departments.department_number, 
        department_name, 
        employee_id, 
        last_name
    FROM departments CROSS JOIN employees
    ORDER BY departments.department_number;

-- 24) A SELECT statement that uses a UNION to combine result sets from two different tables 
USE ex;

SELECT 'Active' AS source, 
        invoice_number, 
        invoice_date, 
        invoice_total
    FROM active_invoices
UNION
    SELECT 'Paid' AS source, 
        invoice_number, 
        invoice_date, 
        invoice_total
    FROM paid_invoices
ORDER BY invoice_total DESC;

-- 25) A SELECT statement that uses a union to combine result sets from a single table 
USE ap;

SELECT 'Active' AS source, invoice_number, invoice_date, invoice_total
    FROM invoices
    WHERE invoice_total - payment_total - credit_total > 0
UNION
    SELECT 'Paid' AS source, invoice_number, invoice_date, invoice_total
    FROM invoices
    WHERE invoice_total - payment_total - credit_total <= 0
ORDER BY invoice_total DESC;

-- 26) A SELECT statement that uses a union to combine result sets from the same two tables 
SELECT invoice_number, vendor_name, '33% Payment' AS payment_type,
        invoice_total AS total, invoice_total * 0.333 AS payment
    FROM invoices JOIN vendors
        ON invoices.vendor_id = vendors.vendor_id
    WHERE invoice_total > 10000
UNION
    SELECT invoice_number, vendor_name, '50% Payment' AS payment_type,
        invoice_total AS total, invoice_total * 0.5 AS payment
    FROM invoices JOIN vendors
        ON invoices.vendor_id = vendors.vendor_id
    WHERE invoice_total BETWEEN 500 AND 10000
UNION
    SELECT invoice_number, vendor_name, 'Full amount' AS payment_type,
        invoice_total AS total, invoice_total AS payment
    FROM invoices JOIN vendors
        ON invoices.vendor_id = vendors.vendor_id
    WHERE invoice_total < 500
ORDER BY payment_type, vendor_name, invoice_number; 

-- 27) A union that simulates a full outer join 
USE ex;

SELECT department_name AS dept_name, d.department_number AS d_dept_no,
           e.department_number AS e_dept_no, last_name
    FROM departments d 
        LEFT JOIN employees e 
        ON d.department_number = e.department_number
UNION
    SELECT department_name AS dept_name, d.department_number AS d_dept_no,
           e.department_number AS e_dept_no, last_name
    FROM departments d 
        RIGHT JOIN employees e 
        ON d.department_number = e.department_number
ORDER BY dept_name;