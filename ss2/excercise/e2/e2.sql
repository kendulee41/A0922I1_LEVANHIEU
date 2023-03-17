create database quanlybanhang;
use quanlybanhang;
create table customer(
	cID int,
    cName varchar(30) not null,
    cAge int not null,
    primary key(cID)
);
create table `order`(
	oID int,
    cID int,
    oDate varchar(20) not null,
    oTotalPrice int,
    primary key(oID),
    foreign key(cID) references customer(cID)
);
create table product(
	pID int,
    pName varchar(30) not null,
    pPrice int not null,
    primary key(pID)
);
create table orderDetail(
	pID int,
    oID int,
    odQTY int not null,
    primary key(pID, oID),
    foreign key(oID)references `order`(oID),
    foreign key(pID)references product(pID)
);