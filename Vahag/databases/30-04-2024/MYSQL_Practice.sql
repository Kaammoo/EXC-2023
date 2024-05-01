use Hospital;

--1
select p.name as "Patient name",
p.phone_number as "Patient phone number"
from Patient p
left join Prescription pr on pr.patient_id = p.id
where pr.patient_id is null;

--2
select d.name as "Doctor name",
d.phone_number as "Doctor phone number"
from Doctor d
left join Appoinment a on a.doctor_id = d.id
where a.doctor_id is null;

--3
select d.name as "Doctor name",
a.date as "Appointment date",
p.name as "Patient name"
from Doctor d
left join Appoinment a on a.doctor_id = d.id
left join Patient p on p.id = a.patient_id;

--4
select r.id as "Room id",
p.name as "Patient name"
from Room r
left join Patient p on r.patient_id = p.id;

--5
select p.name as "Patient name",
sum(pr.prescription_cost) as "Prescription total cost"
from Patient p
left join Prescription pr on pr.patient_id = p.id
group by p.name;

--6
select d.name as "Department name"
from Department d
left join Staff s on s.department_id = d.id
where s.department_id is null;

--7
select p.name as "Patient name", 
avg(datediff(now(), r.admission_date)) as "Average time" --google helped me)))
from Patient p
left join Room r on r.patient_id = p.id
group by p.name;

--8
select ph.name as "Pharmacy name",
ph.address as "Pharmacy address"
from Pharmacy ph
right join Patient p on p.pharmacy_id = ph.id
right join Prescription pr on pr.patient_id = p.id
where pr.patient_id is null;

--9
select p.name as "Patient name",
p.phone_number as "Patient phone number",
count(pr.patient_id) as Count_of_prescription
from Patient p
left join Prescription pr on p.id = pr.patient_id
group by p.id
having Count_of_prescription >= 2; --I have counted many here as more than 2

--10
select p.name as "Patient name",
p.phone_number as "Patient phone number",
a.date as "Appointment date"
from Patient p
left join Appoinment a on a.patient_id = p.id
left join Prescription pr on pr.patient_id = p.id
where a.date is not null and
pr.id is null;
