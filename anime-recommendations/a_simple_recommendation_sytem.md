# A simple recommendation sytem

We'll start with a very simple way for recommendations i.e. just picking the top 10 closest neighbours of any anime/ data point.

The metric closeness is measured with respect to the Euclidean distance betweeen two points as should be clear with the SQL query.

```sql
SELECT * from MAL_ANIME,
    (SELECT dis,id2 from
        (SELECT t1.id as id1,t2.id as id2,sum((t1.data-t2.data)*(t1.data-t2.data)) as dis
            from MAL_X_coo t1,MAL_X_coo t2
            where t1.id = :ANIME_ID and t1.att=t2.att
            group by t1.id,t2.id order by dis)
    where ROWNUM<=:NUM_RESULTS)
where id2 = ANIME_ID order by dis;
```

Say I had to get the top ten recommendations for Naruto(anime_id=20). I would use the following query.
```sql
SELECT * from MAL_ANIME,
    (SELECT dis,id2 from
        (SELECT t1.id as id1,t2.id as id2,sum((t1.data-t2.data)*(t1.data-t2.data)) as dis
            from MAL_X_coo t1,MAL_X_coo t2
            where t1.id = 20 and t1.att=t2.att
            group by t1.id,t2.id order by dis)
    where ROWNUM<=10)
where id2 = ANIME_ID order by dis;
```

The results are pretty convincing.



