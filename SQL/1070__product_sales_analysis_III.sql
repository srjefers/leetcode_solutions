/* Write your PL/SQL query statement below */
with sales_products as (
    select 
        sn.product_id, sn.year, sn.quantity, sn.price,
        row_number() over (partition by sn.product_id order by sn.year asc) rn 
    from Sales sn
    inner join Product p
        on sn.product_id = p.product_id
),
frst_sale as (
    select 
        product_id, year
    from sales_products 
    where rn = 1
),
final as (
    select 
        sp.product_id, sp.year as first_year, sp.quantity, sp.price
    from sales_products sp
    inner join frst_sale fs 
        on fs.product_id = sp.product_id and fs.year = sp.year
)
select * from final