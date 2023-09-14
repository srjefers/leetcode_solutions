/* Write your PL/SQL query statement below */
with delivery_tmp as (
    select 
        delivery_id,
        customer_id,
        order_date,
        customer_pref_delivery_date,
        row_number() over (partition by customer_id order by order_date) rn
    from Delivery
),
final as (
    select 
        delivery_id,
        customer_id,
        order_date - customer_pref_delivery_date days_per_delivery
    from delivery_tmp
    where rn = 1
)
select 
    round(
        ((select count(1) from final where days_per_delivery = 0)
        /(select count(1) from final)
        *100)
    ,2) as immediate_percentage
from dual