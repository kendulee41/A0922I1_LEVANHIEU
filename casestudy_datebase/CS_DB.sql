use furama;

-- 2.	Hiển thị thông tin của tất cả nhân viên có trong hệ thống có 
-- tên bắt đầu là một trong các ký tự “H”, “T” hoặc “K” và có tối đa 15 kí tự.
select *
from nhan_vien
where (ho_ten like 'H%' or ho_ten like 'K%' or ho_ten like 'T%') and char_length(ho_ten) <=15;

-- 3.	Hiển thị thông tin của tất cả khách hàng có độ tuổi từ 18 đến 50 tuổi
--  và có địa chỉ ở “Đà Nẵng” hoặc “Quảng Trị”.
select * from khach_hang
where dia_chi like "%Đà Nẵng" or dia_chi like "%Quảng Trị"
group by ma_khach_hang
having datediff(now(),ngay_sinh)/365 between 18 and 50;

-- 4.	Đếm xem tương ứng với mỗi khách hàng đã từng đặt phòng bao nhiêu lần
-- . Kết quả hiển thị được sắp xếp tăng dần theo số lần đặt phòng của khách hàng.
--  Chỉ đếm những khách hàng nào có Tên loại khách hàng là “Diamond”.

select kh.ma_khach_hang,ho_ten,count(hd.ma_khach_hang) as so_lan_dat_phong
from khach_hang kh join hop_dong hd on kh.ma_khach_hang = hd.ma_khach_hang
		join loai_khach l on kh.ma_loai_khach = l.ma_loai_khach
where ten_loai_khach = 'Diamond'
group by hd.ma_khach_hang
order by so_lan_dat_phong;

-- 5.	Hiển thị ma_khach_hang, ho_ten, ten_loai_khach, ma_hop_dong, 
-- ten_dich_vu, ngay_lam_hop_dong, ngay_ket_thuc, tong_tien 
-- (Với tổng tiền được tính theo công thức như sau: Chi Phí Thuê + Số Lượng * Giá, 
-- với Số Lượng và Giá là từ bảng dich_vu_di_kem, hop_dong_chi_tiet) 
-- cho tất cả các khách hàng đã từng đặt phòng. 
-- (những khách hàng nào chưa từng đặt phòng cũng phải hiển thị ra).
use furama;
select kh.ma_khach_hang, kh.ho_ten, l.ten_loai_khach, 
	hd.ma_hop_dong,dv.ten_dich_vu, ngay_lam_hop_dong, ngay_ket_thuc,(chi_phi_thue+ifnull(so_luong*gia,0)) 
	as tong_tien 
from khach_hang kh left join loai_khach l on kh.ma_loai_khach = l.ma_loai_khach
    left join hop_dong hd on kh.ma_khach_hang = hd.ma_khach_hang
    left join dich_vu dv on hd.ma_dich_vu = dv.ma_dich_vu
    left join hop_dong_chi_tiet hdct on hd.ma_hop_dong= hdct.ma_hop_dong
    left join dich_vu_di_kem dvdk on dvdk.ma_dich_vu_di_kem = hdct.ma_dich_vu_di_kem
    group by hd.ma_khach_hang;
    
-- 6.	Hiển thị ma_dich_vu, ten_dich_vu, dien_tich, chi_phi_thue, ten_loai_dich_vu 
-- của tất cả các loại dịch vụ chưa từng được khách hàng thực hiện đặt
--  từ quý 1 của năm 2021 (Quý 1 là tháng 1, 2, 3).
use furama;
select ma_dich_vu, ten_dich_vu, dien_tich, chi_phi_thue, ten_loai_dich_vu 
from dich_vu dv join loai_dich_vu ldv on dv.ma_loai_dich_vu = ldv.ma_loai_dich_vu
where not exists(select * from hop_dong where dv.ma_dich_vu = ma_dich_vu and
	month(ngay_lam_hop_dong) between 1 and 3 and year(ngay_lam_hop_dong)=2021);

