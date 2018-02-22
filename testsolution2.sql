--aolution of section two of test 
	create table Departments
	(
		Dept_id int Primary Key NOT null,
		Dept_name varchar(20),
		Num_of_Projects int not null 
		check (Num_of_Projects>2)
	);

	create table Projects
	(
		Project_id int Primary key not null,
		Project_name varchar(50) not null,
		Project_Dept varchar(20),
		Num_of_Eng int not null 
		check(Num_of_Eng>1),
		Num_of_hours int 
	)

	create table Engineer
	(
		Eng_id int primary key not null,
		Eng_name varchar(30),
		Eng_proj_id int,
		Num_of_hrs int 
	)

	Insert into Departments		
		values(101, 'intern', 7);

	Insert into Departments 
		values(102, 'Dev', 6);

	Insert into Departments 
		values(103, 'Trainee', 9);

	Insert into Projects 
		values(1, 'Aptus', 'learning', 2, 76);

	Insert into Projects 
		values(2, 'monkey-media', 'Utility', 3, 90);

	Insert into Projects 
		values(3, 'testoholic', 'testing', 4, 82);

	Insert into Engineer 
		values(301, 'ashu', 1, 76);

	Insert into Engineer 
		values(302, 'arnav', 2, 90);

	Insert into Engineer 
		values(303, 'udit', 3, 82);


--Query to find  total number of hours spent as Each engineer in their respective project.

	select Engineer.Eng_name,Projects.Project_name,Engineer.Num_of_hrs 
	from Engineer inner join Projects 
	on Engineer.Eng_proj_id = Projects.Project_id ; 

----Query to find  total number of hours spent as Each project in their respective department.

	select Projects.Project_name,Projects.Num_of_hours,Projects.Project_Dept 
	from Projects ;
