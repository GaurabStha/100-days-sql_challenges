-- Tesla (Medium Level) hashtag #SQL Interview Question — Solution

-- You are given a table of product launches by company by year. 
-- Write a query to count the net difference between the number of 
-- products companies launched in 2020 with the number of products 
-- companies launched in the previous year. Output the name of the 
-- companies and a net difference of net products released for 2020 
-- compared to the previous year.

create database TeslaDB;
use TeslaDB;

-- 𝐒𝐜𝐡𝐞𝐦𝐚 𝐚𝐧𝐝 𝐃𝐚𝐭𝐚𝐬𝐞𝐭:
CREATE TABLE car_launches(
	year int, 
	company_name varchar(15), 
	product_name varchar(30));

INSERT INTO car_launches VALUES
	(2019,'Toyota','Avalon'),
	(2019,'Toyota','Camry'),
	(2020,'Toyota','Corolla'),
	(2019,'Honda','Accord'),
	(2019,'Honda','Passport'),
	(2019,'Honda','CR-V'),
	(2020,'Honda','Pilot'),
	(2019,'Honda','Civic'),
	(2020,'Chevrolet','Trailblazer'),
	(2020,'Chevrolet','Trax'),
	(2019,'Chevrolet','Traverse'),
	(2020,'Chevrolet','Blazer'),
	(2019,'Ford','Figo'),
	(2020,'Ford','Aspire'),
	(2019,'Ford','Endeavour'),
	(2020,'Jeep','Wrangler');

-- FINAL QUERY
-- This is done by me
-- First we find number of product launched in each year and saved in CTE 'product_each_year'
with product_each_year as (
select
	year,
    company_name,
    count(product_name) as number_of_product
from
	car_launches
where
	year in (2019, 2020)
group by
	year, company_name),

-- then we find the product count of previous year 2019 to 2020
-- We used lag function to find the previous year product count
-- which will return null if there is no any product in 2019 so we 
-- used coalesce function to replace null with 0
with_prev_year as (
select
	*,
    coalesce(lag(number_of_product) 
			over
				(partition by company_name order by year)
			, 0) as previous_year_product_count
from
	product_each_year)
-- Now we find the difference between the number of product in 2020
-- and number of product in 2019
select
	company_name,
    (number_of_product - previous_year_product_count) as net_difference
from
	with_prev_year
where
	year = 2020
order by
	net_difference desc;
    
-- The code I copied frome internet
with product_counts as (
	select
		company_name,
        sum(case when year = 2020 then 1 else 0 end) as product2020,
        sum(case when year = 2019 then 1 else 0 end) as product2019
	from 
		car_launches
	where
		year in (2019, 2020)
	group by
		company_name)
select
	company_name,
    (product2020-product2019) as net_difference
from
	product_counts
order by
	net_difference desc;