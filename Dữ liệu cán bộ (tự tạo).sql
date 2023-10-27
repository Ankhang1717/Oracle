------- T?o b?ng
create table canbo
( macb nvarchar2(5)
CONSTRAINT     cb_pk    PRIMARY KEY,
  tencb nvarchar2(20),
  quequan nvarchar2(16), 
  luong number);
----
create table detai
(madetai nvarchar2(5)
CONSTRAINT     dt_pk    PRIMARY KEY,
tendetai nvarchar2(25),
macb nvarchar2(5),
ngaydau date,
ngaycuoi date ,
CONSTRAINT  dtcb_fk FOREIGN KEY (macb) REFERENCES canbo(macb));
----
create table ngoaingu
(macb nvarchar2(5),
 tenngoaingu nvarchar2(17),
 trinhdo   nvarchar2(2),
CONSTRAINT     nn_pk    PRIMARY KEY (macb,tenngoaingu),
CONSTRAINT  nncb_fk FOREIGN KEY (macb)  REFERENCES    canbo(macb)  ) ;    

----- Nh?p d? li?u
insert into canbo(macb, tencb, quequan,luong)
   values ('cb1', 'Vu Thi Binh', 'Ha Noi',2000000); 
insert into canbo(macb, tencb, quequan,luong)
   values ('cb2', 'Luu Ngoc Duc', 'Ha Nam',3000000); 
insert into canbo(macb, tencb, quequan,luong)
   values ('cb3', 'Tran Thu Ha', 'Nam Dinh',2800000);    
insert into canbo(macb, tencb, quequan,luong)
   values ('cb4', 'Dang Thi Hang','Cao Bang',4000000);    
insert into canbo(macb, tencb, quequan,luong)
   values ('cb5', 'Ha Thi Hien', 'Thanh Hoa',5000000);    
insert into canbo(macb, tencb, quequan,luong)
   values ('cb6', 'Dinh Thuy Hien', 'Bac Ninh',3500000); 
insert into canbo(macb, tencb, quequan,luong)
   values ('cb7', 'Vu Thi Hoa', 'Ha Noi',7000000);  
insert into canbo(macb, tencb, quequan,luong)
   values ('cb8', 'Hoang Thi Hue','Ha Noi',8000000);  
insert into canbo(macb, tencb, quequan,luong)
   values ('cb9', 'Le Viet Hung', 'Ninh Binh',3400000); 
insert into canbo(macb, tencb, quequan,luong)
   values ('cb10', 'Tran Viet Hung','Lang Son',null); 
insert into canbo(macb, tencb, quequan,luong)
   values ('cb11', 'Vu Viet Hung', 'Hai Duong',null); 
insert into canbo(macb, tencb, quequan,luong)
   values ('cb12', 'Pham Quang Huy', 'Hai Duong',null);    
insert into canbo(macb, tencb, quequan,luong)
   values ('cb13', 'Bui Thi Thuong Huyen', '',null);    
insert into canbo(macb, tencb, quequan,luong)
   values ('cb14', 'Do Thi Huyen', 'Lao Cai',2000000);    
insert into canbo(macb, tencb, quequan,luong)
   values ('cb15', 'Vu Thi Ngoc Huyen', 'Hai Phong',3000000);    
insert into canbo(macb, tencb, quequan,luong)
   values ('cb16', 'Dinh Van Hung', '',7000000);    
-------------
insert into detai(madetai,tendetai,macb,ngaydau,ngaycuoi) 
   values ('dt1', 'Quan Ly sinh vien','cb1',to_date('16/1/2012','dd/mm/yyyy'),to_date('16/7/2012','dd/mm/yyyy')) ; 
insert into detai(madetai,tendetai,macb,ngaydau,ngaycuoi) 
   values ('dt2', 'Quan Ly Tien Gui', 'cb2',to_date('1/1/2013','dd/mm/yyyy'),to_date('16/7/2013','dd/mm/yyyy')) ;     
