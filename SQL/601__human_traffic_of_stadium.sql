/* Write your PL/SQL query statement below */
with stadium_tmp as (
    select 
        id,
        visit_date,
        people,
        id - row_number() over (order by id) as seq_rn
    from Stadium
    where people >= 100
),
greater_seq as (
    select 
        seq_rn 
    from stadium_tmp
    group by seq_rn
    having count(1) >= 3
)
select 
    id, to_char(visit_date,'yyyy-mm-dd') as visit_date, people
from stadium_tmp st
inner join greater_seq gs
    on gs.seq_rn = st.seq_rn
