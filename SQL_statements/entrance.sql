UPDATE item306 SET VALUE =0 where Value="OFF";
UPDATE item306 SET VALUE =1 where Value="ON";
UPDATE item210 SET VALUE =1 where Value=100;

create table t1 select item306.TIME from item306 where item306.TIME NOT IN(select item210.TIME from item210);
          

ALTER TABLE t1 ADD Value int DEFAULT 0;
CREATE TABLE entrancelight_1 SELECT * FROM item210 UNION ALL SELECT * FROM t1 ORDER BY Time ASC;

create table t2 select item210.TIME from item210 where item210.TIME NOT IN(select item306.TIME from item306);
          

ALTER TABLE t2 ADD Value int DEFAULT 0;
CREATE TABLE entranceswitch SELECT * FROM item306 UNION ALL SELECT * FROM t2 ORDER BY Time ASC;
