SELECT * FROM customers;

SELECT city, COUNT(*) 
FROM customers
GROUP BY city;

SELECT * 
FROM orders
WHERE total_sales > 500;
