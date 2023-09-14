/* Write your PL/SQL query statement below */
with queue_tmp as (
    select 
        person_name,
        weight,
        sum(weight) over (order by turn) sm
    from Queue
),
final as (
    select 
        person_name
    from queue_tmp
    where sm <= 1000
    order by sm desc
)
select * from final
where RowNum = 1