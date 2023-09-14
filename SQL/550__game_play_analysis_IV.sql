/* Write your PL/SQL query statement below */
with lead_date as (
    select 
        player_id,
        event_date,
        first_value(event_date) over (partition by player_id order by event_date) edate,
        lead(event_date) over (partition by player_id order by event_date) ldate
    from Activity
),
ndistinct_players as (
    select count(distinct player_id)
    from lead_date
),
ndays_between_players as (
    select 
        player_id,
        event_date,
        ldate,
        ldate - edate as ndays 
    from lead_date
),
ndistinct_daily_players as (
    select count(1) cnt 
    from ndays_between_players
    where ndays = 1
),
final as (
    select 
        round(
            (select * from ndistinct_daily_players)/
            (select * from ndistinct_players)
        ,2) as fraction
    from dual
)
select * from final