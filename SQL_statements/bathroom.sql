UPDATE item330 SET VALUE =0 where Value="OFF";
UPDATE item330 SET VALUE =1 where Value="ON";
UPDATE item331 SET VALUE =0 where Value="OFF";
UPDATE item331 SET VALUE =1 where Value="ON";
UPDATE item332 SET VALUE =0 where Value="OFF";
UPDATE item332 SET VALUE =1 where Value="ON";
UPDATE item333 SET VALUE =0 where Value="OFF";
UPDATE item333 SET VALUE =1 where Value="ON";
UPDATE item209 SET VALUE =1 where Value=100;
UPDATE item226 SET VALUE =1 where Value=100;


create table t1 select item330.TIME from item330 where item330.TIME NOT IN(select item209.TIME from item209)  
          union select item331.TIME from item331 where item331.TIME NOT IN(select item209.TIME from item209)
		  union select item332.TIME from item332 where item332.TIME NOT IN(select item209.TIME from item209)
          union select item333.TIME from item333 where item333.TIME NOT IN(select item209.TIME from item209)
          union select item226.TIME from item226 where item226.TIME NOT IN(select item209.TIME from item209);
          

ALTER TABLE t1 ADD Value int DEFAULT 0;
CREATE TABLE bathroomlight_1 SELECT * FROM item209 UNION ALL SELECT * FROM t1 ORDER BY Time ASC;

create table t2 select item209.TIME from item209 where item209.TIME NOT IN(select item330.TIME from item330)  
		  union select item331.TIME from item331 where item331.TIME NOT IN(select item330.TIME from item330)
          union select item332.TIME from item332 where item332.TIME NOT IN(select item330.TIME from item330)
          union select item333.TIME from item333 where item333.TIME NOT IN(select item330.TIME from item330)
          union select item226.TIME from item226 where item226.TIME NOT IN(select item330.TIME from item330);
          

ALTER TABLE t2 ADD Value int DEFAULT 0;
CREATE TABLE bathroomswitch_1 SELECT * FROM item330 UNION ALL SELECT * FROM t2 ORDER BY Time ASC;

create table t3 select item209.TIME from item209 where item209.TIME NOT IN(select item331.TIME from item331)  
		  union select item330.TIME from item330 where item330.TIME NOT IN(select item331.TIME from item331)
          union select item332.TIME from item332 where item332.TIME NOT IN(select item331.TIME from item331)
          union select item333.TIME from item333 where item333.TIME NOT IN(select item331.TIME from item331)
          union select item226.TIME from item226 where item226.TIME NOT IN(select item331.TIME from item331);
          

ALTER TABLE t3 ADD Value int DEFAULT 0;
CREATE TABLE bathroomswitch_2 SELECT * FROM item331 UNION ALL SELECT * FROM t3 ORDER BY Time ASC;

create table t4 select item209.TIME from item209 where item209.TIME NOT IN(select item332.TIME from item332)  
		  union select item330.TIME from item330 where item330.TIME NOT IN(select item332.TIME from item332)
          union select item331.TIME from item331 where item331.TIME NOT IN(select item332.TIME from item332)
          union select item333.TIME from item333 where item333.TIME NOT IN(select item332.TIME from item332)
          union select item226.TIME from item226 where item226.TIME NOT IN(select item332.TIME from item332);
          

ALTER TABLE t4 ADD Value int DEFAULT 0;
CREATE TABLE bathroomswitch_3 SELECT * FROM item332 UNION ALL SELECT * FROM t4 ORDER BY Time ASC;

create table t5 select item209.TIME from item209 where item209.TIME NOT IN(select item333.TIME from item333)  
		  union select item330.TIME from item330 where item330.TIME NOT IN(select item333.TIME from item333)
          union select item331.TIME from item331 where item331.TIME NOT IN(select item333.TIME from item333)
          union select item332.TIME from item332 where item332.TIME NOT IN(select item333.TIME from item333)
          union select item226.TIME from item226 where item226.TIME NOT IN(select item333.TIME from item333);
          

ALTER TABLE t5 ADD Value int DEFAULT 0;
CREATE TABLE bathroomswitch_4 SELECT * FROM item333 UNION ALL SELECT * FROM t5 ORDER BY Time ASC;

create table t6 select item209.TIME from item209 where item209.TIME NOT IN(select item226.TIME from item226)  
		  union select item330.TIME from item330 where item330.TIME NOT IN(select item226.TIME from item226)
          union select item331.TIME from item331 where item331.TIME NOT IN(select item226.TIME from item226)
          union select item332.TIME from item332 where item332.TIME NOT IN(select item226.TIME from item226)
          union select item333.TIME from item333 where item333.TIME NOT IN(select item226.TIME from item226);
          

ALTER TABLE t6 ADD Value int DEFAULT 0;
CREATE TABLE bathroomlight_2 SELECT * FROM item226 UNION ALL SELECT * FROM t6 ORDER BY Time ASC;
