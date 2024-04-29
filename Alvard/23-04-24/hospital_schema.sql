Table Hospital {
  id INT [pk]
  name VARCHAR
  address VARCHAR
  phone_number VARCHAR
}

Table Department {
  id INT [pk]
  name VARCHAR
  hospital_id INT [ref: > Hospital.id]
}

Table Doctor {
  id INT [pk]
  name VARCHAR
  specialization VARCHAR
  department_id INT [ref: > Department.id]
  phone_number VARCHAR
}

Table Staff {
  id INT [pk]
  name VARCHAR
  job_title VARCHAR
  department_id INT [ref: > Department.id]
  phone_number VARCHAR
}

Table Patient {
  id INT [pk]
  name VARCHAR
  phone_number VARCHAR
  address VARCHAR
  date_of_birth DATE
  pharmacy_id INT [ref: > Pharmacy.id]
}

Table Room {
  id INT [pk]
  patient_id INT [ref: > Patient.id]
  staff_id INT [ref: > Staff.id]
  admission_date DATE
}

Table Prescription {
  id INT [pk]
  patient_id INT [ref: > Patient.id]
  medication_name VARCHAR
  prescription_date DATE
  prescription_cost DECIMAL
}

Table Invoice {
  id INT [pk]
  patient_id INT [ref: > Patient.id]
  description TEXT
  cost DECIMAL
  total DECIMAL
}

Table Appointment {
  patient_id INT [ref: > Patient.id]
  doctor_id INT [ref: > Doctor.id]
  date DATE
}

Table Pharmacy {
  id INT [pk]
  name VARCHAR
  address VARCHAR
  phone_number VARCHAR
}

