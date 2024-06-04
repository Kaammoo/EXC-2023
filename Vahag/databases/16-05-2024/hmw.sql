-- 1. Write an SQL query that displays the current date.
SELECT CURDATE() AS Date;

/*
+------------+
| Date       |
+------------+
| 2024-05-18 |
+------------+
1 row in set (0.00 sec)
*/

-- 2. Write an SQL query that checks whether a date (1/04/12) passed to the query is in a given format (MM/YY/DD).
SELECT 
    CASE 
        WHEN '1/04/12' LIKE '[0-1]?[0-9]/[0-9]{2}/[0-3]?[0-9]' 
        THEN 'Valid' 
        ELSE 'Invalid' 
    END AS Date_format_check;

/* 
+-------------------+
| Date_format_check |
+-------------------+
| Invalid           |
+-------------------+
1 row in set (0.01 sec)
*/

-- 3. Write an SQL query to find duplicate rows in two tables (EMPLOYEE and WORKERS), and then write a query to delete the duplicates.
CREATE TABLE employee(
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50),
    email VARCHAR(50)
);

CREATE TABLE workers(
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50),
    email VARCHAR(50)
);

INSERT INTO employee (name, email) VALUES
('John Doe', 'john.doe@example.com'),
('Jane Smith', 'jane.smith@example.com'),
('Emily Davis', 'emily.davis@example.com'),
('Michael Brown', 'michael.brown@example.com'),
('Chris Johnson', 'chris.johnson@example.com'),
('Patricia Lee', 'patricia.lee@example.com'),
('Robert Wilson', 'robert.wilson@example.com');

INSERT INTO workers (name, email) VALUES
('John Doe', 'john.doe@example.com'),
('Jane Smith', 'jane.smith@example.com'),
('Samuel Green', 'samuel.green@example.com'),
('Emily Davis', 'emily.davis@example.com'),
('Laura White', 'laura.white@example.com'),
('Michael Brown', 'michael.brown@example.com'),
('Chris Johnson', 'chris.johnson@example.com');

SELECT e.id, e.name, e.email
FROM employee e
INNER JOIN workers w ON e.name = w.name AND e.email = w.email;

/*
+----+---------------+---------------------------+
| id | name          | email                     |
+----+---------------+---------------------------+
|  1 | John Doe      | john.doe@example.com      |
|  2 | Jane Smith    | jane.smith@example.com    |
|  3 | Emily Davis   | emily.davis@example.com   |
|  4 | Michael Brown | michael.brown@example.com |
|  5 | Chris Johnson | chris.johnson@example.com |
+----+---------------+---------------------------+
5 rows in set (0.00 sec)
*/

DELETE e
FROM employee e
INNER JOIN workers w ON e.name = w.name AND e.email = w.email;

/* 
mysql> DELETE e
    -> FROM employee e
    -> INNER JOIN workers w ON e.name = w.name AND e.email = w.email;
Query OK, 5 rows affected (0.01 sec)

mysql> SELECT * FROM employee;
+----+---------------+---------------------------+
| id | name          | email                     |
+----+---------------+---------------------------+
|  6 | Patricia Lee  | patricia.lee@example.com  |
|  7 | Robert Wilson | robert.wilson@example.com |
+----+---------------+---------------------------+
2 rows in set (0.00 sec)
*/

-- 4. Write an SQL statement that lists school names, student names, and their cities only if the school and the student are in the same city and the student is not from New York.
CREATE TABLE school(
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50),
    city VARCHAR(50)
);

CREATE TABLE student(
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50),
    city VARCHAR(50),
    school_id INT,
    FOREIGN KEY (school_id) REFERENCES school(id)
);

INSERT INTO school(name, city) VALUES
('Stanford', 'Stanford'),
('University of Cali', 'San Francisco'),
('Harvard University', 'New York'),
('MIT', 'Boston'),
('Yale', 'New Haven');

INSERT INTO student(id, name, city, school_id) VALUES
(1001, 'Peter Brebec', 'New York', 1),
(1002, 'John Goorgy', 'San Francisco', 2),
(2003, 'Brad Smith', 'New York', 3),
(1004, 'Fabian Johns', 'Boston', 5),
(1005, 'Brad Cameron', 'Stanford', 1),
(1006, 'Geoff Firby', 'Boston', 5),
(1007, 'Johnny Blue', 'New Haven', 2),
(1008, 'Johse Brook', 'Miami', 2);

SELECT sc.name AS School_name,
    st.name AS Student_name,
    st.city AS City
FROM student st
INNER JOIN school sc ON st.school_id = sc.id AND st.city = sc.city
WHERE st.city <> 'New York';

/* 
+--------------------+--------------+---------------+
| School_name        | Student_name | City          |
+--------------------+--------------+---------------+
| Stanford           | Brad Cameron | Stanford      |
| University of Cali | John Goorgy  | San Francisco |
+--------------------+--------------+---------------+
2 rows in set (0.00 sec)
*/

