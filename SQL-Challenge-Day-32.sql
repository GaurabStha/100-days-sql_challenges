-- Delloitte SQL Interview Question 2024

-- Part 1: Find the top 3 highest-paid employees in 
--               each department.
-- Part 2: Find the average salary of employees hired 
--                in the last 5 years.
-- Part 3: Find the employees whose salry is less than 
--                the average salary of employees hired in 
--                the last 5 years.

use DeloitteDB;

CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(100)
);

CREATE TABLE Employees (
	EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    DepartmentID INT,
    Salary DECIMAL(10, 2),
    DateHired DATE,
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);

INSERT INTO Departments 
	(DepartmentID, DepartmentName) 
VALUES
	(1, 'HR'),
	(2, 'Engineering'),
	(3, 'Sales');

INSERT INTO Employees 
	(EmployeeID, FirstName, LastName, DepartmentID, Salary, DateHired) 
VALUES
	(1, 'Alice', 'Smith', 1, 50000, '2020-01-15'),
	(2, 'Bob', 'Johnson', 1, 60000, '2018-03-22'),
	(3, 'Charlie', 'Williams', 2, 70000, '2019-07-30'),
	(4, 'David', 'Brown', 2, 80000, '2017-11-11'),
	(5, 'Eve', 'Davis', 3, 90000, '2021-02-25'),
	(6, 'Frank', 'Miller', 3, 55000, '2020-09-10'),
	(7, 'Grace', 'Wilson', 2, 75000, '2016-04-05'),
	(8, 'Henry', 'Moore', 1, 65000, '2022-06-17');


-- Part 1: Find the top 3 highest-paid employees in 
--         each department.
select 
	EmployeeId,
    FirstName,
    DepartmentName,
    Salary
from (
	select 
		e.EmployeeId,
		e.FirstName,
		d.DepartmentName,
		e.Salary,
		dense_rank() over (partition by e.DepartmentID order by e.Salary desc) as rnk
	from
		Departments as d
	join
		Employees as e
	on
		d.DepartmentID = e.DepartmentID) as t
where
	rnk <= 3;

-- Part 2: Find the average salary of employees hired 
--                in the last 5 years.
select
	round(avg(salary), 2) as avg_salary
from
	Employees
where 
	DateHired >= curdate() - interval 5 year;

-- Part 3: Find the employees whose salary is less than 
--                the average salary of employees hired in 
--                the last 5 years.

select
	*
from
	Employees
where 
	salary < (
		select
			round(avg(salary), 2) as avg_salary
		from
			Employees
		where 
			DateHired >= curdate() - interval 5 year
	);
