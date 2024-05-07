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

create table manager (
    id int auto_increment primary key,
    first_name varchar(20),
    last_name varchar(20),
    phone_number varchar(15)
);

INSERT INTO employees (first_name, last_name, salary, manager_id) VALUES
('John', 'Doe', 50000, NULL),
('Jane', 'Smith', 60000, 1),
('Mike', 'Lee', 76000, 1),
('Emily', 'Clark', 55000, 2),
("Alan", "Lee", 65000, 3);

INSERT INTO salgrade (grade, lower_limit, upper_limit) VALUES
(1, 0, 50000),
(2, 50001, 75000),
(3, 75001, 100000);

INSERT INTO benefits (salary_req, benefit_name) VALUES
(50000, 'Health Insurance'),
(60000, 'Dental Coverage'),
(70000, 'Vision Care'),
(90000, 'Car Insurance');

INSERT INTO manager (first_name, last_name, phone_number) VALUES
('Alice', 'Johnson', '1234567890'),
('Bob', 'Williams', '9876543210'),
('Eva', 'Brown', '5551234567');

-- Ex. 5
select e.first_name "Emp. name", e.last_name "Emp. surname", e.salary, e.manager_id, s.grade
from employees e
left join salgrade s on e.salary >= s.lower_limit and e.salary <= s.upper_limit;

-- Ex. 6
select e.first_name "Employee name", e.last_name "Employee surname",
b.benefit_name "Benefit name"
from employees e left join benefits b on e.salary >= b.salary_req
where id = 5;

-- Ex. 7
select e.first_name "Employee name", e.last_name "Employee surname", e.salary "Employee salary",
m.first_name "Manager name", m.last_name "Manager surname"
from employees e right join manager m on e.manager_id = m.id;

-- Ex. 8
select b.benefit_name "Benefit name", count(e.first_name) "Employees count"
from benefits b right join employees e on e.salary >= b.salary_req
group by b.benefit_name;

-- Ex. 9
select b.benefit_name "Benefit name", count(e.first_name) "Employees count"
from benefits b left join employees e on e.salary >= b.salary_req
group by b.benefit_name;
