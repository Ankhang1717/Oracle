-- B�I TH?C H�NH 2
/* 2.1 C?p nh?t l?i gi� tr? tr??ng NGAYCHUYENHANG c?a nh?ng b?n ghi c�
NGAYCHUYENHANG ch?a x�c ??nh (NULL) trong b?ng DONDATHANG b?ng v?i gi�
tr? c?a tr??ng NGAYDATHANG. */


-- 2.2 T?ng s? l??ng h�ng c?a nh?ng m?t h�ng do c�ng ty VINAMILK cung c?p l�n g?p ?�i.
UPDATE CHITIETDATHANG
SET soluong = soluong * 2
WHERE MAHANG IN (SELECT MAHANG FROM MATHANG WHERE MACONGTY = 369);

/* 2.3 C?p nh?t l?i d? li?u trong b?ng KHACHHANG sao cho n?u t�n c�ng ty v� t�n giao
d?ch c?a kh�ch h�ng tr�ng v?i t�n c�ng ty v� t�n giao d?ch c?a m?t nh� cung c?p n�o ?� th�
??a ch?, ?i?n tho?i, fax v� e-mail ph?i gi?ng nhau. */
UPDATE KHACHHANG KH
SET (DiaChi, DienThoai, Fax, Email) = (
    SELECT NCC.DiaChi, NCC.DienThoai, NCC.Fax, NCC.Email
    FROM NHACUNGCAP NCC
    WHERE KH.TenCongTy = NCC.TenCongTy AND KH.TenGiaoDich = NCC.TenGiaoDich
);
 -- 2.4 T?ng l??ng l�n g?p r??i cho nh?ng nh�n vi�n b�n ???c s? l??ng h�ng nhi?u h?n 100 trong n?m 2013.
UPDATE NHANVIEN
SET LUONGCOBAN = LUONGCOBAN *1.5
WHERE MANHANVIEN IN (SELECT MANHANVIEN FROM DONDATHANG DDT
                            INNER JOIN CHITIETDATHANG CTDT ON DDT.SOHOADON = CTDT.SOHOADON
                     WHERE extract(year from to_date(NGAYDATHANG, 'dd/mm/yy')) = 2013
                     GROUP BY DDT.MANHANVIEN
                     HAVING SUM(SOLUONG) >= 100);

-- 2.5 T?ng ph? c?p l�n b?ng 50% l??ng cho nh?ng nh�n vi�n b�n ???c h�ng nhi?u nh?t.
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

-- 2.6 Gi?m 25% l??ng c?a nh?ng nh�n vi�n trong n?m 2013 kh�ng l?p ???c b?t k? ??n ??t h�ng n�o
UPDATE NHANVIEN
SET LUONGCOBAN = LUONGCOBAN * 0.75
WHERE MANHANVIEN NOT IN (SELECT MANHANVIEN FROM DONDATHANG
                        WHERE EXTRACT(YEAR FROM TO_DATE(NGAYDATHANG, 'dd/mm/yy')) = 2013);

-- 2.7 X�a kh?i b?ng NHANVIEN nh?ng nh�n vi�n ?� l�m vi?c trong c�ng ty qu� 40 n?m
DELETE FROM NHANVIEN
WHERE (sysdate - ngaylamviec)/365 > 40;

-- 2.8 X�a nh?ng ??n ??t h�ng tr??c n?m 2010 ra kh?i c? s? d? li?u
DELETE FROM DONDATHANG
WHERE EXTRACT(YEAR FROM TO_DATE(NGAYDATHANG, 'dd/mm/yy')) < 2010;

-- 2.9 X�a kh?i b?ng LOAIHANG nh?ng lo?i h�ng hi?n kh�ng c� m?t h�ng
DELETE FROM LOAIHANG
WHERE MALOAIHANG IN (SELECT MAHANG FROM MATHANG WHERE SOLUONG = 0);

-- 2.10 X�a kh?i b?ng LOAIHANG nh?ng m?t h�ng c� s? l??ng b?ng 0 v� kh�ng ???c ??t mua trong b?t k� ???n ??t h�ng n�o
DELETE FROM LOAIHANG
WHERE MALOAIHANG IN (SELECT mh.MAHANG FROM MATHANG MH 
                        LEFT JOIN CHITIETDATHANG CTDH ON MH.MAHANG = CTDH.MAHANG
                       WHERE MH.SOLUONG = 0 AND SOHOADON is null);
                       
-- Th?c hi?n truy v?n:
-- 2.11 Cho bi?t danh s�ch c�c ??i t�c cung c?p h�ng cho c�ng ty
SELECT * FROM NHACUNGCAP;

-- 2.12 M� h�ng, t�n h�ng v� s? l??ng c?a c�c m?t h�ng hi?n c� trong c�ng ty
SELECT MAHANG, TENHANG, SOLUONG FROM MATHANG;

-- 2.13 H? t�n v� ??a ch? v� n?m b?t ??u l�m vi?c c?a c�c nh�n vi�n trong c�ng ty
SELECT HO, TEN, DIACHI, EXTRACT(YEAR FROM NGAYLAMVIEC) as nam FROM NHANVIEN;

-- 2.14 Cho bi?t m� v� t�n c?a c�c m?t h�ng c� gi� l?n h?n 100000 v� s? l??ng hi?n c� �t h?n 50
SELECT MAHANG, TENHANG FROM MATHANG
WHERE GIAHANG > 100000 AND SOLUONG < 50;

-- 2.15 Cho bi?t m?i m?t h�ng trong c�ng ty do ai cung c?p
SELECT MAHANG, MACONGTY FROM MATHANG;

