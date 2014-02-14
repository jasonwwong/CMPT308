-- Jason Wong

-- 1.  Get the cities of agents booking an order for customer "Basics"
SELECT city
FROM agents
WHERE aid IN (
		SELECT aid
		FROM orders
		WHERE cid IN (
				SELECT cid
				FROM customers
				WHERE name = 'Basics'))
ORDER BY city ASC;

-- 2.  Get the pids of products ordered through any agent who makes at least one order for a customer in Kyoto
SELECT DISTINCT pid
FROM orders
WHERE aid IN (
		SELECT DISTINCT aid
		FROM orders
		WHERE cid IN (
				SELECT cid
				FROM customers
				WHERE city = 'Kyoto'))
ORDER BY pid ASC;

-- 3.  Find the cids and names of customers who never placed an order through agent a03.
SELECT name, cid
FROM customers
WHERE cid IN (
		SELECT DISTINCT cid
		FROM orders
		WHERE cid NOT IN (
				SELECT DISTINCT cid
				FROM orders
				WHERE aid = 'a03'))
ORDER BY cid ASC;

-- 4.  Get the cids and names of customers who ordered both p01 and p07.
SELECT name, cid
FROM customers
WHERE cid IN (
		SELECT DISTINCT cid
		FROM orders
		WHERE pid = 'p07' AND cid IN (
				SELECT DISTINCT cid
				FROM orders
				WHERE pid = 'p01'))
ORDER BY cid ASC;

-- 5.  Get the pids of products ordered by any customers who ever placed an order through agent a03.
SELECT DISTINCT pid
FROM orders
WHERE cid IN (
		SELECT DISTINCT cid
		FROM orders
		WHERE aid = 'a03')
ORDER BY pid ASC;

-- 6.  Get the names and discounts of all customers who place orders through agents in Dallas or Duluth.
SELECT name, discount
FROM customers
WHERE cid IN (
		SELECT distinct cid
		FROM orders
		WHERE aid IN (
				SELECT aid
				FROM agents
				WHERE city IN ('Dallas', 'Duluth')))
ORDER BY name ASC;

-- 7.  Find all customers who have the same discount as that of any customers in Dallas or Kyoto.
SELECT name
FROM customers
WHERE discount IN (
		SELECT distinct discount
		FROM customers
		WHERE city IN ('Dallas', 'Kyoto'))
ORDER BY name ASC;