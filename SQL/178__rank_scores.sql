/* Write your PL/SQL query statement below */
with final as (
    select 
        score, dense_rank() over (order by score desc) rank
    from Scores
)
select * from final order by rank