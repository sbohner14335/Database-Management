-- 1. Display the name and city of customers who live in any city that makes the most different
--    kinds of products. 
SELECT c.name , c.city 
FROM customers c
WHERE c.city IN (SELECT p.city
	       FROM products p
	       GROUP BY p.city
	       HAVING COUNT(city) IN ( (SELECT MAX (Num) 
					FROM (SELECT Count(p.city) AS Num 
					      FROM products p 
					      GROUP BY p.city) AS a ) ))
					      LIMIT 1);

-- 2. Display the names of products whose priceUSD is strctly above the avg(priceUSD) in reverse alphabetic order.
SELECT p.name
FROM products p
WHERE priceUSD > (SELECT AVG(priceUSD)
		  FROM products)
		  ORDER BY p.name DESC;

-- 3. Display the customer name, pid ordered, and the total for all orders, sorted by high to low.
SELECT c.name, o.pid, o.dollars
FROM customers c
INNER JOIN orders o ON o.cid = c.cid
ORDER BY o.dollars DESC;

-- 4. Display all customer names (in alphabetical order) and their total ordered,
--    and nothing more. Use coalesce to avoid showing nulls).
SELECT DISTINCT c.name, SUM(COALESCE(o.dollars, 0.00))
FROM customers c
LEFT JOIN orders o ON o.cid = c.cid
GROUP BY c.name
ORDER BY c.name ASC;

-- 5. Display the names of all customers who bought products from agents based in Tokyo along
--    with the names of the products they ordered, and the names of the agents who sold it to them.
SELECT c.name, p.name, a.name
FROM customers c
INNER JOIN orders o ON o.cid = c.cid
INNER JOIN agents a ON o.aid = a.aid
INNER JOIN products p ON o.pid = p.pid
WHERE a.city = 'Tokyo';

-- 6. Write a query to check the accuracy of the dollars column in the orders table. Calculate
--    orders.totalUSD from data in other tables and comparing those values to the values in
--    orders.dollars. Display all rows in orders where orders.totalUSD is incorrect, if any.
SELECT *
FROM (SELECT o.*, o.qty*p.priceUSD*(1-(discount/100)) AS truedollars
      FROM orders o
      INNER JOIN products p ON o.pid = p.pid
      INNER JOIN customers c ON o.cid = c.cid) AS tmptable
WHERE dollars != truedollars;

-- 7. What is the difference between a LEFT OUTER JOIN and a RIGHT OUTER JOIN?
--    Use the Cap2 database to write example queries.

--	**LEFT OUTER JOIN**	--
SELECT c.name, o.ordno
FROM customers c
LEFT OUTER JOIN orders o ON o.cid = c.cid;

-- This example of a LEFT OUTER JOIN takes the name of all customers in the customers table and joins it with ordno in the
-- orders table by cid. This outputs the name of every customer in the customers table, as well as the order number(s)
-- of that customer, if there is any ("Weyland-Yutani" has no ordno because this customer has never placed an order).

--	**RIGHT OUTER JOIN**	--
SELECT o.ordno, p.name
FROM orders o
RIGHT OUTER JOIN products p ON o.pid = p.pid;

-- This is an example of a RIGHT OUTER JOIN. This query takes all orders and joins them with the
-- products table via pid. This outputs the number of each order for every product, even if
-- the product has not been ordered yet (This is why the product clip has no ordno).

