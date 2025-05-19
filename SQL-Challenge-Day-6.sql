-- Airbnb (Medium Level) hashtagn#SQL Interview Question

-- Find the total number of available beds per hosts' nationality.
-- Output the nationality along with the corresponding total number of available beds. 
-- Sort records by the total available beds in descending order.

create database AirbnbDB;
use AirbnbDB;

-- 𝐒𝐜𝐡𝐞𝐦𝐚 𝐚𝐧𝐝 𝐃𝐚𝐭𝐚𝐬𝐞𝐭:
CREATE TABLE airbnb_apartments(
	host_id int,
	apartment_id varchar(5),
	apartment_type varchar(10),
	n_beds int,
    n_bedrooms int,
	country varchar(20),
	city varchar(20)
);

INSERT INTO airbnb_apartments VALUES
	(0,'A1','Room',1,1,'USA','NewYork'),
	(0,'A2','Room',1,1,'USA','NewJersey'),
	(0,'A3','Room',1,1,'USA','NewJersey'),
	(1,'A4','Apartment',2,1,'USA','Houston'),
	(1,'A5','Apartment',2,1,'USA','LasVegas'),
	(3,'A7','Penthouse',3,3,'China','Tianjin'),
	(3,'A8','Penthouse',5,5,'China','Beijing'),
	(4,'A9','Apartment',2,1,'Mali','Bamako'),
	(5,'A10','Room',3,1,'Mali','Segou');

CREATE TABLE airbnb_hosts(
	host_id int,
	nationality  varchar(15),
	gender varchar(5),
	age int);
    
INSERT INTO airbnb_hosts VALUES
(0,'USA','M',28),
(1,'USA','F',29),
(2,'China','F',31),
(3,'China','M',24),
(4,'Mali','M',30),
(5,'Mali','F',30);

-- Final Query
-- Here we solved the problem with two methods. Here both of the query gives us the same result cause
-- we have small data. But if we have more data, then there will be difference in result.

select
	h.nationality,
    sum(a.n_beds) as total_beds_per_nationality
from
	airbnb_apartments a
join
	airbnb_hosts h
on
	a.host_id = h.host_id
group by
	h.nationality
order by
	total_beds_per_nationality desc;
    
select 
	country as host_nationality,
	sum(n_beds) as total_beds_per_nationality 
from 
	airbnb_apartments 
group by 
	country 
order by
	total_beds_per_nationality desc;
