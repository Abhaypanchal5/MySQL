-- to slect all the data from employee table
select * from employee

-- to select only employee name and salary from employee table
select CONCAT(`FirstName`, ' ', `LastName`) as emp_name,`Salary` AS emp_salary from employee

-- to select employee name and salary from employee table where salary is greater than 50000
select CONCAT(`FirstName`, ' ', `LastName`) as emp_name,`Salary` AS emp_salary from employee where salary > 50000

-- to select employee name and salary from employee table where salary is between 30000 and 60000
select CONCAT(`FirstName`, ' ', `LastName`) as emp_name,`Salary` AS emp_salary from employee where salary between 30000 and 60000

-- to select employee name and salary from employee table where salary is greater than 50000 and department is 'IT'
select CONCAT(`FirstName`, ' ', `LastName`) as emp_name,`Salary` AS emp_salary from employee where salary > 50000 and `JobTitle` = 'IT'

-- to select employee name and salary from employee table where salary is greater than 50000 or department is 'HR'
select CONCAT(`FirstName`, ' ', `LastName`) as emp_name,`Salary` AS emp_salary from employee where salary > 50000 or `JobTitle` = 'HR'

-- to get the total number of employees in employee table
select count(*) as total_employees from employee

-- to get the highest salary from employee table
select max(Salary) as highest_salary from employee

-- to get the lowest salary from employee table
select min(Salary) as lowest_salary from employee

-- to get the second highest salary and employee name from employee table
select max(Salary) as second_highest_salary, CONCAT(`FirstName`, ' ', `LastName`) as emp_name 
from employee 
where Salary < (select max(Salary) from employee) group by emp_name order by second_highest_salary desc limit 1

-- to get second lowest salary and employee name from employee table
select min(Salary) as second_lowest_salary from employee
where `Salary` > (select min(Salary) from employee) GROUP BY `Salary`  ORDER BY second_lowest_salary asc LIMIT 1


