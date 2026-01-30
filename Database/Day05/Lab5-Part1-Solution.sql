use ITI;


-- ========
--  Part 1
-- ========

-- 1
select COUNT(*)
from Student
where St_Age is not null


-- 2
select distinct Ins_Name
from Instructor


-- 3
select  s.St_Id as 'Student ID',
		s.St_Fname + ' ' + s.St_Lname as 'Student Full Name',
		d.Dept_Name as 'Departmen name'
from Student s
join Department d 
	on s.Dept_Id = d.Dept_Id
	

-- 4
select  i.Ins_Name,
		d.Dept_Name
from Instructor i
left join Department d 
	on i.Dept_Id = d.Dept_Id
	
	
-- 5
select  s.St_Fname + ' ' + s.St_Lname as 'Student Full Name',
		c.Crs_Name
from Student s
join Stud_Course sc
	on s.St_Id = sc.St_Id
join Course c
	on c.Crs_Id = sc.Crs_Id
where sc.Grade is not null
order by s.St_Fname, s.St_Lname


-- 6
select t.Top_Name, count(*)
from Course c
join Topic t
	on c.Top_Id = t.Top_Id
group by t.Top_Name


-- 7
update Instructor 
set Salary = floor(rand(checksum(newid())) * (10000 - 4000)) + 5000;

select  min(Salary) as min_salary,
		max(Salary) as max_salary
from Instructor;


-- 8
select *
from Instructor
where Salary < (
		select avg(Salary)
		from Instructor
) 


-- 9
select 	d.Dept_Name,
		i.Salary
from Department d 
join Instructor i
	on d.Dept_Id = i.Dept_Id
where i.Salary = (
		select min(Salary)
		from Instructor
)


-- 10
select top 2 Salary
from Instructor
order by Salary desc


-- 11
alter table Instructor 
add Bonus int

update Instructor
set Bonus = Case 
				when Salary is not null 
					then Salary * 0.2
			else 1919
END

select  Ins_Name,
		coalesce(Salary, Bonus) as Salary
from Instructor


-- 12
select  St_Fname, 
		St_super
from Student


-- 13
select  d.Dept_Name,
		i.Salary,
		dense_rank() over (partition by d.Dept_Name order by i.Salary desc) as dense_rank
from Department d
join Instructor i
	on i.Dept_Id = d.Dept_Id

	

-- 14
select *
from (
	select  St_Fname + ' ' + St_Lname as 'Student Name',
			Dept_Id,
			row_number() over(partition by Dept_Id order by newid()) as rn 
	from Student
) t
where rn = 1


-- 15
select  s.St_Fname + ' ' + s.St_Lname as 'Student Name',
		case 
			when d.Dept_Name = 'SD' then Null
			else sc.Grade
		end
from Stud_Course sc
join Student s
	on sc.St_Id = s.St_Id
join Department d 
	on s.Dept_Id = d.Dept_Id

	
-- 16
-- a
select * 
into Student_Archive
from Student

select * 
from Student_Archive

--b
select top 0 *
into Student_Archive2
from Student

select * 
from student_archive2




 
