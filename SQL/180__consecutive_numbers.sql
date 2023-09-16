/* Write your PL/SQL query statement below */
with logs_tmp as (
    select 
        id,
        num, 
        lag(num) over (order by id) l_num,
        lead(num) over (order by id) n_num
    from Logs
),
final as (
    select 
        id,
        num,
        case 
            when (num = l_num) and (num = n_num) then 1
            else 0
        end as comparasion_num
    from logs_tmp
    order by id
)
select 
    distinct num as ConsecutiveNums
from final
where comparasion_num = 1