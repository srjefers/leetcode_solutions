/* Write your PL/SQL query statement below */
with requester as (
  select 
    requester_id,
    count(*) over (partition by requester_id) cnt_request,
    row_number() over (partition by requester_id order by requester_id) rn
  from RequestAccepted
),
accepter as (
  select
    accepter_id,
    count(*) over (partition by accepter_id) cnt_accepter,
    row_number() over (partition by ACCEPTER_ID order by ACCEPTER_ID) rn
  from RequestAccepted
),
total_cnt as (
  select REQUESTER_ID, CNT_REQUEST from requester
  where rn = 1
  union all
  select accepter_id, cnt_accepter  from accepter
  where rn = 1
),
final as (
  select REQUESTER_ID as ID, sum(CNT_REQUEST) as num
  from total_cnt
  group by REQUESTER_ID
)
select id, num
from final
where num = (select max(num) from final)