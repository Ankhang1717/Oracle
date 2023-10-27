create table KHACHHANG (
    MAKHACHHANG char(5) primary key,
    TENCONGTY nvarchar2(50),
    TENGIAODICH nvarchar2(50),
    DIACHI nvarchar2(50),
    EMAIL varchar2(50),
    DIENTHOAI char(10),
    FAX char(10)
);

create table NHANVIEN (
    MANHANVIEN char(5) primary key,
    HO nchar(10),
    TEN nchar(10),
    NGAYSINH date,
    NGAYLAMVIEC date,
    DIACHI nvarchar2(50),
    DIENTHOAI char(10),
    LUONGCOBAN number,
    PHUCAP number
);

create table DONDATHANG (
    SOHOADON char(5) primary key,
    MAKHACHHANG char(5),
    MANHANVIEN char(5),
    NGAYDATHANG date,
    NGAYGIAOHANG date,
    NGAYCHUYENHANG date,
    NOIGIAOHANG nvarchar2(50),
    constraint mkh_fk foreign key (MAKHACHHANG) references KHACHHANG (MAKHACHHANG),
    constraint mnv_fk foreign key (MANHANVIEN) references NHANVIEN (MANHANVIEN)
);
drop table dondathang;

create table NHACUNGCAP (
    MACONGTY char(10) primary key,
    TENCONGTY nvarchar2(50),
    TENGIAODICH nvarchar2(50),
    DIACHI nvarchar2(50),
    DIENTHOAI char(10),
    FAX char(10),
    EMAIL varchar2(50)
);

create table LOAIHANG (
    MALOAIHANG char(10) primary key,
    TENLOAIHANG nvarchar2(50)
);

create table MATHANG (
    MAHANG char(10) primary key,
    TENHANG nvarchar2(50),
    MACONGTY char(10),
    MALOAIHANG char(10),
    SOLUONG number,
    DONVITINH nvarchar2(20),
    GIAHANG number,
    constraint mct_fk foreign key (MACONGTY) references NHACUNGCAP (MACONGTY),
    constraint mlh_fk foreign key (MALOAIHANG) references LOAIHANG (MALOAIHANG)
);

create table CHITIETDATHANG(
    SOHOADON char(5),
    MAHANG char(10),
    GIABAN number,
    SOLUONG number,
    MUCGIAMGIA nvarchar2(20),
    constraint shd_fk foreign key (SOHOADON) references DONDATHANG (SOHOADON),
    constraint mh_fk foreign key (MAHANG) references MATHANG (MAHANG)
);

drop table CHITIETDATHANG;

alter table CHITIETDATHANG
add constraint PK_CHITIETDATHANG primary key (SOHOADON, MAHANG);


ALTER TABLE DONDATHANG
ADD CONSTRAINT CK_GH_DH CHECK (NgayGiaoHang > NgayDatHang);

ALTER TABLE DONDATHANG
ADD CONSTRAINT CK_GH_CH CHECK (NgayChuyenHang > NgayGiaoHang);

ALTER TABLE NHANVIEN
ADD CONSTRAINT CK_NS_LV CHECK (NGAYLAMVIEC > NGAYSINH);

ALTER TABLE NHANVIEN
ADD CONSTRAINT CK_LUONG CHECK (LUONGCOBAN > 0);
-- 2.
ALTER TABLE CHITIETDATHANG
MODIFY SOLUONG NUMBER DEFAULT 1;

ALTER TABLE CHITIETDATHANG
MODIFY MUCGIAMGIA NUMBER DEFAULT 0;

ALTER TABLE NHANVIEN
ADD CONSTRAINT CK_NS_LV CHECK (NGAYLAMVIEC > NGAYSINH);

-- 4.
ALTER TABLE NHANVIEN
ADD CONSTRAINT check_age
CHECK (TRUNC(MONTHS_BETWEEN(TO_DATE('2023-10-12', 'YYYY-MM-DD'), ngaysinh) / 12) >= 18
       AND TRUNC(MONTHS_BETWEEN(TO_DATE('2023-10-12', 'YYYY-MM-DD'), ngaysinh) / 12) <= 60);


