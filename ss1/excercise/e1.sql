create database student_management;
use student_management;
create table class(
id int not null,
name varchar(50) not null,
primary key(id));
create table teacher(
id int not null,
name varchar(50) not null,
age int not null,
country varchar(255) not null,
primary key(id));