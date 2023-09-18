/* Write your PL/SQL query statement below */
with users_tmp as (
    select *
    from Users
    where banned = 'No'
),
trips_tmp as (
    select 
        t.request_at as day,
        count(*) over (partition by t.request_at) as cnt,
        case 
            when t.status in ('cancelled_by_driver','cancelled_by_client') then 1
            else 0
        end as t_status
    from Trips t
    inner join users_tmp u_client
        on t.client_id = u_client.users_id
    inner join users_tmp u_driver
        on t.driver_id = u_driver.users_id
    where to_date(t.request_at,'YYYY-MM-DD') 
        between to_date('2013-10-01','YYYY-MM-DD') and to_date('2013-10-03','YYYY-MM-DD')
),
final as (
    select 
        day,
        round(sum(t_status)/cnt, 2) as "Cancellation Rate"
    from trips_tmp
    group by day, cnt
)
select * from final