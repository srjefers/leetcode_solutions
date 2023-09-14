/* Write your PL/SQL query statement below */
with actions_total as (
    select 
        s.user_id,
        sum(case 
            when c.user_id is null then 1
            else 0
        end) as no_action,
        sum(case 
            when c.action = 'timeout' then 1
            else 0
        end) as timeout_action,
        sum(case 
            when c.action = 'confirmed' then 1
            else 0
        end) as confirmed_action
    from Signups s
    left join Confirmations c 
        on c.user_id = s.user_id
    group by s.user_id
),
final as (   
    select 
        user_id,
        round(confirmed_action / (confirmed_action + timeout_action + no_action),2) as confirmation_rate
    from actions_total
)
select * from final