-- 5. Write an SQL statement that lists student names, subject names, subject lecturers, and the max amount of points for all subjects except Computer Science and any subjects with a max score between 100 and 200.
CREATE TABLE subject(
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50),
    max_score INT,
    lecturer VARCHAR(50)
);

DROP TABLE student;

CREATE TABLE student(
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50),
    city VARCHAR(50),
    subject_id INT,
    FOREIGN KEY (subject_id) REFERENCES subject(id)
);

INSERT INTO subject (id, name, max_score, lecturer) VALUES
(11, 'Math', 130, 'Christena Solem'),
(12, 'Computer Science', 150, 'Jaime Pille'),
(13, 'Biology', 300, 'Carrol Denmark'),
(14, 'Geography', 220, 'Yuette Galang'),
(15, 'Physics', 110, 'Colton Rather'),
(16, 'Chemistry', 400, 'Nan Mongeau');

INSERT INTO student(id, name, city, subject_id) VALUES
(2001, 'Thurman Thorn', 'New York', 11),
(2002, 'Sharda Clemens', 'San Francisco', 12),
(2003, 'Buck Elkins', 'New York', 13),
(2004, 'Fabian Johns', 'Boston', 15),
(2005, 'Brad Cameron', 'Stanford', 11),
(2006, 'Sofia Roles', 'Boston', 16),
(2007, 'Rory Pietila', 'New Haven', 12);

SELECT st.name AS Student_name,
        sb.name AS Subject_name,
        sb.lecturer AS Lecturers,
        sb.max_score AS max_score
FROM student st
INNER JOIN subject sb ON st.subject_id = sb.id
WHERE sb.name <> 'Computer Science' AND sb.max_score NOT BETWEEN 100 AND 200;

/*
+--------------+--------------+----------------+-----------+
| Student_name | Subject_name | Lecturers      | max_score |
+--------------+--------------+----------------+-----------+
| Buck Elkins  | Biology      | Carrol Denmark |       300 |
| Sofia Roles  | Chemistry    | Nan Mongeau    |       400 |
+--------------+--------------+----------------+-----------+
2 rows in set (0.00 sec)
*/

-- 6. Write a query that lists courses’ subject names and the number of students taking the course only if the course has three or more students enrolled
INSERT INTO student(id, name, city, subject_id) VALUES
(2008, 'Cicely Weish', 'Tulsa', 14),
(2011, 'Richard Curtin', 'Boston', 11),
(2012, 'Kassy Ledger', 'Stanford', 11),
(2013, 'Henry Ledger', 'Miami', 13),
(2014, 'Darius Fidzberg', 'San Francisco', 12),
(2015, 'Darcey Fiorillo', 'Chicago', 14);

SELECT sb.name AS Subject_name,
        COUNT(st.id) AS Number_of_students
FROM subject sb
INNER JOIN student st ON sb.id = st.subject_id
GROUP BY Subject_name
HAVING Number_of_students >= 3;

/*
+------------------+--------------------+
| Subject_name     | Number_of_students |
+------------------+--------------------+
| Math             |                  4 |
| Computer Science |                  3 |
+------------------+--------------------+
2 rows in set (0.01 sec)
*/

-- 7. Write a query that displays the average age of workers in each company. The result should show the name of the company and the age of the company’s youngest worker.
CREATE TABLE company(
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50)
);

DROP TABLE workers;

CREATE TABLE workers(
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50),
    age INT,
    company_id INT,
    FOREIGN KEY (company_id) REFERENCES company(id)
);

INSERT INTO company(name) VALUES
('Amazon'),
('Samsung'),
('LG'),
('Kia'),
('Lenovo');

INSERT INTO workers(name, age, company_id) VALUES
('Derick Davison', 20, 5),
('Bari Becnel', 50, 1),
('Maddie Mueller', 33, 2),
('Eva Emrich', 23, 1),
('Katelyn Kunze', 55, 3),
('Hue Hover', 26, 2),
('Lucas Lout', 57, 4),
('Granville Grande', 30, 5),
('Robt Rude', 39, 3),
('Lisha Lewin', 25, 4),
('Aron Atlas', 52, 3),
('Chester Coddington', 44, 4),
('Diedre Dominy', 31, 1),
('Evie Edgell', 35, 2),
('Judy Johanson', 36, 5);

SELECT c.name AS Company_name,
        AVG(w.age) AS Workers_average_age,
        MIN(w.age) AS Youngest_worker_age
FROM company c
RIGHT JOIN workers w ON w.company_id = c.id
GROUP BY Company_name;

/*
+--------------+---------------------+---------------------+
| Company_name | Workers_average_age | Youngest_worker_age |
+--------------+---------------------+---------------------+
| Lenovo       |             28.6667 |                  20 |
| Amazon       |             34.6667 |                  23 |
| Samsung      |             31.3333 |                  26 |
| LG           |             48.6667 |                  39 |
| Kia          |             42.0000 |                  25 |
+--------------+---------------------+---------------------+
5 rows in set (0.00 sec)
*/