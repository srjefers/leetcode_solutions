/* Write your PL/SQL query statement below */
with insurance_tmp as (
  select 
    tiv_2015, tiv_2016,
    lat, lon,
    cast(lat as varchar2(10)) || cast(lon as varchar2(10)) as latLon
  from Insurance
),
both_criteria as (
  select 
    tiv_2015, tiv_2016, latlon,
    -- frst_criteria
    count(*) over (partition by tiv_2015) cnt_t2015,
    -- scnd_criteria
    count(*) over (partition by latlon) cnt_latlon
  from insurance_tmp
),
final as (  
  select 
    round(sum(tiv_2016),2) as tiv_2016
  from both_criteria
  where cnt_latlon = 1 and cnt_t2015 >= 2
)
select * from final