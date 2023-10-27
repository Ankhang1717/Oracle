select * from canbo;
select * from detai;

DECLARE que_quan nvarchar2(20);
BEGIN 
    que_quan :=&que_quan;
    FOR rec IN (SELECT dt.macb, tencb, quequan, madetai FROM canbo cb inner join detai dt ON cb.macb = dt.macb) LOOP
    IF que_quan = rec.quequan THEN
    DBMS_OUTPUT.PUT_LINE('Ten can bo do: ' ||rec.tencb|| ' que quan: ' || rec.quequan ||  ' ma de tai: ' || rec.madetai);   
    END IF;
    END LOOP;
END;

SELECT distinct dt.macb, tencb, quequan, madetai FROM canbo cb inner join detai dt ON cb.macb = dt.macb;
                        
    
