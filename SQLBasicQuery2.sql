select * from Employee;

with res as
(
select First,Last,salary, dense_rank() over (order by Salary desc) as rank from employee
) 
 select top 4 * from res where rank<=4;

 with res as
(
select First,Last,salary, dense_rank() over (order by Salary desc) as rank from employee
) 
 select top 4 * from res where rank in(1,3,5);
   
 select first, row_number() over (order by salary) as row_number from employee; 

 with emp (project_id,no_of_emp)
 as
 (
 select project_id,count(first)  from Employee    where active=1 group by(project_id)
 )
 select * from emp;

 select project_id,sex,sum(salary)
 from Employee
 group by sex,rollup(project_id);
  

  select project_id,sum(salary)
  from employee group by(project_id)
  union all
  select null,sum(salary)
  from employee  

  select project_id, sex, sum (salary) as totalsalary
  from employee
  group by project_id, sex with cube;

  select first,last from employee where salary<20000
  except
  select first,last from employee where salary>10000 

  select first,(select employee_id from