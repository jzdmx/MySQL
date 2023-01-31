
-- Day 2
SELECT *
FROM Customers
-- WHERE state = 'VA' OR state = 'GA' OR state = 'FL' 
WHERE state NOT IN ('VA','FL','GA');

SELECT *
FROM products
-- WHERE quantity_in_stock = 49 OR quantity_in_stock = 38 OR quantity_in_stock = 72
WHERE quantity_in_stock IN (49,38,72);

SELECT *
FROM customers
WHERE points BETWEEN 1000 AND 3000;

SELECT *
FROM customers
WHERE birth_date BETWEEN '1990-01-01' AND '2000-01-01';

SELECT *
FROM customers
-- b as beginning 
-- % any number of characters
-- WHERE last_name LIKE 'b%' 

-- as long as has b in last name
-- WHERE last_name LIKE '%b%' 

-- b as ending
-- WHERE last_name LIKE '%y' 

-- underscore for single character
WHERE last_name LIKE 'b____y' ;

SELECT *
FROM customers
WHERE address LIKE '%trail%' OR 
address LIKE '%avenue%';

SELECT *
FROM customers
WHERE phone LIKE '%9';

SELECT *
FROM customers
-- ^ represent the beginning of the string
-- WHERE last_name REGEXP '^field'

-- $ represent the end of the string
-- WHERE last_name REGEXP 'field$'

-- | multiple search pattern
-- WHERE last_name REGEXP 'field$|mac|rose'

-- [] for combine searching
-- WHERE last_name REGEXP '[gim]e'
-- WHERE last_name REGEXP 'e[fmq]'

-- [-] represent a range
-- WHERE last_name REGEXP '[a-h]e'
WHERE last_name REGEXP 'e[a-h]';

SELECT *
FROM customers
-- WHERE first_name REGEXP 'elka|ambur'
-- WHERE last_name REGEXP 'ey$|on$'
-- WHERE last_name REGEXP '^my|se' 
WHERE last_name REGEXP 'b[ru]';

-- missing value
SELECT *
-- FROM customers
-- WHERE phone IS NOT NULL;
FROM orders
WHERE shipped_date IS NULL;

SELECT first_name, last_name, 10 AS points
FROM customers
ORDER BY points, first_name;

SELECT *, quantity*unit_price AS total_price
FROM order_items
WHERE order_id = 2
ORDER BY total_price DESC;

SELECT *
FROM customers
LIMIT 6,3;
-- page 1: 1-3
-- page 2: 4-6
-- page 3: 7-9

SELECT *
FROM customers
ORDER BY points DESC
LIMIT 3;