-- Insert d? li?u vào b?ng Nhân Viên
insert into NHANVIEN (MANHANVIEN, HO, TEN, NGAYSINH, NGAYLAMVIEC, DIACHI, DIENTHOAI, LUONGCOBAN,PHUCAP)
values(001, 'Nguyen', 'Duc', to_date('14/02/2002','dd/mm/yyyy'),to_date('12/5/2019','dd/mm/yyyy'), 'Hai Phong', 0378459436, 1000000, 200000);
insert into NHANVIEN (MANHANVIEN, HO, TEN, NGAYSINH, NGAYLAMVIEC, DIACHI, DIENTHOAI, LUONGCOBAN,PHUCAP)
values(002, 'Nguyen', 'Dung', to_date('05/06/2003','dd/mm/yyyy'),to_date('16/7/2020','dd/mm/yyyy'), 'Bac Ninh', 0375989452, 2000000, 300000);
insert into NHANVIEN (MANHANVIEN, HO, TEN, NGAYSINH, NGAYLAMVIEC, DIACHI, DIENTHOAI, LUONGCOBAN,PHUCAP)
values(003, 'Man', 'Dy', to_date('08/04/2003','dd/mm/yyyy'),to_date('23/10/2020','dd/mm/yyyy'), 'Long Bien', 0239489343, 1500000, 100000);
insert into NHANVIEN (MANHANVIEN, HO, TEN, NGAYSINH, NGAYLAMVIEC, DIACHI, DIENTHOAI, LUONGCOBAN,PHUCAP)
values(004, 'Yen', 'Dan', to_date('04/11/2002','dd/mm/yyyy'),to_date('12/11/2021','dd/mm/yyyy'), 'Thach That', 0398489234, 1200000, 80000);
insert into NHANVIEN (MANHANVIEN, HO, TEN, NGAYSINH, NGAYLAMVIEC, DIACHI, DIENTHOAI, LUONGCOBAN,PHUCAP)
values(007, 'Le', 'Khang', to_date('01/01/2003','dd/mm/yyyy'),to_date('17/10/2019','dd/mm/yyyy'), 'Ha Noi City', 0369489543, 5000000, 700000);

select * from nhanvien;

-- Insert d? li?u vào b?ng Khách Hàng
insert into KHACHHANG (MAKHACHHANG, TENCONGTY, TENGIAODICH, DIACHI, EMAIL, DIENTHOAI, FAX)
values(001, 'Cong ty 1 thanh vien', '', 'Ha Noi', 'Vinamilk@vinamilk.com.vn', '0285455555', '0285161226');
insert into KHACHHANG (MAKHACHHANG, TENCONGTY, TENGIAODICH, DIACHI, EMAIL, DIENTHOAI, FAX)
values(002, 'Cong ty mot ba ba bay', '', 'TP Vinh', 'chamsockhachhang@thmilk.vn', '1800545440', '8854297373');
insert into KHACHHANG (MAKHACHHANG, TENCONGTY, TENGIAODICH, DIACHI, EMAIL, DIENTHOAI, FAX)
values(003, 'Cong ty con cua Phuc Du', '', 'Da Lat', 'infor@dalatmilk.vn', '0901778775', '3908934321');
insert into KHACHHANG (MAKHACHHANG, TENCONGTY, TENGIAODICH, DIACHI, EMAIL, DIENTHOAI, FAX)
values(004, 'CLB Rap Tre Ha Noi', '', 'Quang Ngai', 'Info@vinasoy.com', '0053719719', '0055810391');
insert into KHACHHANG (MAKHACHHANG, TENCONGTY, TENGIAODICH, DIACHI, EMAIL, DIENTHOAI, FAX)
values(005, 'Cong ty Tre va Choi', '', 'TP HCM', 'Customer@nutrifood.co.id', '0214607777', '9384982033');

delete from KHACHHANG;
select * from KHACHHANG;

-- Insert d? li?u vào b?ng ??n ??t Hàng
insert into DONDATHANG (SOHOADON, MAKHACHHANG, MANHANVIEN, NGAYDATHANG, NGAYGIAOHANG, NGAYCHUYENHANG, NOIGIAOHANG)
values(100, 002, 004, to_date('06/06/2021', 'dd/mm/yyyy'), to_date('08/06/2021', 'dd/mm/yyyy'), to_date('15/06/2021', 'dd/mm/yyyy'), 'Ha Tay');
insert into DONDATHANG (SOHOADON, MAKHACHHANG, MANHANVIEN, NGAYDATHANG, NGAYGIAOHANG, NGAYCHUYENHANG, NOIGIAOHANG)
values(101, 001, 002, to_date('13/10/2022', 'dd/mm/yyyy'), to_date('15/10/2022', 'dd/mm/yyyy'), to_date('16/10/2022', 'dd/mm/yyyy'), 'Thanh Pho Hoa Cai');
insert into DONDATHANG (SOHOADON, MAKHACHHANG, MANHANVIEN, NGAYDATHANG, NGAYGIAOHANG, NGAYCHUYENHANG, NOIGIAOHANG)
values(108, 005, 007, to_date('20/01/2022', 'dd/mm/yyyy'), to_date('22/01/2022', 'dd/mm/yyyy'), to_date('25/01/2022', 'dd/mm/yyyy'), 'Ha Dong');
insert into DONDATHANG (SOHOADON, MAKHACHHANG, MANHANVIEN, NGAYDATHANG, NGAYGIAOHANG, NGAYCHUYENHANG, NOIGIAOHANG)
values(104, 003, 001, to_date('05/04/2020', 'dd/mm/yyyy'), to_date('15/04/2020', 'dd/mm/yyyy'), to_date('22/04/2020', 'dd/mm/yyyy'), 'Quang Ninh');
insert into DONDATHANG (SOHOADON, MAKHACHHANG, MANHANVIEN, NGAYDATHANG, NGAYGIAOHANG, NGAYCHUYENHANG, NOIGIAOHANG)
values(113, 004, 003, to_date('29/08/2023', 'dd/mm/yyyy'), to_date('03/09/2023', 'dd/mm/yyyy'), to_date('10/09/2023', 'dd/mm/yyyy'), 'Tay Bac');

