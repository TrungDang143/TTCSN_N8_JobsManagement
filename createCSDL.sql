﻿create database JobsManagement
go

use JobsManagement
go

create table CauHoiBaoMat
(
	cauhoi nvarchar(30) primary key
)
go

create table TaiKhoan
(
	tenDangNhap varchar(20) primary key,
	matKhau varchar(20) not null,
	tenHienThi nvarchar(30) not null,
	cauhoi nvarchar(30) foreign key references CauHoiBaoMat(cauhoi),
	traLoi nvarchar(30) not null,
	khoiDong bit default 1,
	nhacNhoCV bit default 1,
	nhacNho bit default 1,
	hNhacNho int default 0,
	mNhacNho int default 30,
	isAD bit default 0
)
go

create table TrangThai
(
	trangThai nvarchar(20) primary key
)
go

create table CongViec
(
	
	id int primary key,
	noiDungCV nvarchar(50) not null,
	tgBD datetime not null,
	tgKT datetime not null,
	trangThai nvarchar(20) default N'Sắp diễn ra' foreign key references TrangThai(trangThai),
	lapLaiT2 bit default 0,
	lapLaiT3 bit default 0,
	lapLaiT4 bit default 0,
	lapLaiT5 bit default 0,
	lapLaiT6 bit default 0,
	lapLaiT7 bit default 0,
	lapLaiCN bit default 0,
	tenDangNhap varchar(20) foreign key references TaiKhoan(tenDangNhap)
)
go

--cau hoi bao mat
insert into CauHoiBaoMat values(N'Giáo viên bạn quý nhất?')
insert into CauHoiBaoMat values(N'Nơi bạn và ny gặp lần đầu?')
insert into CauHoiBaoMat values(N'Nơi bạn thích đến nhất?')
insert into CauHoiBaoMat values(N'Kỉ niệm đáng nhớ?')
insert into CauHoiBaoMat values(N'Biệt danh lúc nhỏ?')
insert into CauHoiBaoMat values(N'Tên thú cưng đầu tiên?')

--trang thai
insert into TrangThai values(N'Sắp diễn ra')
insert into TrangThai values(N'Đang diễn ra')
insert into TrangThai values(N'Đã hoàn thành')
insert into TrangThai values(N'Chưa hoàn thành')



insert into TaiKhoan(tenDangNhap, matKhau, tenHienThi, cauhoi, traLoi, isAD) values('Admin','1111','ADMIN',N'Kỉ niệm đáng nhớ?','abc', 1)
insert into TaiKhoan(tenDangNhap, matKhau, tenHienThi, cauhoi, traLoi, isAD) values('trungdang','1403','TrungDang',N'Kỉ niệm đáng nhớ?','abcd', 0)
insert into TaiKhoan(tenDangNhap, matKhau, tenHienThi, cauhoi, traLoi, isAD) values('tridinh','0000','Tri',N'Kỉ niệm đáng nhớ?','xyzt', 0)
insert into CongViec values (0,N'Học OOP','5/31/2023 6:30:00','5/31/2023 9:30:00', N'Sắp diễn ra',0,0,0,0,0,0,0,'trungdang')
-----------------------------------------------------------------------------------------

insert into CongViec(id, noiDungCV, tgBD, tgKT, trangThai, tenDangNhap) values (1, N'trungdangtets', '5/31/2023', '6/2/2023', N'Sắp diễn ra', 'trungdang')
--select tenHienThi from taikhoan where tendangnhap ='trungdang'
select * from CongViec
select * from TaiKhoan
drop database JobsManagement
delete from CongViec where noiDungCV = N'k lặp - > hn'
select * from CauHoiBaoMat
print datepart(getdate())
select top(1) id from CongViec where tenDangNhap = 'trungdang' order by id desc
select * from CongViec where tenDangNhap = 'trungdang' order by tgBD desc

