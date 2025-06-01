-- Amazon (Hard Level) #SQL Interview Question

-- Find products which are exclusive to only Amazon and 
-- therefore not sold at Top Shop and Macy's. Your output 
-- should include the product name, brand name, price, and rating.
-- Two products are considered equal if they have the same product 
-- name and same maximum retail price (mrp column).

use AmazonDB;

CREATE TABLE innerwear_amazon_com (
	product_name VARCHAR(255),
	mrp VARCHAR(50),
	price VARCHAR(50),
	pdp_url VARCHAR(255),
	brand_name VARCHAR(100),
	product_category VARCHAR(100),
	retailer VARCHAR(100),
	description VARCHAR(255),
	rating FLOAT,
	review_count INT,
	style_attributes VARCHAR(255),
	total_sizes VARCHAR(50),
	available_size VARCHAR(50),
	color VARCHAR(50));

INSERT INTO innerwear_amazon_com 
	(product_name, mrp, price, pdp_url, brand_name, product_category, retailer, description, rating, review_count, style_attributes, total_sizes, available_size, color) 
VALUES 
	('ProductA', '100', '80', 'url1', 'BrandA', 'Category1', 'Amazon', 'DescriptionA', 4.5, 100, 'StyleA', 'M,L', 'M', 'Red'),
	('ProductB', '200', '180', 'url2', 'BrandB', 'Category1', 'Amazon', 'DescriptionB', 4.2, 150, 'StyleB', 'S,M,L', 'S', 'Blue'),
	('ProductC', '300', '250', 'url3', 'BrandC', 'Category2', 'Amazon', 'DescriptionC', 4.8, 200, 'StyleC', 'L,XL', 'L', 'Green');

CREATE TABLE innerwear_macys_com (
	product_name VARCHAR(255),
	mrp VARCHAR(50),
	price VARCHAR(50),
	pdp_url VARCHAR(255),
	brand_name VARCHAR(100),
	product_category VARCHAR(100),
	retailer VARCHAR(100),
	description VARCHAR(255),
	rating FLOAT,
	review_count FLOAT,
	style_attributes VARCHAR(255),
	total_sizes VARCHAR(50),
	available_size VARCHAR(50),
	color VARCHAR(50));
    
INSERT INTO innerwear_macys_com 
	(product_name, mrp, price, pdp_url, brand_name, product_category, retailer, description, rating, review_count, style_attributes, total_sizes, available_size, color) 
VALUES 
	('ProductA', '100', '85', 'url4', 'BrandA', 'Category1', 'Macys', 'DescriptionA', 4.5, 90, 'StyleA', 'M,L', 'M', 'Red'),
	('ProductD', '150', '130', 'url5', 'BrandD', 'Category3', 'Macys', 'DescriptionD', 4.0, 80, 'StyleD', 'S,M', 'S', 'Yellow'),
	('ProductE', '250', '210', 'url6', 'BrandE', 'Category4', 'Macys', 'DescriptionE', 3.9, 60, 'StyleE', 'M,L', 'L', 'Black');

CREATE TABLE innerwear_topshop_com (
	product_name VARCHAR(255),
	mrp VARCHAR(50),
	price VARCHAR(50),
	pdp_url VARCHAR(255),
	brand_name VARCHAR(100),
	product_category VARCHAR(100),
	retailer VARCHAR(100),
	description VARCHAR(255),
	rating FLOAT,
	review_count FLOAT,
	style_attributes VARCHAR(255),
	total_sizes VARCHAR(50),
	available_size VARCHAR(50),
	color VARCHAR(50));
    
INSERT INTO innerwear_topshop_com 
	(product_name, mrp, price, pdp_url, brand_name, product_category, retailer, description, rating, review_count, style_attributes, total_sizes, available_size, color) 
VALUES 
	('ProductB', '200', '190', 'url7', 'BrandB', 'Category1', 'TopShop', 'DescriptionB', 4.1, 95, 'StyleB', 'S,M,L', 'M', 'Blue'),
	('ProductF', '100', '90', 'url8', 'BrandF', 'Category3', 'TopShop', 'DescriptionF', 3.5, 50, 'StyleF', 'XS,S', 'S', 'Pink'),
	('ProductG', '300', '270', 'url9', 'BrandG', 'Category5', 'TopShop', 'DescriptionG', 4.3, 70, 'StyleG', 'M,L,XL', 'M', 'Purple');

-- FINAL QUERY

-- BY MySELF -- using joins

select
	a.product_name, 
	a.brand_name, 
	a.price,
	a.rating
from
	innerwear_amazon_com as a
left join
	innerwear_macys_com as m 
		on 
			a.product_name = m.product_name
            and
            a.mrp = m.mrp
left join
	innerwear_topshop_com as t 
		on 
			a.product_name = t.product_name
            and
            a.mrp = t.mrp
where a.product_name not in 
							(select product_name from innerwear_macys_com 
							union 
                            select product_name from innerwear_topshop_com);


select
	a.product_name, 
	a.brand_name, 
	a.price,
	a.rating
from
	innerwear_amazon_com as a
left join
	innerwear_macys_com as m 
		on 
			a.product_name = m.product_name
            and
            a.mrp = m.mrp
left join
	innerwear_topshop_com as t 
		on 
			a.product_name = t.product_name
            and
            a.mrp = t.mrp
where 
	m.product_name is null
and 
	t.product_name is null;
    
-- Using no any joins
select
	a.product_name, 
	a.brand_name, 
	a.price,
	a.rating
from
	innerwear_amazon_com as a
where
	not exists (
		select 1
        from innerwear_macys_com as m
        where a.product_name = m.product_name)
and
	not exists (
		select 1
        from innerwear_topshop_com as t
        where a.product_name = t.product_name)
        
