/* Write your PL/SQL query statement below */
with accounts_tmp as (
    select 
        case 
            when income < 20000 then 1
            else 0
        end as low_s, 
        case 
            when income between 20000 and 50000 then 1
            else 0
        end as avg_s,
        case 
            when income > 50000 then 1
            else 0
        end as high_s
    from Accounts
),
final as (
    select 
        'Low Salary' as category, sum(low_s) as accounts_count
    from accounts_tmp
    union all 
    select 
        'Average Salary' as category, sum(avg_s) as accounts_count
    from accounts_tmp
    union all 
    select 
        'High Salary' as category, sum(high_s) as accounts_count
    from accounts_tmp
)
select * from final