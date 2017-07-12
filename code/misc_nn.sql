drop table nn_x;
drop table nn_y;
drop table nn_h;

create table nn_x(
    id number,
    att number,
    data float
);
create table nn_y(
    id number,
    class number,
    data float
);
create table nn_r(
    id number,
    data float
);
create table nn_h(
    id number,
    x number,
    y number,
    data float
);

select * from nn_x,n;

select * from nn_x,nn_h where nn_x.id=x;

select count(*) from nn_h where id=1 group by x;

select x,att as y,2*dbms_random.value(0,1)-1 as data from nn_x,nn_h where id=x and att>1;

select x,class,2*dbms_random.value(0,1)-1 from nn_h1,nn_y group by x,class;

select id,x,activation_func(sum(nn_x.data*nn_h.data)) as data from nn_x,nn_h1 where att=nn_h.y and nn_h.id=1 group by nn_x.id,x;

select nn_x.id,x as att,activation_func(sum(nn_x.data*nn_h.data)) as data from nn_h,nn_x where nn_h.id=1 and att=y group by x, nn_x.id;


select * from nn_x;
with l0 as (select id,att,data from nn_x)
select l0.id as id,x as att,activation_func(sum(l0.data*nn_h.data)) as data from nn_h,l0 where nn_h.id=1 and att=y group by x, l0.id;

update nn_h set id=id+2 where id<=2;
insert into nn_h
with l0 as (select id,att,data from nn_x),
l1 as (select l0.id as id,x as att,activation_func(sum(l0.data*nn_h.data)) as data from nn_h,l0 where nn_h.id=3 and att=y group by x, l0.id),
l2 as (select l1.id as id,x as att,activation_func(sum(l1.data*nn_h.data)) as data from nn_h,l1 where nn_h.id=4 and att=y group by x, l1.id),
l2_error as (select l2.id,att,nn_y.data-l2.data as data from l2,nn_y where class=att and l2.id=nn_y.id),
l2_delta as (select l2.id,l2.att,l2_error.data*activation_der(l2.data) as data from l2,l2_error where l2.att=l2_error.att and l2.id=l2_error.id),
l1_error as (select l2_delta.id,nn_h.y as att,sum(l2_delta.data*nn_h.data) as data from l2_delta,nn_h where nn_h.id=4 and att=x group by l2_delta.id,nn_h.y),
l1_delta as (select l1.id,l1.att,l1_error.data*activation_der(l1.data) as data from l1,l1_error where l1.att=l1_error.att and l1.id=l1_error.id),
h2_update as (select 2 as id,l1.att as x,l2_delta.att as y,SUM(l1.data*l2_delta.data) as data from l1,l2_delta where l1.id=l2_delta.id group by l1.att, l2_delta.att),
h1_update as (select 1 as id,l0.att as x,l1_delta.att as y,SUM(l0.data*l1_delta.data) as data from l0,l1_delta where l0.id=l1_delta.id group by l0.att, l1_delta.att)
select coalesce(h1_update.id,h2_update.id) as id,coalesce(h1_update.x,h2_update.x) as x,coalesce(h1_update.y,h2_update.y) as y,coalesce(h1_update.data,h2_update.data) as data from h1_update full join h2_update on h1_update.id = h2_update.id;
delete from nn_h where id>2;
select count(*) from nn_h;
--l1_error as (select * from l2_delta,nn_h where nn_h.id=2)
select * from nn_h where id=2;

select * from nn_y;

l1 as (select x,id as y,sum(l0.data*nn_h2.data) as data from l0,nn_h2 where att=y group by id,x)
select id,class,nn_y.data-l1.data from l1,nn_y where x=class and y=id;
;
select * from nn_h where id=2;
    update nn_h set id=id+2 where id<=2;
    with l0 as (select id,att,data from nn_x),
    l1 as (select l0.id as id,x as att,activation_func(sum(l0.data*nn_h.data)) as data from nn_h,l0 where nn_h.id=1 and att=y group by x, l0.id),
    l2 as (select l1.id as id,x as att,activation_func(sum(l1.data*nn_h.data)) as data from nn_h,l1 where nn_h.id=2 and att=y group by x, l1.id),
    pred as (select id,att from l2 where data in (select max(data) from l2 group by id)),
    act as (select id,class from nn_y where data in (select max(data) from nn_y group by id))
    select count(*) from act,pred where act.id=pred.id and att<>class;
    
    

    with l0 as (select id,att,data from nn_x),
    l1 as (select l0.id as id,x as att,activation_func(sum(l0.data*nn_h.data)) as data from nn_h,l0 where nn_h.id=1 and att=y group by x, l0.id),
    l2 as (select l1.id as id,x as att,activation_func(sum(l1.data*nn_h.data)) as data from nn_h,l1 where nn_h.id=2 and att=y group by x, l1.id),
    l2_error as (select l2.id,att,nn_y.data-l2.data as data from l2,nn_y where class=att and l2.id=nn_y.id)
    select avg(abs(data)) from l2_error;


insert all
 into nn_y values(1,1,0.9)
 into nn_y values(1,2,0.1)
 into nn_y values(2,1,0.9)
 into nn_y values(2,2,0.1)
 into nn_y values(3,1,0.1)
 into nn_y values(3,2,0.9)
 into nn_y values(4,1,0.1)
 into nn_y values(4,2,0.9)
select * from dual;


insert into nn_x values(1,1,0);
insert into nn_x values(1,2,0);
insert into nn_x values(1,3,1);

insert into nn_x values(2,1,1);
insert into nn_x values(2,2,1);
insert into nn_x values(2,3,1);

insert into nn_x values(3,1,1);
insert into nn_x values(3,2,0);
insert into nn_x values(3,3,1);

insert into nn_x values(4,1,0);
insert into nn_x values(4,2,1);
insert into nn_x values(4,3,1);






