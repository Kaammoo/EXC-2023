-- Task 1: Choose the address and name of the hospital, the name of the department, the name of the doctor, and the name of the patient who underwent a specific operation
SELECT h.address AS "Hospital Address",
       h.name AS "Hospital Name",
       d.name AS "Department Name",
       doc.name AS "Doctor Name",
       p.name AS "Patient Name"
FROM Hospital h
JOIN Department d ON h.id = d.hospital_id
JOIN Doctor doc ON d.id = doc.department_id
JOIN Appointment a ON doc.id = a.doctor_id
JOIN Patient p ON a.patient_id = p.id
JOIN Invoice i ON p.id = i.patient_id
WHERE i.description = 'heart surgery';

-- Task 2: Select the name, surname, and phone number of the patients who have an appointment for the given month
SELECT p.name AS "Patient Name",
       p.surname AS "Patient Surname",
       p.phone_number AS "Patient Phone Number"
FROM Patient p
JOIN Appointment a ON p.id = a.patient_id
WHERE MONTH(a.date) = 5; -- Assuming May is the given month

-- Task 3: Choose the names and surnames of doctors appointed for each department
SELECT d.name AS "Department Name",
       doc.name AS "Doctor Name"
FROM Department d
JOIN Doctor doc ON d.id = doc.department_id;

-- Task 4: Select the personal information and name of the pharmacy for patients whose prescriptions cost $500 or more
SELECT p.name AS "Patient Name",
       p.phone_number AS "Patient Phone Number",
       p.address AS "Patient Address",
       p.date_of_birth AS "Patient Date of Birth",
       ph.name AS "Pharmacy Name"
FROM Patient p
JOIN Prescription pre ON p.id = pre.patient_id
JOIN Pharmacy ph ON p.pharmacy_id = ph.id
WHERE pre.prescription_cost >= 500;
