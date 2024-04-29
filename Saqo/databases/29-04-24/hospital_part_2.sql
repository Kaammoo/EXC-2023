select h.address, h.name, d.name, dc.name, p.name from
Hospital h inner join Department d on h.id = d.hospital_id
inner join Doctor dc on dc.id = d.id
inner join Patient p on p.id = d.hospital_id
inner join Invoice i on i.patient_id = p.id
where i.description = 'Medication Cost';

select p.name, p.phone_number from Patient p
inner join Prescription pr on p.id = pr.patient_id
where pr.prescription_date like '%-04-%';

select d.name from Doctor d 
inner join Department dep on dep.id = d.department_id
where dep.name = 'Cardiology';

select dep.name, d.name from Department dep
left join Doctor d on dep.id = d.department_id;

select p.name, p.phone_number, p.address, p.date_of_birth, p.pharmacy_id, ph.name from Patient p
inner join Pharmacy ph on ph.id = p.pharmacy_id
inner join Invoice i on i.patient_id = p.id
where i.cost > 500;
