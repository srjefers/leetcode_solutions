/* Write your PL/SQL query statement below */
with transactions_tmp as (
    select 
        to_char(trans_date,'yyyy')||'-'||to_char(trans_date,'MM') as month,
        country,
        state,
        amount
    from Transactions
),
final as (
    select 
        month,
        country,
        count(1) as trans_count,
        sum(amount) as trans_total_amount,
        sum(case when state = 'approved' then 1 else 0 end) approved_count,
        sum(case when state = 'approved' then amount else 0 end) as approved_total_amount
    from transactions_tmp
    group by month, country
)
select * from final
