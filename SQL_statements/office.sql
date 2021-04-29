UPDATE item341 SET VALUE =0 where Value="OFF";
UPDATE item341 SET VALUE =1 where Value="ON";
UPDATE item342 SET VALUE =0 where Value="OFF";
UPDATE item342 SET VALUE =1 where Value="ON";
UPDATE item354 SET VALUE =0 where Value="OFF";
UPDATE item354 SET VALUE =1 where Value="ON";
UPDATE item222 SET VALUE =1 where Value=100;

create table t1 select item341.TIME from item341 where item341.TIME NOT IN(select item222.TIME from item222)  
          union select item342.TIME from item342 where item342.TIME NOT IN(select item222.TIME from item222)
		  union select item354.TIME from item354 where item354.TIME NOT IN(select item222.TIME from item222);
          

ALTER TABLE t1 ADD Value int DEFAULT 0;
CREATE TABLE officelight SELECT * FROM item222 UNION ALL SELECT * FROM t1 ORDER BY Time ASC;

create table t2 select item222.TIME from item222 where item222.TIME NOT IN(select item341.TIME from item341)  
		  union select item342.TIME from item342 where item342.TIME NOT IN(select item341.TIME from item341)
          union select item354.TIME from item354 where item354.TIME NOT IN(select item341.TIME from item341);
          

ALTER TABLE t2 ADD Value int DEFAULT 0;
CREATE TABLE officeswitch_1 SELECT * FROM item341 UNION ALL SELECT * FROM t2 ORDER BY Time ASC;

create table t3 select item222.TIME from item222 where item222.TIME NOT IN(select item342.TIME from item342)  
		  union select item341.TIME from item341 where item341.TIME NOT IN(select item342.TIME from item342)
          union select item354.TIME from item354 where item354.TIME NOT IN(select item342.TIME from item342);
          

ALTER TABLE t3 ADD Value int DEFAULT 0;
CREATE TABLE officeswitch_2 SELECT * FROM item342 UNION ALL SELECT * FROM t3 ORDER BY Time ASC;

create table t4 select item222.TIME from item222 where item222.TIME NOT IN(select item354.TIME from item354)  
		  union select item341.TIME from item341 where item341.TIME NOT IN(select item354.TIME from item354)
          union select item342.TIME from item342 where item342.TIME NOT IN(select item354.TIME from item354);
          

ALTER TABLE t4 ADD Value int DEFAULT 0;
CREATE TABLE officeswitch_3 SELECT * FROM item354 UNION ALL SELECT * FROM t4 ORDER BY Time ASC;
