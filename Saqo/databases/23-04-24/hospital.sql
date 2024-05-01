drop table if exists Appointment;
drop table if exists Invoice;
drop table if exists Prescription;
drop table if exists Room;
drop table if exists Patient;
drop table if exists Pharmacy;
drop table if exists Staff;
drop table if exists Doctor;
drop table if exists Department;
drop table if exists Hospital;

create table Hospital (
    id int auto_increment primary key,
    name varchar(30),
    address varchar(30),
    phone_number varchar(10)
);

create table Department (
    id int auto_increment primary key,
    name varchar(30),
    hospital_id int,
    foreign key(hospital_id) references Hospital(id) 
);

create table Doctor (
    id int auto_increment primary key,
    name varchar(20),
    specialization varchar(15),
    department_id int,
    foreign key(department_id) references Department(id),
    phone_number varchar(10)
);

create table Staff (
    id int auto_increment primary key,
    name varchar(20),
    job_title varchar(30),
    department_id int,                                                          
    foreign key(department_id) references Department(id),
    phone_number varchar(10)
);

create table Pharmacy (
    id int auto_increment primary key,                                          
    name varchar(30),                                                           
    address varchar(30),                                                        
    phone_number varchar(10)
);

create table Patient (
    id int auto_increment primary key,
    name varchar(15),
    phone_number varchar(10),
    address varchar(30),
    date_of_birth date,
    pharmacy_id int,
    foreign key(pharmacy_id) references Pharmacy(id)
);

create table Room (
    id int auto_increment primary key,
    patient_id int,
    foreign key(patient_id) references Patient(id),
    staff_id int,
    foreign key(staff_id) references Staff(id),
    admission_date date
);

create table Prescription (
    id int auto_increment primary key,
    patient_id int,
    foreign key(patient_id) references Patient(id),
    medication_name varchar(20),
    prescription_date date,
    prescription_cost int
);

create table Invoice (
    id int auto_increment primary key,
    patient_id int,
    foreign key(patient_id) references Patient(id),
    description varchar(30),
    cost int,
    total int
);

create table Appointment (
    patient_id int,
    foreign key(patient_id) references Patient(id),
    doctor_id int,
    foreign key(doctor_id) references Doctor(id),
    date date
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
(1, 'Medicine X', '2024-04-20', 450),
(2, 'Medicine Y', '2024-04-21', 750);

INSERT INTO Invoice (patient_id, description, cost, total) VALUES
(1, 'Consultation Fee', 450, 100),
(2, 'Medication Cost', 750, 75);

INSERT INTO Appointment (patient_id, doctor_id, date) VALUES
(1, 1, '2024-04-25'),
(2, 2, '2024-04-26');

