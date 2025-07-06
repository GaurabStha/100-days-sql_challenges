

use DeloitteDB;

DROP TABLE IF EXISTS Employees;

create table Employees (id int, salary int);

insert into Employees values (1, 100), (2, 200), (3, 300);

select * from Employees;

DELIMITER $$
CREATE FUNCTION getNthHighestSalary(N INT) RETURNS INT
READS SQL DATA
BEGIN
	declare result int;
	declare offset_val int;
	set offset_val = N-1;

    SELECT DISTINCT salary
    into result
    FROM Employees
    ORDER BY salary DESC
    LIMIT 1 OFFSET offset_val;
    
    return result;
END$$
DELIMITER ;

select getNthHighestSalary(3);