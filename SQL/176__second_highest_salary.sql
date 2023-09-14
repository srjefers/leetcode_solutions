/* Write your PL/SQL query statement below */
with final as (
  select 
    salary, dense_rank() OVER (ORDER BY salary desc) rn
  from Employee
),
secondH as (
  select rowNum, salary from final where rn = 2
)
select 
  (select salary from secondH where rowNum = 1) as SecondHighestSalary
from dual