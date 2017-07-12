create or replace function randomClass (cls in NUMBER)
    RETURN NUMBER
AS
BEGIN
    RETURN floor(dbms_random.value(1,cls+1));
END;
/