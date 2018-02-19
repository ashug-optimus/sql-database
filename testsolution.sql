--query to create table named as train details that contains two column train id and train name
create table train_details
( train_Id int,
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
  ( station_id int,
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
( train_id int,
  station_id int,
  distance int,
  shedule_arrival datetime,
  departed datetime
  )

--query to insert values in journey details table
 
 insert into Journey_details Values(11404,101,0,Null,'2012/1/25 15:04:00');

 update journey_details set departed='2012/1/25 03:00:00'
 where train_id=11404

 insert into Journey_details Values(11404,103,750,'2012/1/25 09:30:00',null);

 insert into Journey_details Values(22505,101,0,Null,'2012/1/25 15:04:00');

 
 insert into Journey_details Values(22505,102,225,'2012/1/25 5:30:00','2012/1/25 06:00:00');

 insert into Journey_details Values(22505,104,150,'2012/1/25 7:10:00','2012/1/25 07:50:00');

 insert into Journey_details Values(22505,103,100,'2012/1/25 8:30:00',null);

 insert into Journey_details Values(33606,102,0,Null,'2012/1/25 10:45:00');

 insert into Journey_details Values(33606,104,150,'2012/1/25 13:20:00','2012/1/25 13:45:00');

 insert into Journey_details Values(33606,103,100,'2012/1/25 17:20:00',null);

--query to view all data from journey details table
  select * from journey_details
  
  -- queries to find route map
  select station_id from journey_details 

  ;with r  ( t_name ,s_name)
  as
  (
   select train_details.train_name,station_details.station_name from journey_details join
  station_details on station_details.station_id=journey_details.station_id  join train_details on train_details.train_Id=journey_details.train_id where convert(int,shedule_arrival)!=0 and convert(int,departed)!=0
  ),
 
  s(t_name,s_name)
  as
  (
  select train_details.train_name,station_details.station_name from journey_details join
  station_details on station_details.station_id=journey_details.station_id  join train_details on train_details.train_id=journey_details.train_id where journey_details.distance=0
  ),
  
  e(t_name,s_name)
  as
  ( 
  select train_details.train_name,station_details.station_name from journey_details join
  station_details on station_details.station_id=journey_details.station_id  join train_details on train_details.train_Id=journey_details.train_id where  convert(varchar,departed) is null
 )
 select  t_name as train_name, s_name as station_name  from s starting inner join r route on starting.t_name=route.t_name inner join e ending on  starting.t_name=ending.t_name 
  

 
--query to find total distance covered by a train  
 
   select train_details.train_name,sum(journey_details.distance )as distance from journey_details join train_details on journey_details.train_id=train_details.train_Id group by train_details.train_name 
 
 

 --answer for question number 3


 SELECT DISTINCT J.Train_Id , T.Train_Name  
FROM Journey_Details J INNER JOIN Train_Details T
ON J.Train_Id = T.Train_Id


SELECT DISTINCT J.Station_Id , J.Train_Id ,S.Station_Name AS Boarding
FROM JOURNEY_DETAILS J INNER JOIN STATION_DETAILS S
ON J.Station_Id = S.Station_Id
WHERE J.shedule_arrival IS NULL

SELECT DISTINCT J.Station_Id , J.Train_Id ,S.Station_Name AS Destination
FROM Journey_Details J INNER JOIN Station_Details S
ON J.Station_Id = S.Station_Id
WHERE J.departed IS NULL


--query to find the train that covers the maximum distance
select top 1 train_details.train_name,sum(journey_details.distance )as distance from journey_details join train_details on journey_details.train_id=train_details.train_Id group by train_details.train_name order by distance desc


--query to find the train that stop atleast all three station
select  train_details.train_name from train_details join journey_details on journey_details.train_id=train_details.train_Id group by (train_details.train_name) having count(journey_details.station_id)>2

--query to find trains not stoping at alighar and kanpur
select distinct
  train_details.train_name from train_details   right join journey_details on train_details.train_Id=journey_details.train_id  where journey_details.station_id!= 102 and journey_details.station_id!=104 group by(station_details.station_id)
   select train_id from journey_details  where station_id not in( 102,104) group by train_id 