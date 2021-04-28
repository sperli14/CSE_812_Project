UPDATE item291 SET VALUE =0 where Value="OFF";
UPDATE item291 SET VALUE =1 where Value="ON";
UPDATE item297 SET VALUE =0 where Value="OFF";
UPDATE item297 SET VALUE =1 where Value="ON";
UPDATE item298 SET VALUE =0 where Value="OFF";
UPDATE item298 SET VALUE =1 where Value="ON";
UPDATE item351 SET VALUE =0 where Value="OFF";
UPDATE item351 SET VALUE =1 where Value="ON";
UPDATE item212 SET VALUE =1 where Value=100;
UPDATE item353 SET VALUE =0 where Value="OFF";
UPDATE item353 SET VALUE =1 where Value="ON";
UPDATE item218 SET VALUE =1 where Value=100;


create table t1 select item291.TIME from item291 where item291.TIME NOT IN(select item212.TIME from item212)  
          union select item297.TIME from item297 where item297.TIME NOT IN(select item212.TIME from item212)
		  union select item298.TIME from item298 where item298.TIME NOT IN(select item212.TIME from item212)
          union select item351.TIME from item351 where item351.TIME NOT IN(select item212.TIME from item212)
          union select item218.TIME from item218 where item218.TIME NOT IN(select item212.TIME from item212)
          union select item353.TIME from item353 where item353.TIME NOT IN(select item212.TIME from item212);
          

ALTER TABLE t1 ADD Value int DEFAULT 0;
CREATE TABLE livinglight_1 SELECT * FROM item212 UNION ALL SELECT * FROM t1 ORDER BY Time ASC;

create table t2 select item212.TIME from item212 where item212.TIME NOT IN(select item291.TIME from item291)  
		  union select item297.TIME from item297 where item297.TIME NOT IN(select item291.TIME from item291)
          union select item298.TIME from item298 where item298.TIME NOT IN(select item291.TIME from item291)
          union select item351.TIME from item351 where item351.TIME NOT IN(select item291.TIME from item291)
          union select item218.TIME from item218 where item218.TIME NOT IN(select item291.TIME from item291)
          union select item353.TIME from item353 where item353.TIME NOT IN(select item291.TIME from item291);
          

ALTER TABLE t2 ADD Value int DEFAULT 0;
CREATE TABLE livingswitch_1 SELECT * FROM item291 UNION ALL SELECT * FROM t2 ORDER BY Time ASC;

create table t3 select item212.TIME from item212 where item212.TIME NOT IN(select item297.TIME from item297)  
		  union select item291.TIME from item291 where item291.TIME NOT IN(select item297.TIME from item297)
          union select item298.TIME from item298 where item298.TIME NOT IN(select item297.TIME from item297)
          union select item351.TIME from item351 where item351.TIME NOT IN(select item297.TIME from item297)
          union select item218.TIME from item218 where item218.TIME NOT IN(select item297.TIME from item297)
          union select item353.TIME from item353 where item353.TIME NOT IN(select item297.TIME from item297);
          

ALTER TABLE t3 ADD Value int DEFAULT 0;
CREATE TABLE livingswitch_2 SELECT * FROM item297 UNION ALL SELECT * FROM t3 ORDER BY Time ASC;

create table t4 select item212.TIME from item212 where item212.TIME NOT IN(select item298.TIME from item298)  
		  union select item291.TIME from item291 where item291.TIME NOT IN(select item298.TIME from item298)
          union select item297.TIME from item297 where item297.TIME NOT IN(select item298.TIME from item298)
          union select item351.TIME from item351 where item351.TIME NOT IN(select item298.TIME from item298)
          union select item218.TIME from item218 where item218.TIME NOT IN(select item298.TIME from item298)
          union select item353.TIME from item353 where item353.TIME NOT IN(select item298.TIME from item298);
          

ALTER TABLE t4 ADD Value int DEFAULT 0;
CREATE TABLE livingswitch_3 SELECT * FROM item298 UNION ALL SELECT * FROM t4 ORDER BY Time ASC;

create table t5 select item212.TIME from item212 where item212.TIME NOT IN(select item351.TIME from item351)  
		  union select item291.TIME from item291 where item291.TIME NOT IN(select item351.TIME from item351)
          union select item297.TIME from item297 where item297.TIME NOT IN(select item351.TIME from item351)
          union select item298.TIME from item298 where item298.TIME NOT IN(select item351.TIME from item351)
          union select item218.TIME from item218 where item218.TIME NOT IN(select item351.TIME from item351)
          union select item353.TIME from item353 where item353.TIME NOT IN(select item351.TIME from item351);
          

ALTER TABLE t5 ADD Value int DEFAULT 0;
CREATE TABLE livingswitch_4 SELECT * FROM item351 UNION ALL SELECT * FROM t5 ORDER BY Time ASC;

create table t6 select item212.TIME from item212 where item212.TIME NOT IN(select item218.TIME from item218)  
		  union select item291.TIME from item291 where item291.TIME NOT IN(select item218.TIME from item218)
          union select item297.TIME from item297 where item297.TIME NOT IN(select item218.TIME from item218)
          union select item298.TIME from item298 where item298.TIME NOT IN(select item218.TIME from item218)
          union select item351.TIME from item351 where item351.TIME NOT IN(select item218.TIME from item218)
          union select item353.TIME from item353 where item353.TIME NOT IN(select item218.TIME from item218);
          

ALTER TABLE t6 ADD Value int DEFAULT 0;
CREATE TABLE livinglight_2 SELECT * FROM item218 UNION ALL SELECT * FROM t6 ORDER BY Time ASC;

create table t7 select item212.TIME from item212 where item212.TIME NOT IN(select item353.TIME from item353)  
		  union select item291.TIME from item291 where item291.TIME NOT IN(select item353.TIME from item353)
          union select item297.TIME from item297 where item297.TIME NOT IN(select item353.TIME from item353)
          union select item298.TIME from item298 where item298.TIME NOT IN(select item353.TIME from item353)
          union select item351.TIME from item351 where item351.TIME NOT IN(select item353.TIME from item353)
          union select item218.TIME from item218 where item218.TIME NOT IN(select item353.TIME from item353);
          

ALTER TABLE t7 ADD Value int DEFAULT 0;
CREATE TABLE livingswitch_5 SELECT * FROM item353 UNION ALL SELECT * FROM t7 ORDER BY Time ASC;
