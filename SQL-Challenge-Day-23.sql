-- Oracle (Hard Level) #SQL Interview Question

-- Write a query that compares each employee's salary to their 
-- manager's and the average department salary (excluding the 
-- manager's salary). Display the department, employee ID, employee's 
-- salary, manager's salary, and department average salary. Order by 
-- department, then by employee salary (highest to lowest).

create database OracleDB;
use OracleDB;

CREATE TABLE employee_o (
	id INT PRIMARY KEY,
	first_name VARCHAR(50),
	last_name VARCHAR(50),
	age INT,
	gender VARCHAR(10),
	employee_title VARCHAR(50),
	department VARCHAR(50),
	salary INT,
	manager_id INT);

INSERT INTO employee_o 
	(id, first_name, last_name, age, gender, employee_title, department, salary, manager_id) 
VALUES
	(1, 'Alice', 'Smith', 45, 'F', 'Manager', 'HR', 9000, 1),
	(2, 'Bob', 'Johnson', 34, 'M', 'Assistant', 'HR', 4500, 1),
	(3, 'Charlie', 'Williams', 28, 'M', 'Coordinator', 'HR', 4800, 1),
	(4, 'Diana', 'Brown', 32, 'F', 'Manager', 'IT', 12000, 4),
	(5, 'Eve', 'Jones', 27, 'F', 'Analyst', 'IT', 7000, 4),
	(6, 'Frank', 'Garcia', 29, 'M', 'Developer', 'IT', 7500, 4),
	(7, 'Grace', 'Miller', 30, 'F', 'Manager', 'Finance', 10000, 7),
	(8, 'Hank', 'Davis', 26, 'M', 'Analyst', 'Finance', 6200, 7),
	(9, 'Ivy', 'Martinez', 31, 'F', 'Clerk', 'Finance', 5900, 7),
	(10, 'John', 'Lopez', 36, 'M', 'Manager', 'Marketing', 11000, 10),
	(11, 'Kim', 'Gonzales', 29, 'F', 'Specialist', 'Marketing', 6800, 10),
	(12, 'Leo', 'Wilson', 27, 'M', 'Coordinator', 'Marketing', 6600, 10);
    
-- FINAL QUERY

with managers as (
	select
		id as manager_id,
		salary,
		department
	from
		employee_o
	where
		id in (select manager_id from employee_o)),
        
deptAverageSalary as (
	select
		department,
		avg(case when id != manager_id then salary end) as average_salary
	from
		employee_o
	group by
		department
)

select
	emp.department as department,
	emp.id as employee_id,
	emp.salary as employee_salary,
	mgr.salary as manager_salary,
    dpt.average_salary as dpt_avg_salary
from
	employee_o as emp
join
	managers as mgr
on
	emp.manager_id = mgr.manager_id
join
	deptAverageSalary as dpt
on
	emp.department = dpt.department
order by
	department, employee_salary desc;
