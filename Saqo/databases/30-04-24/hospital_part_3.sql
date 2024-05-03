-- Ex. 1

select p.name "Patient id", p.phone_number "Patient phone"
from Patient p
left join Prescription pr
on p.id = pr.patient_id
where pr.patient_id is NULL;

-- Ex. 2

select d.name "Doctor name", d.phone_number "Doctor phone"
from Doctor d
left join Appointment a on a.doctor_id = d.id
where a.doctor_id is NULL;

-- Ex. 3

select d.name "Doctor name", a.date "Appointment date", p.name "Patient name"
from Doctor d
left join Appointment a on a.doctor_id = d.id
left join Patient p on p.id = a.patient_id;

-- Ex. 4

select r.id "Room id", p.name "Patient name"
from Room r
left join Patient p on r.patient_id = p.id;

-- Ex. 5

select p.name "Patient name", sum(pr.prescription_cost) "Prescription cost"
from Patient p
inner join Prescription pr on p.id = pr.patient_id
group by p.name;

-- Ex. 6

select dep.id "id", dep.name "Department name",
dep.hospital_id "Department H. id"
from Department dep
left join Doctor d on dep.id = d.department_id
where d.id is NULL;

-- Ex. 7
--Vahag helped me))
select p.name as "Patient name", 
avg(datediff(now(), r.admission_date)) as "Average time"
from Patient p
left join Room r on r.patient_id = p.id
group by p.name;

-- Ex. 8

select ph.name "Pharmacy name", ph.address "Pharmacy address"
from Pharmacy ph
left join Patient p on ph.id = p.pharmacy_id
where p.id is NULL;

-- Ex. 9

select p.name "Patient name", p.phone_number "Patient phone",
count(p.name) "Prescription Count"
from Patient p
right join Prescription pr on pr.patient_id = p.id
group by p.name, p.phone_number;

-- Ex. 10

select p.name "Patient name", p.phone_number "Patient phone", a.date "Apointment Date"
from Patient p
right join Appointment a on a.patient_id = p.id
left join Prescription pr on pr.patient_id = p.id
where pr.id is NULL;
