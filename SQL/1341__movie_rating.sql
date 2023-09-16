/* Write your PL/SQL query statement below */
with user_rate as (
    select 
        distinct 
        u.name,
        count(mr.user_id) over (partition by mr.user_id) cnt
    from Users u
    inner join MovieRating mr
        on u.user_id = mr.user_id
),
final_user as (
    select name as results
    from user_rate
    where cnt = (select max(cnt) from user_rate)
    order by name asc
),
movie_rate as (
    select 
        distinct 
        m.title,
        avg(mr.rating) over (partition by mr.movie_id) avg_r
    from MovieRating mr 
    inner join Movies m 
        on m.movie_id = mr.movie_id
    where trunc(mr.created_at, 'MONTH') = to_date('2020-02-01') 
),
final_movie as (
    select 
        title 
    from movie_rate
    where avg_r = (select max(avg_r) from movie_rate)
        and RowNum = 1
)
select * from final_user
where RowNum = 1
union all 
select * from final_movie