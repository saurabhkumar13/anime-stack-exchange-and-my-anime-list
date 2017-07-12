declare
d number;
begin
delete from test_norm;
select count(*)-1 into d from user_tab_columns where table_name = 'TEST';
for i in 1..d
loop
    execute immediate 'insert into test_norm(id,att,data) select id,'||TO_CHAR(i)||',c'||TO_CHAR(i)||' from test';
end loop;
end;
/
drop table test;
drop table test_norm;
drop table test_norm_classes;
drop table test_norm_means;

create table test_norm(
    id number,
    att number,
    data float);
create table test_norm_classes(
    id number,
    class number
);
create table test_norm_means(
    att number,
    class number,
    mean float,
    ol char
);

delete from test_norm;

select count(*) from test_norm;
select * from test_norm_classes;

