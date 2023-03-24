use demo;
create table Products(
	id int,
    productCode int,
    productName varchar(50),
    productPrice int,
    productAmount int,
    productDescription varchar(50),
    productStatus bit,
    primary key(id)
);
insert into Products 
values	(1,1,'Áo',20000,100,'',1),
		(2,3,'Quần',50000,100,'',0),
		(3,5,'Giày',100000,100,'',1);
insert into Products 
values	(4,1,'Áo',60000,100,'',1),
		(5,1,'Áo',40000,100,'',0),
		(6,5,'Giày',120000,100,'',1);
 --      Tạo index  
alter table Products add index idx_productCode(productCode);
explain select * from Products where productCode = 5;
explain select * from Products where productName = 'Áo' and productPrice < 50000;
alter table Products add index idx_Name_Price(productName,productPrice);

-- 	Tạo view lấy về các thông tin: productCode, productName, productPrice, productStatus
--  từ bảng products.
create view view_Products as
select productCode,productName,productPrice,productStatus
from Products;

select * from view_Products;

-- 		Tạo store procedure lấy tất cả thông tin của tất cả các sản phẩm trong bảng product
DELIMITER //
CREATE PROCEDURE findAllProducts()
BEGIN

  SELECT * FROM customers;

END //
	select * from Products;
END //
DELIMITER ; 
-- 		Tạo store procedure thêm một sản phẩm mới
DELIMITER //
create procedure add_Products(in Id int,in productCode int, in productName varchar(50),in productPrice int,in productAmount int,in productDescription varchar(50),in productStatus bit)
begin 
	insert into Products values(ID,productCode,productName,productPrice,productAmount,productDescription,productStatus);
end //
DELIMITER ;
call add_Products(7,3,'Quần',70000,40,'',0);
-- 		Tạo store procedure sửa thông tin sản phẩm theo id
use demo;
DELIMITER //
create procedure update_products_new(in update_ID int,col varchar(200),new_value  VARCHAR(200))
begin 
    SET @s = CONCAT(
        'UPDATE products SET `',
         col, '` = ', QUOTE(new_value),
         ' WHERE id = ', update_ID
    );
    PREPARE stmt FROM @s;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
end //
DELIMITER ;
call update_products_new(5,'productAmount','150');
-- 		Tạo store procedure xoá sản phẩm theo id
DELIMITER //
create procedure delete_products(in delete_ID int)
begin 
	delete from products
    where id = delete_ID;
end //
DELIMITER ;
call delete_products(7);