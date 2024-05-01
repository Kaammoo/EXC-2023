drop database Employees;

-- Ex. 1
create database Employees;
use Employees;

-- Ex. 2
create table employees (
    id int auto_increment primary key,
    first_name varchar(20),
    last_name varchar(20),
    salary int,
    manager_id int
);

-- Ex. 3
create table salgrade (
    grade int,
    lower_limit int,
    upper_limit int
);

-- Ex. 4
create table benefits (
    salary_req int,
    benefit_name varchar(20)
);

INSERT INTO employees (first_name, last_name, salary, manager_id) VALUES
('John', 'Doe', 50000, NULL),
('Jane', 'Smith', 60000, 1),
('Mike', 'Lee', 76000, 1),
('Emily', 'Clark', 55000, 2);

INSERT INTO salgrade (grade, lower_limit, upper_limit) VALUES
(1, 0, 50000),
(2, 50001, 75000),
(3, 75001, 100000);

INSERT INTO benefits (salary_req, benefit_name) VALUES
(50000, 'Health Insurance'),
(60000, 'Dental Coverage'),
(70000, 'Vision Care');

-- Ex. 5
select e.first_name "Emp. name", e.last_name "Emp. surname", e.salary, e.manager_id, s.grade
from employees e
left join salgrade s on e.salary >= s.lower_limit and e.salary <= s.upper_limit;

-- To do