delete from dondathang;
select * from dondathang;

-- Insert d? li?u vào b?ng Nhà Cung C?p
insert into NHACUNGCAP (MACONGTY, TENCONGTY, TENGIAODICH, DIACHI, DIENTHOAI, FAX, EMAIL)
values(369, 'VINAMILK', '', 'Ha Giang', '0349823944', '0487398453', 'fjeijiwo@gmail.com');
insert into NHACUNGCAP (MACONGTY, TENCONGTY, TENGIAODICH, DIACHI, DIENTHOAI, FAX, EMAIL)
values(781, 'TH TRUE MILK', '', 'Ha Noi', '0983492343', '0982394893', 'diawofjiwfcji@gmail.com');
insert into NHACUNGCAP (MACONGTY, TENCONGTY, TENGIAODICH, DIACHI, DIENTHOAI, FAX, EMAIL)
values(1337, 'DaLat Milk', '', 'Sai Gon', '0389234892', '0349892834', 'motbababayga@gmail.com');
insert into NHACUNGCAP (MACONGTY, TENCONGTY, TENGIAODICH, DIACHI, DIENTHOAI, FAX, EMAIL)
values(537, 'Vinasoy', '', 'Ha Noi', '0398293498', '0348923948', 'ceijiawk@gmail.com');
insert into NHACUNGCAP (MACONGTY, TENCONGTY, TENGIAODICH, DIACHI, DIENTHOAI, FAX, EMAIL)
values(102, 'Nutrifood', '', 'Vung Tau', '0938349823', '0347828343', 'asdfecxi@gmail.com');

delete from nhacungcap;
select * from nhacungcap;

--Insert d? li?u vào b?ng Lo?i Hàng
insert into LOAIHANG(MALOAIHANG, TENLOAIHANG)
values('STKD', 'Sua Tuoi');
insert into LOAIHANG(MALOAIHANG, TENLOAIHANG)
values('NCE', 'Nuoc Cam');
insert into LOAIHANG(MALOAIHANG, TENLOAIHANG)
values('CF', 'Coffee');
insert into LOAIHANG(MALOAIHANG, TENLOAIHANG)
values('SDN', 'Sua Dau');
insert into LOAIHANG(MALOAIHANG, TENLOAIHANG)
values('TOL', 'Tra');
-- Insert d? li?u vào b?ng MATHANG
insert into MATHANG(MAHANG, TENHANG, MACONGTY, MALOAIHANG, SOLUONG, DONVITINH, GIAHANG)
values(001, 'sua dau nanh', 102, 'SDN', 100, 'Loc', 25000);
insert into MATHANG(MAHANG, TENHANG, MACONGTY, MALOAIHANG, SOLUONG, DONVITINH, GIAHANG)
values(003, 'sua tuoi khong duong', 369, 'STKD', 230, 'Loc', 30000);
insert into MATHANG(MAHANG, TENHANG, MACONGTY, MALOAIHANG, SOLUONG, DONVITINH, GIAHANG)
values(005, 'Coffee nguyen chat', 537, 'CF', 350, 'Goi', 5000);
insert into MATHANG(MAHANG, TENHANG, MACONGTY, MALOAIHANG, SOLUONG, DONVITINH, GIAHANG)
values(007, 'Nuoc cam ep', 781, 'NCE', 200, 'Chai', 15000);
insert into MATHANG(MAHANG, TENHANG, MACONGTY, MALOAIHANG, SOLUONG, DONVITINH, GIAHANG)
values(012, 'Tra O Long', 1337, 'TOL', 400, 'Chai', 12000);

-- Insert d? li?u vào b?ng Chi Ti?t ??t Hàng
insert into CHITIETDATHANG(SOHOADON, MAHANG, GIABAN)
values(108, 005, 12000);
insert into CHITIETDATHANG(SOHOADON, MAHANG, GIABAN)
values(113, 012, 17000);
insert into CHITIETDATHANG(SOHOADON, MAHANG, GIABAN)
values(101, 001, 35000);
insert into CHITIETDATHANG(SOHOADON, MAHANG, GIABAN)
values(100, 007, 22000);
insert into CHITIETDATHANG(SOHOADON, MAHANG, GIABAN)
values(104, 003, 38000);


select * from chitietdathang;

