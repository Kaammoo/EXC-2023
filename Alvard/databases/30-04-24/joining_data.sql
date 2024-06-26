-- Create Employees table
CREATE TABLE IF NOT EXISTS employee (
    id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    salary DECIMAL(10, 2),
    manager_id INT
);

-- Create Salgrade table
CREATE TABLE IF NOT EXISTS salgrade (
    grade INT PRIMARY KEY,
    lower_limit DECIMAL(10, 2),
    upper_limit DECIMAL(10, 2)
);

-- Create Benefits table
CREATE TABLE IF NOT EXISTS benefits (
    salary_req DECIMAL(10, 2),
    benefit_name VARCHAR(100)
);

-- Select salary estimates for all employees
SELECT * FROM employee;

-- Select all benefits received by employee with sequence number 5 id. Select the employee's first and last name and benefit names
SELECT e.first_name, e.last_name, b.benefit_name
FROM employee e
JOIN benefits b ON e.salary >= b.salary_req
WHERE e.id = 5;

-- Select each employee's first name, last name, salary, and their manager's first and last name in the same row. Select only employees who have a manager.
SELECT e1.first_name AS employee_first_name, e1.last_name AS employee_last_name, e1.salary,
       e2.first_name AS manager_first_name, e2.last_name AS manager_last_name
FROM employee e1
JOIN employee e2 ON e1.manager_id = e2.id;

-- Select the number of employees for each benefit. Display two columns: benefit_name and count (name of that column: staff_count). The list should not include those benefits that are not received by anyone.
SELECT b.benefit_name, COUNT(*) AS staff_count
FROM employee e
JOIN benefits b ON e.salary >= b.salary_req
GROUP BY b.benefit_name;

-- For each benefit, select the number of employees who received that benefit. Display two columns: benefit_name and count (name of that column: staff_count). If there are benefits that are not received by any employee, the amount should be 0.
SELECT b.benefit_name, COALESCE(COUNT(*), 0) AS staff_count
FROM benefits b
LEFT JOIN employee e ON e.salary >= b.salary_req
GROUP BY b.benefit_name;

