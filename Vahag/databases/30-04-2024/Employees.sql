--1
create database Employees;
use Employees;

create table Manager (
    id int auto_increment primary key,
    first_name varchar(20),
    last_name varchar(20),
    phone_number varchar(20)
);

create table Salgrade (
    id int auto_increment primary key,
    grade int,
    lower_limit int,
    upper_limit int
);

create table Benefits (
    id int auto_increment primary key,
    salary_req int,
    benefit_name varchar(30)
);

create table Employee(
    id int auto_increment primary key,
    first_name varchar(20),
    last_name varchar(20),
    salary int,
    manager_id int,
    foreign key (manager_id) references Manager(id)
);

create table Salgrade_info (
    employee_id int,
    salgrade_id int,
    foreign key (employee_id) references Employee(id),
    foreign key (salgrade_id) references Salgrade(id)
);

create table Benefits_info (
    employee_id int,
    benefit_id int,
    foreign key (employee_id) references Employee(id),
    foreign key (benefit_id) references Benefits(id)
);

INSERT INTO Manager (first_name, last_name, phone_number) 
VALUES ('John', 'Doe', '123-456-7890'),
       ('Jane', 'Smith', '987-654-3210'),
       ('Michael', 'Johnson', '555-123-4567'),
       ('Emily', 'Williams', '444-222-3333'),
       ('Chris', 'Brown', '111-999-8888');

INSERT INTO Salgrade (grade, lower_limit, upper_limit)
VALUES (1, 1000, 2000),
       (2, 2001, 3000),
       (3, 3001, 4000),
       (4, 4001, 5000),
       (5, 5001, 6000);

INSERT INTO Benefits (salary_req, benefit_name)
VALUES (2000, 'Health Insurance'),
       (3000, 'Retirement Plan'),
       (4000, 'Paid Time Off'),
       (5000, 'Stock Options'),
       (6000, 'Tuition Reimbursement');

INSERT INTO Employee (first_name, last_name, salary, manager_id)
VALUES ('Alice', 'Johnson', 2500, 1),
       ('Bob', 'Smith', 3500, 2),
       ('Charlie', 'Brown', 4500, 3),
       ('David', 'Williams', 5500, 4),
       ('Emma', 'Doe', 6500, 5),
       ('Anahit', 'Saruxanyan', 2250, null);

INSERT INTO Salgrade_info (employee_id, salgrade_id)
VALUES (1, 2),
       (2, 3),
       (3, 4),
       (4, 5),
       (5, 5);

INSERT INTO Benefits_info (employee_id, benefit_id)
VALUES (1, 1),
       (2, 2),
       (3, 3),
       (5, 5),
       (5, 3),
       (5, 2),
       (4, 2);

--5
select e.first_name as "Employees first name",
e.last_name as "Employees last name",
s.grade as "Salary grade"
from Employee e
left join Salgrade_info si on e.id = si.employee_id
inner join Salgrade s on si.salgrade_id = s.id;

--6
select e.first_name as "Employees first name",
e.last_name as "Employees last name",
b.benefit_name as "Benefit name"
from Employee e
inner join Benefits_info bi on e.id = bi.employee_id
inner join Benefits b on b.id = bi.benefit_id
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
count(bi.benefit_id) as Staff_count
from Benefits b
left join Benefits_info bi on b.id = bi.benefit_id
inner join Employee e on e.id = bi.employee_id
group by b.benefit_name
having Staff_count >= 1;

--9
select b.benefit_name as "Benefit name",
count(bi.benefit_id) as Staff_count
from Benefits b
left join Benefits_info bi on b.id = bi.benefit_id
left join Employee e on e.id = bi.employee_id
group by b.benefit_name;
