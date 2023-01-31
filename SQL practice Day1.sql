-- Day 1
USE sql_store;
SELECT 
	first_name,
    last_name,
    points,
    (points+10)*100 AS 'discount factor'
FROM customers;
-- WHERE customer_id=1
-- ORDER BY first_name

SELECT 
	name,
    unit_price,
    unit_price*1.1 AS 'new price'
FROM products;

SELECT *
FROM customers
WHERE NOT (birth_date > '1990-01-01' OR points > 1000 );

SELECT *
FROM order_items
WHERE order_id = 6 AND unit_price * quantity > 30;









    

    
    





































