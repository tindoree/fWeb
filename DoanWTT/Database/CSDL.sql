use master
go
drop database BanHangOnline
go
-- Tạo database BanHangOnline
create database BanHangOnline
go
use BanHangOnline

-- 1: Tạo Table [Accounts] chứa tài khoản thành viên được phép sử dụng các trang quản trị ----
create table taiKhoanTV
(
	taiKhoan varchar(20) primary key not null,
	matKhau varchar(20) not null,
	hoDem nvarchar(50) null,
	tenTV nvarchar(30) not null,
	ngaysinh datetime ,
	gioiTinh bit default 1,
	soDT nvarchar(20),
	email nvarchar(50),
	diaChi nvarchar(250),
	trangThai bit default 0,
	ghiChu ntext
)
go

-- 2: Tạo Table [Customers] chứa Thông tin khách hàng  ---------------------------------------
create table khachHang
(
	maKH varchar(10) primary key not null,
	tenKH nvarchar(50) not null,
	soDT varchar(20) ,
	email varchar(50),
	diaChi nvarchar(250),
	ngaySinh datetime ,
	gioiTinh bit default 1,
	ghiChu ntext
)
go


-- 4: Tạo Table [Products] chứa thông tin của sản phẩm mà shop kinh doanh online --------------
create table sanPham
(
	maSP varchar(10) primary key not null,
	tenSP varchar(500) not null,
	hinhDD varchar(max),
	ndTomTat nvarchar(2000),
	ngayDang datetime,
	loaiHang nvarchar(30),
	noiDung nvarchar(4000),
	taiKhoan varchar(20) not null foreign key references taiKhoanTV(taiKhoan),
	daDuyet bit default 0,
	giaBan float,
	giamGia float,
	soLuong integer,
	ghiChu ntext
)
go

-- 5: Tạo Table [Orders] chứa danh sách đơn hàng mà khách đã đặt mua thông qua web ------------
create table donHang
(
	soHD varchar(10) primary key not null ,
	maKH varchar(10) not null foreign key references khachHang(maKH),
	taiKhoan varchar(20) not null foreign key references taiKhoanTV(taiKhoan),
	ngayDat datetime,
	daKichHoat bit default 1,
	ngayGH datetime,
	diaChiGH nvarchar(250),
	ghiChu ntext
)
go	

-- 6: Tạo Table [OrderDetails] chứa thông tin chi tiết của các đơn hàng mà khách đã đặt mua ----
--    dach sách các mặt hàng đã đặt mua trong đơn hàng  ------------------------- 
create table ctDonHang	
(
	soHD varchar(10) not null foreign key references donHang(soHD),
	maSP varchar(10) not null foreign key references sanPham(maSP),
	soLuong int,
	giaBan bigint,
	giamGia BIGINT,
	PRIMARY KEY (soHD, maSP)
)
go


/*========================== Nhập dữ liệu mẫu ==============================*/

--  Nhập thông tin tài khoản, tối thiểu 5 thành viên sẽ dùng để làm việc với các trang: Administrative pages

insert into taiKhoanTV values('minh','123','Nguyễn Triệu','Minh',06/12/1997,1,0935694223,'minhminh@gmail.com','1 CMT8, P.11,Q3, TP.HCM',1,'')
insert into taiKhoanTV values('tin','123','Vũ Hoàng','Tín',15/08/1997,1,0935694223,'tintin@gmail.com','2 CMT8, P.11,Q3, TP.HCM',1,'')
insert into taiKhoanTV values('luan','123','Phạm Thành','Luân',06/12/1997,1,0935694223,'luanluan@gmail.com','3 CMT8, P.11,Q3, TP.HCM',1,'')
insert into taiKhoanTV values('ly','123','Thái Đình','Ly',06/12/1997,1,0935694223,'lyly@gmail.com','4 CMT8, P.11,Q3, TP.HCM',1,'')
insert into taiKhoanTV values('long','123','Phan Minh','Long',06/12/1997,1,0935694223,'longlong@gmail.com','5 CMT8, P.11,Q3, TP.HCM',1,'')
GO



 -- Nhập thông tin sản phẩm, Tối thiểu 30 sản phẩm liên quan đến mục tiêu mà bạn sẽ thực hiện trong đồ án

