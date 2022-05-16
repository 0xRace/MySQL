
USE ap;
SELECT vendor_name, vendor_state
-- Question 2
FROM vendors
WHERE vendor_state = 'CA'

-- query that filters not equal to 'CA'
UNION
SELECT vendor_name, 'Outside CA' AS vendor_state
FROM vendors
WHERE vendor_state != 'CA'
ORDER BY vendor_name;
 -- query that filters not equal to 'CA'
 
 -- Question 3 
 
 USE ex; 
 SELECT department_name, CONCAT(first_name, last_name) AS 'employee name'
 FROM departments
	 JOIN employees USING (department_number)
 ORDER BY department_name, last_name;

-- Question 4
USE ap;
SELECT vendor_name, invoice_date, invoice_number, CONCAT("# ", invoice_sequence) AS "inv sequence", line_item_amount AS li_amount 
FROM vendors
	JOIN invoices ON vendors.vendor_id = invoices.vendor_id
    JOIN invoice_line_items AS ili ON invoices.invoice_id = ili.invoice_id
WHERE vendor_name = "Wells Fargo Bank" ;

-- Question 5
USE ex;
SELECT department_number, department_name, employee_id
FROM departments
	LEFT JOIN employees USING (department_number)
WHERE employee_id IS NULL;

-- Question 6
USE ap; 
SELECT invoice_number, vendor_na e, line_items_description, line_item_amount
FROM vendors
	JOIN invoices USING (vendor_id)
    JOIN invoice_line_items USING (invoice_id)
ORDER BY invoice_number, vendor_name;
