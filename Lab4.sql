-- Stephen Bohner	Lab 4
-- 1. Gets cities of agents booking an order for a customer whose cid is 'c002'.
SELECT city
FROM agents
WHERE aid IN (SELECT aid
	      FROM orders
	      WHERE cid = 'c002');

-- 2. Get the ids of products (pid) through any agent who takes at least one order
--    from a customer in Dallas, sorted by pid from highest to lowest.
SELECT pid
FROM products
WHERE pid IN (SELECT pid
	      FROM orders
	      WHERE aid IN (SELECT aid
			    FROM orders
			    WHERE cid IN (SELECT cid
					  FROM customers
					  WHERE city = 'Dallas')))
					  ORDER BY pid DESC;

-- 3. Get the ids and names of customers who did not place an order through agent a01. 
SELECT cid, name
FROM customers
WHERE cid IN (SELECT cid
	      FROM orders
	      WHERE aid != 'a01');

-- 4. Get the ids of customers who ordered both product p01 and p07.
SELECT cid
FROM customers
WHERE cid IN (SELECT cid
	      FROM orders
	      WHERE pid IN (SELECT pid
			    FROM products
			    WHERE pid IN ('p07', 'p01')));


-- 5. Get the ids of products not ordered by any customers who placed an order with 
--    agent a07 in pid from highest to lowest.
SELECT pid
FROM products
WHERE pid IN (SELECT pid
	      FROM orders
	      WHERE cid IN (SELECT cid
			    FROM orders
			    WHERE aid != 'a07'))
			    ORDER BY pid DESC;

-- 6. Get the name, discounts, and city for all customers who place orders through
--    agents in London or New York.
SELECT name, discount, city
FROM customers
WHERE cid IN (SELECT cid
	      FROM orders
	      WHERE aid IN (SELECT aid
			    FROM agents
			    WHERE city = 'London'
			    OR city = 'New York'));

-- 7. Get all customers who have the same discount as that of any customers in Dallas or London.
SELECT name
FROM customers
WHERE discount IN (SELECT discount
		   FROM customers
		   WHERE city = 'Dallas'
		   OR city = 'London');

-- 8. Check constraints is used in SQL when an entry must be specified. A good example of 
-- this would be checking if the user selected 'Male' or 'Female' on a drop down list.
-- Putting a constraint in your database will not allow data that is not wanted into your database.
-- Another example of a check constraint would be to check the year of a student, or a housing area.
-- A bad check constraint would be a name. This would be a bad constraint because it
-- would be very difficult to only allow certain names to be entered. If there is no check
-- constraint for the name 'Joe' then the user will not be able to submit that data into
-- your database. Contraints should only be used for set selections. Certain aspects 
-- of data entry that only had a few valid selections is ideal for check constraints.



SELECT * FROM orders;

SELECT * FROM agents;

SELECT * FROM customers;

SELECT * FROM products;