-- BÀI TH?C HÀNH 2
/* 2.1 C?p nh?t l?i giá tr? tr??ng NGAYCHUYENHANG c?a nh?ng b?n ghi có
NGAYCHUYENHANG ch?a xác ??nh (NULL) trong b?ng DONDATHANG b?ng v?i giá
tr? c?a tr??ng NGAYDATHANG. */


-- 2.2 T?ng s? l??ng hàng c?a nh?ng m?t hàng do công ty VINAMILK cung c?p lên g?p ?ôi.
UPDATE CHITIETDATHANG
SET soluong = soluong * 2
WHERE MAHANG IN (SELECT MAHANG FROM MATHANG WHERE MACONGTY = 369);

/* 2.3 C?p nh?t l?i d? li?u trong b?ng KHACHHANG sao cho n?u tên công ty và tên giao
d?ch c?a khách hàng trùng v?i tên công ty và tên giao d?ch c?a m?t nhà cung c?p nào ?ó thì
??a ch?, ?i?n tho?i, fax và e-mail ph?i gi?ng nhau. */
UPDATE KHACHHANG KH
SET (DiaChi, DienThoai, Fax, Email) = (
    SELECT NCC.DiaChi, NCC.DienThoai, NCC.Fax, NCC.Email
    FROM NHACUNGCAP NCC
    WHERE KH.TenCongTy = NCC.TenCongTy AND KH.TenGiaoDich = NCC.TenGiaoDich
);
 -- 2.4 T?ng l??ng lên g?p r??i cho nh?ng nhân viên bán ???c s? l??ng hàng nhi?u h?n 100 trong n?m 2013.
UPDATE NHANVIEN
SET LUONGCOBAN = LUONGCOBAN *1.5
WHERE MANHANVIEN IN (SELECT MANHANVIEN FROM DONDATHANG DDT
                            INNER JOIN CHITIETDATHANG CTDT ON DDT.SOHOADON = CTDT.SOHOADON
                     WHERE extract(year from to_date(NGAYDATHANG, 'dd/mm/yy')) = 2013
                     GROUP BY DDT.MANHANVIEN
                     HAVING SUM(SOLUONG) >= 100);

-- 2.5 T?ng ph? c?p lên b?ng 50% l??ng cho nh?ng nhân viên bán ???c hàng nhi?u nh?t.
UPDATE NHANVIEN
SET PHUCAP = LuongCOBAN * 0.5
WHERE MANHANVIEN IN (
    SELECT MANHANVIEN
    FROM (
        SELECT NV.MANHANVIEN, SUM(CTDH.SOLUONG) AS TONG_SOLUONG
        FROM NHANVIEN NV
        JOIN DONDATHANG DH ON NV.MANHANVIEN = DH.MANHANVIEN
        JOIN CHITIETDATHANG CTDH ON DH.SOHOADON = CTDH.SOHOADON
        GROUP BY NV.MANHANVIEN
        ORDER BY TONG_SOLUONG DESC
    )
    WHERE ROWNUM = 1
);

-- 2.6 Gi?m 25% l??ng c?a nh?ng nhân viên trong n?m 2013 không l?p ???c b?t k? ??n ??t hàng nào
UPDATE NHANVIEN
SET LUONGCOBAN = LUONGCOBAN * 0.75
WHERE MANHANVIEN NOT IN (SELECT MANHANVIEN FROM DONDATHANG
                        WHERE EXTRACT(YEAR FROM TO_DATE(NGAYDATHANG, 'dd/mm/yy')) = 2013);

-- 2.7 Xóa kh?i b?ng NHANVIEN nh?ng nhân viên ?ã làm vi?c trong công ty quá 40 n?m
DELETE FROM NHANVIEN
WHERE (sysdate - ngaylamviec)/365 > 40;

-- 2.8 Xóa nh?ng ??n ??t hàng tr??c n?m 2010 ra kh?i c? s? d? li?u
DELETE FROM DONDATHANG
WHERE EXTRACT(YEAR FROM TO_DATE(NGAYDATHANG, 'dd/mm/yy')) < 2010;

-- 2.9 Xóa kh?i b?ng LOAIHANG nh?ng lo?i hàng hi?n không có m?t hàng
DELETE FROM LOAIHANG
WHERE MALOAIHANG IN (SELECT MAHANG FROM MATHANG WHERE SOLUONG = 0);

-- 2.10 Xóa kh?i b?ng LOAIHANG nh?ng m?t hàng có s? l??ng b?ng 0 và không ???c ??t mua trong b?t kì ???n ??t hàng nào
DELETE FROM LOAIHANG
WHERE MALOAIHANG IN (SELECT mh.MAHANG FROM MATHANG MH 
                        LEFT JOIN CHITIETDATHANG CTDH ON MH.MAHANG = CTDH.MAHANG
                       WHERE MH.SOLUONG = 0 AND SOHOADON is null);
                       
-- Th?c hi?n truy v?n:
-- 2.11 Cho bi?t danh sách các ??i tác cung c?p hàng cho công ty
SELECT * FROM NHACUNGCAP;

-- 2.12 Mã hàng, tên hàng và s? l??ng c?a các m?t hàng hi?n có trong công ty
SELECT MAHANG, TENHANG, SOLUONG FROM MATHANG;

-- 2.13 H? tên và ??a ch? và n?m b?t ??u làm vi?c c?a các nhân viên trong công ty
SELECT HO, TEN, DIACHI, EXTRACT(YEAR FROM NGAYLAMVIEC) as nam FROM NHANVIEN;

