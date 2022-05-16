-- Lab 4 Quiz
USE ap;
SELECT vendor_name, COUNT(invoices.vendor_id) AS "invoice_count", CONCAT("$ ",FORMAT(SUM(invoices.invoice_total), 2)) AS "invoice_total_sum",
	CONCAT("$ ",ROUND( AVG(invoices.invoice_total), 2) )AS "invoice_average"
FROM vendors JOIN invoices USING (vendor_id)
GROUP BY vendor_name
ORDER BY invoice_count DESC;

-- Question 3
SELECT DISTINCT vendor_name
FROM vendors
WHERE vendor_id IN (
		SELECT vendor_id FROM invoices
)
ORDER BY vendor_name;

-- Question 4 
USE ap;
SELECT invoice_number, invoice_total
FROM invoices
WHERE payment_total > (
SELECT AVG(invoice_total)
FROM invoices 
WHERE invoice_total > 0 
)
ORDER BY invoice_total DESC;

-- Question 5 
USE ap; 
WITH maximum_vals AS(
SELECT vendor_id, MAX(invoice_total) AS "max_invoice"
FROM invoices
WHERE invoice_total - credit_total - payment_total > 0 
GROUP BY vendor_id
)
SELECT SUM(max_invoice) as "sum_invoice"
FROM maximum_vals;