
use Company_SD;

----------
-- part 1
----------

-- 1
select * from Employee


-- 2
select fname as 'First Name',
	   lname as 'Last Name',
	   salary as ' Salary',
	   Dno as 'Department Number'
from Employee


-- 3
select P.Pname as 'Project Name',
       P.Plocation as 'Project Location',
	   D.Dname as 'Department Name'
from Project P join Departments D on P.Dnum = D.Dnum


-- 4
select Fname + ' ' + Lname as 'Full Name', 0.1*(Salary*12) as 'ANNUAL COMM'
from Employee


-- 5
select SSN, Fname + ' ' + Lname, Salary as 'Full Name'
from Employee
where Salary > 1000;


-- 6
select SSN, Fname + ' ' + Lname as 'Full Name'
from Employee
where Salary*12 > 10000;


-- 7
select Fname + ' ' + Lname as 'Full Name', Salary
from Employee
where Sex = 'F';


-- 8
select Dnum as 'Department ID', Dname as 'Department Name'
from Departments
where MGRSSN = 968574


-- 9
select Pnumber as 'Project ID', Pname as 'Project Name', Plocation as 'Project Location'
from Project
where Dnum = 10;

-- =============================================================================================


----------
-- part 2
----------

-- 10
select D.Dname as 'Department Name',
	   D.Dnum as 'Departmant ID',
	   E.SSN as 'Manager ID',
	   E.Fname + ' ' + E.Lname as 'Manager Name'
from Departments D 
join Employee E 
	on E.SSN = D.MGRSSN;


-- 11
select D.Dname as 'Department Name',
       P.Pname as 'Project Name'
from Departments D join Project P on D.Dnum = P.Dnum;


-- 12
select D.Dependent_name as 'Dependent Name',
	   D.Sex as 'Dependent Gender',
	   D.Bdate as 'Dependent Birthdate',
	   E.Fname + ' ' + E.Lname as 'Employee Name'
from Dependent D 
left join Employee E 
	on D.ESSN = E.SSN


-- 13
select Pname,
	   Pnumber,
	   City,
	   Plocation
from Project
where City in ('Alex', 'Cairo');


-- 14
select *
from Project
where Pname like 'a%'


-- 15
select *
from Employee
where Dno = 30 and Salary between 1000 and 2000;


-- 16
select E.Fname + ' ' + E.Lname as name,
	   E.Dno as department,
	   P.Pname,
	   WF.Hours 
from Employee E 
join Project P 
	on E.Dno = P.Dnum
join Works_for WF 
	on P.Pnumber = WF.Pno
where E.Dno = 10 and P.Pname = 'AL Rabwah' and WF.Hours >= 10;


-- 17
select E.Fname + ' ' + E.Lname as name,
	   P.Pname
from Employee E 
join Project P 
	on E.Dno = P.Dnum
Order by P.Pname Asc


-- 18
select P.Pnumber,
	   D.Dname,
	   E.Lname,
	   E.Address,
	   E.Bdate 
from Employee E 
join Departments D 
	on E.SSN = D.MGRSSN
join Project P 
	on D.Dnum = P.Dnum
where P.City = 'Cairo';


-- 19
select *
from Employee E 
Right Join Departments D on E.SSN = D.MGRSSN


-- 20
select *
from Employee E 
left Join Dependent D on E.SSN = D.ESSN;


-- 21
delete from Employee where SSN = 102672;
insert into Employee(Fname, Lname, SSN, Bdate, Address, Sex, Salary, Superssn, Dno)
Values ('Israa',
		'Ehab',
		102672,
		'2003-06-01 00:00:00.000',
		'Benha, Egypt',
		'F',
		3000,
		112233,
		10
	);
select * from Employee


-- 22
delete from Employee where SSN = 102660;
insert into Employee(Fname, Lname, SSN, Bdate, Address, Sex, Dno)
Values ('Yara',
		'Ayman',
		102660,
		'2003-07-01 00:00:00.000',
		'Benha, Egypt',
		'F',
		30
	);
select * from Employee


-- 23
update Employee
set Salary = Salary + (0.20 * Salary)
where SSN = 102672;

select Fname, Lname, Salary from Employee where ssn = 102672;


-- 24
select format(GETDATE(), 'dd-MM-yyyy') as today; -- Standard

select convert(varchar, GETDATE(), 103) as today; -- British/French

