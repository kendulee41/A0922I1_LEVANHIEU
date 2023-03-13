create database quanlydonhang;
use quanlydonhang;
create table nhaCC(
	maNCC int,
    tenNCC varchar(255) not null,
    diachi varchar(255) not null,
    sdt varchar(11) not null,
    primary key(maNCC)
);
create table phieuXuat(
	soPX int,
	ngayXuat varchar(50),
    primary key(soPX)
);
create table vatTu(
	maVatTu int,
    tenVatTu varchar(255),
    primary key(maVatTu)
);
create table phieuNhap(
	soPN int,
    ngayNhap varchar(50),
    primary key(soPN)
);
create table donDH(
	soDH int,
    ngayDH varchar(50),
    maNCC int,
    foreign key(maNCC) references nhaCC(maNCC),
    primary key(soDH)
);
create table donDH_vatTu(
	soDH int,
    maVatTu int,
    primary key(soDH,maVatTu),
    foreign key(soDH) references dondH(soDH),
    foreign key(maVatTu) references vattu(maVatTu)
);
create table VatTu_phieuNhap(
	maVatTu int,
    soPN int,
    primary key(maVatTu,soPN),
    dGNhap varchar(50),
    sLNhap int,
    foreign key(soPN) references phieunhap(soPN),
    foreign key(maVatTu) references vattu(maVatTu)
);
create table VatTu_phieuXuat(
	maVatTu int,
    soPX int,
    primary key(maVatTu,soPX),
    dGXuat varchar(50),
    sLXuat int,
    foreign key(soPX) references phieuxuat(soPX),
    foreign key(maVatTu) references vattu(maVatTu)
);
