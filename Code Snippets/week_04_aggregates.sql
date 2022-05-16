SELECT COUNT(*) AS number_of_invoices,
    SUM(invoice_total - payment_total - credit_total) AS total_due
FROM invoices
WHERE invoice_total - payment_total - credit_total > 0; 


SELECT COUNT(vendor_id) AS number_of_vendors
  FROM invoices;


SELECT 'After 1/1/2014' AS selection_date, 
    COUNT(*) AS number_of_invoices,
    ROUND(AVG(invoice_total), 2) AS avg_invoice_amt,
    SUM(invoice_total) AS total_invoice_amt,
    MAX(invoice_total) AS highest_invoice_total,
    MIN(invoice_total) AS lowest_invoice_total
FROM invoices
WHERE invoice_date > '2014-01-01';


SELECT MIN(vendor_name) AS first_vendor,
   MAX(vendor_name) AS last_vendor,
   COUNT(vendor_name) AS number_of_vendors
FROM vendors;


SELECT vendor_id
-- SUM(invoice_total) AS vendor_invoice_total
	FROM invoices;

    
SELECT vendor_id, invoice_total
  FROM invoices
  WHERE vendor_id = 122;
  
  
SELECT vendor_id, SUM(invoice_total) AS vendor_invoice_total
	FROM invoices
    -- WHERE invoice_total > 7000
    GROUP BY vendor_id
    HAVING vendor_invoice_total > 7000
    ORDER BY vendor_invoice_total DESC;  
    
    
SELECT vendor_name, SUM(invoice_total) AS vendor_invoice_total
	FROM invoices JOIN vendors USING(vendor_id)
    GROUP BY vendor_id
    HAVING vendor_invoice_total > 7000
    ORDER BY vendor_invoice_total DESC;      
    
    
SELECT vendor_name, SUM(invoice_total) AS vendor_total
  FROM invoices JOIN vendors USING(vendor_id)
  WHERE vendor_state != 'CA'
  GROUP BY vendor_id
  HAVING vendor_total > 5000
  ORDER BY vendor_total DESC;
  
SELECT vendor_name, invoice_total
 FROM invoices JOIN vendors USING(vendor_id)
 WHERE vendor_name = "Zylka Design";    