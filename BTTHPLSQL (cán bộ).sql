-- CÂU 1: Nh?p vào mã ?? tài, cho bi?t thông tin c?a ?? tài ?ó (tên ?? tài, ngày b?t ??u, ngày k?t thúc, tên cán b?) b?ng PL SQL     
set serveroutput on   
DECLARE
   v_madetai VARCHAR2(10);   -- Bi?n ?? nh?p mã ?? tài t? ng??i dùng
   v_tendetai VARCHAR2(100); -- Bi?n ?? l?u tên ?? tài
   v_ngaybatdau DATE;        -- Bi?n ?? l?u ngày b?t ??u
   v_ngayketthuc DATE;       -- Bi?n ?? l?u ngày k?t thúc
   v_ten_can_bo VARCHAR2(50);-- Bi?n ?? l?u tên cán b?

BEGIN
   -- Yêu c?u ng??i dùng nh?p mã ?? tài
   v_madetai := &v_madetai;

   -- Truy v?n thông tin v? ?? tài d?a vào mã ?? tài
   SELECT tendetai, ngaydau, ngaycuoi, tencb
   INTO v_tendetai, v_ngaybatdau, v_ngayketthuc, v_ten_can_bo
   FROM detai dt
   INNER JOIN canbo cb on dt.macb = cb.macb
   WHERE madetai = v_madetai;

   -- Xu?t thông tin ?? tài
   DBMS_OUTPUT.PUT_LINE('Mã ?? tài: ' || v_madetai);
   DBMS_OUTPUT.PUT_LINE('Tên ?? tài: ' || v_tendetai);
   DBMS_OUTPUT.PUT_LINE('Ngày b?t ??u: ' || TO_CHAR(v_ngaybatdau, 'dd/mm/yyyy'));
   DBMS_OUTPUT.PUT_LINE('Ngày k?t thúc: ' || TO_CHAR(v_ngayketthuc, 'dd/mm/yyyy'));
   DBMS_OUTPUT.PUT_LINE('Tên cán b?: ' || v_ten_can_bo);
END;

-- CÂU 2: Cho bi?t danh sách các ?? tài c?a cán b? có mã là 'cb1'
set serveroutput on
DECLARE
    ma_can_bo nvarchar2(20) := 'cb1';
    ten_de_tai nvarchar2(50);
BEGIN
    FOR rec IN (SELECT tendetai FROM detai WHERE macb = ma_can_bo) LOOP
--    ten_de_tai := rec.tendetai;
    DBMS_OUTPUT.PUT_LINE('Ten de tai: ' || rec.tendetai);
    END LOOP;
END;

-- Bonus: Nh?p mã cán b?, cho bi?t danh sách các ?? tài c?a cán b? ?ó
set serveroutput on
DECLARE
    ma_can_bo nvarchar2(20);
    ten_de_tai nvarchar2(50);
BEGIN
    ma_can_bo :=&ma_can_bo;
    FOR rec IN (SELECT tendetai FROM detai WHERE macb = ma_can_bo) LOOP
    DBMS_OUTPUT.PUT_LINE('Ten de tai: ' || rec.tendetai);
    END LOOP;
END;

DECLARE
    ma_can_bo nvarchar2(20);
    thong_bao nvarchar2(20);
BEGIN
    ma_can_bo :=&ma_can_bo;
    SELECT count(*) INTO thong_bao FROM DETAI WHERE ma_can_bo = macb;
    
    IF thong_bao > 0 THEN DBMS_OUTPUT.PUT_LINE('Can bo co de tai');
    ELSE DBMS_OUTPUT.PUT_LINE('Can bo khong co de tai');
    END IF;
END;
-- CÂU 3: Cho bi?t danh sách các cán b? có quê ? Hà N?i
SET SERVEROUTPUT ON
DECLARE 
    que_quan nvarchar2(50) :='Ha Noi';
    ma_can_bo nvarchar2(5);
BEGIN
    FOR rec IN (SELECT macb FROM canbo WHERE quequan = que_quan) LOOP
    ma_can_bo := rec.macb;
    DBMS_OUTPUT.PUT_LINE('Ma can bo: ' || ma_can_bo);
    END LOOP;
END;

-- CÂU 4: Tr? v? danh sách các ?? tài ?ã h?t h?n
SET SERVEROUTPUT ON
DECLARE 
    Ngay_Cuoi date ;
    ma_de_tai nvarchar2(5);
    ten_de_tai nvarchar2(50);
BEGIN
    FOR rec IN (SELECT madetai, tendetai FROM detai WHERE detai.ngaycuoi < SYSDATE) LOOP
    ma_de_tai := rec.madetai;
    ten_de_tai := rec.tendetai;
    DBMS_OUTPUT.PUT_LINE('Ma de tai: ' || ma_de_tai);
    DBMS_OUTPUT.PUT_LINE('Ten de tai: ' || ten_de_tai);
    END LOOP;
END;

