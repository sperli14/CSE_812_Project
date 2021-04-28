UPDATE item302 SET VALUE =0 where Value="OFF";
UPDATE item302 SET VALUE =1 where Value="ON";
UPDATE item304 SET VALUE =0 where Value="OFF";
UPDATE item304 SET VALUE =1 where Value="ON";
UPDATE item345 SET VALUE =0 where Value="OFF";
UPDATE item345 SET VALUE =1 where Value="ON";
UPDATE item346 SET VALUE =0 where Value="OFF";
UPDATE item346 SET VALUE =1 where Value="ON";
UPDATE item223 SET VALUE =1 where Value=100;
UPDATE item230 SET VALUE =1 where Value=100;


create table t1 select item302.TIME from item302 where item302.TIME NOT IN(select item223.TIME from item223)  
          union select item304.TIME from item304 where item304.TIME NOT IN(select item223.TIME from item223)
		  union select item345.TIME from item345 where item345.TIME NOT IN(select item223.TIME from item223)
          union select item346.TIME from item346 where item346.TIME NOT IN(select item223.TIME from item223)
          union select item230.TIME from item230 where item230.TIME NOT IN(select item223.TIME from item223);
          

ALTER TABLE t1 ADD Value int DEFAULT 0;
CREATE TABLE kitchenlight_1 SELECT * FROM item223 UNION ALL SELECT * FROM t1 ORDER BY Time ASC;

create table t2 select item223.TIME from item223 where item223.TIME NOT IN(select item302.TIME from item302)  
		  union select item304.TIME from item304 where item304.TIME NOT IN(select item302.TIME from item302)
          union select item345.TIME from item345 where item345.TIME NOT IN(select item302.TIME from item302)
          union select item346.TIME from item346 where item346.TIME NOT IN(select item302.TIME from item302)
          union select item230.TIME from item230 where item230.TIME NOT IN(select item302.TIME from item302);
          

ALTER TABLE t2 ADD Value int DEFAULT 0;
CREATE TABLE kitchenswitch_1 SELECT * FROM item302 UNION ALL SELECT * FROM t2 ORDER BY Time ASC;

create table t3 select item223.TIME from item223 where item223.TIME NOT IN(select item304.TIME from item304)  
		  union select item302.TIME from item302 where item302.TIME NOT IN(select item304.TIME from item304)
          union select item345.TIME from item345 where item345.TIME NOT IN(select item304.TIME from item304)
          union select item346.TIME from item346 where item346.TIME NOT IN(select item304.TIME from item304)
          union select item230.TIME from item230 where item230.TIME NOT IN(select item304.TIME from item304);
          

ALTER TABLE t3 ADD Value int DEFAULT 0;
CREATE TABLE kitchenswitch_2 SELECT * FROM item304 UNION ALL SELECT * FROM t3 ORDER BY Time ASC;

create table t4 select item223.TIME from item223 where item223.TIME NOT IN(select item345.TIME from item345)  
		  union select item302.TIME from item302 where item302.TIME NOT IN(select item345.TIME from item345)
          union select item304.TIME from item304 where item304.TIME NOT IN(select item345.TIME from item345)
          union select item346.TIME from item346 where item346.TIME NOT IN(select item345.TIME from item345)
          union select item230.TIME from item230 where item230.TIME NOT IN(select item345.TIME from item345);
          

ALTER TABLE t4 ADD Value int DEFAULT 0;
CREATE TABLE kitchenswitch_3 SELECT * FROM item345 UNION ALL SELECT * FROM t4 ORDER BY Time ASC;

create table t5 select item223.TIME from item223 where item223.TIME NOT IN(select item346.TIME from item346)  
		  union select item302.TIME from item302 where item302.TIME NOT IN(select item346.TIME from item346)
          union select item304.TIME from item304 where item304.TIME NOT IN(select item346.TIME from item346)
          union select item345.TIME from item345 where item345.TIME NOT IN(select item346.TIME from item346)
          union select item230.TIME from item230 where item230.TIME NOT IN(select item346.TIME from item346);
          

ALTER TABLE t5 ADD Value int DEFAULT 0;
CREATE TABLE kitchenswitch_4 SELECT * FROM item346 UNION ALL SELECT * FROM t5 ORDER BY Time ASC;

create table t6 select item223.TIME from item223 where item223.TIME NOT IN(select item230.TIME from item230)  
		  union select item302.TIME from item302 where item302.TIME NOT IN(select item230.TIME from item230)
          union select item304.TIME from item304 where item304.TIME NOT IN(select item230.TIME from item230)
          union select item345.TIME from item345 where item345.TIME NOT IN(select item230.TIME from item230)
          union select item346.TIME from item346 where item346.TIME NOT IN(select item230.TIME from item230);
          

ALTER TABLE t6 ADD Value int DEFAULT 0;
CREATE TABLE kitchenlight_2 SELECT * FROM item230 UNION ALL SELECT * FROM t6 ORDER BY Time ASC;
