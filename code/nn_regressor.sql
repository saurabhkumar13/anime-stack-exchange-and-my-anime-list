declare
hidden_num number:=20;
n number;
maxN number;
d number;
batch_factor number:=5;
err float;
error_total float;
training_error float;
begin

    -- get number of data points, dimensions 
    select count(DISTINCT att) into d from nn_x;
--    select count(DISTINCT id) into n from nn_x;
    select max(id) into n from nn_x;
    
    
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
    
    insert into nn_h select 1,x,att,2*dbms_random.value(0,1)-1 from (select distinct att from nn_x) temp,nn_h where att>1;

    
    insert into nn_h select 2,1,x,2*dbms_random.value(0,1)-1 from (select distinct x from nn_h);

    -- back propagation
for i in 1..1
loop
    update nn_h set id=id+2 where id<=2;
    
    for j in 0..batch_factor-1
    loop
        insert into nn_h
        with l0 as (select id,att,data from nn_x where id between j*ceil(n/batch_factor)+1 and (j+1)*ceil(n/batch_factor)+1),
        l1 as (select l0.id as id,x as att,activation_func(sum(l0.data*nn_h.data)) as data from nn_h,l0 where nn_h.id=3 and att=y group by x, l0.id),
        l2 as (select l1.id as id,x as att,activation_func(sum(l1.data*nn_h.data)) as data from nn_h,l1 where nn_h.id=4 and att=y group by x, l1.id),
        l2_error as (select l2.id,att,nn_r.data-l2.data as data from l2,nn_r where l2.id=nn_r.id),
        l2_delta as (select l2.id,l2.att,l2_error.data*activation_der(l2.data) as data from l2,l2_error where l2.att=l2_error.att and l2.id=l2_error.id),
        l1_error as (select l2_delta.id,nn_h.y as att,sum(l2_delta.data*nn_h.data) as data from l2_delta,nn_h where nn_h.id=4 and att=x group by l2_delta.id,nn_h.y),
        l1_delta as (select l1.id,l1.att,l1_error.data*activation_der(l1.data) as data from l1,l1_error where l1.att=l1_error.att and l1.id=l1_error.id),
        h2_update as (select 2 as id,l1.att as x,l2_delta.att as y,SUM(l1.data*l2_delta.data) as data from l1,l2_delta where l1.id=l2_delta.id group by l1.att, l2_delta.att),
        h1_update as (select 1 as id,l0.att as x,l1_delta.att as y,SUM(l0.data*l1_delta.data) as data from l0,l1_delta where l0.id=l1_delta.id group by l0.att, l1_delta.att),
        h as (select coalesce(h1_update.id,h2_update.id) as id,coalesce(h1_update.y,h2_update.y) as x,coalesce(h1_update.x,h2_update.x) as y,coalesce(h1_update.data,h2_update.data) as data from h1_update full join h2_update on h1_update.id = h2_update.id)
        select h.id,h.x,h.y,h.data+nn_h.data from h,nn_h where h.id+2=nn_h.id and h.x=nn_h.x and h.y=nn_h.y;
    end loop;
    delete from nn_h where id>2;
        
    if MOD(i,5) = 0 then
        error_total:=0;
        for j in 0..batch_factor-1
        loop
            with l0 as (select id,att,data from nn_x where id between j*ceil(n/batch_factor)+1 and (j+1)*ceil(n/batch_factor)+1),
            l1 as (select l0.id as id,x as att,activation_func(sum(l0.data*nn_h.data)) as data from nn_h,l0 where nn_h.id=1 and att=y group by x, l0.id),
            l2 as (select l1.id as id,x as att,activation_func(sum(l1.data*nn_h.data)) as data from nn_h,l1 where nn_h.id=2 and att=y group by x, l1.id),
            l2_error as (select l2.id,att,nn_r.data-l2.data as data from l2,nn_r where l2.id=nn_r.id)
            select avg(abs(data)) into err from l2_error;
            error_total:=error_total+err;
            dbms_output.put_line('error '||error_total);
        end loop;
    end if;
        
end loop;
end;