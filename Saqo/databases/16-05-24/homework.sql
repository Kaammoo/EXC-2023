drop database if exists Homework;
create database Homework;
use Homework;

-- Ex. 1
-- write an sql query that displays the current date.
select curdate();

-- Ex. 2
-- Write an SQL query that checks whether a date (1/04/12)
-- passed to the query is in a given format (MM/YY/DD).
select 
    if(str_to_date('01/04/12', '%m/%y/%d') is not null, 'Valid', 'Invalid')
        as date_format_check;

-- Ex. 3
-- Write an SQL query to find duplicate rows in two tables (EMPLOYEE and WORKERS),
-- and then write a query to delete the duplicates.
drop table if exists EMPLOYEE;
create table EMPLOYEE (
    id int auto_increment primary key,
    name varchar(50),
    email varchar(50)
);

drop table if exists WORKERS;
create table WORKERS (
    id int auto_increment primary key,
    name varchar(50),
    email varchar(50)
);

insert into EMPLOYEE (name, email) values
('alice smith', 'alice@example.com'),
('bob johnson', 'bob@example.com'),
('charlie brown', 'charlie@example.com'),
('david wilson', 'david@example.com'),
('eve davis', 'eve@example.com');

insert into WORKERS (name, email) values
('alice smith', 'alice@example.com'),
('bob johnson', 'bob@example.com'),
('fiona clark', 'fiona@example.com'),
('george white', 'george@example.com'),
('eve davis', 'eve@example.com');

select * from EMPLOYEE;
select * from WORKERS;

select e.id, e.name, e.email from EMPLOYEE e
join WORKERS w on e.name = w.name and e.email = w.email;

delete e, w
from EMPLOYEE e
join WORKERS w on e.name = w.name and e.email = w.email
where e.name = w.name and e.email = w.email;

-- Ex. 4
-- Write an SQL statement that lists school names, student names,
-- and their cities only if the school and the student are in the same city
-- and the student is not from New York.

-- Table school
drop table if exists school;
create table school (
    school_id int primary key,
    school_name varchar(50),
    city varchar(50)
);

insert into school (school_id, school_name, city) values
(1, 'Stanford', 'Stanford'),
(2, 'University of Cali', 'San Francisco'),
(3, 'Harvard University', 'New York'),
(4, 'MIT', 'Boston'),
(5, 'Yale', 'New Haven');

-- Table student
drop table if exists student;
create table student (
    student_id int primary key,
    student_name varchar(50),
    city varchar(50),
    school_id int
);

insert into student (student_id, student_name, city, school_id) values
(1001, 'Peter Brebec', 'New York', 1),
(1002, 'John Goorgy', 'San Francisco', 2),
(2003, 'Brad Smith', 'New York', 3),
(1004, 'Fabian Johns', 'Boston', 5),
(1005, 'Brad Cameron', 'Stanford', 1),
(1006, 'Geoff Firby', 'Boston', 5),
(1007, 'Johnny Blue', 'New Haven', 2),
(1008, 'Johse Brook', 'Miami', 2);

select sc.school_name, st.student_name, st.city from school sc
join student st on st.school_id = sc.school_id
and sc.city = st.city;

-- Ex. 5
-- Write an SQL statement that lists student names, subject names,
-- subject lecturers, and the max amount of points for all subjects except
-- Computer Science and any subjects with a max score between 100 and 200.

-- Table subject
drop table if exists subject;
create table subject (
    subject_id int primary key,
    subject_name varchar(50),
    max_score int,
    lecturer varchar(50)
);

insert into subject (subject_id, subject_name, max_score, lecturer) values
(11, 'Math', 130, 'Christena Solem'),
(12, 'Computer Science', 150, 'Jaime Pille'),
(13, 'Biology', 300, 'Carrol Denmark'),
(14, 'Geography', 220, 'Yuette Galang'),
(15, 'Physics', 110, 'Colton Rather'),
(16, 'Chemistry', 400, 'Nan Mongeau');

-- Table student
drop table if exists student;
create table student (
    student_id int primary key,
    student_name varchar(50),
    city varchar(50),
    subject_id int
);

