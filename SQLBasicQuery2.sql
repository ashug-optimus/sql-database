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

  BEGIN TRY  
     
    SELECT * FROM Employee;  
END TRY  
BEGIN CATCH  
    SELECT   
        ERROR_NUMBER() AS ErrorNumber  
       ,ERROR_MESSAGE() AS ErrorMessage;  
END CATCH;


Select First,Salary,"res"=
CASE Salary
When 20000 then 'Salary is moderate'
When 15000 then 'Salary is okok'
When 50000 then 'Salary is nice'
Else 'It is less'
END
 from Employee ;

 UPDATE Employee
 SET Age = 
 (CASE
 WHEN (Salary >10000) then age+1
 Else age+2
 end
 );

 select * from employee;


select CAST('2300-09-23' as datetime);

update employee set salary =null where first ='sneh';

select first,last, ISNULL(Salary,round(PF,0)) - ISNULL(PF,0)  as gross_sal from Employee;	

Declare @val1 int;  
Declare @val2 int;  
BEGIN TRY  
Set @val1=9;  
Set @val2=@val1%2;   
if @val2=1  
Print ' Error Not Occur,number is odd'  
else  
Begin  
Print 'Error Occur';  
Throw 60000,'Number Is Even',100  
End  
  
END TRY  
BEGIN CATCH  
Print 'Error Occur that is:'  
Print Error_Message()  
END CATCH   

Create procedure spProc10
@projectid int
as
begin 
select employee.first,employee.project_id,project.project_name from employee inner join project on Employee.project_id = project.project_id where employee.project_id =@projectid;
end;

Declare @first varchar
exec spProc10 4;



CREATE FUNCTION EmployeeFromID
(@id int)
RETurns TABLE 
as
return
select first,last,salary,age from employee where Employee_ID=@id;

select * from EmployeeFromID(3);



