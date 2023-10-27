-- C�U 1: Nh?p v�o m� ?? t�i, cho bi?t th�ng tin c?a ?? t�i ?� (t�n ?? t�i, ng�y b?t ??u, ng�y k?t th�c, t�n c�n b?) b?ng PL SQL     
set serveroutput on   
DECLARE
   v_madetai VARCHAR2(10);   -- Bi?n ?? nh?p m� ?? t�i t? ng??i d�ng
   v_tendetai VARCHAR2(100); -- Bi?n ?? l?u t�n ?? t�i
   v_ngaybatdau DATE;        -- Bi?n ?? l?u ng�y b?t ??u
   v_ngayketthuc DATE;       -- Bi?n ?? l?u ng�y k?t th�c
   v_ten_can_bo VARCHAR2(50);-- Bi?n ?? l?u t�n c�n b?

BEGIN
   -- Y�u c?u ng??i d�ng nh?p m� ?? t�i
   v_madetai := &v_madetai;

   -- Truy v?n th�ng tin v? ?? t�i d?a v�o m� ?? t�i
   SELECT tendetai, ngaydau, ngaycuoi, tencb
   INTO v_tendetai, v_ngaybatdau, v_ngayketthuc, v_ten_can_bo
   FROM detai dt
   INNER JOIN canbo cb on dt.macb = cb.macb
   WHERE madetai = v_madetai;

   -- Xu?t th�ng tin ?? t�i
   DBMS_OUTPUT.PUT_LINE('M� ?? t�i: ' || v_madetai);
   DBMS_OUTPUT.PUT_LINE('T�n ?? t�i: ' || v_tendetai);
   DBMS_OUTPUT.PUT_LINE('Ng�y b?t ??u: ' || TO_CHAR(v_ngaybatdau, 'dd/mm/yyyy'));
   DBMS_OUTPUT.PUT_LINE('Ng�y k?t th�c: ' || TO_CHAR(v_ngayketthuc, 'dd/mm/yyyy'));
   DBMS_OUTPUT.PUT_LINE('T�n c�n b?: ' || v_ten_can_bo);
END;

-- C�U 2: Cho bi?t danh s�ch c�c ?? t�i c?a c�n b? c� m� l� 'cb1'
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

-- Bonus: Nh?p m� c�n b?, cho bi?t danh s�ch c�c ?? t�i c?a c�n b? ?�
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
-- C�U 3: Cho bi?t danh s�ch c�c c�n b? c� qu� ? H� N?i
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

-- C�U 4: Tr? v? danh s�ch c�c ?? t�i ?� h?t h?n
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

-- C�U 5: Th?c hi?n vi?c t?ng l??ng cho t?t c? c�c c�n b? c� ?? t�i, m?i c�n b? ???c t?ng th�m 1 tri?u ??ng
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


-- C�U 6: Cho danh s�ch c�c c�n b? c� ngo?i ng? l� Ti?ng Anh
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

-- C�U 7: ??a ra th�ng b�o (??n h?n/h?t h?n/ c�n h?n) ??i v?i c�c ?? t�i theo m� ?? t�i ??a v�o
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

/* C�U 8: Duy?t to�n b? c�c ?? t�i trong b?ng ?? t�i, v?i m?i ?? t�i 
ch?a ??n h?n th� g�n m?t th�ng b�o: ?? t�i th? i (Trong ?�, i l� s? th? t? 
c?a c�c ?? t�i ch?a ??n h?n v� b?t ??u t? 1) */
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
    
    
-- C�U 9: X�a ?i c�c c�n b? c� l??ng l� null
/*
BEGIN
   DELETE FROM canbo 
   where LUONG is null;
END; */
-- B? d�nh kh�a ngo?i, kh�ng x�a ???c

-- C�U 10: Nh?p v�o h? t�n c?a m?t c�n b?, cho ra th�ng b�o c�n b? ?� c� t?n t?i trong CSDL hay kh�ng
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

-- S? kh�c bi?t gi?a Tencb LIKE '%' || TEN1 || '%' v� TEN1 LIKE '%' || tencb || '%' ??
 /* n?u nh? c�u l?nh SELECT kh�ng t�m th?y d? li?u ph� h?p
 v?i ?i?u ki?n t�m ki?m trong CSDL th� s? xu?t hi?n l?i no data found.
 V� v?y, ph?i th? c�ch */
 
-- C�U 11: Cho bi?t c�c ?? t�i h?t h?n v�o th�ng 11/2013
SET SERVEROUTPUT ON
DECLARE 
    ma_de_tai nvarchar2(20);
BEGIN
    FOR rec IN (SELECT madetai FROM detai WHERE TO_CHAR(ngaycuoi, 'MM') = 11 AND TO_CHAR(ngaycuoi, 'YYYY') = 2013) LOOP
    ma_de_tai := rec.madetai;
    DBMS_OUTPUT.PUT_LINE('De tai het han vao thang 11/2013 la: '|| ma_de_tai);
    END LOOP;
END;



    