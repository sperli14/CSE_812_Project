UPDATE item335 SET VALUE =0 where Value="OFF";
UPDATE item335 SET VALUE =1 where Value="ON";
UPDATE item336 SET VALUE =0 where Value="OFF";
UPDATE item336 SET VALUE =1 where Value="ON";
UPDATE item337 SET VALUE =0 where Value="OFF";
UPDATE item337 SET VALUE =1 where Value="ON";
UPDATE item338 SET VALUE =0 where Value="OFF";
UPDATE item338 SET VALUE =1 where Value="ON";
UPDATE item360 SET VALUE =0 where Value="OFF";
UPDATE item360 SET VALUE =1 where Value="ON";
UPDATE item356 SET VALUE =0 where Value="OFF";
UPDATE item356 SET VALUE =1 where Value="ON";
UPDATE item207 SET VALUE =1 where Value=100;
UPDATE item208 SET VALUE =1 where Value=100;
UPDATE item214 SET VALUE =1 where Value=100;
UPDATE item220 SET VALUE =1 where Value=100;


create table t1 select item335.TIME from item335 where item335.TIME NOT IN(select item360.TIME from item360)  
          union select item336.TIME from item336 where item336.TIME NOT IN(select item360.TIME from item360)
		  union select item337.TIME from item337 where item337.TIME NOT IN(select item360.TIME from item360)
          union select item338.TIME from item338 where item338.TIME NOT IN(select item360.TIME from item360)
          union select item214.TIME from item214 where item214.TIME NOT IN(select item360.TIME from item360)
          union select item356.TIME from item356 where item356.TIME NOT IN(select item360.TIME from item360)
          union select item207.TIME from item207 where item207.TIME NOT IN(select item360.TIME from item360)
          union select item208.TIME from item208 where item208.TIME NOT IN(select item360.TIME from item360)
          union select item220.TIME from item220 where item220.TIME NOT IN(select item360.TIME from item360);
          

ALTER TABLE t1 ADD Value int DEFAULT 0;
CREATE TABLE bedroomswitch_6 SELECT * FROM item360 UNION ALL SELECT * FROM t1 ORDER BY Time ASC;

create table t2 select item360.TIME from item360 where item360.TIME NOT IN(select item335.TIME from item335)  
		  union select item336.TIME from item336 where item336.TIME NOT IN(select item335.TIME from item335)
          union select item337.TIME from item337 where item337.TIME NOT IN(select item335.TIME from item335)
          union select item338.TIME from item338 where item338.TIME NOT IN(select item335.TIME from item335)
          union select item214.TIME from item214 where item214.TIME NOT IN(select item335.TIME from item335)
          union select item356.TIME from item356 where item356.TIME NOT IN(select item335.TIME from item335)
          union select item207.TIME from item207 where item207.TIME NOT IN(select item335.TIME from item335)
          union select item208.TIME from item208 where item208.TIME NOT IN(select item335.TIME from item335)
          union select item220.TIME from item220 where item220.TIME NOT IN(select item335.TIME from item335);
          

ALTER TABLE t2 ADD Value int DEFAULT 0;
CREATE TABLE bedroomswitch_1 SELECT * FROM item335 UNION ALL SELECT * FROM t2 ORDER BY Time ASC;

create table t3 select item360.TIME from item360 where item360.TIME NOT IN(select item336.TIME from item336)  
		  union select item335.TIME from item335 where item335.TIME NOT IN(select item336.TIME from item336)
          union select item337.TIME from item337 where item337.TIME NOT IN(select item336.TIME from item336)
          union select item338.TIME from item338 where item338.TIME NOT IN(select item336.TIME from item336)
          union select item214.TIME from item214 where item214.TIME NOT IN(select item336.TIME from item336)
          union select item356.TIME from item356 where item356.TIME NOT IN(select item336.TIME from item336)
          union select item207.TIME from item207 where item207.TIME NOT IN(select item336.TIME from item336)
          union select item208.TIME from item208 where item208.TIME NOT IN(select item336.TIME from item336)
          union select item220.TIME from item220 where item220.TIME NOT IN(select item336.TIME from item336);
          

