--query to create table named as train details that contains two column train id and train name
	create table train_details
	( 
		train_Id int,
		train_name varchar(30)
	)

 --query to enter data in train details table
	insert into train_details
		values(11404,'shatabdi')

	insert into train_details
		values(22505,'rajdhani')

	insert into train_details
		values(33606,'passenger')
   
--query to view the train details table
  
	select * from train_details

--query to create table named as station details with two column station id and station name 
	create table station_details
	 ( 
		station_id int,
		station_name varchar(30)
	)

--query to insert values in station details table 

	insert into station_details
		values(101,'Delhi')

	insert into station_details
		values(102,'Alighar')

	insert into station_details
		values(103,'Lucknow')

	insert into station_details
		values(104,'Kanpur')


--query to view the station details table
	select * from station_details

--query to create table named as journey details that contain train id,staion id,distance,shedule arrival,departed
	create table journey_details
	( 
		train_id int,
		station_id int,
		distance int,
		shedule_arrival datetime,
		departed datetime
  )

--query to insert values in journey details table
 
	insert into Journey_details 
		Values(11404,101,0,Null,'2012/1/25 15:04:00');

	update journey_details set departed='2012/1/25 03:00:00'
		where train_id=11404

	insert into Journey_details 
		Values(11404,103,750,'2012/1/25 09:30:00',null);

	insert into Journey_details 
		Values(22505,101,0,Null,'2012/1/25 15:04:00');

 
	insert into Journey_details 
		Values(22505,102,225,'2012/1/25 5:30:00','2012/1/25 06:00:00');

	insert into Journey_details 
		Values(22505,104,150,'2012/1/25 7:10:00','2012/1/25 07:50:00');

	insert into Journey_details 
		Values(22505,103,100,'2012/1/25 8:30:00',null);

	insert into Journey_details 
		Values(33606,102,0,Null,'2012/1/25 10:45:00');

	insert into Journey_details 
		Values(33606,104,150,'2012/1/25 13:20:00','2012/1/25 13:45:00');

	insert into Journey_details 
		Values(33606,103,100,'2012/1/25 17:20:00',null);

--query to view all data from journey details table
	select * from journey_details
  
-- queries to find route map from where a train starts , where it goes , and where the train terminates
  
  --table starting_station contains station name from where a train starts
	create table starting_station
	(
		train_name varchar(30),
		station_name varchar(30),
	)

 --table route_station contains station name from where a train pass by
	create table route_station
	(
		train_name varchar(30),
		station_name varchar(30),
	)

--table end_station contains station name  where a train terminates

	create table end_station
	(
		 train_name varchar(30),
		station_name varchar(30),
	)

--query that finds the data for above mentioned three tables 
	insert into starting_station
		select train_details.train_name,station_details.station_name 
		from journey_details join
		station_details 
		on station_details.station_id=journey_details.station_id  
		join train_details 
		on train_details.train_id=journey_details.train_id 
		where journey_details.distance=0

	insert into route_station
		select train_details.train_name,station_details.station_name 
		from journey_details join
		station_details 
		on station_details.station_id=journey_details.station_id  
		join train_details 
		on train_details.train_Id=journey_details.train_id 
		where convert(int,shedule_arrival)!=0 and convert(int,departed)!=0 
		group by train_details.train_name,station_details.station_name

    insert into end_station
		select train_details.train_name,station_details.station_name 
		from journey_details join
		station_details 
		on station_details.station_id=journey_details.station_id  
		join train_details 
		on train_details.train_Id=journey_details.train_id 
		where  convert(varchar,departed) is null

--Query to create table that contains the information of train and there routing stations
	create table route
	( 
		train_name varchar(30),
		station_name varchar(max)
	)

--Query to find the data for route table from starting_station ,route_station and end_station tables
	insert into route
	select distinct starting_station.train_name as train_name,concat(starting_station.station_name,',',route_station.station_name,',',end_station.station_name) as stations 
	from starting_station   
	left join route_station 
	on starting_station.train_name=route_station.train_name 
	left join end_station
	 on starting_station.train_name=end_station.train_name 
  

 
