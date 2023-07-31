create database School;
use school;

create table dmkhoa (
MaKhoa varchar(20) primary key,
TenKhoa varchar(255)
);

create table dmnganh (
MaNganh int primary key,
TenNganh varchar(255),
MaKhoa varchar(20),
foreign key (MaKhoa) references  dmkhoa(Makhoa)
);
create table dmlop(
MaLop varchar(20) primary key,
TenLop varchar(255),
MaNganh int,
Khoahoc int,
HeDT varchar(255),
NamNhapHoc int,
foreign key (MaNganh) references dmnganh(MaNganh)
);
create table sinhvien(
Masv int primary key auto_increment,
Hoten varchar(255),
Malop varchar(20),
Gioitinh tinyint(1),
Ngaysinh date,
Diachi varchar(255),
foreign key (MaLop) references dmlop(MaLop)
);

create table dmhocphan(
MaHP int primary key auto_increment,
tenHP varchar(255),
sodvht int,
MaNganh int,
HocKy int,
foreign key (MaNganh) references dmnganh(MaNganh)
);
create table diemhp(
MaSV int ,
MaHP int ,
DiemHp float,
foreign key (MaSV) references sinhvien(MaSV),
foreign key (MaHP) references dmhocphan(MaHP)
);
-- ----------------------------------------------------------------------------------------------------------------
insert into dmkhoa (MaKhoa,TenKhoa) values
('CNTT','Công nghệ thông tin'),
('KT','Kế Toán'),
('SP','Sư Phạm');

insert into dmnganh (MaNganh,TenNganh,MaKhoa) values
(140902,'Sư phạm toán tín','SP'),
(480202,'Tin học ứng dụng','CNTT');

insert into dmlop(MaLop,TenLop,MaNganh,KhoaHoc,HeDT,NamNhapHoc) values
('CT11','Cao đẳng tin học',480202,11,'TC',2013),
('CT12','Cao đẳng tin học',480202,12,'CĐ',2013),
('CT13','Cao đẳng tin học',480202,13,'TC',2014);

insert into dmhocphan(TenHp,sodvht,MaNganh,HocKy) values
('Toán cao cấp A1',4,480202,1),
('Tiếng anh 1',3,480202,1),
('Vật lý đại cương',4,480202,1),
('Tiếng anh 2',7,480202,1),
('Tiếng anh 1',3,480202,2),
('Xác xuất thống kê',3,480202,2);

insert into sinhvien(HoTen,Malop,Gioitinh,Ngaysinh,Diachi) values
('Phan Thanh','CT12',0,'1990-09-12','Tuy Phước'),
('Nguyễn Thị Cẩm','CT12',1,'1994-01-12','Quy Nhơn'),
('Võ Thị Hà','CT12',1,'1995-07-02','An Nhơn'),
('Trần Hoài Nam','CT12',0,'1994-04-05','Tây Sơn'),
('Trần Văn Hoàng','CT13',0,'1995-08-04','Vĩnh Thạnh'),
('Đặng Thị Thảo','CT13',1,'1995-06-12','Quy Nhơn'),
('Lê Thị Sen','CT13',1,'1994-08-12','Phù Mỹ'),
('Nguyễn Văn Huy','CT11',0,'1995-06-04','Tuy Phước'),
('Trần Thị Hoa','CT11',0,'1994-08-09','Hoài Nhơn');

insert into diemhp(MaSV,MaHP,DiemHp) values
(2,2,5.9),
(2,3,4.6),
(3,1,4.3),
(3,2,6.7),
(3,3,7.3),
(4,1,4),
(4,2,5.2),
(4,3,3.5),
(5,1,9.8),
(5,2,7.9),
(5,3,7.5),
(6,1,6.1),
(6,2,5.6),
(6,3,4),
(7,1,6.2);
-- ---------------------------------------------------------------------------------------------------------------
-- 1. Hiển thị danh sách gồm MaSV, HoTên, MaLop, DiemHP, MaHP của những sinh viên có điểm HP >= 5 (5đ)
select sv.MaSV, sv.HoTen, sv.MaLop, hp.DiemHP, hp.MaHP from sinhvien sv 
join diemhp hp on hp.masv = sv.masv
where hp.diemhp >= 5 ;

-- 2. Hiển thị danh sách MaSV, HoTen, MaLop, MaHP, DiemHP, MaHP được sắp xếp theo ưu tiên MaLop, HoTen tăng dần. (5đ)
select  sv.MaSV, sv.HoTen, sv.MaLop, hp.DiemHP, hp.MaHP
from sinhvien sv 
join diemhp hp on hp.masv = sv.masv
order by sv.MaLop, sv.HoTen;

