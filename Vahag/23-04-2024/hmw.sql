use Hospital;

create table Hospital (
    id int auto_increment primary key,
    name varchar(20),
    address varchar(20),
    phone_number varchar(20)
);

create table Pharmacy (
    id int auto_increment primary key,
    name varchar(20),
    address varchar(20),
    phone_number varchar(20)
);

create table Patient (
    id int auto_increment primary key,
    name varchar(20),
    phone_number varchar(20),
    address varchar(20),
    date_of_birth date,
    pharmacy_id int,
    foreign key (pharmacy_id) references Pharmacy(id)
);

create table Department (
    id int auto_increment primary key,
    name varchar(20),
    hospital_id int,
    foreign key (hospital_id) references Hospital(id)
);

create table Doctor (
    id int auto_increment primary key,
    name varchar(20),
    specialization varchar(20),
    department_id int,
    phone_number varchar(20),
    foreign key (department_id) references Department(id)
);

create table Appoinment (
    patient_id int,
    doctor_id int,
    date date,
    foreign key (patient_id) references Patient(id),
    foreign key (doctor_id) references Doctor(id)
);

create table Staff (
    id int auto_increment primary key,
    name varchar(20),
    job_title varchar(20),
    department_id int,
    phone_number varchar(20),
    foreign key (department_id) references Department(id)
);

create table Room (
    id int auto_increment primary key,
    patient_id int,
    staff_id int,
    admission_date date,
    foreign key (staff_id) references Staff(id)
);

create table Prescription (
    id int auto_increment primary key,
    patient_id int,
    medication_name varchar(20),
    prescription_date date,
    prescription_cost int,
    foreign key (patient_id) references Patient(id)
);

create table Invoice (
    id int auto_increment primary key,
    patient_id int,
    description varchar(50),
    cost int,
    total int,
    foreign key (patient_id) references Patient(id)
);

-- Inserting data into the Hospital table
INSERT INTO Hospital (name, address, phone_number) VALUES
('General Hospital', '123 Main St', '123-456-7890'),
('City Hospital', '456 Oak St', '987-654-3210');

-- Inserting data into the Pharmacy table
INSERT INTO Pharmacy (name, address, phone_number) VALUES
('Pharmacy A', '789 Elm St', '456-789-0123'),
('Pharmacy B', '101 Pine St', '321-654-0987');

-- Inserting data into the Patient table
INSERT INTO Patient (name, phone_number, address, date_of_birth, pharmacy_id) VALUES
('John Doe', '111-222-3333', '456 Maple St', '1990-05-15', 1),
('Jane Smith', '444-555-6666', '789 Cedar St', '1985-10-20', 2);

-- Inserting data into the Department table
INSERT INTO Department (name, hospital_id) VALUES
('Cardiology', 1),
('Orthopedics', 1),
('Pediatrics', 2);

-- Inserting data into the Doctor table
INSERT INTO Doctor (name, specialization, department_id, phone_number) VALUES
('Dr. Johnson', 'Cardiologist', 1, '555-111-2222'),
('Dr. Patel', 'Orthopedic Surgeon', 2, '555-333-4444'),
('Dr. Lee', 'Pediatrician', 3, '555-555-6666');

-- Inserting data into the Appointment table
INSERT INTO Appointment (patient_id, doctor_id, date) VALUES
(1, 1, '2024-05-01'),
(2, 3, '2024-05-02');

-- Inserting data into the Staff table
INSERT INTO Staff (name, job_title, department_id, phone_number) VALUES
('Nurse Johnson', 'Cardiology Nurse', 1, '555-777-8888'),
('Nurse Smith', 'Pediatrics Nurse', 3, '555-999-0000');

-- Inserting data into the Room table
INSERT INTO Room (patient_id, staff_id, admission_date) VALUES
(1, 1, '2024-05-01'),
(2, 2, '2024-05-02');

-- Inserting data into the Prescription table
INSERT INTO Prescription (patient_id, medication_name, prescription_date, prescription_cost) VALUES
(1, 'Aspirin', '2024-05-01', 10),
(2, 'Amoxicillin', '2024-05-02', 20);

-- Inserting data into the Invoice table
INSERT INTO Invoice (patient_id, description, cost, total) VALUES
(1, 'Doctor Visit', 100, 100),
(2, 'Doctor Visit', 150, 150);