-- CÂU 5: Th?c hi?n vi?c t?ng l??ng cho t?t c? các cán b? có ?? tài, m?i cán b? ???c t?ng thêm 1 tri?u ??ng
/* SET SERVEROUTPUT ON
DECLARE
    ma_can_bo nvarchar2(5);
    LUONG1 CANBO.LUONG%TYPE;
BEGIN
    FOR rec IN (SELECT DISTINCT dt.macb, cb.luong FROM detai dt
                    INNER JOIN canbo cb on cb.macb = dt.macb) LOOP
    ma_can_bo := rec.macb;
    LUONG1 := rec.Luong + 1000000;
    DBMS_OUTPUT.PUT_LINE('Ma can bo: ' || ma_can_bo);
    DBMS_OUTPUT.PUT_LINE('Luong: ' || Luong1);
    END LOOP;
END; */

DECLARE
    tang_luong canbo.luong%TYPE := 1000000;
BEGIN 
    UPDATE canbo
    SET LUONG = LUONG + tang_luong
    WHERE macb IN 
    (SELECT DISTINCT canbo.macb 
     FROM canbo cb INNER JOIN detai dt ON cb.macb = dt.macb);
END;


-- CÂU 6: Cho danh sách các cán b? có ngo?i ng? là Ti?ng Anh
set serveroutput on 
DECLARE
    ngoai_ngu nvarchar2(20) := 'Anh';
    ma_can_bo nvarchar2(5);
BEGIN
    FOR rec IN (SELECT macb FROM ngoaingu WHERE TENNGOAINGU = ngoai_ngu) LOOP
    ma_can_bo := rec.macb;
    DBMS_OUTPUT.PUT_LINE('Ma can bo: ' || ma_can_bo);
    END LOOP;
END;

-- CÂU 7: ??a ra thông báo (??n h?n/h?t h?n/ còn h?n) ??i v?i các ?? tài theo mã ?? tài ??a vào
SET SERVEROUTPUT ON 
DECLARE
    ma_de_tai nvarchar2(10);
    ngay_ket_thuc detai.ngaycuoi%type;
    thong_bao nvarchar2(50);
BEGIN
    ma_de_tai :=&ma_de_tai;
    SELECT ngaycuoi 
    INTO ngay_ket_thuc
    FROM detai WHERE madetai = ma_de_tai; 

    thong_bao := 
        CASE    
            WHEN ngay_ket_thuc < SYSDATE THEN 'het han'
            WHEN ngay_ket_thuc = SYSDATE THEN 'den han'
            WHEN ngay_ket_thuc > SYSDATE THEN 'con han'
        END;
    DBMS_OUTPUT.PUT_LINE('thong bao: '|| thong_bao);
END;

/* CÂU 8: Duy?t toàn b? các ?? tài trong b?ng ?? tài, v?i m?i ?? tài 
ch?a ??n h?n thì gán m?t thông báo: ?? tài th? i (Trong ?ó, i là s? th? t? 
c?a các ?? tài ch?a ??n h?n và b?t ??u t? 1) */
SET SERVEROUTPUT ON
DECLARE
    ma_de_tai nvarchar2(5);
    v_num number :=0;
BEGIN
    FOR rec IN (SELECT madetai FROM detai where ngaycuoi > SYSDATE) LOOP
    ma_de_tai := rec.madetai;
    v_num := v_num + 1;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('De tai thu: '||v_num);
END;
    
    
-- CÂU 9: Xóa ?i các cán b? có l??ng là null
/*
BEGIN
   DELETE FROM canbo 
   where LUONG is null;
END; */
-- B? dính khóa ngo?i, không xóa ???c

-- CÂU 10: Nh?p vào h? tên c?a m?t cán b?, cho ra thông báo cán b? ?ó có t?n t?i trong CSDL hay không
SET SERVEROUTPUT ON
DECLARE
    Ten1 nvarchar2(50);
    Thong_bao number;
BEGIN
    TEN1 :=&TEN1;
    SELECT count(*) INTO Thong_bao FROM canbo WHERE Tencb LIKE '%' || TEN1 || '%';
    
        IF Thong_bao > 0 THEN DBMS_OUTPUT.PUT_LINE('can bo ' || TEN1 || ' ton tai');
        ELSE DBMS_OUTPUT.PUT_LINE('can bo ' || TEN1 || ' khong ton tai');
        END IF;
END;

-- S? khác bi?t gi?a Tencb LIKE '%' || TEN1 || '%' và TEN1 LIKE '%' || tencb || '%' ??
 /* n?u nh? câu l?nh SELECT không tìm th?y d? li?u phù h?p
 v?i ?i?u ki?n tìm ki?m trong CSDL thì s? xu?t hi?n l?i no data found.
 Vì v?y, ph?i th? cách */
 
-- CÂU 11: Cho bi?t các ?? tài h?t h?n vào tháng 11/2013
SET SERVEROUTPUT ON
DECLARE 
    ma_de_tai nvarchar2(20);
BEGIN
    FOR rec IN (SELECT madetai FROM detai WHERE TO_CHAR(ngaycuoi, 'MM') = 11 AND TO_CHAR(ngaycuoi, 'YYYY') = 2013) LOOP
    ma_de_tai := rec.madetai;
    DBMS_OUTPUT.PUT_LINE('De tai het han vao thang 11/2013 la: '|| ma_de_tai);
    END LOOP;
END;



    