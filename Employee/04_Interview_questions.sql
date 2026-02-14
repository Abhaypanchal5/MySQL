-- Q1) Find the second highest salary from employee table in 4 different ways.
    -- method 1) using subquery
    select max(Salary) as second_highest_salary from employee where Salary < (select max(Salary) from employee)

    -- method 2) using order by and limit (this method cant be used in case of duplicate salaries)
    select Salary as second_highest_salary from employee order by Salary desc limit 1,1

    -- method 3) using order by and limit with distinct (this method can be used in case of duplicate salaries)
    select distinct Salary as second_highest_salary from employee order by Salary desc limit 1,1

    -- method 4) using over clause and row_number() function (this method can be used in case of duplicate salaries)
    select Salary as second_highest_salary from (
        select Salary, row_number() over (order by Salary desc) as rn from employee
    ) as subquery where rn = 2
    