insert into detai(madetai,tendetai,macb,ngaydau,ngaycuoi) 
   values ('dt3', 'Quan Ly Ky tuc xa','cb5',to_date('8/9/2013','dd/mm/yyyy'),to_date('20/11/2013','dd/mm/yyyy')) ;     
insert into detai(madetai,tendetai,macb,ngaydau,ngaycuoi) 
   values ('dt4', 'Quan Ly Ban Hang','cb1',to_date('18/3/2011','dd/mm/yyyy'),to_date('19/8/2011','dd/mm/yyyy')) ;     
insert into detai(madetai,tendetai,macb,ngaydau,ngaycuoi) 
   values ('dt5', 'Quan Ly Diem Thi','cb8',to_date('18/3/2012','dd/mm/yyyy'),to_date('20/11/2013','dd/mm/yyyy')) ;     
insert into detai(madetai,tendetai,macb,ngaydau,ngaycuoi) 
   values ('dt9', 'Tim hieu Core Banking','cb9',('23-APR-2013'),'23-DEC-2013') ;     
insert into detai(madetai,tendetai,macb,ngaydau,ngaycuoi) 
   values ('dt10', 'Tim hieu DSS','cb10',('17-JUL-2013'),'23-JAN-2014') ;     
insert into detai(madetai,tendetai,macb,ngaydau,ngaycuoi) 
   values ('dt11', 'Quan ly rui ro','cb13',('17-JUL-2015'),'23-JAN-2016') ;     
insert into detai(madetai,tendetai,macb,ngaydau,ngaycuoi) 
   values ('dt12', 'Mo hinh du doan no xau','cb15',('20-may-2013'),'20-may-2014') ;     
insert into detai(madetai,tendetai,macb,ngaydau,ngaycuoi) 
   values ('dt16', 'Datamining','cb10',('1-april-2015'),'1-JAN-2016') ;     
insert into detai(madetai,tendetai,macb,ngaydau,ngaycuoi) 
   values ('dt6', 'ERP cho doanh nghiep','',(''),'') ;     
-----------------
insert into ngoaingu(macb,tenngoaingu,trinhdo)
   values ('cb1', 'Anh', 'B1'); 
insert into ngoaingu(macb,tenngoaingu,trinhdo)
   values ('cb1', 'Phap', 'TC');    
insert into ngoaingu(macb,tenngoaingu,trinhdo)
   values ('cb2', 'Anh', 'B2');  
insert into ngoaingu(macb,tenngoaingu,trinhdo)
   values ('cb3', 'Anh', 'C');   
insert into ngoaingu(macb,tenngoaingu,trinhdo)
   values ('cb4', 'Trung Quoc', 'H4');      
insert into ngoaingu(macb,tenngoaingu,trinhdo)
   values ('cb5','Nga','T2');   
insert into ngoaingu(macb,tenngoaingu,trinhdo)
   values ('cb6','Anh',null);  
insert into ngoaingu(macb,tenngoaingu,trinhdo)
   values ('cb9','Anh','C');     
insert into ngoaingu(macb,tenngoaingu,trinhdo)
   values ('cb7','Nga','T3');        
   --------------
select * from detai;   
select * from canbo;  
select * from ngoaingu;

-- ??m s? ?? tài c?a m?i cán b?

select dt.MaCB, TenCB, count(*), ngaydau from detai dt
inner join canbo cb on dt.MaCB = cb.MaCB
group by dt.MaCB, TenCB, ngaydau;

-- S? l??ng ?? tài c?a m?i cán b? = 2 ???c b?t ??u trong n?m 2012
select dt.MaCB, TenCB, count(*) from detai dt 
inner join canbo cb on dt.MaCB = cb.MaCB
where extract(year from to_date(ngaydau, 'dd/mm/yy'))>= 2012
group by dt.MaCB, TenCB
having count(*) = 2;

-- ch?a th?c hi?n ?? tài nào
select * from canbo cb
left outer join detai dt on dt.MaCB = cb.MaCB
where dt.macb is null;

select cb.macb from canbo cb
where not exists (select nn.macb from ngoaingu nn);

