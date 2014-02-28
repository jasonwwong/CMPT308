-- Jason Wong

-- 1.  Get the name and city of customers who live in a city where the most number of products are made
SELECT name, city
FROM customers
WHERE city IN(
		SELECT city
		FROM products
		GROUP BY city
		ORDER BY sum(quantity) DESC
		LIMIT 1)
ORDER BY name ASC;

-- 2.  Get the name and city of customers who live in any city where the most number of products are made
SELECT name, city
FROM customers
WHERE city IN(
		SELECT city
		FROM products
		GROUP BY city
		HAVING sum(quantity) = (
				SELECT sum(quantity)
				FROM products
				GROUP BY city
				ORDER BY sum(quantity) DESC
				LIMIT 1))
ORDER BY name ASC;

-- 3.  List the products whose priceUSD is above the average priceUSD
SELECT name
FROM products
WHERE priceUSD > (
		SELECT avg(priceUSD)
		FROM products)

-- 4.  Show the customer name, pid ordered, and dollars for all customer orders, sorted by dollars from high to low
SELECT customers.name, orders.pid, orders.dollars
FROM orders LEFT OUTER JOIN customers on (orders.cid = customers.cid)
ORDER BY dollars DESC;

-- 5.  Show all customer names (in order) and their total ordered
SELECT name, sum(dollars) AS total
FROM orders LEFT OUTER JOIN customers on (orders.cid = customers.cid)
GROUP BY name
ORDER BY name ASC;

-- 6.  Show the names of all customers who bought products from agents based in New York along with the names of the products they ordered, and the names of the agents who sold it to them
SELECT customers.name AS customer, products.name AS product, agents.name AS agent
FROM orders LEFT OUTER JOIN agents on (orders.aid = agents.aid) LEFT OUTER JOIN customers on (orders.cid = customers.cid) LEFT OUTER JOIN products on (orders.pid = products.pid)
WHERE agents.city = 'New York'
ORDER BY customer ASC;

-- 7.  Write a query to check the accuracy of the dollars column in the Orders table
SELECT ordno, qty * priceUSD * ((100 - discount) / 100) = dollars AS accurate
FROM orders LEFT OUTER JOIN products on (orders.pid = products.pid) LEFT OUTER JOIN customers on (orders.cid = customers.cid)
