-- Nh?p vào quê quán và cho bi?t s? l??ng ng??i có quê quán ??y
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
    DBMS_OUTPUT.PUT_LINE('S? ng??i có quê ? ?ây là: ' || v_result_count);
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

-- 3. Vi?t th? t?c nh?p vào mã cán b?, tr? v? tên ?? tài và th?i h?n c?a ?? tài c?a cán b? ?ó
Create or replace procedure
huhu (mcb detai.macb%TYPE)
is
v_count NUMBER;
begin
    SELECT COUNT(*) INTO v_count FROM detai WHERE macb = mcb;
        IF v_count = 0 THEN
            dbms_output.put_line('Không có ?? tài');
        ELSE
            FOR rec IN (select tendetai, ngaycuoi - ngaydau as thoihan from detai where macb = mcb) LOOP
                 dbms_output.put_line('ten de tai: ' || rec.tendetai || ', thoi han: ' || rec.thoihan);
            END LOOP;
        END IF;
end;

execute huhu('&mcb');

/* 2. Vi?t hàm tr? v? thông báo ?? tài ?ã ??n h?n, ch?a ??n h?n (còn bao nhiêu ngày)
hay ?ã quá h?n (quá bao nhiêu ngày) khi bi?t mã ?? tài */
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


    
        
        

