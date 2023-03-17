use quanlybanhang;
insert into customer
value 	(1,'Minh Quan',10),
		(2,'Ngoc Oanh',20),
        (3,'Hong Ha',50);
insert into `order`
value 	(1,1,'3/21/2006',null),
		(2,2,'3/23/2006',null),
        (3,1,'3/16/2006',null);
insert into product
value	(1,'May Giat',3),
		(2,'Tu Lanh',5),
        (3,'Dieu Hoa',7),
        (4,'Quat',1),
        (5,'Bep Dien',2);
insert into OrderDetail
value	(1,1,3),
		(3,1,7),
        (4,1,2),
        (1,2,1),
        (1,3,8),
        (5,2,4),
        (3,2,3);
        
-- Hiển thị các thông tin  gồm oID, oDate, oPrice của tất cả các hóa đơn trong bảng `Order`
 select oID,oDate,oTotalPrice
 from `order`;
 
 -- Hiển thị danh sách các khách hàng đã mua hàng, và danh sách sản phẩm được mua bởi các khách
use quanlybanhang;
select c.cID,cName,pName
from customer c join `order` o on c.cID = o.cID
	join orderdetail oD on oD.oID = o.oID
    join product p on p.pID = oD.pID
group by pName,cName;

-- Hiển thị tên những khách hàng không mua bất kỳ một sản phẩm nào
select c.cID,cName
from customer c left join `order` o on c.cID = o.cID
where o.oID is null;

-- Hiển thị mã hóa đơn, ngày bán và giá tiền của từng hóa đơn 
-- (giá một hóa đơn được tính bằng tổng giá bán của từng loại mặt hàng xuất hiện trong hóa đơn.
--  Giá bán của từng loại được tính = odQTY*pPrice)
select o.oID,oDate, sum(odQTY*pPrice) as Price
from `order` o join orderdetail oD on o.oID=oD.oID
	join product p on p.pID = oD.pID
group by o.oID;