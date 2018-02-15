CREATE TABLE Employee
( Employee_ID int IDENTITY(1,1) PRIMARY KEY,
  First varchar(50),
  Last varchar(50),
  Sex varchar(1),
  Active bit);
select * from Employee;
