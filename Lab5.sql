-- 1. Show the cities of agents booking an order for a customer whose cid is 'c002'. Use Joins.
SELECT city
FROM agents a
INNER JOIN orders o
ON o.aid = a.aid 
AND o.cid = 'c002';

-- 2. Show the ids of products (pid) ordered through any agent who makes at least one order
--    for a customer in 'Dallas' (c002 and c003), sorted by pid from highest to lowest. Use joins.
SELECT DISTINCT o.pid
FROM orders o
INNER JOIN agents a
ON o.aid = a.aid
INNER JOIN customers c
ON c.cid = o.cid
WHERE c.city = 'Dallas'
ORDER BY pid DESC;


SELECT cid
FROM customers
WHERE city = 'Dallas';


-- 3. Show the names of customers who have never placed an order. Use subquery.
SELECT c.name
FROM customers c
WHERE cid NOT IN (SELECT cid
		  FROM orders);

-- 4. Show the names of customers who have never placed an order. Outer join.
SELECT c.name
FROM customers c
LEFT JOIN orders o
ON c.cid = o.cid
WHERE o.ordno IS NULL;

-- 5. Show the names of customers who placed at least one order through an agent in their
--    own city, along with those agent's names.
SELECT DISTINCT c.name, a.name
FROM customers c
INNER JOIN orders o
ON o.cid = c.cid
INNER JOIN agents a
ON a.aid = o.aid
WHERE c.city = a.city;


-- 6. Show the names of customers and agents living in the same city, along with the name
--    of the shared city, regardless of whether or not the customer has ever placed an order
--    with that agent.
SELECT c.name, a.name, c.city
FROM customers c, agents a
WHERE c.city = a.city;

-- 7. Show the name and city of customers who live in the city that makes the fewest 
--    different kinds of products.
SELECT c.name, c.city
FROM customers c
WHERE c.city IN (SELECT city
		 FROM products
		 GROUP BY city
		 ORDER BY count(pid) ASC
		 LIMIT 1);