/*
insert into Acc (tenDangNhap,matKhau,tenHienThi,traLoi) values('Admin','1111','ADMIN','Tên giáo viên bạn quý nhất?','0123456789')
select * from Acc

create proc [dbo].[SP_AuthorizationLogin]
@UserName nvarchar(20),
@PassWord nvarchar(20)
as
begin
    if exists (select * from Acc where tenDangNhap = @UserName and matKhau = @PassWord)
        select 0 as code
	else  
        select 1 as code
end

create proc [dbo].[SP_Retrieve_User]
as
begin
    select * from Acc
end

create proc [dbo].[SP_ThemTaiKhoan]
@TaiKhoan varchar(20),
@TenHienThi nvarchar(30),
@MatKhau varchar(20),
@traLoi nvarchar(30)
as
begin
    Insert into Acc values(@TaiKhoan,@MatKhau,@TenHienThi,@traLoi)
end
*/

create proc DangNhap_1 (@userName varchar(20), @passWord varchar(20))
as
begin	
	select * from TaiKhoan where tenDangNhap = @userName AND matKhau = @passWord
end

exec DangNhap_1 'Admin', '1111'

create proc DangNhap_2 (@userName varchar(20))
as
begin
	select * from TaiKhoan where tenDangNhap = @userName
end
--drop proc DangNhap_2
exec DangNhap_2 'Admin'


create proc DangKy_1 (@userName varchar(20), @passWord varchar(20), @tenHT nvarchar(30), @cauHoi nvarchar(30), @traLoi nvarchar(30))
as
begin
	insert into TaiKhoan(tenDangNhap, matKhau, tenHienThi, cauhoi, traLoi) values(@userName, @passWord, @tenHT, @cauHoi, @traLoi)
end
--drop proc DangKy
go

exec DangKy_1 'dinhtri', '1111', 'tri', N'Kỉ niệm đáng nhớ?', 'xyz'
exec DangKy_1 'tridinh', '1111', 'tri', N'Tên thú cưng đầu tiên?', 'xyz'



select * from CongViec
select * from TaiKhoan
insert into CongViec values (0,N'Học OOP','6/1/2023 6:30:00','06/03/2023 9:30:00', N'Sắp diễn ra',0,0,0,0,0,0,0,'trungdang')
insert into CongViec values (7,N'Học CTDL','6/9/2023 14:30:00','6/9/2023 20:30:00', N'Chưa hoàn thành',0,0,0,0,0,0,0,'Admin')
insert into CongViec values (6,N'Học SQL','5/30/2023 6:30:00','6/15/2023 22:30:00', N'Đã hoàn thành',0,0,0,0,0,0,0,'tridinh')
insert into CongViec values (3,N'Training','6/2/2023 6:30:00','6/2/2023 22:30:00', N'Sắp diễn ra',0,0,0,0,0,0,0,'tridinh')
insert into CongViec values (4,N'di lam','6/1/2023 6:30:00','06/03/2023 9:30:00', N'Sắp diễn ra',0,0,0,0,0,0,0,'trungdang')
insert into CongViec values (6,N'ABC','07/15/2023 6:30:00','07/30/2023 9:30:00', N'Đã hoàn thành',0,0,0,0,0,0,0,'Admin')

delete from CongViec
create view Today
as
	select noiDungCV, tgBD, tgKT, trangThai from CongViec
	where (year(tgBD) = year(getdate()) AND month(tgBD) = month(getdate()) AND day(tgBD) = day(getdate())) 
	OR (year(tgKT) = year(getdate()) AND month(tgKT) = month(getdate()) AND day(tgKT) = day(getdate()))
	OR (tgBD < getdate() AND getdate() < tgKT)
drop view Today
select * from CongViec where year(tgBD) = year(getdate()) AND month(tgBD) = month(getdate()) AND day(tgBD) = day(getdate())


select * from Today

