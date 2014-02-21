-- Jason Wong

-- 1.  Get the cities from agents booking an order for customer "Basics" using joins
SELECT agents.city
FROM agents, orders, customers
WHERE customers.name = 'Basics'
AND orders.cid = customers.cid
AND agents.aid = orders.aid
ORDER BY city ASC;

-- 2.  Get the pids of product ordered through any agents who makes at least one order for a customer in Kyoto using joins
SELECT DISTINCT o2.pid
FROM orders o1, orders o2, customers, agents
WHERE customers.city = 'Kyoto'
AND o1.cid = customers.cid
AND agents.aid = o1.aid
AND o2.aid = agents.aid
ORDER BY o2.pid ASC;

-- 3.  Get the names of customers who have never placed an order using a subquery
SELECT DISTINCT name
FROM customers
WHERE cid NOT IN(
		SELECT distinct cid
		FROM orders)
ORDER BY name ASC;

-- 4.  Get the names of customers who have never placed an order using an outer join
SELECT DISTINCT customers.name
FROM customers LEFT OUTER JOIN orders ON (customers.cid = orders.cid)
WHERE orders.cid IS NULL
ORDER BY name ASC;

-- 5.  Get the names of customers who placed at least one order through an agent in their city, along with those agents' names
SELECT DISTINCT customers.name as "Customer", agents.name as "Agent"
FROM orders, customers LEFT OUTER JOIN agents ON (customers.city = agents.city)
WHERE agents.city IS NOT NULL
AND orders.cid = customers.cid
AND orders.aid = agents.aid;

-- 6.  Get the names of customers and agents in the same city, along with the name of the city, regardless of whether or not the customer has ever placed an order with that agent
SELECT DISTINCT customers.name AS "Customer", agents.name AS "Agent", customers.city
FROM customers LEFT OUTER JOIN agents ON (customers.city = agents.city)
WHERE agents.city IS NOT NULL
ORDER BY customers.name ASC;

-- 7.  Get the name and city of customers who live in the city where the least number of products are made
SELECT name, city
FROM customers
WHERE city IN(
		SELECT city
		FROM products
		GROUP BY city
		ORDER BY count(*) ASC
		LIMIT 1)
ORDER BY name ASC;