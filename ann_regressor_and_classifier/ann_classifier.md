.# ANN classifier
```sql
declare
hidden_num number:=4;
n number;
d number;
c number;
err float;
training_error float;
begin

    -- get number of data points, dimensions and classes
    select count(DISTINCT att) into d from nn_x;
    select count(DISTINCT id) into n from nn_x;
    select count(DISTINCT class) into c from nn_y;


    -- Initialize hidden weights of h1 with size of (d,h)

    -- Initialize hidden weights of h2 with size of (h,c)
    -- H1 -> x:h, y:d
    -- H2 -> x:d, y:h
    dbms_random.seed(47);
    delete from nn_h;
    for i in 1..hidden_num
    loop
        insert into nn_h values(1,i,1,2*dbms_random.value(0,1)-1);
    end loop;

    insert into nn_h select 1,x,att,2*dbms_random.value(0,1)-1 from nn_x,nn_h where nn_x.id=x and att>1;

    insert into nn_h select 2,class,x,2*dbms_random.value(0,1)-1 from nn_h,nn_y group by x,class;

    -- back propagation
for i in 1..80
loop
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
    h1_update as (select 1 as id,l0.att as x,l1_delta.att as y,SUM(l0.data*l1_delta.data) as data from l0,l1_delta where l0.id=l1_delta.id group by l0.att, l1_delta.att),
    h as (select coalesce(h1_update.id,h2_update.id) as id,coalesce(h1_update.y,h2_update.y) as x,coalesce(h1_update.x,h2_update.x) as y,coalesce(h1_update.data,h2_update.data) as data from h1_update full join h2_update on h1_update.id = h2_update.id)
    select h.id,h.x,h.y,h.data+nn_h.data from h,nn_h where h.id+2=nn_h.id and h.x=nn_h.x and h.y=nn_h.y;

    delete from nn_h where id>2;
    if MOD(i,20) = 0 then
    with l0 as (select id,att,data from nn_x),
    l1 as (select l0.id as id,x as att,activation_func(sum(l0.data*nn_h.data)) as data from nn_h,l0 where nn_h.id=1 and att=y group by x, l0.id),
    l2 as (select l1.id as id,x as att,activation_func(sum(l1.data*nn_h.data)) as data from nn_h,l1 where nn_h.id=2 and att=y group by x, l1.id),
    l2_error as (select l2.id,att,nn_y.data-l2.data as data from l2,nn_y where class=att and l2.id=nn_y.id)
    select avg(abs(data)) into err from l2_error;

    with l0 as (select id,att,data from nn_x),
    l1 as (select l0.id as id,x as att,activation_func(sum(l0.data*nn_h.data)) as data from nn_h,l0 where nn_h.id=1 and att=y group by x, l0.id),
    l2 as (select l1.id as id,x as att,activation_func(sum(l1.data*nn_h.data)) as data from nn_h,l1 where nn_h.id=2 and att=y group by x, l1.id),
    pred as (select id,att from l2 where data in (select max(data) from l2 group by id)),
    act as (select id,class from nn_y where data in (select max(data) from nn_y group by id))
    select count(*) into training_error from act,pred where act.id=pred.id and att<>class;

    dbms_output.put_line('error '||err);
    dbms_output.put_line('training error '||training_error*100/n);

    end if;

end loop;
end;
```
