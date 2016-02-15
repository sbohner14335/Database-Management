-- 1. Lists orno and dollars of all orders.
SELECT ordno, dollars 
FROM orders;

-- 2. Lists name and city of agents named 'Smith'.
SELECT name, city
FROM agents 
WHERE name='Smith';

-- 3. Lists pid, name, and priceUSD of products with quantity greater than 208,000.
SELECT pid, name, priceUSD
FROM products 
WHERE quantity>208000;

-- 4. Lists names and cities of customers in Dallas. 
SELECT name, city
FROM customers 
WHERE city='Dallas';

-- 5. Lists names of agents in New York and NOT in Tokyo. 
SELECT name
FROM agents 
WHERE city='New York' 
AND city!='Tokyo';

-- 6. Lists all data for products not in Dallas or Duluth that costs $1 or more. 
SELECT * FROM products 
WHERE priceUSD>=1 
AND city!= 'Dallas' 
AND city!='Duluth';

-- 7. Lists all data for orders in January or March. 
SELECT * 
FROM orders
WHERE mon='jan' 
OR mon='mar';

-- 8. Lists all data for orders in February that are less than $500. 
SELECT * 
FROM orders
WHERE mon='feb' 
AND dollars<500;

-- 9. Lists all orders from the customer whose cid is C005.
SELECT *
FROM orders
WHERE cid='c005';