-- 7.	Hiển thị thông tin ma_dich_vu, ten_dich_vu, dien_tich, so_nguoi_toi_da, chi_phi_thue,
--  ten_loai_dich_vu của tất cả các loại dịch vụ đã từng được khách hàng đặt phòng
--  trong năm 2020 nhưng chưa từng được khách hàng đặt phòng trong năm 2021.
select ma_dich_vu, ten_dich_vu, dien_tich, so_nguoi_toi_da, chi_phi_thue,ten_loai_dich_vu
from dich_vu dv join loai_dich_vu ldv on dv.ma_loai_dich_vu = ldv.ma_loai_dich_vu
where exists(select * from hop_dong where dv.ma_dich_vu = ma_dich_vu and 
	year(ngay_lam_hop_dong)=2020) and not exists(select * from hop_dong where dv.ma_dich_vu = ma_dich_vu and 
	year(ngay_lam_hop_dong)=2021);
    
-- 8.	Hiển thị thông tin ho_ten khách hàng có trong hệ thống,
--  với yêu cầu ho_ten không trùng nhau.
select ho_ten from khach_hang kh 
group by ho_ten;
--
select distinct ho_ten from khach_hang kh ;
-- 
select ho_ten from khach_hang union select ho_ten from khach_hang;

-- 9.	Thực hiện thống kê doanh thu theo tháng, nghĩa là tương ứng với mỗi tháng
--  trong năm 2021 thì sẽ có bao nhiêu khách hàng thực hiện đặt phòng.
select month(ngay_lam_hop_dong) as thang, count(ma_khach_hang) as so_luong_khach_hang
from hop_dong 
where year(ngay_lam_hop_dong) = 2021
group by thang
order by thang;

-- 10.	Hiển thị thông tin tương ứng với từng hợp đồng thì đã sử dụng bao nhiêu dịch vụ đi kèm. 
-- Kết quả hiển thị bao gồm ma_hop_dong, ngay_lam_hop_dong, ngay_ket_thuc, tien_dat_coc,
--  so_luong_dich_vu_di_kem (được tính dựa trên việc sum so_luong ở dich_vu_di_kem).
select hd.ma_hop_dong, ngay_lam_hop_dong, ngay_ket_thuc, tien_dat_coc,
	ifnull(so_luong,0) as so_luong_dich_vu_di_kem 
from hop_dong hd left join hop_dong_chi_tiet hdct on hd.ma_hop_dong = hdct.ma_hop_dong
group by hd.ma_hop_dong;

-- 11.	Hiển thị thông tin các dịch vụ đi kèm đã được sử dụng bởi những khách hàng
--  có ten_loai_khach là “Diamond” và có dia_chi ở “Vinh” hoặc “Quảng Ngãi”.
select dvdk.ma_dich_vu_di_kem,ten_dich_vu_di_kem
from dich_vu_di_kem dvdk join hop_dong_chi_tiet hdct on dvdk.ma_dich_vu_di_kem = hdct.ma_dich_vu_di_kem
	join hop_dong hd on hd.ma_hop_dong = hdct.ma_hop_dong
    join khach_hang kh on hd.ma_khach_hang = kh.ma_khach_hang
    join loai_khach lk on lk.ma_loai_khach = kh.ma_loai_khach
where ten_loai_khach = "Diamond" and (dia_chi like "% Vinh" or dia_chi like "% Quảng Ngãi");

-- 12.	Hiển thị thông tin ma_hop_dong, ho_ten (nhân viên), ho_ten (khách hàng),
--  so_dien_thoai (khách hàng), ten_dich_vu,
--  so_luong_dich_vu_di_kem (được tính dựa trên việc sum so_luong ở dich_vu_di_kem),
--  tien_dat_coc của tất cả các dịch vụ đã từng được khách hàng đặt vào 3 tháng cuối năm 2020
--  nhưng chưa từng được khách hàng đặt vào 6 tháng đầu năm 2021.
select hd.ma_hop_dong,nv.ho_ten,kh.ho_ten,kh.so_dien_thoai,ten_dich_vu,
	ifnull(sum(so_luong),0) as so_luong_dich_vu_di_kem,tien_dat_coc
from hop_dong hd left join hop_dong_chi_tiet hdct on hd.ma_hop_dong = hdct.ma_hop_dong
	join dich_vu dv on dv.ma_dich_vu = hd.ma_dich_vu
	join khach_hang kh on kh.ma_khach_hang = hd.ma_khach_hang
    join nhan_vien nv on nv.ma_nhan_vien = hd.ma_nhan_vien
