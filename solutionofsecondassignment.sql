--Query to create table 
	create table t_empl
	(
		emp_id int identity(1001,2) ,
		emp_code varchar(max),
		emp_f_name varchar(max) Not null,
		emp_m_name varchar(max),
		emp_l_name varchar(max) not null,
		emp_dob date not null,
		emp_doj date not null,
		constraint pk primary key(emp_id),
		constraint chk_age check(datediff(year,emp_dob,convert(date,getdate())) >=18)
	)

--Query to insert data in t_empl table 
	insert into t_empl (emp_code,emp_f_name,emp_l_name,emp_dob,emp_doj)
	values('OPT20110105','Manmohan','Singh','1983-02-10','2010-05-25')

	insert into t_empl (emp_code,emp_f_name,emp_m_name,emp_l_name,emp_dob,emp_doj)
	values('OPT20100915','Alfred','Joseph','Lawrence','1988-02-28','2011-06-26')

	insert into t_empl (emp_code,emp_f_name,emp_m_name,emp_l_name,emp_dob,emp_doj)
	values('OPT20100420','Arnav','singh','prasahar','1988-01-31','2011-06-26')


--Query to view all the data of empl table
	
	select * from t_empl

--Query to create activity table that contain activity id and activity name
	create table t_activity
	(
		activity_id int not null,
		activity_description varchar(max),
		constraint p_k primary key(activity_id)
	)
	 
	

--Query to insert data in t_activity table

	insert into t_activity
	values( 1, 'code analysis')

	insert into t_activity
	values( 2, 'Lunch')

	insert into t_activity
	values( 3, 'coding')

	insert into t_activity
	values( 4, 'knowledge transition')

	insert into t_activity
	values( 5, 'database')

--Query to view all data of t_activity table

	select * from t_activity

	
--Query to create attendence table that contain attendence id,employee id attendence time, and end attendence hours

	CREATE TABLE t_atten_det
		( 
			atten_id int identity(1001,1),
			emp_id int foreign key references t_empl(emp_id),
			activity_id int foreign key references t_activity(activity_id),
			atten_start_date datetime ,
			atten_end_hours int
		)
		  
--Query to insert data in t_atten_det

	insert into t_atten_det
		values( 1001, 5, '2011-02-13 10:00:00', 2)

	insert into t_atten_det
		values( 1001, 1, '2011-01-14 10:00:00', 3)

	insert into t_atten_det
		values( 1001, 3, '2011-02-13 13:00:00', 5)

	insert into t_atten_det
		values( 1003, 5, '2011-02-16 10:00:00', 8)

	insert into t_atten_det
		values( 1003, 5, '2011-02-17 10:00:00', 8)

	insert into t_atten_det
		values( 1003, 5, '2011-02-19 10:00:00', 7)

--Query to view all the data from t_atten_det table
	select * from t_atten_det

--Query to create salary table that contains salary id ,employee id, changed date, new salary
	create table t_salary
	(
		salary_id int not null,
		emp_id int ,
		changed_date date,
		new_salary int
	)

--Query to insert data in salary table
	insert into t_salary
		values(1001,1003,'2011-02-16',20000)

	insert into t_salary
		values(1002,1003,'2011-01-05',25000)

	insert into t_salary
		values(1003,1001,'2011-02-16',26000)

--Query to view data from salary table
	select * from t_salary

--query to solve first question of assignment 2
 
	select concat(emp_f_name ,' ', (emp_m_name),' ',emp_l_name ) as name,emp_dob as dateofbirth from t_empl where datepart(d, dateadd(day, 1, emp_dob)) = 1

--Query to solve second question of assignment 2
		   
	SELECT  S.Name, S.[Total Worked Hours], ta.Activity_description AS [Last Worked Activity], 
 		ad.atten_end_hours 
 		AS [Hours Worked ]
 		FROM t_atten_det ad
		INNER JOIN
		(SELECT a.Emp_id,e.emp_f_name + ' ' + COALESCE(e.EMP_m_name,'') + ' ' + COALESCE(e.EMP_l_name,'') AS Name, SUM(a.atten_end_hours) AS [Total Worked Hours], MAX(a.atten_start_date) AS [Last Worked Activity]
		FROM t_empl e
		INNER JOIN t_atten_det a
		ON
		e.Emp_id = a.Emp_id
		INNER JOIN t_activity ac
		ON a.Activity_id = ac.Activity_id
		GROUP BY e.EMP_f_name + ' ' + COALESCE(e.EMP_m_name,'') + ' ' + COALESCE(e.EMP_l_name,''), a.Emp_id)S
		ON ad.atten_start_date = S.[Last Worked Activity]
		INNER JOIN t_activity ta
		ON
		ad.Activity_id = ta.Activity_id;