create view Tomorrow
as
	select noiDungCV, tgBD, tgKT, trangThai from CongViec
	where (year(tgBD) = year(getdate()+1) AND month(tgBD) = month(getdate()+1) AND day(tgBD) = day(getdate()+1)) 
	OR (year(tgKT) = year(getdate()+1) AND month(tgKT) = month(getdate()+1) AND day(tgKT) = day(getdate()+1))
	OR (tgBD < getdate()+1 AND getdate()+1 < tgKT)
	drop view Tomorrow
select * from Tomorrow

create view thisWeek
as
	select noiDungCV, tgBD, tgKT, trangThai from CongViec
	where year(tgBD) = year(getdate()) AND datepart(week, getdate()) = datepart(week, tgBD)
	OR year(tgKT) = year(getdate()) AND datepart(week, getdate()) = datepart(week, tgKT)


select * from thisWeek


create view thisMonth
as
	select noiDungCV, tgBD, tgKT, trangThai from CongViec
	where year(tgBD) = year(getdate()) AND month(tgBD) = month(getdate())
	OR year(tgKT) = year(getdate()) AND month(tgKT) = month(getdate())

select * from thisMonth

create proc hienThiCV(@userName varchar(20))
as
begin
	select noiDungCV, tgBD, tgKT, trangThai from CongViec where tenDangNhap = @userName
end

exec hienThiCV 'tridinh'

--HOM NAY
create proc HomNay (@userName varchar(20))
as 
begin
	select noiDungCV, tgBD, tgKT, trangThai from CongViec
	where ((year(tgBD) = year(getdate()) AND month(tgBD) = month(getdate()) AND day(tgBD) = day(getdate())) 
	OR (year(tgKT) = year(getdate()) AND month(tgKT) = month(getdate()) AND day(tgKT) = day(getdate()))
	OR (tgBD < getdate() AND getdate() < tgKT)) AND tenDangNhap = @userName
end

--- TUAN NAYY
create proc TuanNay (@userName varchar(20))
as 
begin
	select noiDungCV, tgBD, tgKT, trangThai from CongViec
	where (year(tgBD) = year(getdate()) AND datepart(week, getdate()) = datepart(week, tgBD)
	OR year(tgKT) = year(getdate()) AND datepart(week, getdate()) = datepart(week, tgKT))
	AND tenDangNhap = @userName
end
--NGAY MAI
create proc NgayMai (@userName varchar(20))
as 
begin
	select noiDungCV, tgBD, tgKT, trangThai from CongViec
	where (datepart(year,getdate()) = datepart(year, tgBD) AND datepart(month,getdate()) = datepart(month, tgBD) AND datepart(day,getdate()+1) = datepart(day, tgBD)
	OR datepart(year,getdate()) = datepart(year, tgBD) AND datepart(month,getdate() + 1) = datepart(month, tgBD) AND datepart(day,getdate()+1) = datepart(day, tgBD)
	OR datepart(year,getdate()) = datepart(year, tgKT) AND datepart(month,getdate()) = datepart(month, tgKT) AND datepart(day,getdate()+1) = datepart(day, tgKT)
	OR datepart(year,getdate()) = datepart(year, tgKT) AND datepart(month,getdate() + 1) = datepart(month, tgKT) AND datepart(day,getdate()+1) = datepart(day, tgKT)
	OR tgBD < getdate()+1 AND getdate()+1 < tgKT)
	AND tenDangNhap = @userName
end
drop proc NgayMai
--THANG NAYY
create proc ThangNay (@userName varchar(20))
as 
begin
	select noiDungCV, tgBD, tgKT, trangThai from CongViec
	where (year(tgBD) = year(getdate()) AND month(tgBD) = month(getdate())
	OR year(tgKT) = year(getdate()) AND month(tgKT) = month(getdate()))
	AND tenDangNhap = @userName
end
drop proc NgayMai
exec NgayMai 'tridinh'
exec HomNay 'tridinh'
exec TuanNay 'tridinh'
exec ThangNay 'trungdang'

