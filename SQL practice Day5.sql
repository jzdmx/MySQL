-- Day 5 Aggreagate
USE sql_invoicing;
SELECT
	MAX(invoice_total) AS highest,
    MIN(invoice_total) AS lowest,
    AVG(invoice_total) AS average,
    SUM(invoice_total*1.5) AS tital,
    COUNT(invoice_total) AS number_of_invoices,
--   COUNT(payment_date) AS count_of_payments
-- COUNT for NON NULL values
	COUNT(*) AS total_record
FROM invoices
WHERE invoice_date > '2019-07-01';


-- exercise
SELECT
	'first half of 2019' AS date_range,
	SUM(invoice_total) AS total_sales,
    SUM(payment_total) AS total_payments,
	SUM(invoice_total - payment_total) AS what_we_expect
FROM invoices
WHERE invoice_date BETWEEN '2019-01-01' AND '2019-06-30'
UNION
SELECT
	'second half of 2019' AS date_range,
	SUM(invoice_total) AS total_sales,
    SUM(payment_total) AS total_payments,
	SUM(invoice_total - payment_total) AS what_we_expect
FROM invoices
WHERE invoice_date BETWEEN '2019-07-01' AND '2019-12-31'
UNION
SELECT
	'total 2019' AS date_range,
	SUM(invoice_total) AS total_sales,
    SUM(payment_total) AS total_payments,
	SUM(invoice_total - payment_total) AS what_we_expect
FROM invoices
WHERE invoice_date BETWEEN '2019-01-01' AND '2019-12-31';

    
-- group by
-- always after FROM and WHERE, before ORDER BY
SELECT
	state,
    city,
	SUM(invoice_total) AS total_sales
FROM invoices i
JOIN clients USING(client_id)
WHERE invoice_date >= '2019-07-01'
GROUP BY state,city;
-- exercise
SELECT
	date,
    pm.name AS payment_method,
	SUM(amount) AS total_payments
FROM payments p
JOIN payment_methods pm 
	ON p.payment_method = pm.payment_method_id
GROUP BY date, payment_method
ORDER BY date ASC;


-- HAVING clause
-- WHERE before GROUP BY
-- HAVING after GROUP BY
SELECT
	client_id,
    SUM(invoice_total) AS total_sales,
	COUNT(*) AS number_of_invoices
FROM invoices
GROUP BY client_id
HAVING total_sales > 500 AND number_of_invoices;
-- exercise
USE sql_store;

SELECT 
	c.customer_id,
    c.first_name,
    c.last_name,
    SUM(oi.quantity * oi.unit_price) AS total_sales
FROM customers c
JOIN orders o USING (customer_id)
JOIN order_items oi USING(order_id)
WHERE state = 'VA'
GROUP BY c.customer_id, c.first_name, c.last_name
HAVING total_sales > 100;


-- Rollup
-- add colums
USE sql_invoicing;
SELECT
	state,
    city,
	SUM(invoice_total) AS total_sales
FROM invoices i
JOIN clients c USING (client_id)
GROUP BY state, city WITH ROLLUP;
-- exercise
SELECT 
    pm.name AS payment_method,
	SUM(amount) AS total
FROM payments p
JOIN payment_methods pm ON p.payment_method = pm.payment_method_id
GROUP BY pm.name WITH ROLLUP;
    
    
    
    
