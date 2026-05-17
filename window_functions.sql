SELECT employee_id,
salary,
DENSE_RANK() OVER(ORDER BY salary DESC) AS salary_rank
FROM employees;

SELECT customer_id,
order_date,
ROW_NUMBER() OVER(PARTITION BY customer_id ORDER BY order_date) AS row_num
FROM orders;
