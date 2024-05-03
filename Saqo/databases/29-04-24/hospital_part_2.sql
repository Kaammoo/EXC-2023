select h.address "Hospital address", h.name "Hospital name",
d.name "Department name", dc.name "Doctor name",
p.name "Patient name"
from Hospital h 
inner join Department d on h.id = d.hospital_id
inner join Doctor dc on dc.id = d.id
inner join Appointment a on a.doctor_id = dc.id
inner join Patient p on a.patient_id = p.id
inner join Invoice i on i.patient_id = p.id
where i.description = 'Medication Cost';

select p.name, p.phone_number from Patient p
inner join Prescription pr on p.id = pr.patient_id
where month(pr.prescription_date) = month(now());

select d.name doctor_name from Doctor d
inner join Department dep on dep.id = d.department_id
where dep.name = 'Cardiology';

select dep.name department_name, d.name doctor_name from Department dep
left join Doctor d on dep.id = d.department_id;

select p.name "Patient name", p.phone_number "Ptient phone",
p.address "Patient address", p.date_of_birth "atient Date of birth",
p.pharmacy_id "pharmacy id", ph.name "Pharmacy name"
from Patient p
inner join Pharmacy ph on ph.id = p.pharmacy_id
inner join Invoice i on i.patient_id = p.id
where i.cost > 500;
