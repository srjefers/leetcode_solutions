* Write your PL/SQL query statement below */
with orders_tmp as (
    select 
        buyer_id,
        count(buyer_id) cnt
    from Orders
    where extract(year from order_date) = 2019
    group by buyer_id
),
final as (
    select 
        u.user_id as buyer_id,
        to_char(u.join_date, 'YYYY-MM-DD') as join_date,
        coalesce(o.cnt,0) as orders_in_2019
    from users u
    left join orders_tmp o
        on o.buyer_id = u.user_id
)
select * from final