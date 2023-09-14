/* Write your PL/SQL query statement below */
with customer_nonduplicates as (
    select distinct customer_id, product_key 
    from Customer
    order by customer_id, product_key
),
cnt_customer_prods as (
    select 
        customer_id, product_key,
        count(*) over (partition by customer_id) cnt_prods
    from customer_nonduplicates cn
),
final as (
    select 
        distinct customer_id 
    from cnt_customer_prods
    where cnt_prods = (select count(1) from Product)
)
select * from final