insert into sanPham (maSP, tenSP, hinhDD, loaiHang, noiDung, taiKhoan, giaBan, giamGia,ghiChu) 
values ('001', 'Esprit Ruffle Shirt','/images/product-01.jpg','1',N'Gam màu vàng tươi sáng, màu đỏ nổi bật hay màu đen đơn giản, cho bạn dễ lựa chọn và dễ dàng kết hợp trang phục khác nhau. Chất liệu thun mềm mại, thoáng mát, thấm hút mồ hôi tốt, không hầm bí, mang lại cảm giác thoải mái khi mặc','tin','166400',' ',' ')
insert into sanPham (maSP, tenSP, hinhDD, loaiHang, noiDung, taiKhoan, giaBan, giamGia,ghiChu) 
values ('002', 'Herschel supply','/images/product-02.jpg','1',N'Gam màu vàng tươi sáng, màu đỏ nổi bật hay màu đen đơn giản, cho bạn dễ lựa chọn và dễ dàng kết hợp trang phục khác nhau. Chất liệu thun mềm mại, thoáng mát, thấm hút mồ hôi tốt, không hầm bí, mang lại cảm giác thoải mái khi mặc','tin','353100',' ',' ')
insert into sanPham (maSP, tenSP, hinhDD, loaiHang, noiDung, taiKhoan, giaBan, giamGia,ghiChu) 
values ('003', 'Only Check Trouser','/images/product-03.jpg','1',N'Gam màu vàng tươi sáng, màu đỏ nổi bật hay màu đen đơn giản, cho bạn dễ lựa chọn và dễ dàng kết hợp trang phục khác nhau. Chất liệu thun mềm mại, thoáng mát, thấm hút mồ hôi tốt, không hầm bí, mang lại cảm giác thoải mái khi mặc','tin','255000',' ',' ')
insert into sanPham (maSP, tenSP, hinhDD, loaiHang, noiDung, taiKhoan, giaBan, giamGia,ghiChu) 
values ('004', 'Classic Trench Coat','/images/product-04.jpg','1',N'Gam màu vàng tươi sáng, màu đỏ nổi bật hay màu đen đơn giản, cho bạn dễ lựa chọn và dễ dàng kết hợp trang phục khác nhau. Chất liệu thun mềm mại, thoáng mát, thấm hút mồ hôi tốt, không hầm bí, mang lại cảm giác thoải mái khi mặc','tin','750000',' ',' ')
insert into sanPham (maSP, tenSP, hinhDD, loaiHang, noiDung, taiKhoan, giaBan, giamGia,ghiChu) 
values ('005', 'Front Pocket Jumper','/images/product-05.jpg','1',N'Gam màu vàng tươi sáng, màu đỏ nổi bật hay màu đen đơn giản, cho bạn dễ lựa chọn và dễ dàng kết hợp trang phục khác nhau. Chất liệu thun mềm mại, thoáng mát, thấm hút mồ hôi tốt, không hầm bí, mang lại cảm giác thoải mái khi mặc','tin','3475000',' ',' ')
insert into sanPham (maSP, tenSP, hinhDD, loaiHang, noiDung, taiKhoan, giaBan, giamGia,ghiChu) 
values ('006', 'Vintage Inspired Classic','/images/product-06.jpg','1',N'Gam màu vàng tươi sáng, màu đỏ nổi bật hay màu đen đơn giản, cho bạn dễ lựa chọn và dễ dàng kết hợp trang phục khác nhau. Chất liệu thun mềm mại, thoáng mát, thấm hút mồ hôi tốt, không hầm bí, mang lại cảm giác thoải mái khi mặc','tin','750000',' ',' ')
insert into sanPham (maSP, tenSP, hinhDD, loaiHang, noiDung, taiKhoan, giaBan, giamGia,ghiChu) 
values ('007', 'Shirt in Stretch Cotton','/images/product-07.jpg','1',N'Gam màu vàng tươi sáng, màu đỏ nổi bật hay màu đen đơn giản, cho bạn dễ lựa chọn và dễ dàng kết hợp trang phục khác nhau. Chất liệu thun mềm mại, thoáng mát, thấm hút mồ hôi tốt, không hầm bí, mang lại cảm giác thoải mái khi mặc','tin','932000',' ',' ')
insert into sanPham (maSP, tenSP, hinhDD, loaiHang, noiDung, taiKhoan, giaBan, giamGia,ghiChu) 
values ('008', 'Pieces Metallic Printed','/images/product-08.jpg','1',N'Gam màu vàng tươi sáng, màu đỏ nổi bật hay màu đen đơn giản, cho bạn dễ lựa chọn và dễ dàng kết hợp trang phục khác nhau. Chất liệu thun mềm mại, thoáng mát, thấm hút mồ hôi tốt, không hầm bí, mang lại cảm giác thoải mái khi mặc','tin','526600',' ',' ')
insert into sanPham (maSP, tenSP, hinhDD, loaiHang, noiDung, taiKhoan, giaBan, giamGia,ghiChu) 
values ('009', 'Converse All Star Hi Plimsolls','/images/product-09.jpg','1',N'Gam màu vàng tươi sáng, màu đỏ nổi bật hay màu đen đơn giản, cho bạn dễ lựa chọn và dễ dàng kết hợp trang phục khác nhau. Chất liệu thun mềm mại, thoáng mát, thấm hút mồ hôi tốt, không hầm bí, mang lại cảm giác thoải mái khi mặc','tin','189600',' ',' ')
insert into sanPham (maSP, tenSP, hinhDD, loaiHang, noiDung, taiKhoan, giaBan, giamGia,ghiChu) 
values ('010', 'Femme T-Shirt In Stripe','/images/product-10.jpg','1',N'Gam màu vàng tươi sáng, màu đỏ nổi bật hay màu đen đơn giản, cho bạn dễ lựa chọn và dễ dàng kết hợp trang phục khác nhau. Chất liệu thun mềm mại, thoáng mát, thấm hút mồ hôi tốt, không hầm bí, mang lại cảm giác thoải mái khi mặc','tin','750000',' ',' ')
insert into sanPham (maSP, tenSP, hinhDD, loaiHang, noiDung, taiKhoan, giaBan, giamGia,ghiChu) 
values ('011', 'Herschel supply','/images/product-11.jpg','1',N'Gam màu vàng tươi sáng, màu đỏ nổi bật hay màu đen đơn giản, cho bạn dễ lựa chọn và dễ dàng kết hợp trang phục khác nhau. Chất liệu thun mềm mại, thoáng mát, thấm hút mồ hôi tốt, không hầm bí, mang lại cảm giác thoải mái khi mặc','tin','258500',' ',' ')
insert into sanPham (maSP, tenSP, hinhDD, loaiHang, noiDung, taiKhoan, giaBan, giamGia,ghiChu) 
values ('012', 'Herschel supply','/images/product-12.jpg','1',N'Gam màu vàng tươi sáng, màu đỏ nổi bật hay màu đen đơn giản, cho bạn dễ lựa chọn và dễ dàng kết hợp trang phục khác nhau. Chất liệu thun mềm mại, thoáng mát, thấm hút mồ hôi tốt, không hầm bí, mang lại cảm giác thoải mái khi mặc','tin','631500',' ',' ')
insert into sanPham (maSP, tenSP, hinhDD, loaiHang, noiDung, taiKhoan, giaBan, giamGia,ghiChu) 
values ('013', 'T-Shirt with Sleeve','/images/product-13.jpg','1',N'Gam màu vàng tươi sáng, màu đỏ nổi bật hay màu đen đơn giản, cho bạn dễ lựa chọn và dễ dàng kết hợp trang phục khác nhau. Chất liệu thun mềm mại, thoáng mát, thấm hút mồ hôi tốt, không hầm bí, mang lại cảm giác thoải mái khi mặc','tin','184900',' ',' ')
insert into sanPham (maSP, tenSP, hinhDD, loaiHang, noiDung, taiKhoan, giaBan, giamGia,ghiChu) 
values ('014', 'Pretty Little Thing','/images/product-14.jpg','1',N'Gam màu vàng tươi sáng, màu đỏ nổi bật hay màu đen đơn giản, cho bạn dễ lựa chọn và dễ dàng kết hợp trang phục khác nhau. Chất liệu thun mềm mại, thoáng mát, thấm hút mồ hôi tốt, không hầm bí, mang lại cảm giác thoải mái khi mặc','tin','547900',' ',' ')
insert into sanPham (maSP, tenSP, hinhDD, loaiHang, noiDung, taiKhoan, giaBan, giamGia,ghiChu) 
values ('015', 'Mini Silver Mesh Watch','/images/product-15.jpg','1',N'Gam màu vàng tươi sáng, màu đỏ nổi bật hay màu đen đơn giản, cho bạn dễ lựa chọn và dễ dàng kết hợp trang phục khác nhau. Chất liệu thun mềm mại, thoáng mát, thấm hút mồ hôi tốt, không hầm bí, mang lại cảm giác thoải mái khi mặc','tin','868500',' ',' ')
insert into sanPham (maSP, tenSP, hinhDD, loaiHang, noiDung, taiKhoan, giaBan, giamGia,ghiChu) 
values ('016', 'Square Neck Back','/images/product-16.jpg','1',N'Gam màu vàng tươi sáng, màu đỏ nổi bật hay màu đen đơn giản, cho bạn dễ lựa chọn và dễ dàng kết hợp trang phục khác nhau. Chất liệu thun mềm mại, thoáng mát, thấm hút mồ hôi tốt, không hầm bí, mang lại cảm giác thoải mái khi mặc','tin','296400',' ',' ')


