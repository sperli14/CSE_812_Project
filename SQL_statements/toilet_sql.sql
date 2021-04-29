UPDATE item347 SET VALUE =0 where Value="OFF";
UPDATE item347 SET VALUE =1 where Value="ON";
UPDATE item348 SET VALUE =0 where Value="OFF";
UPDATE item348 SET VALUE =1 where Value="ON";
UPDATE item215 SET VALUE =1 where Value=100;

create table t1 select item347.TIME from item347 where item347.TIME NOT IN(select item215.TIME from item215)  
		  union select item348.TIME from item348 where item348.TIME NOT IN(select item215.TIME from item215);
          

ALTER TABLE t1 ADD Value int DEFAULT 0;
CREATE TABLE toiletlight SELECT * FROM item215 UNION ALL SELECT * FROM t1 ORDER BY Time ASC;

create table t2 select item215.TIME from item215 where item215.TIME NOT IN(select item347.TIME from item347)  
		  union select item348.TIME from item348 where item348.TIME NOT IN(select item347.TIME from item347);
          

ALTER TABLE t2 ADD Value int DEFAULT 0;
CREATE TABLE toiletswitch_1 SELECT * FROM item347 UNION ALL SELECT * FROM t2 ORDER BY Time ASC;

create table t3 select item215.TIME from item215 where item215.TIME NOT IN(select item348.TIME from item348)  
		  union select item347.TIME from item347 where item347.TIME NOT IN(select item348.TIME from item348);
          

ALTER TABLE t3 ADD Value int DEFAULT 0;
CREATE TABLE toiletswitch_2 SELECT * FROM item348 UNION ALL SELECT * FROM t3 ORDER BY Time ASC;
