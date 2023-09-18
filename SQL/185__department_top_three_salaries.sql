/* Write your PL/SQL query statement below */
with employee_tmp as (
    select 
        name,
        salary,
        departmentId,
        dense_rank() over (partition by departmentId order by salary desc) rnk
    from Employee
    order by rnk
)
,final as (
    select 
        d.name as Department,
        e.name as Employee,
        e.salary
    from employee_tmp e
    inner join Department d 
        on e.departmentId = d.id
    where rnk between 1 and 3
)
select * from final