/* Write your PL/SQL query statement below */
with Products_tmp as (
    select 
        product_id,
        new_price,
        change_date,
        row_number() over (partition by product_id order by change_date) rn
    from Products
),
last_price_products as (
    select 
        product_id, max(rn) rn
    from Products_tmp
    where change_date <= to_date('2019-08-16','yyyy-mm-dd')
    group by product_id
),
final as (
    select
        pt.product_id,
        pt.new_price price
    from last_price_products pf
    inner join Products_tmp pt
        on pt.product_id = pf.product_id and pf.rn = pt.rn
)
select * from final
union all
select 
    distinct product_id, 10
from Products_tmp
where product_id not in (
    select 
        distinct product_id
    from last_price_products
)