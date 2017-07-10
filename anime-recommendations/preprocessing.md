
# Preprocessing

First step should be normalizing all columns.

There are a lot of options for normalizing the data like
* Min-Max Normalization
* Decimal Scaling
* Standard Deviation method

We'll move forward with Min-Max normalization

```sql
DECLARE
    range FLOAT;
    min_val FLOAT;
    d number;
BEGIN
    select count(*)-1 into d from user_tab_columns where table_name = 'MAL_X_NORM';
    for i in 1..d
    loop
        execute immediate 'SELECT min(c'||i||') from MAL_X_NORM' into min_val;
        execute immediate 'SELECT max(c'||i||')-min(c'||i||') from MAL_X_NORM' into range;
        execute immediate 'update MAL_X_NORM set c'||i||' = (c'||i||'-:min)/ :range'
            using min_val, range;
    end loop;
END;
```
# 2D-MATRIX to COO format

We can now use the `MAL_X_NORM` to fill `MAL_X_COO` table which will have all datapoints in COO format.

```sql
declare
    d number;
begin
    delete from mal_x_coo;
    select count(*)-1 into d from user_tab_columns
        where table_name = 'MAL_X_NORM';
    for i in 1..d
    loop
        execute immediate 'insert into mal_x_coo(id,att,data)'||
            'select id,'||i||',c'||i||' from MAL_X_NORM';
    end loop;
end;
```


> Why use COO format

* In any other scenario a simple matrix is the obvious choice, but since we are working in SQL the usual programming approaches would not work.
* We can also call this step **Database Normalization**. We do this to have better control over the relationships in our data.
