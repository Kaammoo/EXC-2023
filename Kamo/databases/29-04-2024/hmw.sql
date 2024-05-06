USE Hospital;

SELECT h.address "Hospital address", h.name "Hospital name",
d.name "Department name", dc.name "Doctor name",
p.name "Patient name"
FROM Hospital h 
INNER JOIN Department d ON h.id = d.hospital_id
INNER JOIN Doctor dc ON dc.id = d.id
INNER JOIN Appointment a ON a.doctor_id = dc.id
INNER JOIN Patient p ON a.patient_id = p.id
INNER JOIN Invoice inv ON inv.patient_id = p.id
WHERE inv.description = 'Medication Cost';

SELECT p.name, p.phone_number FROM Patient p
INNER JOIN Prescription pr ON p.id = pr.patient_id
WHERE MONTH(pr.prescription_date) = MONTH(NOW());

SELECT d.name doctor_name FROM Doctor d
INNER JOIN Department dep ON dep.id = d.department_id
WHERE dep.name = 'Cardiology';

SELECT dep.name department_name, d.name doctor_name FROM Department dep
LEFT JOIN Doctor d ON dep.id = d.department_id;

SELECT p.name "Patient name", p.phone_number "Ptient phone",
p.address "Patient address", p.date_of_birth "atient Date of birth",
p.pharmacy_id "pharmacy id", ph.name "Pharmacy name"
FROM Patient p
INNER JOIN Pharmacy phar ON phar.id = p.pharmacy_id
INNER JOIN Invoice inv ON inv.patient_id = p.id
WHERE inv.cost >= 500;