select datepart(year, tgKT),
datepart(month, tgKT),
datepart(day, tgKT)
go
--from CongViec where tenDangNhap = 'trungdang'
----------------------------------


exec DoiTrangThai 6, trungdang, N'Chưa hoàn thành'
SELECT	 * FROM CongViec

exec GetSoCVbyTT 'Đang diễn ra', 'trungdang'
go

CREATE PROCEDURE GetCongViecByDateRange
    @startDate DATE,
    @endDate DATE,
	@username varchar(20)
AS
BEGIN

    SELECT id, noiDungCV as N'Nội dung công việc', tgBD as N'Bắt đầu', tgKT as N'Kết thúc', trangThai as N'Trạng thái'
    FROM congviec
    WHERE CONVERT(DATE, tgBD) >= @startDate 
    AND CONVERT(DATE, tgKT) <= @endDate
	and tenDangNhap = @username
END

drop proc GetCongViecByDateRange
exec GetCongViecByDateRange '2023-6-3', '2023-6-5', 'trungdang'

CREATE PROCEDURE GetCongViecByDateRange1
    @startDate DATE,
    @endDate DATE,
	@username varchar(20)
AS
BEGIN

    SELECT id, noiDungCV , tgBD, tgKT, trangThai
    FROM congviec
    WHERE CONVERT(DATE, tgBD) >= @startDate 
    AND CONVERT(DATE, tgKT) <= @endDate
	and tenDangNhap = @username
END

select dbo.getNextIdLap( 'trungdang' )
select * from CongViec where tenDangNhap = 'trungdang'
declare @id int
	set @id = (select top(1) id from CongViec where tenDangNhap = 'trungdang' order by id desc) + 1
	print @id

select dbo.GetIdLapLai( 29 , 'trungdang' )
select * from CongViec where tenDangNhap = 'trungdang'

create proc ChangeJob (@truongHop int, @id int, @idLap int, @noiDungCV nvarchar(50), @tgBD datetime, @tgKT datetime, @trangThai nvarchar(20), @t2 bit, @t3 bit, @t4 bit, @t5 bit, @t6 bit, @t7 bit, @cn bit, @tenDangNhap varchar(20)) as
begin
	if(@truongHop = 1)
		exec ChangeJob_KLap_KLap @id, @noiDungCV, @tgBD, @tgKT, @trangThai, @t2, @t3, @t4, @t5, @t6, @t7, @cn, @tenDangNhap
	else if(@truongHop = 2)
		exec ChangeJob_Lap_Lap @idLap, @noiDungCV, @tgBD, @tgKT, @trangThai, @t2, @t3, @t4, @t5, @t6, @t7, @cn, @tenDangNhap
	else if(@truongHop = 3)
		exec ChangeJob_KLap_Lap @idLap, @noiDungCV, @tgBD, @tgKT, @trangThai, @t2, @t3, @t4, @t5, @t6, @t7, @cn, @tenDangNhap
	else if(@truongHop = 4)
		exec ChangeJob_Lap_KLap @noiDungCV, @tgBD, @tgKT, @trangThai, @t2, @t3, @t4, @t5, @t6, @t7, @cn, @tenDangNhap
	else
		exec ChangeJob_Lap_newLap @idLap, @noiDungCV, @tgBD, @tgKT, @trangThai, @t2, @t3, @t4, @t5, @t6, @t7, @cn, @tenDangNhap
end
go

--giữ nguyên trạng thái lặp: k lăp - k lap
create proc ChangeJob_KLap_KLap (@id int, @noiDungCV nvarchar(50), @tgBD datetime, @tgKT datetime, @trangThai nvarchar(20), @t2 bit, @t3 bit, @t4 bit, @t5 bit, @t6 bit, @t7 bit, @cn bit, @tenDangNhap varchar(20)) as
begin
	update CongViec set 
		noiDungCV = @noiDungCV, 
		tgBD = @tgBD,
		tgkt = @tgKT,
		trangThai = @trangThai
		where tenDangNhap = @tenDangNhap and id = @id
