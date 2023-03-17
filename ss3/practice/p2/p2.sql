use quanlysinhvien;
-- Hiển thị danh sách tất cả các học viên
select * from student;

-- Hiển thị danh sách các học viên đang theo học.
select * from student
where `status` =1;

-- Hiển thị danh sách các môn học có thời gian học nhỏ hơn 10 giờ.
select * from `subject`
where credit < 10;

-- Hiển thị danh sách học viên lớp A1
select studentID,studentName,className from student s
join class c on s.classID = c.classID
where c.className = 'A1';

-- Hiển thị điểm môn CF của các học viên.
select s.studentID,s.studentName,m.mark as CFMath
from student s join mark m 
		on s.StudentID = m.studentID
	join `subject` sub 
		on sub.subID = m.subID
where subName = 'CF';