-- 3. Hiển thị danh sách gồm MaSV, HoTen, MaLop, DiemHP, HocKy của những sinh viên có DiemHP từ 5 à 7 ở học kỳ I. (5đ)
select sv.masv,sv.hoten,sv.malop,dhp.diemhp,hp.hocky from sinhvien sv
join diemhp dhp on dhp.masv = sv.masv
join dmhocphan hp on dhp.maHp = hp.mahp
where dhp.diemhp  between 5 and 7  and hp.hocky = 1;
-- 4. Hiển thị danh sách sinh viên gồm MaSV, HoTen, MaLop, TenLop, MaKhoa của Khoa có mã CNTT (5đ)
select sv.MaSV, sv.HoTen, sv.MaLop, l.TenLop, n.MaKhoa from  sinhvien sv
join dmlop l on l.malop = sv.malop
join dmnganh n on n.manganh = l.manganh ;

-- 5. Cho biết MaLop, TenLop, tổng số sinh viên của mỗi lớp (SiSo): (5đ)
select l.malop , l.tenlop,count(sv.malop) SiSo from dmlop l
join sinhvien sv on sv.malop =  l.malop
group by sv.malop ;

-- 6. Cho biết điểm trung bình chung của mỗi sinh viên ở mỗi học kỳ, biết công thức tính DiemTBC như sau:
-- DiemTBC = ∑(𝐷𝑖𝑒𝑚𝐻𝑃∗𝑆𝑜𝑑𝑣ℎ𝑝)/∑(𝑆𝑜𝑑𝑣ℎ𝑝)
select dhp.HocKy, sv.MaSV, SUM(hp.DiemHP * dhp.sodvht) / SUM(dhp.sodvht) as DiemTBC 
from sinhvien sv
join diemhp hp on hp.MaSV = sv.MaSV
Join dmhocphan dhp on dhp.mahp = hp.mahp
group by dhp.HocKy, sv.MaSV
order by dhp.HocKy, sv.MaSV;

-- 7. Cho biết MaLop, TenLop, số lượng nam nữ theo từng lớp.
select sv.malop,l.tenlop,
case when
sv.gioitinh = 0 then 'Nam' else 'Nữ' end Gioitinh , count(sv.gioitinh) from sinhvien sv
join dmlop l on l.malop = sv.malop
group by sv.gioitinh , sv.malop;

-- 8. Cho biết điểm trung bình chung của mỗi sinh viên ở học kỳ 1
-- Biết: DiemTBC = ∑(𝐷𝑖𝑒𝑚𝐻𝑃∗𝑆𝑜𝑑𝑣ℎ𝑝)/∑(𝑆𝑜𝑑𝑣ℎ𝑝)
select sv.MaSV, SUM(hp.DiemHP * dhp.sodvht) / SUM(dhp.sodvht) as DiemTBC 
from sinhvien sv
join diemhp hp on hp.MaSV = sv.MaSV
Join dmhocphan dhp on dhp.mahp = hp.mahp
where dhp.hocky = 1
group by dhp.HocKy, sv.MaSV
order by dhp.HocKy, sv.MaSV;

-- 9. Cho biết MaSV, HoTen, Số các học phần thiếu điểm (DiemHP<5) của mỗi sinh viên
select dhp.masv, sv.hoten , count(dhp.diemhp) as Sluong 
from diemhp dhp
join sinhvien sv on sv.masv = dhp.masv
where dhp.diemhp <5
group by dhp.masv ;

-- 10. Đếm số sinh viên có điểm HP <5 của mỗi học phần
select dhp.mahp, count(dhp.diemhp) SL_SV_Thieu from diemhp dhp
where dhp.diemhp < 5
group by dhp.mahp ;
-- 11. Tính tổng số đơn vị học trình có điểm HP<5 của mỗi sinh viên
select dhp.masv,sv.hoten,sum(hp.sodvht) from diemhp dhp
join sinhvien sv on sv.masv = dhp.masv
join dmhocphan hp on hp.mahp = dhp.mahp
where dhp.diemhp < 5
group by dhp.masv ; 

-- 12. Cho biết MaLop, TenLop có tổng số sinh viên > 2.
select l.MaLop, l.TenLop, count(sv.MaSV) as SiSo
from dmlop l
join sinhvien sv on sv.MaLop = l.MaLop
group by l.MaLop, l.TenLop
having count(sv.MaSV) > 2;

-- 13. Cho biết HoTen sinh viên có ít nhất 2 học phần có điểm <5. (10đ)
select  sv.masv,sv.HoTen,count(hp.mahp)
from sinhvien sv
join diemhp hp on sv.MaSV = hp.MaSV
where hp.DiemHP < 5
group by  sv.MaSV, sv.HoTen
having count(hp.MaHP) >= 2;


-- 14. Cho biết HoTen sinh viên học ít nhất 3 học phần mã 1,2,3 (10đ)
select sv.HoTen , count(hp.mahp)
from sinhvien sv
join diemhp hp on sv.MaSV = hp.MaSV
where hp.MaHP in (1, 2, 3)
group by  sv.MaSV, sv.HoTen
having count(distinct hp.MaHP) >= 3;
