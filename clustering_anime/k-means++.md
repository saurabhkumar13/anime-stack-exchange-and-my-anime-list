# k-means++

```sql
declare
k integer:=4;
d number;
n number;
misc number;
misc2 number;
miscf float;
begin
    delete from test_norm_classes;
-- Initializing no of records, dimensions
    select count(id) into n from test;
    select count(*)-2 into d from user_tab_columns where table_name = 'TEST';
-- initializing means
    delete from test_norm_means;
    misc:=randomClass(n);
    select min(id) into misc2 from test where id>=misc;
    insert into test_norm_means (select att,1,data,0 from test_norm where att<>-1 and id=misc2);
    for i in 1 .. k-1
    loop
        delete from test_norm where att=-1;

        insert into test_norm select id,-1,min(dis) from
            (select id,class,sum((data-mean)*(data-mean)) as dis from test_norm, test_norm_means
                where test_norm.att=test_norm_means.att group by id,class) group by id;


        for rec in (select id from test_norm where att=-1 order by data desc)
        loop

            misc2:=rec.id;

            -- EXIT WHEN randomClass(2)=1 or misc>n;

        end loop;

        insert into test_norm_means
            (select att,i+1,data,0 from test_norm where att<>-1 and id=misc2);

    end loop;
    delete from test_norm where att=-1;
    insert into test_norm_means select att,class,mean+1,1 from test_norm_means;
for jk in  1..1000
loop
dbms_output.put_line(jk);
-- Break Condition

    select max((a.mean-b.mean)*(a.mean-b.mean)) into miscf from
        (select att,class,mean from test_norm_means where ol=0) a,
        (select att,class,mean from test_norm_means where ol=1) b
    where a.class=b.class and a.att=b.att;

    EXIT WHEN miscf=0;

    delete from test_norm_means where ol=1;

-- Minimization

    delete from test_norm_classes;

    insert into test_norm_classes with t as(
    select id,class,sum((data-mean)*(data-mean)) as dis from test_norm, test_norm_means
                        where test_norm.att=test_norm_means.att group by id,class)
    (select id,class from t where dis in (select min(dis) from t group by id));


-- Expectation
--    delete from test_norm_means;
    update test_norm_means set ol=1;

    insert into test_norm_means
        (select att,class,avg(data),0 from test_norm,test_norm_classes
            where test_norm.id=test_norm_classes.id group by att,class);

end loop;

delete from test_norm_means where ol=1;

select sum((data-mean)*(data-mean)) into miscf from test_norm, test_norm_means, test_norm_classes
    where test_norm_classes.class=test_norm_means.class
        and test_norm.att=test_norm_means.att
        and test_norm.id=test_norm_classes.id;
dbms_output.put_line(miscf);
end;
/
```
