-- schema & security
-- variables 
-- flow control
-- functions
-------------------------------------------------
--schema.lbjectname 

-- logical speration create more then object 
-- acees on set of objects (schema )


create schema ordering;
alter schema ordering transfer orders;

alter schema ordering transfer products;

-- dbo schema 
-- default schema 
select * from dbo.customers

-- dbo.orders
select * from orders

select * from ordering.orders

-- create table in speicific schema
create table ordering.OrderOverview
(
 OrderID int identity,
 OrderDesc varchar(100)
)

select * from ordering.OrderOverView

-- access on schema

-----------------------------------------------------
--server ---> database 
--security
		--authentication : user exist or not 
		--windows auth 
		--sql server auth  username password
			
		--authorization : permision
--1] change sql server configurations to sql server auth
--2] restart server 
--3] connect as window auth 
--4] create login user on server
--5] create user on database level
--6] access on schema (Grant , deny)
--7] reconnect with user 

------------------------------------------------
-- server (login)
	--DB (user, tables , schema, ....)
		--schema (permisions )
			--objects (constrains , columns,...)
				-- coulmns


------------------------------------------
full name access
--[servername].[database].[schema].object

select I.Ins_Name , I.Salary from [ITI].[dbo].Instructor I
union
select e.Fname , e.Salary from [Company_SD].[dbo].Employee e

-- join , group 
-- microservices 

-- azure , amazion
--------------------------------------------------------------------
--local var
	-- containter
	-- batch

--declare @x int = 3;

---- set value
--set @x = 15

--select @x = 20

--select @x = (select st_age from Student where st_id = 3)
declare @x int = 3;

select st_age from Student 
select @x = st_age from Student  -- last value from result (assign)

select @x = (select st_age from Student) -- issue

select @x

-- save age , name of student ID = 5
declare @studentID int = 5 , @studentAge int , @studentName varchar(50);

--select @studentAge = st_age , @studentName = St_Fname
--from Student
--where st_id = @studentID

--select @studentAge , @studentName

-- update + set var 
update Student
set St_Age += 3 , @studentAge = st_age , @studentName = st_fname
where st_id = 5

select @studentAge , @studentName

--------------------------------------------
declare @studnetsAges table (age int );

insert into @studnetsAges
select st_Age from Student 

select * from @studnetsAges


declare @numberOfStudents int = 4

select top(@numberOfStudents) *
from Student
order by St_Age


--  dynamic exuction 
-- string --- query -- excute 
-- magic string 
-- sql injections 
execute('select * from student')

declare @tableName varchar(100) = 'instructor';
execute('select * from ' + @tableName);

------------------------------------------------------------------------------------
--global variables 

select @@SERVERNAME

select @@VERSION

update Student 
set St_Age  += 3
where St_Id between 5 and 10

declare @studentCount int ;
select @studentCount =  @@ROWCOUNT  -- last number of queries update on server 

select @studentCount

update Student 
set St_Age  = 'age'
where St_Id between 5 and 10

-- audit 
select @@ERROR   -- last query run if it was any issue save error number 


insert into ordering.OrderOverview
values ('yuy')

select @@IDENTITY  -- last insert happened set @@identity = last identity
------------------------------------------------------
-- control of flow
-- if 
-- ir existis 
-- while
-- cont
-- breal 
--case
--iif

----------------------------------------

declare @studentUpdatedRowNumber int
update Student
set St_Age += 3
where st_id = 344566

select @studentUpdatedRowNumber =  @@ROWCOUNT

if @studentUpdatedRowNumber > 0 
begin
	select concat(@studentUpdatedRowNumber, 'updated');
end

else 
	select 'there is no rows updated'


-- if existis 

if exists (select * from Student)
	select 'there is data'
else select 'there is no data'




declare @tableName varchar(30) = 'Studenthdjfhkjd';

if exists (select * from sys.tables
where name = @tableName)
	insert into Student (St_Id , St_Fname) values (15 , 'ahmed')

if not exists (select * from sys.tables
where name = @tableName)
	select 'there is no data'



-- while
-- cont
-- break

declare @counter int =  0;
declare @id  int = 16
while @counter <= 10
begin
	insert into Student (St_Id , St_Fname) values (@id , 'ahmed')
	set @id = @id +1 

	-- counter value increase by 1 
	set @counter = @counter + 1
end 


declare @counter int = 0;

-- 0 1 2 3 4 5 6 7 8 9 10 11 12 13 15 
while @counter <= 20
begin
	set @counter += 1;  -- 1
	if @counter = 14 
		continue;        -- discard rest of code (loop agian)

	if @counter = 16
		break;           -- break loop 
	select @counter
end 

-- select + Case 

select Ins_Name , Salary , 
case 
	when Salary between 4000 and 10000 then 'A'
	when Salary between 10000 and 15000 then (select ins_name from Instructor where Ins_Id = 5)
	when Salary > 15000 then 'C'
	else 'no salary detected'
end as salaryDetectoin
from Instructor


update Instructor
set salary = 
	case 
	when salary < 4000 then Salary * 1.2
	else Salary * 1
	end


-- iif 1 condition 
select Ins_Name , iif(salary > 4000 , 'above low', 'low')
from Instructor
-----------------------------------------------------------
-- funcitons 

--  scalre function 
--return 1 value 

alter function getStudentName(@id int )
returns varchar(50)
	begin
		-- id search student name
		declare @studentName varchar(50)
		select @studentName  = st_fname from Student where st_id = @id
		return @studentName
	end 


-- 
select dbo.getStudentName(5)




-- inline function 
-- body logic
create function getStudentName2()
returns table
as
	return select * from Student


-- multi statment
create function getStudentNames4(@fistID int , @sencondID int , @format varchar(3))
returns @studentTable table (ID int , Name varchar(50))
as
	begin
		if @format = 'AAA'
		-- fill table return 
			insert into @studentTable 
			select s.St_Id , s.St_Fname
			from Student s
			where s.St_Id between @fistID and @sencondID

		else if @format = 'BBB'
			insert into @studentTable 
			select s.St_Id , s.St_Fname
			from Student s
			where s.St_Id > @sencondID



		return 

	end 





create function getStudents()
returns @studentTable table (ID int , Name varchar(50))
as
	begin
			insert into @studentTable 
			select s.St_Id , s.St_Fname
			from Student s

			-- allow update runtime 
			update @studentTable
			set ID += 3

          --execute ('select * from student')  error 

		return 

	end 

select * from getStudents()
	



-- 
select * from dbo.getStudentNames4(10 , 20 , 'BBB')


-- identity (Disable )


-- check syntax  server 
---- enable 
SET IDENTITY_INSERT [dbo].[Employees] off

--use northwind;

--insert into ordering.employee values ('desc')

---- disable
set Identity_Insert [dbo].[Employees] on
--insert into ordering.OrderOverview values ('desc')





































