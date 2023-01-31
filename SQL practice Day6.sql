-- Day 6 
	-- writing complex queries
	-- Subqueries
SELECT *
FROM products
WHERE unit_price > (
	SELECT unit_price
    FROM products
    WHERE product_id = 3
);
-- exercise
USE sql_hr;
SELECT *
FROM employees
WHERE salary >= (
	SELECT
    AVG(salary)
    FROM employees
);
    

-- IN
-- find the product that have never been ordered
USE sql_store;
SELECT *
FROM products
WHERE product_id NOT IN(
	SELECT DISTINCT product_id
    FROM order_items);
-- exercise
-- Find client without invoices
USE sql_invoicing;
SELECT *
FROM clients
WHERE client_id NOT IN(
	SELECT DISTINCT client_id
	FROM invoices);


-- join
-- Find client without invoices
SELECT *
FROM clients
LEFT JOIN invoices USING (client_id)
WHERE invoice_id IS NULL;

-- exercise
-- find customers who have orderd lettuce
-- select customer_id, first_name, last_name
USE sql_store;
SELECT 
	DISTINCT customer_id,
    c.first_name,
    c.last_name
FROM customers c 
JOIN orders o USING (customer_id)
JOIN order_items oi USING (order_id)
WHERE product_id = 3;

SELECT 	
	customer_id,
    first_name,
    last_name
FROM customers
WHERE customer_id IN (
	SELECT o.customer_id
    FROM order_items oi
    JOIN orders o USING (order_id)
    WHERE product_id = 3);
    
-- all
-- select invoices larger than all invoices of client 3
USE sql_invoicing;
SELECT *
FROM invoices
WHERE invoice_total > (
	SELECT MAX(invoice_total)
	FROM invoices
	WHERE client_id =3
);

SELECT *
FROM invoices
WHERE invoice_total > ALL (
	SELECT invoice_total
	FROM invoices
	WHERE client_id = 3
);

-- ANY
-- SOME
-- ANY = IN
SELECT *
FROM invoices
WHERE invoice_total > ANY (
	SELECT invoice_total
	FROM invoices
	WHERE client_id = 3
);


SELECT *
FROM invoices
WHERE invoice_total > SOME (
	SELECT invoice_total
	FROM invoices
	WHERE client_id = 3
);

-- select clients with at least two invoices
SELECT *
FROM clients
WHERE client_id = ANY (
	SELECT client_id
	FROM invoices
	GROUP BY client_id
	HAVING COUNT(*) >= 2)

-- correlate queries
-- select employees whose salary is above the average in their office
USE sql_hr;
SELECT *
FROM employees e
WHERE salary > (
	SELECT AVG(salary) 
    FROM employees
    WHERE office_id = e.office_id);
-- exercise
-- get invoices that are larger than the client's average invoice amount
USE sql_invoicing;
SELECT *
FROM invoices i
WHERE invoice_total > (
	SELECT AVG(invoice_total)
    FROM invoices
    WHERE client_id = i.client_id);



-- exists
-- select clients that have an invoice
SELECT * FROM clients
WHERE client_id IN(
	SELECT DISTINCT client_id
    FROM invoices
);

SELECT *
FROM clients 
JOIN invoices
USING (client_id);

SELECT *
FROM clients c
WHERE EXISTS (
	SELECT client_id
    FROM invoices
    WHERE client_id = c.client_id);

-- find the products that have never been ordered
USE sql_store;
SELECT * FROM products p
WHERE NOT EXISTS (
	SELECT product_id
    FROM order_items
    WHERE product_id = p.product_id);
-- or
SELECT * FROM products p
WHERE product_id NOT IN (
	SELECT product_id
    from order_items)

-- subqueries in select cluase
SELECT 
	invoice_id,
	invoice_total,
    (SELECT AVG(invoice_total) FROM invoices) AS invoice_avg,
    invoice_total - (SELECT invoice_avg) AS difference
FROM invoices;
-- exercise
SELECT 
	client_id,
    name,
    (SELECT SUM(invoice_total) FROM invoices WHERE client_id = c.client_id) AS total_sales,
    (SELECT AVG(invoice_total) FROM invoices) AS average,
    (SELECT total_sales - average) AS difference
FROM clients c;


-- subqueries in the FROM clause only for simple queries
SELECT * 
FROM (
	SELECT 
		client_id,
		name,
		(SELECT SUM(invoice_total) FROM invoices WHERE client_id = c.client_id) AS total_sales,
		(SELECT AVG(invoice_total) FROM invoices) AS average,
		(SELECT total_sales - average) AS difference
	FROM clients c
) AS sales_summary
WHERE total_sales IS NOT NULL































    
    
