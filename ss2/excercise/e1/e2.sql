create database quanlysinhvien;
use quanlysinhvien;
create table class(
	classID int auto_increment,
	className varchar(60) not null,
    startDate datetime not null,
    status bit,
    primary key(classID)
);
create table student(
	StudentID int auto_increment,
    StudentName varchar(30) not null,
    Address varchar(50),
    phone varchar(20),
    `status` bit,
    classID int,
    primary key(StudentID),
    foreign key(classID) references class(classID)
);
create table `subject`(
	subID int auto_increment,
    subName varchar(30) not null,
    credit tinyint not null check(credit>=1) default(1),
    `status` bit default(1),
    primary key(subID)
);
create table mark(
	markID int auto_increment,
    subID int,
    studentID int,
    mark float default(0) check(mark between 0 and 100),
    examTimes tinyint default(1),
    primary key(markID),
    foreign key(subID) references `subject`(subID),
    foreign key(studentID) references student(studentID)
);
