UPDATE item318 SET VALUE =0 where Value="OFF";
UPDATE item318 SET VALUE =1 where Value="ON";
UPDATE item344 SET VALUE =0 where Value="OFF";
UPDATE item344 SET VALUE =1 where Value="ON";
UPDATE item213 SET VALUE =1 where Value=100;

create table t1 select item318.TIME from item318 where item318.TIME NOT IN(select item213.TIME from item213)  
		  union select item344.TIME from item344 where item344.TIME NOT IN(select item213.TIME from item213);
          

ALTER TABLE t1 ADD Value int DEFAULT 0;
CREATE TABLE staircaselight SELECT * FROM item213 UNION ALL SELECT * FROM t1 ORDER BY Time ASC;

create table t2 select item213.TIME from item213 where item213.TIME NOT IN(select item318.TIME from item318)  
		  union select item344.TIME from item344 where item344.TIME NOT IN(select item318.TIME from item318);
          

ALTER TABLE t2 ADD Value int DEFAULT 0;
CREATE TABLE staircaseswitch_1 SELECT * FROM item318 UNION ALL SELECT * FROM t2 ORDER BY Time ASC;

create table t3 select item213.TIME from item213 where item213.TIME NOT IN(select item344.TIME from item344)  
		  union select item318.TIME from item318 where item318.TIME NOT IN(select item344.TIME from item344);
          

ALTER TABLE t3 ADD Value int DEFAULT 0;
CREATE TABLE staircaseswitch_2 SELECT * FROM item344 UNION ALL SELECT * FROM t3 ORDER BY Time ASC;
