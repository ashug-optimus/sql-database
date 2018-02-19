--aolution of section two of test 
create table Departments(
Dept_id int Primary Key NOT null,
Dept_name varchar(20),
Num_of_Projects int not null check (Num_of_Projects>2)
);

create table Projects(
Project_id int Primary key not null,
Project_name varchar(50) not null,
Project_Dept varchar(20),
Num_of_Eng int not null check(Num_of_Eng>1),
Num_of_hours int 
)

create table Engineer(
Eng_id int primary key not null,
Eng_name varchar(30),
Eng_proj_id int,
Num_of_hrs int 
)

select Engineer.Eng_name,Projects.Project_name,Engineer.Num_of_hrs from Engineer inner join Projects on Engineer.Eng_proj_id = Projects.Project_id ; 

select Projects.Project_name,Projects.Num_of_hours,Projects.Project_Dept from Projects ;
