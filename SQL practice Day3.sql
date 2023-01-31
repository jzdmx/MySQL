-- day 3
SELECT order_id, o.customer_id, first_name, last_name
FROM orders o
JOIN customers c
	ON o.customer_id = c.customer_id;
    
SELECT order_id, oi.product_id, quantity, unit_price
FROM order_items oi
JOIN products p
	ON oi.product_id = p.product_id；

-- USE sql_hr;
-- self join
SELECT 
	e.employee_id,
    e.first_name,
    e.last_name AS manager
FROM employees e
JOIN employees m
	ON e.reports_to = m.employee_id;

-- joining multiple tables
-- USE sql_store;
SELECT 
	o.order_id, 
    o.order_date,
    c.first_name,
    c.last_name,
    os.name AS status
FROM orders o
JOIN customers c
	ON o.customer_id = c.customer_id
JOIN order_statuses os
	ON o.status = os.order_status_id;


-- excercise
USE sql_invoicing;

SELECT 
	p.date,
    p.invoice_id,
    p.amount,
    c.name,
    pm.name AS payment_name

FROM payments p
JOIN clients c
	ON p.client_id = c.client_id
JOIN payment_methods pm
	ON p.payment_method = pm.payment_method_id

-- compound join condition
USE sql_store; 

SELECT *
FROM order_items oi
JOIN order_item_notes oin
	ON oi.order_id = oin.order_id
    AND oi.product_id = oin.product_id;

USE sql_store;
-- inner joint
-- outer joint
-- left joint mainly based on FROM xx table
-- right joint mainly based on JOIN xx table
SELECT 
	c.customer_id,
    c.first_name,
    o.order_id
FROM customers c
RIGHT JOIN orders o
	ON c.customer_id = o.customer_id
ORDER BY c.customer_id;

SELECT 
	p.product_id,
    p.name,
    oi.quantity
FROM products p
LEFT JOIN order_items oi
	ON p.product_id = oi.product_id
ORDER BY p.product_id;

-- outer joint between multiple tables
-- do not use right joint when joining multiple tables
SELECT 
	c.customer_id,
    c.first_name,
    o.order_id,
    sh.name AS shipper
FROM customers c
LEFT JOIN orders o
	ON c.customer_id = o.customer_id
LEFT JOIN shippers sh
	ON o.shipper_id = sh.shipper_id
ORDER BY c.customer_id;

-- excerciese
SELECT 
	o.order_date,
    o.order_id,
    c.first_name AS customer,
    sh.name AS shipper,
    os.name AS status
FROM orders o
JOIN customers c
	ON o.customer_id = c.customer_id
LEFT JOIN shippers sh
	ON o.shipper_id = sh.shipper_id
LEFT JOIN order_statuses os
	ON o.status = os.order_status_id
ORDER BY status;

-- self outer joint
USE sql_hr;
SELECT 
	e.employee_id,
    e.first_name,
    m.first_name AS manager
    
FROM employees e
LEFT JOIN employees m
	ON e.reports_to = m.employee_id

-- The Using Clause
USE sql_store;
SELECT 
	o.order_date,
    c.first_name,
    sh.name AS shipper
FROM orders o
JOIN customers c
	-- ON o.customer_id = c.customer_id
    -- a simplified way for same name in different tables
    USING(customer_id)
LEFT JOIN shippers sh
	USING(shipper_id);

-- a simplified way for different name in different tables
SELECT *
FROM order_items oi
JOIN order_item_notes oin
	USING(order_id, product_id);

-- excerise
USE sql_invoicing;
SELECT 
	p.date,
    c.name AS client,
    p.amount,
    pm.name AS payment_method   
FROM payments p
JOIN clients c USING(client_id)
JOIN payment_methods pm
	ON p.payment_method = pm.payment_method_id;


-- cross joint
-- for small tables/ color tables
USE sql_store;
SELECT 
	c.first_name AS customer,
    p.name AS product
FROM customers c
CROSS JOIN products p 
ORDER BY c.first_name;

-- implicit cross joint
SELECT 
	s.name AS shipper,
    p.name AS product
FROM shippers s, products p
ORDER BY p.product_id;

-- explicit cross joint
SELECT 
	s.name AS name,
    p.name AS product
FROM shippers s
CROSS JOIN products p;

-- unions
SELECT 
	order_id,
    order_date,
    'Active' AS status
FROM orders
WHERE order_date >='2019-01-01'
UNION
SELECT 
	order_id,
    order_date,
    'Achived' AS status
FROM orders
WHERE order_date < '2019-01-01';

-- excerise
SELECT 
	c.customer_id,
    c.first_name,
    c.points,
    'Bronze' AS type
FROM customers c
WHERE c.points < '2000' 
UNION
SELECT 
	c.customer_id,
    c.first_name,
    c.points,
    'Silver' AS type
FROM customers c
WHERE c.points >='2000' AND c.points<'3000'
UNION
SELECT 
	c.customer_id,
    c.first_name,
    c.points,
    'Gold' AS type
FROM customers c
WHERE c.points >= '3000'
ORDER BY first_name;