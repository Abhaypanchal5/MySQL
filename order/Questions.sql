-- Write SQL to show: Customer name and their total spending
SELECT c.name, sum(o.total_amount) as Total_spent from customers c join orders o on c.customer_id = o.customer_id GROUP BY c.name 

-- Using same tables: Find the TOP spending customer name and amount
SELECT customers.name,sum(orders.total_amount) as total_spent 
FROM customers JOIN orders on customers.customer_id = orders.customer_id 
GROUP BY customers.customer_id ORDER BY total_spent desc LIMIT 1

-- Find the second highest spending customer: No LIMIT trick only.Try using subquery or ranking logic.

SELECT name, total_spent
FROM (
    SELECT 
        c.name,
        SUM(o.total_amount) AS total_spent
    FROM customers c
    JOIN orders o
      ON c.customer_id = o.customer_id
    GROUP BY c.customer_id, c.name
) t
WHERE total_spent = (
    SELECT MAX(total_spent)
    FROM (
        SELECT SUM(o.total_amount) AS total_spent
        FROM customers c
        JOIN orders o
          ON c.customer_id = o.customer_id
        GROUP BY c.customer_id
    ) x
    WHERE total_spent < (
        SELECT MAX(total_spent)
        FROM (
            SELECT SUM(o.total_amount) AS total_spent
            FROM customers c
            JOIN orders o
              ON c.customer_id = o.customer_id
            GROUP BY c.customer_id
        ) y
    )
);