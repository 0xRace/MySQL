-- Lab 5
-- cte syntax is with __  AS (SELECT statement)
-- Question 1 using joins
USE ap;
SELECT vendor_name, vendor_contact_first_name, vendor_state
FROM vendors
	JOIN invoices USING (vendor_id)
    JOIN invoice_line_items USING (invoice_id)
WHERE line_item_amount < 100;
-- alternative with a subquery
SELECT vendor_name, vendor_contact_first_name, vendor_state
FROM vendors
WHERE vendor_id IN (
	SELECT vendor_id
    FROM invoices
    JOIN invoice_line_items USING (invoice_id)
    WHERE line_item_amount < 100
);

-- Question 3
USE ap;
WITH vendors_line_items AS(
	SELECT vendor_id
    FROM invoices
    JOIN invoice_line_items USING (invoice_id)
    WHERE line_item_amount < 100
)
SELECT vendor_name, vendor_contact_first_name, vendor_state
FROM vendors
JOIN vendors_line_items USING (vendor_id);

-- Question 4
USE ap;
SELECT vendor_name AS "Vendor Name", CONCAT("$",FORMAT(invoice_number,2)) AS "Invoice Number",
CAST(invoice_date AS datetime) AS "Invoice Date/Time", invoice_total AS "Invoice Total"
FROM vendors v
JOIN invoices i
USING(vendor_id)
WHERE invoice_date = (
	SELECT MAX(invoice_date)
    FROM invoices
    WHERE invoice_total < 100 AND vendor_id = i.vendor_id
);

-- Question 5
/* Write a SELECT statement that returns these columns from an INNER JOIN of the vendors and invoices tables of the ap database;
- vendor_name in all uppercase as 'Vendor Name'
- vendor_contact_first_name in all lowercase as “Contact Person”
- vendor_phone [with parts of the number separated by -, ex. 555-555-5555] as 'Vendor Phone'
- the most recent invoice_date for each vendor [using the DATE_FORMAT to return the date in the following format, ex. 2018, March 2 ] as 'Latest Invoice'
This should return 34 rows. Sort on invoice_date
*/
USE ap;
SELECT UPPER(vendor_name) AS "Vendor Name", LOWER(vendor_contact_first_name) AS "Contact Person",
 REPLACE((REPLACE(vendor_phone,") ","-")),"(","") AS "Vendor Phone", DATE_FORMAT(invoice_due_date, '%Y, %M %e' ) AS  "Latest Invoice"
 FROM vendors v
 INNER JOIN invoices 
 WHERE v.vendor_id = invoices.vendor_id and invoice_due_date = (
 SELECT MAX(invoice_due_date)
 FROM (
	SELECT vendor_id, invoice_due_date
	FROM invoices
    WHERE v.vendor_id = invoices.vendor_id
 ) t
 )
 ORDER BY invoice_due_date;
