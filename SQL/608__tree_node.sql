/* Write your PL/SQL query statement below */
with final as (
    select 
        t1.id,
        case 
            when t1.p_id is null then 'Root'
            when t2.id is null then 'Leaf'
            else 'Inner'
        end type
    from Tree t1
    left join Tree t2
        on t1.id = t2.p_id
)
select 
    distinct id, type 
from final