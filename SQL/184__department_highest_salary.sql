/* Write your PL/SQL query statement below */
with employe as (
    select 
        id, name, salary, departmentId,
        dense_rank() over (partition by departmentId order by salary desc) drnk
    from Employee
),
final as (
    select 
        dep.name as Department,
        emp.name as Employee,
        emp.salary as Salary
    from employe emp
    inner join Department dep 
        on dep.id = emp.departmentId
    where drnk = 1
)
select * from final