where month(ngay_lam_hop_dong) between 10 and 12 and year(ngay_lam_hop_dong) =2020 
	and not exists(select * from hop_dong where dv.ma_dich_vu = ma_dich_vu
		and month(ngay_lam_hop_dong) between 1 and 6 and year(ngay_lam_hop_dong) =2021)
group by hd.ma_hop_dong;

-- 13.	Hiển thị thông tin các Dịch vụ đi kèm được sử dụng nhiều nhất bởi các Khách hàng 
-- đã đặt phòng. 
-- (Lưu ý là có thể có nhiều dịch vụ có số lần sử dụng nhiều như nhau).
with temp1 as (select ma_dich_vu_di_kem,ten_dich_vu_di_kem, sum(so_luong) as so_luong_dich_vu_di_kem
from dich_vu_di_kem 
join hop_dong_chi_tiet using(ma_dich_vu_di_kem)
group by ma_dich_vu_di_kem) 
select * from temp1 where so_luong_dich_vu_di_kem =
	(select max(so_luong_dich_vu_di_kem) from temp1);

-- 14.	Hiển thị thông tin tất cả các Dịch vụ đi kèm chỉ mới được sử dụng một lần duy nhất.
--  Thông tin hiển thị bao gồm ma_hop_dong, ten_loai_dich_vu, ten_dich_vu_di_kem, so_lan_su_dung
-- (được tính dựa trên việc count các ma_dich_vu_di_kem).
select hd.ma_hop_dong, ten_loai_dich_vu, ten_dich_vu_di_kem,count(hdct.ma_dich_vu_di_kem) so_lan_su_dung
from hop_dong hd join dich_vu using (ma_dich_vu)
	join loai_dich_vu using(ma_loai_dich_vu)
    join hop_dong_chi_tiet hdct using(ma_hop_dong)
    join dich_vu_di_kem using(ma_dich_vu_di_kem)
group by ma_dich_vu_di_kem
having so_lan_su_dung=1
order by hd.ma_hop_dong;

-- 15.	Hiển thi thông tin của tất cả nhân viên bao gồm ma_nhan_vien, ho_ten, ten_trinh_do,
--  ten_bo_phan, so_dien_thoai, dia_chi mới chỉ lập được tối đa 3 hợp đồng từ năm 2020 đến 2021.
select ma_nhan_vien, ho_ten, ten_trinh_do,ten_bo_phan, so_dien_thoai, dia_chi
from nhan_vien join hop_dong using(ma_nhan_vien)
join trinh_do using(ma_trinh_do)
join bo_phan using(ma_bo_phan)
where year(ngay_lam_hop_dong) between 2020 and 2021
group by ma_nhan_vien
having count(ma_nhan_vien) <4;

-- 16.	Xóa những Nhân viên chưa từng lập được hợp đồng nào từ năm 2019 đến năm 2021.
delete from nhan_vien
where not exists(select * from hop_dong 
	where nhan_vien.ma_nhan_vien = ma_nhan_vien and year(ngay_lam_hop_dong) between 2019 and 2021);

-- 17.	Cập nhật thông tin những khách hàng có ten_loai_khach từ Platinum lên Diamond,
--  chỉ cập nhật những khách hàng đã từng đặt phòng với Tổng Tiền thanh toán trong năm 2021 là lớn hơn 10.000.000 VNĐ.

-- cau18
delete from khach_hang kh
where not exists (
select *from hop_dong 
where ma_khach_hang=kh.ma_khach_hang and year(ngay_lam_hop_dong)>=2021);

-- cau19
update dich_vu_di_kem
set gia=gia*2
where ma_dich_vu_di_kem in(
select tmp.ma_dich_vu_di_kem
from (
select ma_dich_vu_di_kem
from (
select ma_dich_vu_di_kem, sum(so_luong) t
from dich_vu join hop_dong using(ma_dich_vu) join hop_dong using (ma_hop_dong)
group by ma_dich_vu_di_kem
having t>10)
	)tmp
);

-- cau20
select ma_nhan_vien as id, ho_ten, email, so_dien_thoai, ngay_sinh, dia_chi
from nhan_vien
union all
select ma_khach_hang as id, ho_ten, email, so_dien_thoai, ngay_sinh, dia_chi
from khach_hang