insert into student (student_id, student_name, city, subject_id) values
(2001, 'Thurman Thorn', 'New York', 11),
(2002, 'Sharda Clemens', 'San Francisco', 12),
(2003, 'Buck Elkins', 'New York', 13),
(2004, 'Fabian Johns', 'Boston', 15),
(2005, 'Brad Cameron', 'Stanford', 11),
(2006, 'Sofia Roles', 'Boston', 16),
(2007, 'Rory Pietila', 'New Haven', 14);

select st.student_name, su.subject_name, su.lecturer, su.max_score
from student st
join subject su on su.subject_id = st.subject_id
where su.subject_name not like 'Computer Science'
and su.max_score not between 100 and 200;

-- Ex. 6
-- Write a query that lists courses’ subject names and the number of students
-- taking the course only if the course has three or more students enrolled

-- Table subject
drop table if exists subject;
create table subject (
    subject_id int primary key,
    subject_name varchar(50),
    max_score int,
    lecturer varchar(50)
);

insert into subject (subject_id, subject_name, max_score, lecturer) values
(11, 'Math', 130, 'Christena Solem'),
(12, 'Computer Science', 50, 'Jaime Pille'),
(13, 'Biology', 300, 'Carrol Denmark'),
(14, 'Geography', 220, 'Yuette Galang'),
(15, 'Physics', 110, 'Colton Rather'),
(16, 'Chemistry', 400, 'Nan Mongeau');

-- Table student
drop table if exists student;
create table student (
    student_id int primary key,
    student_name varchar(50),
    city varchar(50),
    subject_id int
);

insert into student (student_id, student_name, city, subject_id) values
(2001, 'Thurman Thorn', 'New York', 11),
(2002, 'Sharda Clemens', 'San Francisco', 12),
(2003, 'Buck Elkins', 'New York', 13),
(2004, 'Fabian Johns', 'Boston', 15),
(2005, 'Brad Cameron', 'Stanford', 11),
(2006, 'Sofia Roles', 'Boston', 16),
(2007, 'Rory Pietila', 'New Haven', 12),
(2008, 'Cicely Weish', 'Tulsa', 14),
(2011, 'Richard Curtin', 'Boston', 11),
(2012, 'Kassy Ledger', 'Stanford', 11),
(2013, 'Henry Ledger', 'Miami', 13),
(2014, 'Darius Fidzberg', 'San Francisco', 12),
(2015, 'Darcey Fiorillo', 'Chicago', 14);

select su.subject_name, count(st.subject_id) students_count
from subject su
left join student st on su.subject_id = st.subject_id
group by su.subject_name
having count(st.subject_id) >= 3;

-- Ex. 7
-- Write a query that displays the average age of workers in each company.
-- The result should show the name of the company and the age of the
-- company’s youngest worker.

-- Table company
drop table if exists company;
create table company (
    id int primary key,
    name varchar(255)
);

insert into company (id, name) values
(1, 'Amazon'),
(2, 'Samsung'),
(3, 'LG'),
(4, 'Kia'),
(5, 'Lenovo');

-- Table workers
drop table if exists workers;
create table workers (
    id int primary key,
    name varchar(255),
    age int,
    company_id int
);

insert into workers (id, name, age, company_id) values
(1, 'Derick Davison', 20, 5),
(2, 'Bari Becnel', 50, 1),
(3, 'Maddie Mueller', 33, 2),
(4, 'Eva Emrich', 23, 1),
(5, 'Katelyn Kunze', 55, 3),
(6, 'Hue Hover', 26, 2),
(7, 'Lucas Lout', 57, 4),
(8, 'Granville Grande', 30, 5),
(9, 'Robt Rude', 39, 3),
(10, 'Lisha Lewin', 25, 4),
(11, 'Aron Atlas', 52, 3),
(12, 'Chester Coddington', 44, 4),
(13, 'Diedre Dominy', 31, 1),
(14, 'Evie Edgell', 35, 2),
(15, 'Judy Johanson', 36, 5);

select c.name, avg(w.age) average, min(w.age) min_age
from company c
left join workers w on c.id = w.company_id
group by c.name;
