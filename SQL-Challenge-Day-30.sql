--  Problem Statement

-- You are given a table named teams with a single column named team_name
-- that contains the following rows:

create database iplDB;
use iplDB;

create table teams (
	team_name varchar(10)
);

insert into teams values 
	('CSK'),
	('LSG'),
	('MI'),
	('DC'),
	('RR'),
	('GT'),
	('RCB'),
	('PK'),
	('SRH'),
	('KKR');
    
-- Write a SQl query to generate all possible unique match combinations between the
-- teams in the format team1 vs team2.
-- Constraints:
-- -> Each pair should appear only once (e.g. "CSK vs KKR" is valid but "KKR vs CSK" should not appear.)
-- -> A team should not be matched with itself (e.g. "CSK vs CSK" is invalid.)

select 
	concat(t1.team_name, " vs ", t2.team_name) as matches
from
	teams as t1
join
	teams as t2
on
	t1.team_name > t2.team_name
order by
	matches asc;