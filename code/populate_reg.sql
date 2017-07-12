with ques as (select * from posts where post_type_id=1),
ans as (select * from posts where post_type_id=2),
res as (select ques.id,ques.owner_user_id,length(ques.title) as title_length,length(ques.body) as body_length,coalesce((ans.creation_date-ques.creation_date),-1) as res from ques left outer join ans on ans.id=ques.accepted_answer_id)
select * from res ;

insert into test;
insert into nn_r;
with ques as (select * from posts where post_type_id=1),
ans as (select * from posts where post_type_id=2),
ques_ans as (select ques.id,ques.owner_user_id,length(ques.title) as title_length,length(ques.body) as body_length,ques.creation_date as ques_time,ans.creation_date as ans_time from ques left outer join ans on ans.id=ques.accepted_answer_id),
comm as (select min(creation_date) as comm_time,post_id from comments group by post_id),
res as (select id,title_length,body_length,ques_time,
    case when coalesce(ans_time-ques_time,10000)<coalesce(comm_time-ques_time,10000) 
    then coalesce(ans_time-ques_time,3000) 
    else coalesce(comm_time-ques_time,3000) end as ttl, 
    owner_user_id from ques_ans left join comm on ques_ans.id=comm.post_id)
select id,ttl from res;

delete from nn_x;


create table X(id int,c1 float,c2 float,c3 float,c4 float,c5 float,
    c6 float,c7 float,c8 float,c9 float,c10 float,c11 float);

select count( DISTINCT POST_TAGS.TAG_ID) from POST_TAGS,x where x.id=POST_TAGS.POST_ID;

merge into x using nn_x on (x.id=nn_x.id and nn_x.ATT=1) WHEN MATCHED THEN UPDATE SET c1=DATA;



SELECT x.id,data,c1,c2,c3,c4,c5,c6,c7,c8,c9,c10,c11 from nn_r,x where nn_r.id=x.id and c8 is not NULL order by x.id desc;


SELECT * from nn_r where id in (select id from x where c8 is not NULL)  order by id desc;
-- 1 time from days' start
-- 2 title length
-- 3 body length
-- 4 time from week's start
-- 5 time from month's start
-- 6 time from year's start
-- USER 
-- 7 reputation
-- 8 views
-- 9 upvotes
-- 10 downvotes
-- 11 creation_date
insert into nn_x
with ques as (select * from posts where post_type_id=1),
ques_user as (select ques.id,11,users.creation_date-to_date('01/01/2012','DD/MM/YYYY') from ques left outer join users on users.id=ques.owner_user_id)
select * from ques_user;

select min(creation_date)-to_date('01/01/2012','DD/MM/YYYY') from users;

select count(*) from nn_x group by att;

delete from nn_r;

declare
tag_t varchar2(1000);
ch    varchar2(1);
idd number:=1;
begin
for rec in (select id,(UTL_I18N.UNESCAPE_REFERENCE(tags)) as tag from posts where post_type_id=1)
loop
    for i in 1..length(rec.tag)
    loop
        ch:=substr(rec.tag,i,1);
        if ch='<' then
            tag_t:='';
        elsif ch='>' then
            insert into post_tags (select idd,rec.id,id from tags where tag_name=tag_t);
            idd:=idd+1;
        else
            tag_t:=tag_t||ch;
        end if;    
    end loop;
end loop;
end;
/
select count(*) from (select count(*) from post_tags group by tag_id);

select * from post_history where post_id in
(select post_id from votes where vote_type_id=4);


