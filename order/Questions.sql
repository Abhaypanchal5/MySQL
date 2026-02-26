-- Write SQL to show: Customer name and their total spending
SELECT c.name, sum(o.total_amount) as Total_spent from customers c join orders o on c.customer_id = o.customer_id GROUP BY c.name 

