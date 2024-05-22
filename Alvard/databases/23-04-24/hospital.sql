CREATE TABLE Hospital (
  id INT PRIMARY KEY,
  name VARCHAR(255),
  address VARCHAR(255),
  phone_number VARCHAR(20)
);

CREATE TABLE Department (
  id INT PRIMARY KEY,
  name VARCHAR(255),
  hospital_id INT,
  FOREIGN KEY (hospital_id) REFERENCES Hospital(id)
);

CREATE TABLE Doctor (
  id INT PRIMARY KEY,
  name VARCHAR(255),
  specialization VARCHAR(255),
  department_id INT,
  phone_number VARCHAR(20),
  FOREIGN KEY (department_id) REFERENCES Department(id)
);

CREATE TABLE Staff (
  id INT PRIMARY KEY,
  name VARCHAR(255),
  job_title VARCHAR(255),
  department_id INT,
  phone_number VARCHAR(20),
  FOREIGN KEY (department_id) REFERENCES Department(id)
);

CREATE TABLE Patient (
  id INT PRIMARY KEY,
  name VARCHAR(255),
  phone_number VARCHAR(20),
  address VARCHAR(255),
  date_of_birth DATE,
  pharmacy_id INT,
  FOREIGN KEY (pharmacy_id) REFERENCES Pharmacy(id)
);

CREATE TABLE Room (
  id INT PRIMARY KEY,
  patient_id INT,
  staff_id INT,
  admission_date DATE,
  FOREIGN KEY (patient_id) REFERENCES Patient(id),
  FOREIGN KEY (staff_id) REFERENCES Staff(id)
);

CREATE TABLE Prescription (
  id INT PRIMARY KEY,
  patient_id INT,
  medication_name VARCHAR(255),
  prescription_date DATE,
  prescription_cost DECIMAL(10, 2),
  FOREIGN KEY (patient_id) REFERENCES Patient(id)
);

CREATE TABLE Invoice (
  id INT PRIMARY KEY,
  patient_id INT,
  description TEXT,
  cost DECIMAL(10, 2),
  total DECIMAL(10, 2),
  FOREIGN KEY (patient_id) REFERENCES Patient(id)
);

CREATE TABLE Appointment (
  patient_id INT,
  doctor_id INT,
  date DATE,
  FOREIGN KEY (patient_id) REFERENCES Patient(id),
  FOREIGN KEY (doctor_id) REFERENCES Doctor(id)
);

CREATE TABLE Pharmacy (
  id INT PRIMARY KEY,
  name VARCHAR(255),
  address VARCHAR(255),
  phone_number VARCHAR(20)
);

INSERT INTO Hospital (id, name, address, phone_number) VALUES
(1, 'Hospital A', '123 Main Street', '123-456-7890'),
(2, 'Hospital B', '456 Oak Avenue', '456-789-0123'),
(3, 'Hospital C', '789 Elm Street', '789-012-3456'),
(4, 'Hospital D', '321 Maple Road', '321-654-9870'),
(5, 'Hospital E', '654 Pine Boulevard', '654-987-0123');

INSERT INTO Department (id, name, hospital_id) VALUES
(1, 'Department A', 1),
(2, 'Department B', 1),
(3, 'Department C', 2),
(4, 'Department D', 3),
(5, 'Department E', 3);

INSERT INTO Doctor (id, name, specialization, department_id, phone_number) VALUES
(1, 'Dr. Smith', 'Cardiology', 1, '111-111-1111'),
(2, 'Dr. Johnson', 'Orthopedics', 2, '222-222-2222'),
(3, 'Dr. Williams', 'Pediatrics', 3, '333-333-3333'),
(4, 'Dr. Brown', 'Surgery', 4, '444-444-4444'),
(5, 'Dr. Davis', 'Oncology', 5, '555-555-5555');

INSERT INTO Staff (id, name, job_title, department_id, phone_number) VALUES
(1, 'John Doe', 'Nurse', 1, '111-222-3333'),
(2, 'Jane Smith', 'Nurse', 1, '222-333-4444'),
(3, 'Emily Johnson', 'Nurse', 2, '333-444-5555'),
(4, 'Michael Williams', 'Nurse', 3, '444-555-6666'),
(5, 'Sarah Brown', 'Nurse', 4, '555-666-7777');

INSERT INTO Patient (id, name, phone_number, address, date_of_birth, pharmacy_id) VALUES
(1, 'Alice', '111-222-3333', '123 Elm Street', '1990-01-01', 1),
(2, 'Bob', '222-333-4444', '456 Oak Avenue', '1985-05-05', 2),
(3, 'Charlie', '333-444-5555', '789 Maple Road', '1978-10-10', 3),
(4, 'David', '444-555-6666', '321 Pine Boulevard', '1995-03-15', 4),
(5, 'Eve', '555-666-7777', '654 Cedar Lane', '1982-12-20', 5);

INSERT INTO Room (id, patient_id, staff_id, admission_date) VALUES
(1, 1, 1, '2024-04-29'),
(2, 2, 2, '2024-04-29'),
(3, 3, 3, '2024-04-29'),
(4, 4, 4, '2024-04-29'),
(5, 5, 5, '2024-04-29');

INSERT INTO Prescription (id, patient_id, medication_name, prescription_date, prescription_cost) VALUES
(1, 1, 'Medication A', '2024-04-29', 50.00),
(2, 2, 'Medication B', '2024-04-29', 60.00),
(3, 3, 'Medication C', '2024-04-29', 70.00),
(4, 4, 'Medication D', '2024-04-29', 80.00),
(5, 5, 'Medication E', '2024-04-29', 90.00);

INSERT INTO Invoice (id, patient_id, description, cost, total) VALUES
(1, 1, 'Hospital Charges', 500.00, 500.00),
(2, 2, 'Hospital Charges', 600.00, 600.00),
(3, 3, 'Hospital Charges', 700.00, 700.00),
(4, 4, 'Hospital Charges', 800.00, 800.00),
(5, 5, 'Hospital Charges', 900.00, 900.00);

INSERT INTO Appointment (patient_id, doctor_id, date) VALUES
(1, 1, '2024-05-01'),
(2, 2, '2024-05-02'),
(3, 3, '2024-05-03'),
(4, 4, '2024-05-04'),
(5, 5, '2024-05-05');

INSERT INTO Pharmacy (id, name, address, phone_number) VALUES
(1, 'Pharmacy A', '123 Main Street', '111-222-3333'),
(2, 'Pharmacy B', '456 Oak Avenue', '222-333-4444'),
(3, 'Pharmacy C', '789 Maple Road', '333-444-5555'),
(4, 'Pharmacy D', '321 Pine Boulevard', '444-555-6666'),
(5, 'Pharmacy E', '654 Cedar Lane', '555-666-7777');


SELECT * FROM Hospital
INNER JOIN Department ON Hospital.id = Department.hospital_id
INNER JOIN Doctor ON Department.id = Doctor.department_id;

SELECT * FROM Hospital
LEFT JOIN Department ON Hospital.id = Department.hospital_id
LEFT JOIN Doctor ON Department.id = Doctor.department_id;

SELECT * FROM Hospital
RIGHT JOIN Department ON Hospital.id = Department.hospital_id
RIGHT JOIN Doctor ON Department.id = Doctor.department_id;