select * from ngoaingu

select * from canbo
where QUEQUAN = 'Ha Noi' and LUONG = (Select min(Luong) from canbo)

-- 3.1 Cho bi?t trình ?? ngo?i ng? c?a cán b? làm ?? tài 'dt1'
select nn.macb, trinhdo from ngoaingu nn
inner join detai dt on nn.MaCB = dt.MaCb
where madetai = 'dt1'

-- 3.2 ??m xem m?i cán b? có bao nhiêu ?? tài
select macb, count(*) from detai
group by macb

-- 3.3 ??a ra thông tin MaCB, TenCB, NgoaiNgu c?a nh?ng cán b? có ngo?i ng? là 'Anh'
select cb.MaCB, TenCB, TenNgoaiNgu from canbo cb
inner join NgoaiNgu nn on cb.MaCB = nn.MaCB
where TenNgoaiNgu = 'Anh'

-- 3.4 ??a ra danh sách các cán b? không có ?? tài nào
select cb.MaCB, TenCB from canbo cb
left join detai dt on cb.MaCB = dt.MaCB
where madetai is null

-- 3.6 Cho danh sách thông tin cán b?, tên ?? tài, thông báo (n?i dung là quá h?n, ??n h?n ho?c ch?a ??n h?n d?a vào ngày cu?i ?? tài)
select cb.MaCB,
    TenCB
    TenDeTai, 
    CASE
        WHEN NGAYCUOI < CURRENT_DATE THEN 'OVER DUE'
        WHEN NGAYCUOI = CURRENT_DATE THEN 'DUE'
        WHEN NGAYCUOI > CURRENT_DATE THEN 'UNDUE'
    END AS THONGBAO
from detai dt 
inner join canbo cb on dt.MaCB = cb.MaCB

-- 3.7 Cho danh sách g?m macb, tencb, ti?n th??ng v?i các cán b? có ?? tài ???c th??ng 1000000
select  distinct cb.macb, 
        tencb,
        CASE 
            WHEN madetai is null THEN '0'
            ELSE '1000000'
        END AS TIENTHUONG
from canbo cb
left join detai dt on dt.MaCB = cb.MaCB




-- 3.8 ??m xem m?i t?nh có bao nhiêu cán b?
select QueQuan, count(*) from canbo
group by QUeQUan

-- 3.10. Th?ng kê các ?? tài n?m 2013
select madetai, tendetai from detai
where extract(year from to_date(ngaydau, 'dd/mm/yy'))= 2013
and extract(year from to_date(ngaycuoi, 'dd/mm/yy'))= 2013

-- T?o b?ng ch?c v?
create table ChucVu (
    MaCV nvarchar2 (5) primary key,
    MaCB nvarchar2(5),
    TenCV nvarchar2(50),
    NgayNC date,
    NgayKT date,
    Constraint CV1_FK Foreign key (MaCB) references canbo(macb)
)

insert into ChucVu (MaCV, MaCB, TenCV, NgayNC, NgayKT)
values('GD', 'cb1', 'Giam ?oc', ('17-JAN-2010'), '')
insert into ChucVu (MaCV, MaCB, TenCV, NgayNC, NgayKT)
values('PGD', 'cb3', 'Pho Giam ?oc', ('19-FEB-2010'), '19-FEB-2015');
insert into ChucVu (MaCV, MaCB, TenCV, NgayNC, NgayKT)
values('TPKD', 'cb6', 'Truong Phong Kinh Doanh', ('03-MAR-2011'), '03-MAR-2015');
insert into ChucVu (MaCV, MaCB, TenCV, NgayNC, NgayKT)
values('TPDT', 'cb9', 'Truong Phong Dao Tao', ('10-JUL-2012'), '10-JUL-2014');
insert into ChucVu (MaCV, MaCB, TenCV, NgayNC, NgayKT)
values('TPNS', 'cb5', 'Truong Phong Nhan Su', ('15-DEC-2013'), '15-DEC-2015');

select * from chucvu
