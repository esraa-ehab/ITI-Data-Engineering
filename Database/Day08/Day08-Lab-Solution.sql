-- 1
use iti;

create procedure students_per_department as
begin 
	select  d.Dept_Name,
			count(s.St_Id) as total_students
	from Department d
	join Student s 
		on d.Dept_Id = s.Dept_id
	group by d.Dept_Name
end

exec students_per_department


-- 2
use Company_SD;

create or alter procedure project_employees as
begin
	declare @emp_count int
	
	select @emp_count = count(*)
	from Works_for
	where Pno = 100
	
	if @emp_count >= 3
		begin
			print 'The number of employees in the project p1 is 3 or more';
		end
	else
		begin
			print 'The following employees work for the project p1';
			
			select e.Fname, e.Lname
			from HumanResourceSchema.Employee e
			join Works_for wf
				on e.SSN = wf.ESSn
			where wf.Pno = 100
		end
end

exec project_employees


-- 3
create or alter procedure replace_employee 
	@old_emp_no int,
	@new_emp_no int,
	@proj_no int
as
begin
	update Works_for
	set ESSn = @new_emp_no
	where ESSn = @old_emp_no and Pno = @proj_no
end

exec replace_employee
	@old_emp_no = 112233,
    @new_emp_no = 102660,
    @proj_no = 100


-- 4
use Company_SD;

alter table CompanySchema.Project
add Budget int

create table Project_Budget_Audit
(
    ProjectNo     varchar(10),
    UserName      varchar(100),
    ModifiedDate  datetime,
    Budget_Old    int,
    Budget_New    int
)

create trigger trg_project_budget on CompanySchema.Project
after update as
begin
    if update(Budget)
    begin
        insert into Project_Budget_Audit
            (ProjectNo, UserName, ModifiedDate, Budget_Old, Budget_New)
        select
            d.Pnumber,
            suser_name(),
            getdate(),
            d.Budget,
            i.Budget
        from deleted d
        join inserted i
            on d.Pnumber = i.Pnumber;
    end
end

update CompanySchema.Project
set Budget = 5000
where Pnumber = 200


-- 5
use ITI;

create trigger prevent_department_insert on Department
instead of insert
as
begin
    print 'You can’t insert a new record in the Department table';
end

insert into Department (Dept_Id,
						Dept_Name,
						Dept_Desc,
						Dept_Location)
values(80, 'AI', 'Network', 'Cairo')


-- 6
use Company_SD;

create trigger prevent_insert_march on HumanResourceSchema.Employee
instead of insert
as
begin
    if month(getdate()) = 3
	    begin
	        print 'Insertion into Employee table is not allowed in March';
	    end
    else
	    begin
	        insert into HumanResourceSchema.Employee
	        select * from inserted;
	    end
end

insert into HumanResourceSchema.Employee(Fname, Lname, SSN, Bdate, Address, Sex, Salary, Superssn, Dno)
values(
    'Ali',
    'Ehab',
    100001,
    '2003-9-20',
    '18 El Khateeb St.',
    'Male',
    500000,
    102660,
    10
)


-- 7
use iti;

create table Student_Audit
(
    UserName varchar(100),
    Date     datetime,
    Note     varchar(300)
)

create or alter trigger student_after_insert on Student
after insert as
begin
    insert into Student_Audit
        (UserName, Date, Note)
    select
        suser_name(),
        getdate(),
        suser_name() +  ' Insert New Row with Key=' + cast(St_Id as varchar(10)) + ' in table Student'
    from inserted;
end

insert into Student(St_Id, St_Fname, St_Lname, St_Address, St_Age, Dept_Id, St_super)
values(
        15,
        'Ali',
        'Eehab',
        'Benha',
        18,
        20,
        2
     )

     
-- 8
create trigger student_instead_of_delete
on Student instead of delete as
begin
    insert into Student_Audit
        (UserName, Date, Note)
    select
        suser_name(),
        getdate(),
        'try to delete Row with Key=' + cast(St_Id as varchar(10))
    from deleted;
end

delete from Student
where St_Id = 15