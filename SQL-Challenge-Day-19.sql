-- Walmart (HardLevel) #SQL Interview Question

-- Identify users who started a session and placed an order on the same day. 
-- For these users, calculate the total number of orders and the total order 
-- value for that day. Your output should include the user, the session date, 
-- the total number of orders, and the total order value for that day.

show databases;

create database WalmartDB;
use WalmartDB;

CREATE TABLE sessions(
	session_id INT PRIMARY KEY,
	user_id INT,
	session_date DATETIME);

INSERT INTO sessions
	(session_id, user_id, session_date) 
VALUES 
	(1, 1, '2024-01-01 00:00:00'),
	(2, 2, '2024-01-02 00:00:00'),
	(3, 3, '2024-01-05 00:00:00'),
	(4, 3, '2024-01-05 00:00:00'),
	(5, 4, '2024-01-03 00:00:00'),
	(6, 4, '2024-01-03 00:00:00'),
	(7, 5, '2024-01-04 00:00:00'),
	(8, 5, '2024-01-04 00:00:00'),
	(9, 3, '2024-01-05 00:00:00'),
	(10, 5, '2024-01-04 00:00:00');

CREATE TABLE order_summary (
	order_id INT PRIMARY KEY,
	user_id INT,
	order_value INT,
	order_date DATETIME);

INSERT INTO order_summary 
	(order_id, user_id, order_value, order_date) 
VALUES 
	(1, 1, 152, '2024-01-01 00:00:00'),
	(2, 2, 485, '2024-01-02 00:00:00'),
	(3, 3, 398, '2024-01-05 00:00:00'),
	(4, 3, 320, '2024-01-05 00:00:00'),
	(5, 4, 156, '2024-01-03 00:00:00'),
	(6, 4, 121, '2024-01-03 00:00:00'),
	(7, 5, 238, '2024-01-04 00:00:00'),
	(8, 5, 70, '2024-01-04 00:00:00'),
	(9, 3, 152, '2024-01-05 00:00:00'),
	(10, 5, 171, '2024-01-04 00:00:00');
    
-- FINAL QUERY

select
	s.user_id as user_id,
	s.session_date as session_date,
	count(o.order_id) as total_orders,
	sum(o.order_value) as total_order_value
from
	sessions as s
join
	order_summary as o
on
	s.user_id = o.user_id
and
	date(s.session_date) = date(o.order_date)
group by
	s.user_id, s.session_date;
