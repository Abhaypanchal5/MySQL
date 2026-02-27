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

select name,total_spent from(
    SELECT 
        c.name,
        SUM(o.total_amount) AS total_spent,
        DENSE_RANK() OVER (ORDER BY SUM(o.total_amount) DESC) AS rnk
    FROM customers c
    JOIN orders o
      ON c.customer_id = o.customer_id
    GROUP BY c.customer_id, c.name) as ranked
where rnk = 2

-- Find customers whose spending is ABOVE average spending of all customers.
SELECT name, total_spent
FROM (
    SELECT 
        c.name,
        SUM(o.total_amount) AS total_spent
    FROM customers c
    JOIN orders o
      ON c.customer_id = o.customer_id
    GROUP BY c.customer_id, c.name
) AS total_spending_per_customer
WHERE total_spent > (
    SELECT AVG(total_spent)
    FROM (
        SELECT SUM(o.total_amount) AS total_spent
        FROM customers c
        JOIN orders o
          ON c.customer_id = o.customer_id
        GROUP BY c.customer_id
    ) AS avg_table
);

-- Write SQL to get Top 3 customers by spending using ROW_NUMBER():
    -- Must use ROW_NUMBER()
    -- Must filter where row_num <= 3
select* from (
    SELECT name, total_spent, ROW_NUMBER()OVER(ORDER BY total_spent DESC) as row_num
    FROM (
        SELECT 
            c.name,
            SUM(o.total_amount) AS total_spent
        FROM customers c
        JOIN orders o
        ON c.customer_id = o.customer_id
        GROUP BY c.customer_id, c.name
    ) AS total_spending_per_customer)as ranked

    where row_num <= 3

-- Write query to show:Top 2 customers per city based on spending
-- Must use PARTITION BY

-- Must use ROW_NUMBER()

-- Must filter properly
SELECT *
FROM (
    SELECT 
        city,
        name,
        total_spent,
        ROW_NUMBER() OVER (
            PARTITION BY city 
            ORDER BY total_spent DESC
        ) AS rnk
    FROM (
        SELECT 
            c.city,
            c.name,
            SUM(o.total_amount) AS total_spent
        FROM customers c
        JOIN orders o 
          ON c.customer_id = o.customer_id
        GROUP BY c.customer_id, c.name, c.city
    ) AS customer_totals
) AS ranking
WHERE rnk <= 2;

-- ADD this data to continue the questions
INSERT INTO orders VALUES
(108, 1, '2024-07-05', 8000),
(109, 1, '2024-08-02', 6000),

(110, 2, '2024-07-07', 2000),
(111, 2, '2024-08-09', 5000),

(112, 3, '2024-07-11', 3000),
(113, 3, '2024-08-15', 1000),

(114, 4, '2024-07-20', 10000),
(115, 4, '2024-08-25', 15000),

(116, 5, '2024-07-22', 4000),
(117, 5, '2024-08-28', 7000),

(118, 6, '2024-07-30', 3500),
(119, 6, '2024-08-18', 2000);

