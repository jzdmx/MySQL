-- day 4
-- inserting a row to a existing table
-- auto increment will assign values automatically

USE sql_store;
INSERT INTO customers (
	first_name,
    last_name,
    birth_date,
    address,
    city,
    state)
VALUES(
	'John',
    'Smith',
    '1990-01-01',
    'address',
    'city',
    'CA') ;
    
-- inserting multiple rows in one go
INSERT INTO shippers(name)
VALUES ('shipper1'),
		('shipper2'),
        ('shipeer3');
        
-- exercise
-- insert 3 rows in the products table
INSERT INTO products (
		name,
        quantity_in_stock,
        unit_price)
VALUES('Jin','20','10'),
		('Xiaoyu','50','9'),
        ('Mary','455','8');

-- inserting hierarchical rows

-- update a single row 
UPDATE invoices
SET payment_total = DEFAULT,
	payment_date = NULL
WHERE invoice_id = 3;

-- updating multiple rows
UPDATE invoices
SET payment_total = invoice_total*0.5,
	payment_date = due_date
WHERE client_id = 3

-- creating a copy of a table
-- CREATE TABLE order_archived AS
INSERT INTO order_archived
SELECT*
FROM orders
WHERE order_date < '2019-01-01';

-- exercise
USE sql_invoicing;
CREATE TABLE invoices_aichived AS 
SELECT 
	i.invoice_id,
    i.number,
    c.name AS client,
    i.invoice_total,
    i.payment_total,
    i.invoice_date,
    i.payment_date,
    i.due_date
FROM invoices i
JOIN clients c
	USING (client_id)
WHERE payment_date IS NOT NULL;

-- updating multiple rows
USE sql_invoicing;
UPDATE invoices
SET payment_total = invoice_total*0.5,
	payment_date = due_date
WHERE client_id IN (3,4);

-- exercise
USE sql_store;
UPDATE customers
SET 
	points = points + 50
WHERE 
	birth_date < '1990-01-01';

-- subqueries in updates
USE sql_invoicing;
UPDATE invoices
SET payment_total = invoice_total*0.5,
	payment_date = due_date
WHERE client_id IN  
		(SELECT client_id 
        FROM clients
		WHERE state IN ('CA','NY'));

-- exercise
USE sql_store;
UPDATE orders
SET comments = 'gold customer'
WHERE customer_id IN
				(SELECT customer_id
				FROM customers
				WHERE points > 3000);

-- deleting rows
USE sql_invoicing;

DELETE FROM invoices
WHERE client_id = (
					SELECT client_id
					FROM clients
					WHERE name = 'Myworks')

