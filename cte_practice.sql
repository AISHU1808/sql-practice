WITH high_sales AS (
    SELECT customer_id, total_sales
    FROM orders
    WHERE total_sales > 1000
)

SELECT *
FROM high_sales;
