/* Write your PL/SQL query statement below */
with emp_tmp as (
    select 
        id, name, managerId 
    from Employee
),
self_join_emp as (
    select 
        emp.id, emp.name emp_name, emp.managerId,
        man.name manager_name
    from emp_tmp emp
    left join emp_tmp man
        on man.id = emp.managerId
    where man.name is not null
),
cnt_manager_reports as (
    select  
        managerId, manager_name, 
        count(1) cnt
    from self_join_emp
    group by managerId, manager_name
),
final as (
    select manager_name as name
    from cnt_manager_reports
    where cnt >= 5
)
select * from final
