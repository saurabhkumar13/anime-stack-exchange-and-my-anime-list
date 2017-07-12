create or replace type kdarray is varray(4) of FLOAT; -- k*d
create or replace type karray is varray(2) of NUMBER; -- k
create or replace type narray is varray(40) of NUMBER; -- k
/
declare
k integer:=2;
d number:=2;
n number:=20;
means1 kdarray:=kdarray();
means2 kdarray:=kdarray();
num karray:=karray();
dat narray;
type col_array is varray(2) of VARCHAR2(100);
cols col_array := col_array('x','y');
plsql_block VARCHAR2(500);
dis float;
mdis float;
mcls number;
begin
    merge into test using dual on (1=1) when matched then update set test.class=randomClass(k);
    means1.extend(k*d);
    means2.extend(k*d);
    num.extend(k);

-- Initializing with zeros

    for i in 1 .. k*d
    loop
        means1(i):=0;
        means2(i):=0;
    end loop;

    for i in 1 .. k
    loop
        num(i) := 0;
    end loop;

-- Expectation
    for cls in 1..k
    loop
        for dim in 1..d
        loop
            plsql_block:='select avg(c'||TO_CHAR(dim)||') from test where class=:bind_cls';
            execute immediate plsql_block into means1((cls-1)*d+dim) using cls;
        end loop;    
    end loop;    
-- Minimization
    
    plsql_block:='SELECT ';
    for j in 1..d
    loop
        plsql_block := plsql_block 
    end loop;            

    open cur;
    loop
        fetch cur into rec;
        exit when cur%NOTFOUND;
        for i in 1..k
        loop
        end loop;
--        update test set class=1 where id=rec.id;
    end loop;     
end;
/