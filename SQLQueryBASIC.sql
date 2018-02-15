select * from Employee;

select TOP 5 * from Employee order by Salary DESC;

ALTER table Employee ADD CONSTRAINT DEFAULT_AGE DEFAULT 18 for AGE;

ALTER table Employee ADD CONSTRAINT DEFAULT_DESG DEFAULT 'TRAINEE' for DESIGNAION;

insert into Employee(first,Last,Sex,Active,Salary) VALUES('Sneh','Rathore','F',1,15000);

select * from Employee;

Update Employee set DESIGNATIONS = 'MANAGER', Salary = 50000 where Salary > 40000 AND AGE>35;

Delete from Employee where Active = 0 AND DESIGNATIONS ='INTERN';

select * from Employee;

select TOP 3 Salary from Employee ORDER BY Salary DESC;


SELECT  MAX(salary) AS salary
  FROM employee
 WHERE salary < (SELECT MAX(salary)
                 FROM employee); 


SELECT MAX(salary) AS salary
  FROM employee
 WHERE salary < (SELECT MAX(salary) 
                 FROM employee
                 WHERE salary < (SELECT MAX(salary)
                 FROM employee)
                ); 

select first,last from Employee where first LIKE 'a%';

select * from Employee where Salary in (15000,50000);

select * from Employee where Salary BETWEEN 15000 AND 50000;

select first as Fname,last as Lname from Employee;

Create table Department
(
Dept_name varchar(20),
Dept_Id int
);

select * from Department;

insert into Department Values('Trainee',1);
insert into Department Values('Manager',2);
insert into Department Values('Intern',3);
insert into Department Values('Tech_Lead',4);

Alter table Department rename column departmnet to Dept__Name;

EXEC sp_rename 'Department.departmnet', 'Dept_name','COLUMN';

select * from Department;

select Employee.first, Employee.last, Employee.DESIGNATIONS,Department.Dept_Id from Employee INNER JOIN Department on Employee.Designations = Department.Dept_name;

select TOP 1 Salary from (Select TOP 5 Salary from Employee order by Salary DESC) as Sal ORDER by Salary;

insert into Employee values('ashish','kumar','m',0,null,10000,22);

select * from Employee;

select Employee.first,employee.last from Employee LEFT JOIN Department on Employee.DESIGNATIONS = Department.Dept_name;

insert into Department VALUES('HR',6);
	
select Department.Dept_name, count(Employee.first) from Employee RIGHT JOIN Department on Employee.DESIGNATIONS = Department.Dept_name GROUP BY Department.Dept_name ;

select Employee.first,employee.last,Department.Dept_name from Employee FULL OUTER JOIN Department on Employee.DESIGNATIONS = Department.Dept_name;



create table CompanyC
(
e_id int IDENTITY(1,1) PRIMARY KEY, 
e_name varchar(50)
)


insert into CompanyC VAlues('Vijay');

select * from CompanyA UNION select * from CompanyB UNIoN select * from CompanyC;

select DESIGNATIONS ,count(First) as no_of_employees
from Employee
group by( DESIGNATIONS)
having count(DESIGNATIONS)>2;

select first from Employee
where exists (select First from Employee where Salary>400000);

select first from Employee
where Salary=all(select salary from employee where Salary=200000);

select * into Employee_backup from Employee;

select * from Employee_backup2;

select * into Employee_backup2
 from Employee_backup
 where salary>40000;

 insert into Employee_backup2( First,Last,Sex,Active,DESIGNATIONS,Salary,Age)
 select  First,Last,Sex,Active,DESIGNATIONS,Salary,Age from Employee
 where Salary<40000;
  
 alter table department add constraint pk NOT null dept_id;

 create table Employee2
 (e_id int  foreign key references Employee(Employee_id)  ,
  name varchar(30) NOT null primary key,
  phone int  CONSTRAINT chk_phone CHECK (phone not like '%[^0-9]%') unique,
  dept_id int 
  );

  create index salary_index on Employee (salary);

CREATE VIEW [details] AS
SELECT first, last,salary, age
FROM employee
WHERE Salary <50000;

select * from [details];

Drop table CompanyC;
truncate table companyb;

 select * from department;
 
 alter table Employee
 alter column DESIGNATIONS int;

 alter table Employee
 add  project_id int;

update Employee set project_id=1 where Employee_id=2;
 

  select * from Employee;

  update Employee set project_id=1 where Employee_id=3;
update Employee set project_id=1 where Employee_id=4;
update Employee set project_id=2 where Employee_id=5;
update Employee set project_id=2where Employee_id=6;
update Employee set project_id=3 where Employee_id=7;
update Employee set project_id=4 where Employee_id=8;
update Employee set project_id=5 where Employee_id=9;

  update Employee set project_id=1 where Employee_id=2;
update Employee set project_id=3 where Employee_id=10;
update Employee set project_id=3 where Employee_id=11;
  update Employee set project_id=6 where Employee_id=12;

  create table project
  ( project_id int,
    project_name varchar(30));

	insert into project (project_id,project_name)
	values(6,'database');

	alter table project add constraint pk not null (project_id);
	
	select* from project;

	ALTER TABLE project
 ALTER COLUMN project_id int NOT NULl;

 alter table project add constraint pk primary key (project_id);
 
 alter table Employee add constraint fk foreign key (project_id) references project(project_id);   

 select employee.first,employee.project_id,project.project_name from employee inner join project on Employee.project_id = project.project_id;

 Alter table Employee add PF decimal(10,2);
 Update Employee set PF = 00.1275 * Salary where Salary >0;

 select * from Employee;
 SELECT FORMAT( GETDATE(), 'ddd,dd,MM,yy hh:mm:ss tt');
  SELECT FORMAT( GETDATE(), 'ddd,dd,MM,yy hh:mm:ss tt');
