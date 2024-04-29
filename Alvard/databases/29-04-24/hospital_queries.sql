-- Task 1: Choose the address and name of the hospital, the name of the department, the name of the doctor, and the name of the patient who underwent a specific operation
SELECT h.address, h.name AS hospital_name, d.name AS department_name, doc.name AS doctor_name, p.name AS patient_name
FROM Hospital h
JOIN Department d ON h.id = d.hospital_id
JOIN Doctor doc ON d.id = doc.department_id
JOIN Appointment a ON doc.id = a.doctor_id
JOIN Patient p ON a.patient_id = p.id
JOIN Invoice i ON p.id = i.patient_id
WHERE i.description = 'heart surgery';

-- Task 2: Select the name, surname, and phone number of the patients who have an appointment for the given month
SELECT p.name, p.phone_number
FROM Patient p
JOIN Appointment a ON p.id = a.patient_id
WHERE MONTH(a.date) = 5; -- Assuming May is the given month

-- Task 3: Choose the names and surnames of doctors appointed for each department
SELECT d.name AS department_name, doc.name AS doctor_name
FROM Department d
JOIN Doctor doc ON d.id = doc.department_id;

-- Task 4: Select the personal information and name of the pharmacy for patients whose prescriptions cost $500 or more
SELECT p.*, ph.name AS pharmacy_name
FROM Patient p
JOIN Prescription pre ON p.id = pre.patient_id
JOIN Pharmacy ph ON p.pharmacy_id = ph.id
WHERE pre.prescription_cost >= 500;

