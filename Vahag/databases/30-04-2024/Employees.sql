--1
create database Employees;
use Employees;

--I added this table
create table Manager (
    id int auto_increment primary key,
    first_name varchar(20),
    last_name varchar(20),
    phone_number varchar(20)
);

--3
create table Salgrade (
    id int auto_increment primary key,
    grade int,
    lower_limit int,
    upper_limit int
);

֊֊4
create table Benefits (
    id int auto_increment primary key,
    salary_req int,
    benefit_name varchar(30)
);

֊֊2
create table Employee(
    id int auto_increment primary key,
    first_name varchar(20),
    last_name varchar(20),
    salary int,
    manager_id int,
    salgrade_id int,
    benefit_id int,
    foreign key (manager_id) references Manager(id),
    foreign key (salgrade_id) references Salgrade(id),
    foreign key (benefit_id) references Benefits(id)
);
--I don't know if it is possible to give these links

--Add values all tables
INSERT INTO Manager (first_name, last_name, phone_number) VALUES
    ('John', 'Doe', '1234567890'),
    ('Jane', 'Smith', '0987654321'),
    ('Alice', 'Johnson', '5555555555'),
    ('Bob', 'Brown', '7777777777'),
    ('Emma', 'Wilson', '9999999999'),
    ('Michael', 'Jones', '3333333333'),
    ('Sarah', 'Davis', '1111111111');

INSERT INTO Salgrade (grade, lower_limit, upper_limit) VALUES
    (3, 1000, 2000),
    (2, 2001, 3000),
    (3, 3001, 4000),
    (8, 4001, 5000),
    (5, 5001, 6000),
    (6, 6001, 7000),
    (6, 7001, 8000);

INSERT INTO Benefits (salary_req, benefit_name) VALUES
    (1500, 'Health Insurance'),
    (900, 'Retirement Plan'),
    (3200, 'Vacation Days'),
    (2000, 'Gym Membership'),
    (4300, 'Stock Options'),
    (6000, 'Company Car'),
    (7350, 'Bonus Scheme');

INSERT INTO Employee (first_name, last_name, salary, manager_id, salgrade_id, benefit_id) VALUES
    ('Michael', 'Johnson', 1500, 1, 2, 5),
    ('Emily', 'Anderson', 2500, 2, 3, 6),
    ('David', 'Lee', 3500, 1, 4, 3),
    ('Jennifer', 'Clark', 4500, 2, 2, 2),
    ('Daniel', 'Taylor', 5500, 1, 1, 2),
    ('Emma', 'White', 6500, 4, 7, 6),
    ('James', 'Martinez', 7500, 3, 1, 7),
    ('Jason', 'Statement', 1500, null, 2, 5);


--5
select e.first_name as "Employees first name",
e.last_name as "Employees last name",
s.grade as "Salary grade"
from Employee e
left join Salgrade s on e.salgrade_id = s.id;

--6
select e.first_name as "Employees first name",
e.last_name as "Employees last name",
b.benefit_name as "Benefit name"
from Employee e
inner join Benefits b on e.benefit_id = b.id
where e.id = 5;

--7
select e.first_name as "Employees first name",
e.last_name as "Employees last name",
e.salary as "Employees salary",
m.first_name as "Manager first name",
m.last_name as "Manager last name"
from Employee e
left join Manager m on e.manager_id = m.id
where e.manager_id is not null;

--8
select b.benefit_name as "Benefit name",
count(e.benefit_id) as Staff_count
from Benefits b
left join Employee e on e.benefit_id = b.id
group by b.benefit_name
having Staff_count >= 1;

--9
select b.benefit_name as "Benefit name",
count(e.benefit_id) as Staff_count
from Benefits b
left join Employee e on e.benefit_id = b.id
group by b.benefit_name;
