-- Deloitte SQL Interview Problem - Level Hard Script

use DeloitteDB;

show tables;

DROP TABLE IF EXISTS Products;

CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    Product VARCHAR(255),
    Category VARCHAR(100)
);

INSERT INTO Products (ProductID, Product, Category)
VALUES
    (1, 'Laptop', 'Electronics'),
    (2, 'Smartphone', 'Electronics'),
    (3, 'Tablet', 'Electronics'),
    (4, 'Headphones', 'Accessories'),
    (5, 'Smartwatch', 'Accessories'),
    (6, 'Keyboard', 'Accessories'),
    (7, 'Mouse', 'Accessories'),
    (8, 'Monitor', 'Accessories'),
    (9, 'Printer', 'Electronics');

with cte as (
	select 
		*,
		row_number() over (partition by Category order by ProductID asc) as RN1,
		row_number() over (partition by Category order by ProductID desc) as RN2
	from
		Products)
        
select
	b.ProductID,
	a.Product, 
    a.Category
from
	cte as a
join
	cte as b
on
	a.Category = b.Category
and
	a.RN1 = b.RN2;