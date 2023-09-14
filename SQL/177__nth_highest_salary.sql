CREATE FUNCTION getNthHighestSalary(N IN NUMBER) RETURN NUMBER IS
result NUMBER;
BEGIN
    /* Write your PL/SQL query statement below */
    with final as (
        select 
            salary, dense_rank() OVER (ORDER BY salary desc) rn
        from Employee
    ),
    secondH as (
        select rowNum, salary from final where rn = N
    )
    select 
        (select salary from secondH where rowNum = 1) 
        into result 
    from dual;
    RETURN result;
END;