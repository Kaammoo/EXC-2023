use Hospital;

--1
select h.address as H_address, h.name as H_name, 
d.name as D_name, doc.name as Doc_name, p.name as P_name 
from Hospital h
inner join Department d on h.id = d.hospital_id
inner join Doctor doc on doc.department_id = d.id
inner join Patient p on p.id = d.hospital_id
inner join Invoice i on i.patient_id = p.id
where i.description = 'Doctor Visit';

--2
select p.name, p.phone_number
from Patient p
inner join Prescription pr
on pr.patient_id = p.id
where pr.prescription_date like '%-04-%';

--3
select d.name, d.specialization
from Doctor d
inner join Department dep
on d.department_id = dep.id
where dep.id = 1; -- can change department id there

--4
select d.name as D_name, doc.name as Doc_name, doc.specialization 
from Department d
left join Doctor doc
on d.id = doc.department_id;

--5
select p.name, p.phone_number, p.address, p.date_of_birth, ph.name
from Patient p
inner join Pharmacy ph on p.pharmacy_id = ph.id
inner join Invoice i on i.patient_id = p.id
where i.cost >= 500;