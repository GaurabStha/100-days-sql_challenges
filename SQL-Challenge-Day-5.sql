-- Microsoft (Medium Level) hashtag#SQL Interview Question

-- Given a list of projects and employees mapped to each project, calculate by the amount of project budget allocated to each employee. 
-- The output should include the project title and the project budget rounded to the closest integer.
-- Order your list by projects with the highest budget per employee first.

create database MicrosoftDB;
use MicrosoftDB;

CREATE TABLE ms_projects(id int, title varchar(15), budget int);

INSERT INTO ms_projects VALUES 
(1, 'Project1', 29498),
(2, 'Project2', 32487),
(3, 'Project3', 43909),
(4, 'Project4', 15776),
(5, 'Project5', 36268),
(6, 'Project6', 41611),
(7, 'Project7', 34003),
(8, 'Project8', 49284),
(9, 'Project9', 32341),
(10, 'Project10', 47587),
(11, 'Project11', 11705),
(12, 'Project12', 10468),
(13, 'Project13', 43238),
(14, 'Project14', 30014),
(15, 'Project15', 48116),
(16, 'Project16', 19922),
(17, 'Project17', 19061),
(18, 'Project18', 10302),
(19, 'Project19', 44986),
(20, 'Project20', 19497);

CREATE TABLE ms_emp_projects(emp_id int, project_id int);

INSERT INTO ms_emp_projects VALUES 
(10592,  1),
(10593,  2),
(10594,  3),
(10595,  4),
(10596,  5),
(10597,  6),
(10598,  7),
(10599,  8),
(10600,  9),
(10601, 10),
(10602, 11),
(10603, 12),
(10604, 13),
(10605, 14),
(10606, 15),
(10607, 16),
(10608, 17),
(10609, 18),
(10610, 19),
(10611, 20);

select
	mp.title as project_title,
	round(mp.budget/count(mep.emp_id), 0) as project_budget_per_employee
from
	ms_projects mp
join
	ms_emp_projects mep
on
	mp.id = mep.project_id
group by
	mp.id, mp.title, mp.budget
order by
	project_budget_per_employee desc;