use quanlysinhvien;

-- Hiển thị tất cả các thông tin môn học (bảng subject) có credit lớn nhất.
select * from `subject`
order by credit desc
limit 1;

-- Hiển thị các thông tin môn học có điểm thi lớn nhất.
select sub.*,mark,studentID
from `subject` sub join mark m on sub.subID = m.subID
group by sub.subID
having mark  = all (select max(mark) from Mark group by mark.subID);

-- Hiển thị các thông tin sinh viên và điểm trung bình của mỗi sinh viên,
--  xếp hạng theo thứ tự điểm giảm dần
select s.*,avg(mark) as averge
from student s join mark m on s.studentID = m.studentID
group by s.studentID
order by averge desc;