ALTER TABLE t3 ADD Value int DEFAULT 0;
CREATE TABLE bedroomswitch_2 SELECT * FROM item336 UNION ALL SELECT * FROM t3 ORDER BY Time ASC;

create table t4 select item360.TIME from item360 where item360.TIME NOT IN(select item337.TIME from item337)  
		  union select item335.TIME from item335 where item335.TIME NOT IN(select item337.TIME from item337)
          union select item336.TIME from item336 where item336.TIME NOT IN(select item337.TIME from item337)
          union select item338.TIME from item338 where item338.TIME NOT IN(select item337.TIME from item337)
          union select item214.TIME from item214 where item214.TIME NOT IN(select item337.TIME from item337)
          union select item356.TIME from item356 where item356.TIME NOT IN(select item337.TIME from item337)
          union select item207.TIME from item207 where item207.TIME NOT IN(select item337.TIME from item337)
          union select item208.TIME from item208 where item208.TIME NOT IN(select item337.TIME from item337)
          union select item220.TIME from item220 where item220.TIME NOT IN(select item337.TIME from item337);
          

ALTER TABLE t4 ADD Value int DEFAULT 0;
CREATE TABLE bedroomswitch_3 SELECT * FROM item337 UNION ALL SELECT * FROM t4 ORDER BY Time ASC;

create table t5 select item360.TIME from item360 where item360.TIME NOT IN(select item338.TIME from item338)  
		  union select item335.TIME from item335 where item335.TIME NOT IN(select item338.TIME from item338)
          union select item336.TIME from item336 where item336.TIME NOT IN(select item338.TIME from item338)
          union select item337.TIME from item337 where item337.TIME NOT IN(select item338.TIME from item338)
          union select item214.TIME from item214 where item214.TIME NOT IN(select item338.TIME from item338)
          union select item356.TIME from item356 where item356.TIME NOT IN(select item338.TIME from item338)
          union select item207.TIME from item207 where item207.TIME NOT IN(select item338.TIME from item338)
          union select item208.TIME from item208 where item208.TIME NOT IN(select item338.TIME from item338)
          union select item220.TIME from item220 where item220.TIME NOT IN(select item338.TIME from item338);
          

ALTER TABLE t5 ADD Value int DEFAULT 0;
CREATE TABLE bedroomswitch_4 SELECT * FROM item338 UNION ALL SELECT * FROM t5 ORDER BY Time ASC;

create table t6 select item360.TIME from item360 where item360.TIME NOT IN(select item214.TIME from item214)  
		  union select item335.TIME from item335 where item335.TIME NOT IN(select item214.TIME from item214)
          union select item336.TIME from item336 where item336.TIME NOT IN(select item214.TIME from item214)
          union select item337.TIME from item337 where item337.TIME NOT IN(select item214.TIME from item214)
          union select item338.TIME from item338 where item338.TIME NOT IN(select item214.TIME from item214)
          union select item356.TIME from item356 where item356.TIME NOT IN(select item214.TIME from item214)
          union select item207.TIME from item207 where item207.TIME NOT IN(select item214.TIME from item214)
          union select item208.TIME from item208 where item208.TIME NOT IN(select item214.TIME from item214)
          union select item220.TIME from item220 where item220.TIME NOT IN(select item214.TIME from item214);
          

ALTER TABLE t6 ADD Value int DEFAULT 0;
CREATE TABLE bedroomlight_3 SELECT * FROM item214 UNION ALL SELECT * FROM t6 ORDER BY Time ASC;

