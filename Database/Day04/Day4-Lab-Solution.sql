use Company_SD;

-- 1
select	d.Dependent_name
		, d.Sex as Dependent_gender
		, e.Sex as Parent_gender
from Employee e
join Dependent d on e.SSN = d.ESSN
where d.Sex = 'F' and e.Sex = 'F'

Union 

select	d.Dependent_name
		, d.Sex as Dependent_gender
		, e.Sex as Parent_gender
from Employee e
join Dependent d on e.SSN = d.ESSN
where d.Sex = 'M' and e.Sex = 'M'


-- 2
select  e.Fname + ' ' + e.Lname as employee_name,
		p.Pname as project_name, 
	    sum(wf.Hours) as total_hours
from Project p
join works_for wf on p.Pnumber = wf.Pno 
join Employee e on wf.ESSn = e.SSN
group by e.Fname, e.Lname, p.Pname


--3
select m.Fname, m.Lname
from Employee e1
join Employee m
    on e1.Superssn = m.SSN
where e1.Fname = 'Kamel'
  and e1.Lname = 'Mohamed'
  
 
-- 4
select d.*
from Departments d
join Employee e ON d.Dnum = e.Dno
where e.SSN = (
    select min(SSN)
    from Employee
)


-- 5
select  e.Dno,
		d.Dname,
		max(e.Salary) as Max_Salary,
		min(e.Salary) as Min_Salary,
		avg(e.Salary) as Avg_Salary
from Employee e
join Departments d on d.Dnum = e.Dno
group by e.Dno, d.Dname


-- 6
select e.Fname + ' ' + e.Lname as manager_name
from Employee e
join Departments d on e.SSN = d.MgrSSN
where e.SSN not in (
    select de.ESSN
    from Dependent de
)


-- 7
select  d.Dnum,
    	d.Dname,
    	count(e.SSN) as employee_count
from Departments d
join Employee e on d.Dnum = e.Dno
group by d.Dnum, d.Dname
having avg(e.Salary) < (
    select avg(Salary)
    from Employee
)


-- 8
select  e.Fname,
    	e.Lname,
    	p.Pname
from Employee e
join Works_for wf on e.SSN = wf.ESSn
join Project p on wf.Pno = p.Pnumber
order by e.Dno, e.Lname, e.Fname


-- 9
select  Fname + ' ' + Lname as employee_name,
		Salary as max_2_salaries
From Employee
where salary >= (
		select max(Salary)
		from Employee
		Where salary < (
			select max(Salary)
			from Employee
		)
) 
order by salary desc
 

-- 10
select  
    e.Fname + ' ' + e.Lname as employee_name
from Employee e
where Fname in (
    select Dependent_name from Dependent
)
or Lname in (
    select Dependent_name from Dependent
)


-- 11
select 
    e.SSN,
    e.Fname + ' ' + e.Lname as employee_name
from Employee e
where exists (
    select 1
    from Dependent d
)


-- 12
insert into Departments (Dname, Dnum, MGRSSN, [MGRStart Date])
values ('DEPT IT', 100, 112233, '2006-11-01')

select * from Departments

-- 13
	-- a
	update Departments
	set MGRSSN = 968574
	where Dnum = 100

	-- b
	update Departments
    set MGRSSN = 102672
    where Dnum = 20

  	-- c
	update Employee
	set Superssn = 102672
	where SSN = 102660

	
-- 14
delete from Dependent
where ESSN = 223344
	
update Departments
set MGRSSN = 102672
where MGRSSN = 223344

update Employee
set Superssn = 102672
where Superssn = 223344

delete from Works_for
where ESSn = 223344

delete from Employee
where SSN = 223344

	
-- 15
update Employee
set Salary = Salary * 1.3
where SSN in (
    select wf.ESSn
    from Works_for wf
    join Project p on wf.Pno = p.Pnumber
    where p.Pname = 'Al Rabwah'
)

  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
