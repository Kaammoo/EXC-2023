SELECT p.name AS "Patient name", p.phone_number AS "Patient phone number"
FROM Patient p
LEFT JOIN Prescription pr ON pr.patient_id = p.id
WHERE pr.patient_id IS NULL;

SELECT d.name AS "Doctor name", d.phone_number AS "Doctor phone number"
FROM Doctor d
LEFT JOIN Appointment a ON a.doctor_id = d.id
WHERE a.doctor_id IS NULL;

SELECT d.name AS "Doctor name", a.date AS "Appointment date", p.name AS "Patient name"
FROM Doctor d
LEFT JOIN Appointment a ON a.doctor_id = d.id
LEFT JOIN Patient p ON p.id = a.patient_id;

SELECT r.id AS "Room id", p.name AS "Patient name"
FROM Room r
LEFT JOIN Patient p ON r.patient_id = p.id;

SELECT p.name AS "Patient name", SUM(pr.prescription_cost) AS "Prescription total cost"
FROM Patient p
LEFT JOIN Prescription pr ON pr.patient_id = p.id
GROUP BY p.name;

SELECT d.name AS "Department name"
FROM Department d
LEFT JOIN Staff s ON s.department_id = d.id
WHERE s.department_id IS NULL;

SELECT p.name AS "Patient name", AVG(DATEDIFF(NOW(), r.admission_date)) AS "Average time"
FROM Patient p
LEFT JOIN Room r ON r.patient_id = p.id
GROUP BY p.name;

SELECT ph.name AS "Pharmacy name", ph.address AS "Pharmacy address"
FROM Pharmacy ph
RIGHT JOIN Patient p ON p.pharmacy_id = ph.id
RIGHT JOIN Prescription pr ON pr.patient_id = p.id
WHERE pr.patient_id IS NULL;

SELECT p.name AS "Patient name", p.phone_number AS "Patient phone number", COUNT(pr.patient_id) AS Count_of_prescription
FROM Patient p
LEFT JOIN Prescription pr ON p.id = pr.patient_id
GROUP BY p.id
HAVING Count_of_prescription >= 2;

SELECT p.name AS "Patient name", p.phone_number AS "Patient phone number", a.date AS "Appointment date"
FROM Patient p
LEFT JOIN Appointment a ON a.patient_id = p.id
LEFT JOIN Prescription pr ON pr.patient_id = p.id
WHERE a.date IS NOT NULL AND pr.id IS NULL;