create table t7 select item360.TIME from item360 where item360.TIME NOT IN(select item356.TIME from item356)  
		  union select item335.TIME from item335 where item335.TIME NOT IN(select item356.TIME from item356)
          union select item336.TIME from item336 where item336.TIME NOT IN(select item356.TIME from item356)
          union select item337.TIME from item337 where item337.TIME NOT IN(select item356.TIME from item356)
          union select item338.TIME from item338 where item338.TIME NOT IN(select item356.TIME from item356)
          union select item214.TIME from item214 where item214.TIME NOT IN(select item356.TIME from item356)
          union select item207.TIME from item207 where item207.TIME NOT IN(select item356.TIME from item356)
          union select item208.TIME from item208 where item208.TIME NOT IN(select item356.TIME from item356)
          union select item220.TIME from item220 where item220.TIME NOT IN(select item356.TIME from item356);
          

ALTER TABLE t7 ADD Value int DEFAULT 0;
CREATE TABLE bedroomswitch_5 SELECT * FROM item356 UNION ALL SELECT * FROM t7 ORDER BY Time ASC;

create table t8 select item360.TIME from item360 where item360.TIME NOT IN(select item208.TIME from item208)  
		  union select item335.TIME from item335 where item335.TIME NOT IN(select item208.TIME from item208)
          union select item336.TIME from item336 where item336.TIME NOT IN(select item208.TIME from item208)
          union select item337.TIME from item337 where item337.TIME NOT IN(select item208.TIME from item208)
          union select item338.TIME from item338 where item338.TIME NOT IN(select item208.TIME from item208)
          union select item214.TIME from item214 where item214.TIME NOT IN(select item208.TIME from item208)
          union select item207.TIME from item207 where item207.TIME NOT IN(select item208.TIME from item208)
          union select item356.TIME from item356 where item356.TIME NOT IN(select item208.TIME from item208)
          union select item220.TIME from item220 where item220.TIME NOT IN(select item208.TIME from item208);
          

ALTER TABLE t8 ADD Value int DEFAULT 0;
CREATE TABLE bedroomlight_2 SELECT * FROM item208 UNION ALL SELECT * FROM t8 ORDER BY Time ASC;

create table t9 select item360.TIME from item360 where item360.TIME NOT IN(select item207.TIME from item207)  
		  union select item335.TIME from item335 where item335.TIME NOT IN(select item207.TIME from item207)
          union select item336.TIME from item336 where item336.TIME NOT IN(select item207.TIME from item207)
          union select item337.TIME from item337 where item337.TIME NOT IN(select item207.TIME from item207)
          union select item338.TIME from item338 where item338.TIME NOT IN(select item207.TIME from item207)
          union select item214.TIME from item214 where item214.TIME NOT IN(select item207.TIME from item207)
          union select item356.TIME from item356 where item356.TIME NOT IN(select item207.TIME from item207)
          union select item208.TIME from item208 where item208.TIME NOT IN(select item207.TIME from item207)
          union select item220.TIME from item220 where item220.TIME NOT IN(select item207.TIME from item207);
          

ALTER TABLE t9 ADD Value int DEFAULT 0;
CREATE TABLE bedroomlight_1 SELECT * FROM item207 UNION ALL SELECT * FROM t9 ORDER BY Time ASC;

create table t10 select item335.TIME from item335 where item335.TIME NOT IN(select item220.TIME from item220)  
		  union select item336.TIME from item336 where item336.TIME NOT IN(select item220.TIME from item220) 
          union select item337.TIME from item337 where item337.TIME NOT IN(select item220.TIME from item220)
          union select item338.TIME from item338 where item338.TIME NOT IN(select item220.TIME from item220)
          union select item356.TIME from item356 where item356.TIME NOT IN(select item220.TIME from item220)
          union select item360.TIME from item360 where item360.TIME NOT IN(select item220.TIME from item220)
          union select item207.TIME from item207 where item207.TIME NOT IN(select item220.TIME from item220)
          union select item208.TIME from item208 where item208.TIME NOT IN(select item220.TIME from item220)
          union select item214.TIME from item214 where item214.TIME NOT IN(select item220.TIME from item220);

ALTER TABLE t10 ADD Value int DEFAULT 0;
CREATE TABLE bedroomlight_4 SELECT * FROM item220 UNION ALL SELECT * FROM t10 ORDER BY Time ASC;
