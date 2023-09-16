/* Write your PL/SQL query statement below */
with tmp_1 as (
    select distinct visited_on from Customer
),
customer_tmp as (
    select 
        a.visited_on date_to_evaluate,
        b.visited_on date_to_compare,
        b.amount
    from tmp_1 a
    inner join Customer b
        on b.visited_on between a.visited_on and a.visited_on + 6
),
group_amount_per_date as (
    select
        distinct 
        to_char(last_value(date_to_compare) over (partition by date_to_evaluate),'yyyy-mm-dd') as visited_on,
        first_value(to_char(date_to_compare,'yyyy-mm-dd')) over (partition by date_to_evaluate) as fv,
        sum(amount) over (partition by date_to_evaluate) as amount,
        round(sum(amount) over (partition by date_to_evaluate)/7,2) as average_amount 
    from customer_tmp
),
final as (
    select 
        visited_on,
        amount,
        average_amount,
        row_number() over (partition by visited_on order by FV asc) as rn
    from group_amount_per_date
)
select 
    visited_on,
    amount,
    average_amount
from final
where rn = 1