-- 2.16 Lo?i h�ng "th?c ph?m" do nh?ng c�ng ty n�o cung c?p v� ??a ch? c?a c�c c�ng ty ?� l� g�?
SELECT TENHANG, NCC.MACONGTY, DIACHI FROM MATHANG MH
INNER JOIN NHACUNGCAP NCC ON MH.MACONGTY = NCC.MACONGTY
INNER JOIN LOAIHANG LH ON MH.MAHANG = LH.MALOAIHANG
WHERE TENLOAIHANG = 'Thuc Pham';

-- 2.17 ??n ??t h�ng s? 1 do ai ??t v� do nh�n vi�n n�o l?p, th?i gian v� ??a ?i?m giao h�ng l� ? ?�u?
SELECT MANHANVIEN, NGAYDATHANG, NOIGIAOHANG FROM DONDATHANG 
WHERE SOHOADON = 1;

-- 2.18 H�y cho bi?t s? ti?n l??ng m� c�ng ty ph?i tr? cho m?i nh�n vi�n l� bao nhi�u (l??ng = l??ng c? b?n + ph? c?p)
SELECT LUONGCOBAN + Phucap as LUONG FROM NHANVIEN;

/* 2.19 Trong ??n ??t h�ng s? 3 ??t mua nh?ng m?t h�ng n�o v�
s? ti?n m� kh�ch h�ng ph?i tr? cho m?i m?t h�ng l� bao nhi�u 
(s? ti?n ph?i tr? ???c t�nh theo c�ng th?c:
SOLUONGxGIABAN - SOLUONGxGIABANxMUCGIAMGIA/100) */
SELECT TENHANG, CTDH.SOLUONG * GIABAN - CTDH.SOLUONG * GIABAN * MUCGIAMGIA/100 as PHAITRA FROM DONDATHANG DDH
INNER JOIN CHITIETDATHANG CTDH ON DDH.SOHOADON = CTDH.SOHOADON
INNER JOIN MATHANG MH ON CTDH.MAHANG = MH.MAHANG
WHERE DDH.SOHOADON = 3;

-- 2.20 Trong c�ng ty c� nh?ng nh�n vi�n n�o c� c�ng ng�y sinh?


-- 2.21 Nh?ng ??n ??t h�ng n�o y�u c?u giao h�ng ngay t?i c�ng ty ??t h�ng v� nh?ng ??n ?� l� c?a c�ng ty n�o?
SELECT TENCONGTY FROM DONDATHANG DDH
INNER JOIN KHACHHANG KH ON DDH.MAKHACHHANG = KH.MAKHACHHANG
WHERE NOIGIAOHANG = DIACHI;

-- 2.22 Nh?ng m?t h�ng n�o ch?a t?ng ???c kh�ch h�ng ??t mua?
SELECT TENHANG FROM MATHANG MH 
LEFT JOIN CHITIETDATHANG CTDH ON MH.MAHANG = CTDH.MAHANG 
WHERE SOHOADON is null;

-- 2.23 Nh?ng nh�n vi�n n�o c?a c�ng ty c� l??ng c? b?n cao nh?t?
SELECT MANHANVIEN, TEN FROM NHANVIEN 
WHERE LUONGCOBAN = (SELECT MAX(LUONGCOBAN) FROM NHANVIEN);

/* 2.24 Trong b?ng nh�n vi�n, cho danh s�ch c�c nh�n vi�n g?m m� nh�n vi�n,
t�n nh�n vi�n, ng�y sinh, ??a ch?, th�m ni�n. Trong ?�, th�m ni�n t�nh ???c
d?a v�o ng�y l�m vi?c */
SELECT MANHANVIEN, TEN, NGAYSINH, DIACHI,
        CASE
            WHEN sysdate - ngaylamviec > 10 THEN 'Lau nam'
            ELSE 'Chua lau'
        END as thamnien
FROM NHANVIEN;

-- 2.25 Cho danh s�ch c�c nh�n vi�n g?m c�c th�ng tin: M� nh�n vi�n, t�n, ??a ch?, tu?i
SELECT MANHANVIEN, TEN, DIACHI FROM NHANVIEN;

/* 2.26 Trong b?ng m?t h�ng, cho danh s�ch c�c m?t h�ng g?m m� m?t h�ng,
t�n m?t h�ng, m� lo?i h�ng, gi�, ?�nh gi�. Trong ?�, c?t ?�nh gi� t�nh ???c
d?a v�o s? l??ng, n?u s? l??ng nh? h?n 100 l� "�t", t? 100 ??n 200 l� "trung b�nh"
c�n tr�n 200 l� "nhi?u" */
SELECT MH.MAHANG, MH.TENHANG, MH.GIAHANG, 
        CASE
            WHEN MH.SOLUONG < 100 THEN 'It'
            WHEN MH.SOLUONG BETWEEN 100 AND 199 THEN 'Trung binh'
            ELSE 'Nhieu'
        END as danhgia
FROM MATHANG MH;


-- 2.27 M?i nh�n vi�n l?p ???c bao nhi�u h�a ??n ??t h�ng
SELECT NV.MANHANVIEN, count(*) FROM NHANVIEN NV
INNER JOIN DONDATHANG DDH ON NV.MANHANVIEN = DDH.MANHANVIEN
GROUP BY NV.MANHANVIEN;

-- 2.28 Cho bi?t m?i nh� cung c?p ?� cung c?p m?t h�ng n�o ??y v?i s? l??ng nhi?u nh?t l� bao nhi�u
SELECT distinct NCC.MACONGTY, TENHANG, SOLUONG FROM NHACUNGCAP NCC
INNER JOIN MATHANG MH ON NCC.MACONGTY = MH.MACONGTY
ORDER BY SOLUONG desc;