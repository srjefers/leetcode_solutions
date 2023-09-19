# 176. Second Highest Salary
`Oracle` :shipit:

## Problem
```
Table: Employee
+-------------+------+
| Column Name | Type |
+-------------+------+
| id          | int  |
| salary      | int  |
+-------------+------+
id is the primary key (column with unique values) for this table.
Each row of this table contains information about the salary of an employee.
```

Write a solution to find the second highest salary from the Employee table. If there is no second highest salary, return null (return None in Pandas).

The result format is in the following example.

**Example 1:**
```
Input: 
Employee table:
+----+--------+
| id | salary |
+----+--------+
| 1  | 100    |
| 2  | 200    |
| 3  | 300    |
+----+--------+
Output: 
+---------------------+
| SecondHighestSalary |
+---------------------+
| 200                 |
+---------------------+
```
**Example 2:**
``` 
Input:
Employee table:
+----+--------+
| id | salary |
+----+--------+
| 1  | 100    |
+----+--------+
Output: 
+---------------------+
| SecondHighestSalary |
+---------------------+
| null                |
+---------------------+
```


## SQL Problem Schema
```sql
Create table If Not Exists Employee (id int, salary int)
Truncate table Employee
insert into Employee (id, salary) values ('1', '100')
insert into Employee (id, salary) values ('2', '200')
insert into Employee (id, salary) values ('3', '300')
```

## Approach
💡 Used CTE's to have a clean code, I think that I can reduce the whole code to only one cte but it depends since the results is able to return more than one row, also I didn't wanted to use the `offset rows` function from oracle. **Dense_Rank()** window function returns an extra column that defines the scale/rank of the value.

Why dual? 
Well since dual is a table that only has one row and is used to run operations I used to execute a subquery, since I tried to run without it, I saw that Oracle instead of returnin null was returning a message such like `not data found`. Thats why I used dual to avoid having that error.

## Complexity
- Runtime AVG: 1398 ms

- Memory: 0b


## SQL Script
```sql
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
```