--query to find total distance covered by a train an storing that in a single table named as max distance 
	create table max_distance
    ( 
		train_name varchar(30),
        distance int
	 )

 -- Query to find data fro max distance table from journey detail table
	insert into max_distance
	select train_details.train_name,sum(journey_details.distance )as distance 
	from journey_details 
	join train_details 
	on journey_details.train_id=train_details.train_Id 
	group by train_details.train_name 

--Query to find the train with there routing stations and max distance
	select route.train_name,route.station_name,max_distance.distance 
	from route 
	left join max_distance 
	on route.train_name=max_distance.train_name

--Query to give the table asked in first question
	create table final_table
	(
		train_name varchar(max),
		station_name varchar(max),
		distance int,
		avg_speed int
	)
	insert into final_table
		select T9.train_name,T9.station_name,T9.distance,T8.speed 
		from
		(
			select route.train_name,route.station_name,max_distance.distance 
			from route left join max_distance 
			on route.train_name=max_distance.train_name
		) T9

		left join
		(
			select speed = abs(max_distance.distance/T5.diff),t5.train_name 
			from max_distance left join
		(
			select DATEDIFF(hh,T1.departed,T2.shedule_arrival) as diff,T1.train_name
			from 
		( 
			select train_details.train_name,station_details.station_name,journey_details.departed 
			from journey_details join
			station_details	
			on station_details.station_id=journey_details.station_id  
			join train_details 
			on train_details.train_id=journey_details.train_id
			where journey_details.distance=0
		) t1

		left join
		(
			select train_details.train_name,station_details.station_name,journey_details.shedule_arrival 
			from journey_details join
			station_details 
			on station_details.station_id=journey_details.station_id  join train_details 
			on train_details.train_Id=journey_details.train_id 
			where  convert(varchar,departed) is null
		) t2
		on
		t1.train_name =t2.train_name
		) T5
		on max_distance.train_name =T5.train_name
		) T8
		on T9.train_name =T8.train_name

	select * from final_table
	


--query to find the train that covers the maximum distance
	select top 1 train_details.train_name,sum(journey_details.distance )as distance 
	from journey_details join train_details 
	on journey_details.train_id=train_details.train_Id 
	group by train_details.train_name 
	order by distance desc

--Query to find the train name that has the maximum average speed
    select train_name,avg_speed from final_table
	where avg_speed=(select max(avg_speed) as max_speed from final_table) 

--query to find the train that stop atleast all three station
	select  train_details.train_name 
	from train_details join 
	journey_details 
	on journey_details.train_id=train_details.train_Id 
	group by (train_details.train_name) 
	having count(journey_details.station_id)>2

--query to find trains not stoping at alighar and kanpur
	select Train_Name 
	from Train_Details 
	Except 
	(
		select train_name 
		from train_details  inner join 
		journey_details  
		on train_details.train_id=journey_details.train_id 
        where station_id  IN (102, 104) 
		group by train_name
	)


--Query to find the boarding and destination of trains
  -- boarding table contains the station id ,train id and station name from where train start its journey
	create table boarding
	( 
		staion_id int,
		train_id int,
		boarding varchar(30),
    )

	insert into boarding
		SELECT DISTINCT J.Station_Id , J.Train_Id ,S.Station_Name AS Boarding
		FROM JOURNEY_DETAILS J INNER JOIN 
		STATION_DETAILS S
		ON J.Station_Id = S.Station_Id
		WHERE J.shedule_arrival IS NULL
   
   -- departer table contains the station id ,train id and station name  where train ends  its journey
    create table departer
	( 
		staion_id int,
		train_id int,
		destination varchar(30),
	)
	insert into departer
		SELECT DISTINCT J.Station_Id , J.Train_Id ,S.Station_Name AS Destination
		FROM Journey_Details J INNER JOIN 
		Station_Details S
		ON J.Station_Id = S.Station_Id
		WHERE J.departed IS NULL

--Query to find boarding and destination
 
	select boarding.station_id,boarding.train_id,boarding.boarding ,departer.destination 
	from boarding join 
	departer 
	on boarding.train_id=departer.train_id
