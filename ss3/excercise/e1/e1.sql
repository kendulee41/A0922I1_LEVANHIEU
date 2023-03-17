use quanlysinhvien;

-- Hiển thị tất cả các sinh viên có tên bắt đầu bảng ký tự ‘h’
select * from student 
where StudentName like 'h%';

-- Hiển thị các thông tin lớp học có thời gian bắt đầu vào tháng 12.
use quanlysinhvien;
select * from class
where startDate like '%-12-%';

-- Hiển thị tất cả các thông tin môn học có credit trong khoảng từ 3-5.
select * from `subject`
where credit between 3 and 5;

-- Thay đổi mã lớp(ClassID) của sinh viên có tên ‘Hung’ là 2.
UPDATE student
SET classID = 2
WHERE studentName ='Hung';
select * from student;

-- Hiển thị các thông tin: StudentName, SubName, Mark.
-- 	Dữ liệu sắp xếp theo điểm thi (mark) giảm dần. nếu trùng sắp theo tên tăng dần.
select StudentName,SubName,Mark
from student s join mark m on s.StudentID = m.studentID
	join `subject` sub on sub.subID = m.subID
order by mark desc,StudentName;