-- 2.14 Cho bi?t mã và tên c?a các m?t hàng có giá l?n h?n 100000 và s? l??ng hi?n có ít h?n 50
SELECT MAHANG, TENHANG FROM MATHANG
WHERE GIAHANG > 100000 AND SOLUONG < 50;

-- 2.15 Cho bi?t m?i m?t hàng trong công ty do ai cung c?p
SELECT MAHANG, MACONGTY FROM MATHANG;

-- 2.16 Lo?i hàng "th?c ph?m" do nh?ng công ty nào cung c?p và ??a ch? c?a các công ty ?ó là gì?
SELECT TENHANG, NCC.MACONGTY, DIACHI FROM MATHANG MH
INNER JOIN NHACUNGCAP NCC ON MH.MACONGTY = NCC.MACONGTY
INNER JOIN LOAIHANG LH ON MH.MAHANG = LH.MALOAIHANG
WHERE TENLOAIHANG = 'Thuc Pham';

-- 2.17 ??n ??t hàng s? 1 do ai ??t và do nhân viên nào l?p, th?i gian và ??a ?i?m giao hàng là ? ?âu?
SELECT MANHANVIEN, NGAYDATHANG, NOIGIAOHANG FROM DONDATHANG 
WHERE SOHOADON = 1;

-- 2.18 Hãy cho bi?t s? ti?n l??ng mà công ty ph?i tr? cho m?i nhân viên là bao nhiêu (l??ng = l??ng c? b?n + ph? c?p)
SELECT LUONGCOBAN + Phucap as LUONG FROM NHANVIEN;

/* 2.19 Trong ??n ??t hàng s? 3 ??t mua nh?ng m?t hàng nào và
s? ti?n mà khách hàng ph?i tr? cho m?i m?t hàng là bao nhiêu 
(s? ti?n ph?i tr? ???c tính theo công th?c:
SOLUONGxGIABAN - SOLUONGxGIABANxMUCGIAMGIA/100) */
SELECT TENHANG, CTDH.SOLUONG * GIABAN - CTDH.SOLUONG * GIABAN * MUCGIAMGIA/100 as PHAITRA FROM DONDATHANG DDH
INNER JOIN CHITIETDATHANG CTDH ON DDH.SOHOADON = CTDH.SOHOADON
INNER JOIN MATHANG MH ON CTDH.MAHANG = MH.MAHANG
WHERE DDH.SOHOADON = 3;

-- 2.20 Trong công ty có nh?ng nhân viên nào có cùng ngày sinh?


-- 2.21 Nh?ng ??n ??t hàng nào yêu c?u giao hàng ngay t?i công ty ??t hàng và nh?ng ??n ?ó là c?a công ty nào?
SELECT TENCONGTY FROM DONDATHANG DDH
INNER JOIN KHACHHANG KH ON DDH.MAKHACHHANG = KH.MAKHACHHANG
WHERE NOIGIAOHANG = DIACHI;

-- 2.22 Nh?ng m?t hàng nào ch?a t?ng ???c khách hàng ??t mua?
SELECT TENHANG FROM MATHANG MH 
LEFT JOIN CHITIETDATHANG CTDH ON MH.MAHANG = CTDH.MAHANG 
WHERE SOHOADON is null;

-- 2.23 Nh?ng nhân viên nào c?a công ty có l??ng c? b?n cao nh?t?
SELECT MANHANVIEN, TEN FROM NHANVIEN 
WHERE LUONGCOBAN = (SELECT MAX(LUONGCOBAN) FROM NHANVIEN);

/* 2.24 Trong b?ng nhân viên, cho danh sách các nhân viên g?m mã nhân viên,
tên nhân viên, ngày sinh, ??a ch?, thâm niên. Trong ?ó, thâm niên tính ???c
d?a vào ngày làm vi?c */
SELECT MANHANVIEN, TEN, NGAYSINH, DIACHI,
        CASE
            WHEN sysdate - ngaylamviec > 10 THEN 'Lau nam'
            ELSE 'Chua lau'
        END as thamnien
FROM NHANVIEN;

-- 2.25 Cho danh sách các nhân viên g?m các thông tin: Mã nhân viên, tên, ??a ch?, tu?i
SELECT MANHANVIEN, TEN, DIACHI FROM NHANVIEN;

/* 2.26 Trong b?ng m?t hàng, cho danh sách các m?t hàng g?m mã m?t hàng,
tên m?t hàng, mã lo?i hàng, giá, ?ánh giá. Trong ?ó, c?t ?ánh giá tính ???c
d?a vào s? l??ng, n?u s? l??ng nh? h?n 100 là "ít", t? 100 ??n 200 là "trung bình"
còn trên 200 là "nhi?u" */
SELECT MH.MAHANG, MH.TENHANG, MH.GIAHANG, 
        CASE
            WHEN MH.SOLUONG < 100 THEN 'It'
            WHEN MH.SOLUONG BETWEEN 100 AND 199 THEN 'Trung binh'
            ELSE 'Nhieu'
        END as danhgia
FROM MATHANG MH;


-- 2.27 M?i nhân viên l?p ???c bao nhiêu hóa ??n ??t hàng
SELECT NV.MANHANVIEN, count(*) FROM NHANVIEN NV
INNER JOIN DONDATHANG DDH ON NV.MANHANVIEN = DDH.MANHANVIEN
GROUP BY NV.MANHANVIEN;

-- 2.28 Cho bi?t m?i nhà cung c?p ?ã cung c?p m?t hàng nào ??y v?i s? l??ng nhi?u nh?t là bao nhiêu
SELECT distinct NCC.MACONGTY, TENHANG, SOLUONG FROM NHACUNGCAP NCC
INNER JOIN MATHANG MH ON NCC.MACONGTY = MH.MACONGTY
ORDER BY SOLUONG desc;