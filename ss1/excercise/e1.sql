create database student_management;
use student_management;

create table class(
id int not null,
`name` varchar(50) not null,
primary key(id));


create table teacher(
id int not null,
`name` varchar(50) not null,
age int check (age > 18),
country varchar(255) not null,
primary key(id));