end
go
--giữ nguyên trạng thái lặp: lặp lại tư tượng
create proc ChangeJob_Lap_Lap (@idLap int, @noiDungCV nvarchar(50), @tgBD datetime, @tgKT datetime, @trangThai nvarchar(20), @t2 bit, @t3 bit, @t4 bit, @t5 bit, @t6 bit, @t7 bit, @cn bit, @tenDangNhap varchar(20)) as
begin
	update CongViec set 
		noiDungCV = @noiDungCV, 
		tgBD =  DATEADD(HOUR, DATEPART(HOUR, @tgBD) - DATEPART(HOUR, tgBD), DATEADD(MINUTE, DATEPART(MINUTE, @tgBD) - DATEPART(MINUTE, tgBD), tgBD)),
		tgkt = DATEADD(HOUR, DATEPART(HOUR, @tgKT) - DATEPART(HOUR, tgKT), DATEADD(MINUTE, DATEPART(MINUTE, @tgKT) - DATEPART(MINUTE, tgKT), tgKT)),
		trangThai = @trangThai
		where tenDangNhap = @tenDangNhap and idLap = @idLap
end
go

--thay đổi trạng thái lặp: k lặp - lặp
create proc ChangeJob_KLap_Lap (@idLap int, @noiDungCV nvarchar(50), @tgBD datetime, @tgKT datetime, @trangThai nvarchar(20), @t2 bit, @t3 bit, @t4 bit, @t5 bit, @t6 bit, @t7 bit, @cn bit, @tenDangNhap varchar(20)) as
begin
	insert into CongViec values(@idLap, @noiDungCV, @tgBD, @tgKT, @trangThai, @t2, @t3, @t4, @t5, @t6, @t7, @cn, @tenDangNhap)
end
go

-- thay đổi trạng thái: lặp - k lặp
create proc ChangeJob_Lap_KLap (@noiDungCV nvarchar(50), @tgBD datetime, @tgKT datetime, @trangThai nvarchar(20), @t2 bit, @t3 bit, @t4 bit, @t5 bit, @t6 bit, @t7 bit, @cn bit, @tenDangNhap varchar(20)) as
begin
	insert into CongViec values(0, @noiDungCV, @tgBD, @tgKT, @trangThai, @t2, @t3, @t4, @t5, @t6, @t7, @cn, @tenDangNhap)
end
go

-- thay đổi trạng thái: lặp - lặp khác
create proc ChangeJob_Lap_newLap (@idLap int, @noiDungCV nvarchar(50), @tgBD datetime, @tgKT datetime, @trangThai nvarchar(20), @t2 bit, @t3 bit, @t4 bit, @t5 bit, @t6 bit, @t7 bit, @cn bit, @tenDangNhap varchar(20)) as
begin
	insert into CongViec values(idLap, @noiDungCV, @tgBD, @tgKT, @trangThai, @t2, @t3, @t4, @t5, @t6, @t7, @cn, @tenDangNhap)
end
go


create proc chuaHT(
	@userName varchar(20)
)
as
begin 
	select noiDungCV from CongViec	
	where trangThai = N'Chưa hoàn thành'
	and tenDangNhap = @userName
end

exec chuaHT 'Admin'
drop proc chuaHT

create proc countChuaHT(
	@userName varchar(20)
)
as
begin 
	select COUNT(*) from CongViec	
	where trangThai = N'Chưa hoàn thành'
	and tenDangNhap = @userName
end

exec  countChuaHT 'Admin'

create proc daHT(
	@userName varchar(20)
)
as
begin 
	select noiDungCV from CongViec	
	where trangThai = N'Đã hoàn thành'
	and tenDangNhap = @userName
end

exec daHT 'Admin'




