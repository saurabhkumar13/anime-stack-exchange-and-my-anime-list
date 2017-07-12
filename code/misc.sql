select * from test_norm_means;

select 1,-1,MIN(eudis) from (select SUM(dis) as eudis,class from 
                    (select (data-mean)*(data-mean) as dis,class from test_norm, test_norm_means 
                    where test_norm.att=test_norm_means.att and id=1)
                     group by class);        

insert into test_norm_means select att,class,mean+1,1 from test_norm_means;
select * from test_norm_means;
select * from test_norm;
delete from test_norm_means;
select id,data from test_norm where att=-1 order by data desc;

select max((a.mean-b.mean)*(a.mean-b.mean)) from (select att,class,mean from test_norm_means where ol=0) a,(select att,class,mean from test_norm_means where ol=1) b where a.class=b.class and a.att=b.att;

select 1,-1,MIN(eudis) from 
                (select SUM(dis) as eudis,class from 
                    (select (data-mean)*(data-mean) as dis,class from test_norm, test_norm_means 
                    where test_norm.att=test_norm_means.att and id=1)
                     group by class);

(select avg(data),att,class from test_norm,test_norm_classes 
                where test_norm.id=test_norm_classes.id group by att,class);

delete from test_norm_means where ol=1;
with t as(
select id,class,sum((data-mean)*(data-mean)) as dis from test_norm, test_norm_means 
                    where test_norm.att=test_norm_means.att group by id,class)
select id,class from t where dis in (select min(dis) from t group by id);
                    
select id,-1,min(dis) from (select id,class,sum((data-mean)*(data-mean)) as dis from test_norm, test_norm_means 
            where test_norm.att=test_norm_means.att group by id,class) group by id;

delete from test_norm_means where ol=1;
select sum((data-mean)*(data-mean)) from test_norm, test_norm_means, test_norm_classes where test_norm_classes.class=test_norm_means.class and test_norm.att=test_norm_means.att and test_norm.id=test_norm_classes.id;


select * from users;
select count(*) from test;
create table test(id number,c1 float, c2 float);
delete from test;


select a.id, a.c as c1, b.c as c2 from (select users.id,count(*) as c from users left join posts on users.id = posts.owner_user_id and posts.post_type_id=1 group by users.id,users.reputation) a,
(select users.id,count(*) as c from users left join posts on users.id = posts.owner_user_id and posts.post_type_id=2 group by users.id,users.reputation) b where a.id=b.id and a.c<50 and b.c<50;


insert into test
with t as (
select a.id, a.c as c1, b.c as c2 from (select users.id,count(*) as c from users left join posts on users.id = posts.owner_user_id and posts.post_type_id=1 group by users.id,users.reputation) a,
(select users.id,count(*) as c from users left join posts on users.id = posts.owner_user_id and posts.post_type_id=2 group by users.id,users.reputation) b where a.id=b.id and a.c<50 and b.c<50
)
SELECT
    id,
    1.00*(c1-minc1)/rc1 as c1,
    1.00*(c2-minc2)/rc2 as c2
FROM
    (
    SELECT
       id,
       c1,
       MIN(c1) OVER () AS minc1,
       MAX(c1) OVER () - MIN(c1) OVER () AS rc1,
       c2,
       MIN(c2) OVER () AS minc2,
       MAX(c2) OVER () - MIN(c2) OVER () AS rc2
    FROM
       t
    ) X;                    

select c1,c2 from test;

select c1,c2,class from test,test_norm_classes where test.id=test_norm_classes.id;
select count(*),class from test,test_norm_classes where test.id=test_norm_classes.id group by class;

