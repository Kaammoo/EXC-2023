-- 1. Find over-the-counter patient names and phone numbers.
SELECT p.name, p.phone_number
FROM Patient p
JOIN Prescription pre ON p.id = pre.patient_id
WHERE pre.medication_type = 'Over-the-counter';

-- 2. Find the names and phone numbers of doctors who do not have scheduled appointments.
SELECT d.name, d.phone_number
FROM Doctor d
LEFT JOIN Appointment a ON d.id = a.doctor_id
WHERE a.doctor_id IS NULL;

-- 3. Find a list of doctors along with their scheduled appointments. Include the doctor's name, date of appointment, and patient's name. If the doctor has no appointments, include them in the result with NULL values for appointment details.
SELECT d.name AS doctor_name, a.date AS appointment_date, p.name AS patient_name
FROM Doctor d
LEFT JOIN Appointment a ON d.id = a.doctor_id
LEFT JOIN Patient p ON a.patient_id = p.id;

-- 4. Find ward IDs and patient names currently occupying them.
SELECT r.id AS ward_id, p.name AS patient_name
FROM Room r
JOIN Patient p ON r.patient_id = p.id;

-- 5. Find the total cost of prescriptions for each patient, including their name and total cost.
SELECT p.name AS patient_name, SUM(pre.prescription_cost) AS total_cost
FROM Patient p
JOIN Prescription pre ON p.id = pre.patient_id
GROUP BY p.id;

-- 6. Find departments that don't have staff assigned to them.
SELECT d.name AS department_name
FROM Department d
LEFT JOIN Staff s ON d.id = s.department_id
WHERE s.id IS NULL;

-- 7. Find the average duration of room occupancy for all patients.
SELECT AVG(DATEDIFF(CURRENT_DATE(), r.admission_date)) AS avg_occupancy_duration
FROM Room r;

-- 8. Find the names and addresses of pharmacies that have not received prescriptions.
SELECT ph.name AS pharmacy_name, ph.address AS pharmacy_address
FROM Pharmacy ph
LEFT JOIN Prescription pre ON ph.id = pre.pharmacy_id
WHERE pre.id IS NULL;

-- 9. Find the names and phone numbers of patients who have been prescribed multiple medications, as well as the number of prescriptions.
SELECT p.name, p.phone_number, COUNT(pre.id) AS num_prescriptions
FROM Patient p
JOIN Prescription pre ON p.id = pre.patient_id
GROUP BY p.id
HAVING COUNT(pre.id) > 1;

-- 10. Find patients who have appointments but do not have any prescriptions. Include their names, phone numbers, and appointment dates.
SELECT p.name, p.phone_number, a.date AS appointment_date
FROM Patient p
JOIN Appointment a ON p.id = a.patient_id
LEFT JOIN Prescription pre ON p.id = pre.patient_id
WHERE pre.id IS NULL;

