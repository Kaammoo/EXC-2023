CREATE DATABASE Hospital;

USE Hospital;

DROP TABLE IF EXISTS Hospital;
CREATE TABLE Hospital (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(30),
    address VARCHAR(30),
    phone_number VARCHAR(10)
);

DROP TABLE IF EXISTS Department;
CREATE TABLE Department (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(30),
    hospital_id INT,
    FOREIGN KEY(hospital_id) REFERENCES Hospital(id) 
);

DROP TABLE IF EXISTS Doctor;
CREATE TABLE Doctor (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(20),
    specialization VARCHAR(15),
    department_id INT,
    FOREIGN KEY(department_id) REFERENCES Department(id),
    phone_number VARCHAR(10)
);

DROP TABLE IF EXISTS Staff;
CREATE TABLE Staff (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(20),
    job_title VARCHAR(30),
    department_id INT,                                                          
    FOREIGN KEY(department_id) REFERENCES Department(id),
    phone_number VARCHAR(10)
);

DROP TABLE IF EXISTS Pharmacy;
CREATE TABLE Pharmacy (
    id INT AUTO_INCREMENT PRIMARY KEY,                                          
    name VARCHAR(30),                                                           
    address VARCHAR(30),                                                        
    phone_number VARCHAR(10)
);

DROP TABLE IF EXISTS Patient;
CREATE TABLE Patient (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(15),
    phone_number VARCHAR(10),
    address VARCHAR(30),
    date_of_birth DATE,
    pharmacy_id INT,
    FOREIGN KEY(pharmacy_id) REFERENCES Pharmacy(id)
);

DROP TABLE IF EXISTS Room;
CREATE TABLE Room (
    id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT,
    FOREIGN KEY(patient_id) REFERENCES Patient(id),
    staff_id INT,
    FOREIGN KEY(staff_id) REFERENCES Staff(id),
    admission_date DATE
);

DROP TABLE IF EXISTS Prescription;
CREATE TABLE Prescription (
    id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT,
    FOREIGN KEY(patient_id) REFERENCES Patient(id),
    medication_name VARCHAR(20),
    prescription_date DATE,
    prescription_cost INT
);

DROP TABLE IF EXISTS Invoice;
CREATE TABLE Invoice (
    id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT,
    FOREIGN KEY(patient_id) REFERENCES Patient(id),
    description VARCHAR(30),
    cost INT,
    total INT
);

DROP TABLE IF EXISTS Appointment;
CREATE TABLE Appointment (
    patient_id INT,
    FOREIGN KEY(patient_id) REFERENCES Patient(id),
    doctor_id INT,
    FOREIGN KEY(doctor_id) REFERENCES Doctor(id),
    date DATE
);

INSERT INTO Hospital (name, address, phone_number) VALUES
('Hospital A', '123 Main St', '1234567890'),
('Hospital B', '456 Elm St', '9876543210');

INSERT INTO Department (name, hospital_id) VALUES
('Cardiology', 1),
('Orthopedics', 1),
('Neurology', 2);

INSERT INTO Doctor (name, specialization, department_id, phone_number) VALUES
('Dr. Smith', 'Cardiologist', 1, '1111111111'),
('Dr. Johnson', 'Orthopedist', 2, '2222222222'),
('Dr. Lee', 'Neurologist', 3, '3333333333');

INSERT INTO Staff (name, job_title, department_id, phone_number) VALUES
('Nurse Jane', 'Registered Nurse', 1, '4444444444'),
('Receptionist Mary', 'Front Desk Clerk', 2, '5555555555'),
('Technician Bob', 'Lab Technician', 3, '6666666666');

INSERT INTO Pharmacy (name, address, phone_number) VALUES
('Pharmacy A', '789 Oak St', '7777777777'),
('Pharmacy B', '101 Pine St', '8888888888');

INSERT INTO Patient (name, phone_number, address, date_of_birth, pharmacy_id) VALUES
('John Doe', '9999999999', '456 Maple St', '1990-05-15', 1),
('Jane Smith', '1010101010', '789 Pine St', '1985-08-20', 2);

INSERT INTO Room (patient_id, staff_id, admission_date) VALUES
(1, 1, '2024-04-20'),
(2, 2, '2024-04-21');

INSERT INTO Prescription (patient_id, medication_name, prescription_date, prescription_cost) VALUES
(1, 'Medicine X', '2024-04-20', 50),
(2, 'Medicine Y', '2024-04-21', 75);

INSERT INTO Invoice (patient_id, description, cost, total) VALUES
(1, 'Consultation Fee', 100, 100),
(2, 'Medication Cost', 75, 75);

INSERT INTO Appointment (patient_id, doctor_id, date) VALUES
(1, 1, '2024-04-25'),
(2, 2, '2024-04-26');
