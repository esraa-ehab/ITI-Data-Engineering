use AdventureWorks2012;

-- ========
--  Part 1
-- ========

-- 1
select SalesOrderID, ShipDate
from Sales.SalesOrderHeader
where ShipDate between '2002-07-28' and '2014-07-29'


-- 2
select ProductID, Name
from Production.Product
WHERE StandardCost < 110


-- 3
select ProductID, Name
from Production.Product
where Weight is null


-- 4
select *
from Production.Product
where Color in ('Silver', 'Black', 'Red')


-- 5
select *
from Production.Product
where Name like 'B%'


-- 6
UPDATE Production.ProductDescription
SET Description = 'Chromoly steel_High of defects'
WHERE ProductDescriptionID = 3

select *
from production.productdescription
where description like '%[_]%'


-- 7
select orderdate, sum(totaldue) as total_sales
from sales.salesorderheader
where orderdate between '2001-07-01' and '2014-07-31'
group by orderdate
order by orderdate 


-- 8
select distinct hiredate
from humanresources.employee


-- 9
select avg(distinct listprice) as avg_listprice
from production.product


-- 10
select 
    'the ' + name + ' is only ' + cast(listprice as varchar(20))+ '!' as product_info
from production.product
where listprice between 100 and 120
order by listprice


-- 11
create login itistud
with password = 'StrongP@ss123'

use ITI;
create user itistud for login itistud

grant select, insert on dbo.Student to itistud;
grant select, insert on dbo.Stud_Course to itistud;

deny update, delete on dbo.Student to itistud;
deny update, delete on dbo.Stud_Course to itistud;


-- 12
select * from Student


-- ========
--  Part 2
-- ========
use ITI

-- 1
create function dbo.get_month_name (@d date)
returns varchar(20)
as
begin
    return datename(month, @d);
end

select dbo.get_month_name('2024-02-15') as month_name;


-- 2
create function dbo.get_numbers_between (@start int, @end int)
returns @t table (num int)
as
begin
    while @start <= @end
    begin
        insert into @t values (@start)
        set @start = @start + 1
    end
    return
end

select *
from dbo.get_numbers_between(5, 10);


-- 3
create function dbo.get_student_dept (@stid int)
returns table
as
return
(
    select 
        d.Dept_Name,
        s.St_Fname + ' ' + s.St_Lname as full_name
    from Student s
    join Department d
        on s.Dept_Id = d.Dept_Id
    where s.St_Id = @stid
)

select *
from dbo.get_student_dept(1);



-- 4
create function dbo.check_student_name (@stid int)
returns varchar(100)
as
begin
    declare @fname varchar(50),
            @lname varchar(50),
            @result varchar(100);

    select 
        @fname = St_Fname,
        @lname = St_Lname
    from Student
    where St_Id = @stid

    if @fname is null and @lname is null
        set @result = 'first name & last name are null'
    else if @fname is null
        set @result = 'first name is null'
    else if @lname is null
        set @result = 'last name is null'
    else
        set @result = 'first name & last name are not null'

    return @result
end

select dbo.check_student_name(1) as status_message;
select dbo.check_student_name(13) as status_message;


-- 5
create function dbo.get_manager_info (@managerid int)
returns table
as
return
(
    select 
        d.Dept_Name,
        i.Ins_Name,
        d.Manager_hiredate
    from Department d
    join Instructor i
        on d.Dept_Manager = i.Ins_Id
    where d.Dept_Manager = @managerid
)

select *
from dbo.get_manager_info(9);


-- 6
create function dbo.get_student_names (@type varchar(20))
returns @t table (result varchar(100))
as
begin
    if @type = 'first name'
        insert into @t
        select isnull(St_Fname, '') from Student

    else if @type = 'last name'
        insert into @t
        select isnull(St_Lname, '') from Student

    else if @type = 'full name'
        insert into @t
        select isnull(St_Fname, '') + ' ' + isnull(St_Lname, '') from Student

    return
end

select *
from dbo.get_student_names('first name')

select *
from dbo.get_student_names('last name')

select *
from dbo.get_student_names('full name')




