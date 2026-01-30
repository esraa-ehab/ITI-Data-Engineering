create database Courses_db;

use Courses_db;

create table Instrutor (
	id int primary key,
	fname varchar(50) not null,
	lname varchar(50) not null,
	birthdate date not null,
	salary decimal(10,2) default 3000 check (salary between 100 and 5000),
	over_time decimal(10,2) unique,
	hiredate date default (getdate()),
	address varchar(50) check (address in ('cairo', 'alex')),
	age as (year(getdate()) - year(birthdate)),
	net_salary as (salary + coalesce(over_time, 0))
);



create table Course (
	crs_id int primary key,
	crs_name varchar(100) not null,
	duration int unique not null
);


create table lab (
	lab_id int,
	course_id int not null,
	location varchar(100) not null,
	capacity int check (capacity < 20),
	primary key (lab_id, course_id),
	foreign key (course_id) references Course(crs_id)
		on delete cascade 
		on update cascade
);


create table teach (
	instructor_id int,
	course_id int,
	primary key (instructor_id, course_id),
	foreign key (instructor_id) references Instrutor(id)
		on delete cascade 
		on update cascade,
	foreign key (course_id) references Course(crs_id)
		on delete cascade 
		on update cascade
);


