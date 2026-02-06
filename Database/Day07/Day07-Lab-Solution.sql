use ITI;

-- 1
create view student_passed as
select s.St_Fname + ' ' + s.St_Lname as student_name,
		sc.Crs_Id,
		sc.Grade
from Student s
join Stud_Course sc
	on s.St_Id = sc.St_Id
where sc.grade > 50

select * from student_passed


-- 2
create view manager_topics with encryption as
select 
    i.Ins_Name,
    t.Top_Name 
from Department d
join Instructor i  on i.Ins_Id = d.Dept_Manager
join Ins_Course ic on i.Ins_Id = ic.Ins_Id
join Course c on ic.Crs_Id = c.Crs_Id
join Topic t on c.Top_Id = t.Top_Id
where d.Dept_Manager is not null

select * from manager_topics


-- 3
create view instructor_department as
select 
    i.Ins_Name,
    d.Dept_Name
from Department d
join Instructor i  on i.Dept_Id = d.Dept_Id
where d.Dept_Name in ('SD', 'Java')

select * from instructor_department


-- 4
create view v1 as
select *
from Student
where St_Address in ('Alex', 'Cairo')

select * from v1;

alter view v1 as
select *
from Student
where St_Address in ('Alex', 'Cairo')
with check option

update v1
set St_Address = 'Tanta'
where St_Address = 'Alex'


-- 5
use Company_SD;

alter view project_employee_count as
select 
    wf.Pno as project_number,
    count(e.SSN) as employee_count
from Works_for wf
left join HumanResourceSchema.Employee e on wf.ESSn = e.SSN
group by wf.Pno

select * from project_employee_count


-- 6
create schema CompanySchema;

alter schema CompanySchema
transfer dbo.Departments

alter schema CompanySchema
transfer dbo.Project

create schema HumanResourceSchema;

alter schema HumanResourceSchema
transfer dbo.Employee


-- 7
create clustered index idx_department_hiredate
on CompanySchema.Departments([MGRStart Date])


-- 8
use ITI

create unique index idx_student_age
on dbo.Student(St_Age)


-- 9
use Company_SD;

declare emp_cursor cursor for
select SSN, Salary
from HumanResourceSchema.Employee;

declare @ssn int, @salary money;
open emp_cursor;
fetch next from emp_cursor into @ssn, @salary;

while @@fetch_status = 0
begin
    if @salary < 3000
        update HumanResourceSchema.Employee
        set Salary = Salary * 1.10
        where SSN = @ssn;
    else
        update HumanResourceSchema.Employee
        set Salary = Salary * 1.20
        where SSN = @ssn;

    fetch next from emp_cursor into @ssn, @salary;
end;

close emp_cursor;
deallocate emp_cursor;


-- 10
use ITI;

declare dept_cursor cursor for
select d.Dept_Name, i.Ins_Name
from Department d
join Instructor i on d.Dept_Manager = i.Ins_Id;

declare @dept_name varchar(50), @manager_name varchar(50);

open dept_cursor;
fetch next from dept_cursor into @dept_name, @manager_name;

while @@fetch_status = 0
begin
	select 
        @dept_name,
        @manager_name ;

	print 'department: ' + @dept_name + ' - manager: ' + @manager_name;

    fetch next from dept_cursor into @dept_name, @manager_name;
end;

close dept_cursor;
deallocate dept_cursor;


-- 11
declare @names varchar(max) = '';

declare student_cursor cursor for
select St_Fname
from Student
where St_Fname is not null;

declare @fname varchar(50);

open student_cursor;
fetch next from student_cursor into @fname;

while @@fetch_status = 0
begin
    set @names = @names + @fname + ', ';
    fetch next from student_cursor into @fname;
end;
print @names;
select @names;
close student_cursor;
deallocate student_cursor;


-- 12
select name, type_desc
from sys.objects
where type in ('U', 'V');


-- 13
select * from Student where St_ID = 1;





