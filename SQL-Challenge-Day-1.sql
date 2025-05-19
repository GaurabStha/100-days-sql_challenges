-- Meta/Facebook (Hard Level) hashtag #SQL Interview Question
	-- A table named “famous” has two columns called user id and follower id. 
	-- It represents each user ID has a particular follower ID. 
	-- These follower IDs are also users of hashtag#Facebook / hashtag#Meta.
	-- Then, find the famous percentage of each user. 
	-- Famous Percentage = number of followers a user has / total number of users on the platform.

-- First we check the databases then created the database 'MetaPlatformDB' for our day 1 challenge.
show databases;

create database MetaPlatformDB;
use MetaPlatformDB;


-- 𝐒𝐜𝐡𝐞𝐦𝐚 𝐚𝐧𝐝 𝐃𝐚𝐭𝐚𝐬𝐞𝐭:
CREATE TABLE famous 
(user_id INT, follower_id INT);

INSERT INTO famous VALUES
(1, 2), (1, 3), (2, 4), (5, 1), (5, 3), 
(11, 7), (12, 8), (13, 5), (13, 10), 
(14, 12), (14, 3), (15, 14), (15, 13);

show tables;

select * from famous;

select count(distinct(user_id)) as total_follower
from famous;

-- We use union to get a distinct list of all users by combining user_id and follower_id from the 'famous' table
select users from (
select user_id as users from famous
union
select follower_id as users from famous) t;

select user_id, count(follower_id) as total_follower
from famous
group by user_id;

-- FINAL QUERY

-- Without common table expression (CTE) 
select user_id,
count(follower_id)*100/(select count(*) from (
select user_id as users from famous
union
select follower_id as users from famous) t) follower_percentage
from famous
group by user_id;

-- With common table expression (CTE)
-- Here we used users as a CTE.
with users as (
select user_id as users from famous
union
select follower_id as users from famous)

select user_id,
count(follower_id)*100/(select count(*) from users) as follower_percentage
from famous
group by user_id;

