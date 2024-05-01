use Hospital;

select h.address as "Hospital address", 
h.name as "Hospital name", 
d.name as "Department name", 
doc.name as "Doctor name", 
p.name as "Patient name" 
from Hospital h
inner join Department d on h.id = d.hospital_id
inner join Doctor doc on doc.department_id = d.id
inner join Appoinment a on doc.id = a.doctor_id
inner join Patient p on p.id = a.patient_id
inner join Invoice i on i.patient_id = p.id
where i.description = 'Doctor Visit';

select p.name as "Patient name", 
p.phone_number as "Patient phone number"
from Patient p
inner join Prescription pr
on pr.patient_id = p.id
where month(pr.prescription_date) = 4;

select d.name as "Doctor name", 
d.specialization as "Doctor specialization"
from Doctor d
inner join Department dep
on d.department_id = dep.id
where dep.id = 1; 

select d.name as "Department name",
doc.name as "Doctor name"
from Department d
left join Doctor doc
on d.id = doc.department_id;

select p.name as "Patient name", 
p.phone_number as "Patient phone number", 
p.address as "Patient address", 
p.date_of_birth as "Patient date of birth", 
ph.name as "Pharmacy name"
from Patient p
inner join Pharmacy ph on p.pharmacy_id = ph.id
inner join Invoice i on i.patient_id = p.id
where i.cost >= 500;