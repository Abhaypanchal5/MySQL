CREATE table Employee
(
    EmployeeID int primary key AUTO_INCREMENT,
    FirstName varchar(50) not null,
    LastName varchar(50) not null,
    Email varchar(100)  unique DEFAULT "N/A",
    PhoneNumber varchar(10) DEFAULT "N/A",
    JobTitle varchar(50) not null,
    Salary decimal(18, 2) not null
);

# Run the above code to create the Employee table in your database. 
#This table includes columns for EmployeeID, FirstName, LastName, Email, PhoneNumber, JobTitle, and Salary. 
#The EmployeeID is set to auto-increment and serves as the primary key. The Email column is unique and has a default value of "N/A", while the PhoneNumber column also has a default value of "N/A".