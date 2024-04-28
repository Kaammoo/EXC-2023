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


