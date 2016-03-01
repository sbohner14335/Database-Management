-- 1. Display the name and city of customers who live in any city that makes the most different
--    kinds of products. **
SELECT c.name, c.city
FROM customers c
WHERE cid IN (SELECT cid
	      FROM orders
	      WHERE pid IN (SELECT pid
			    FROM products
			    GROUP BY count(city)));

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

SELECT aid
FROM agents
WHERE city = 'Tokyo';