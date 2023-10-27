-- Nh?p v�o qu� qu�n v� cho bi?t s? l??ng ng??i c� qu� qu�n ??y
create or replace procedure
hehe (que_quan IN canbo.quequan%TYPE,
      num OUT number)
is
begin 
    select count(*) into num from canbo where quequan = que_quan;
end;

set serveroutput on
DECLARE
    v_result_count NUMBER;
BEGIN
    hehe('&que_quan', v_result_count);
    DBMS_OUTPUT.PUT_LINE('S? ng??i c� qu� ? ?�y l�: ' || v_result_count);
END;
/

-- S? d?ng execute
create or replace procedure
hehe (que_quan canbo.quequan%TYPE,
      num number)
is
begin 
    select count(*) into num from canbo where quequan = que_quan;
end;

variable sl number;
execute hehe('&que_quan', :sl);
print sl;

-- 3. Vi?t th? t?c nh?p v�o m� c�n b?, tr? v? t�n ?? t�i v� th?i h?n c?a ?? t�i c?a c�n b? ?�
Create or replace procedure
huhu (mcb detai.macb%TYPE)
is
v_count NUMBER;
begin
    SELECT COUNT(*) INTO v_count FROM detai WHERE macb = mcb;
        IF v_count = 0 THEN
            dbms_output.put_line('Kh�ng c� ?? t�i');
        ELSE
            FOR rec IN (select tendetai, ngaycuoi - ngaydau as thoihan from detai where macb = mcb) LOOP
                 dbms_output.put_line('ten de tai: ' || rec.tendetai || ', thoi han: ' || rec.thoihan);
            END LOOP;
        END IF;
end;

execute huhu('&mcb');

/* 2. Vi?t h�m tr? v? th�ng b�o ?? t�i ?� ??n h?n, ch?a ??n h?n (c�n bao nhi�u ng�y)
hay ?� qu� h?n (qu� bao nhi�u ng�y) khi bi?t m� ?? t�i */
create or replace function
message (mdt detai.madetai%TYPE)
Return nvarchar2
as
    han nvarchar2(20);
begin 
        select ngaycuoi into han from detai where madetai = mdt;
        IF han < sysdate then return ('da het han');
        ELSIF han = sysdate then return 'da den han';
            ELSE return 'chua den han';
        END IF;
END;

Select message('&mdt') from dual;


    
        
        

