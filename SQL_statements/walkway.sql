UPDATE item307 SET VALUE =0 where Value="OFF";
UPDATE item307 SET VALUE =1 where Value="ON";
UPDATE item319 SET VALUE =0 where Value="OFF";
UPDATE item319 SET VALUE =1 where Value="ON";
UPDATE item320 SET VALUE =0 where Value="OFF";
UPDATE item320 SET VALUE =1 where Value="ON";
UPDATE item322 SET VALUE =0 where Value="OFF";
UPDATE item322 SET VALUE =1 where Value="ON";
UPDATE item324 SET VALUE =0 where Value="OFF";
UPDATE item324 SET VALUE =1 where Value="ON";
UPDATE item323 SET VALUE =0 where Value="OFF";
UPDATE item323 SET VALUE =1 where Value="ON";
UPDATE item328 SET VALUE =0 where Value="OFF";
UPDATE item328 SET VALUE =1 where Value="ON";
UPDATE item329 SET VALUE =0 where Value="OFF";
UPDATE item329 SET VALUE =1 where Value="ON";
UPDATE item221 SET VALUE =1 where Value=100;


create table t1 select item307.TIME from item307 where item307.TIME NOT IN(select item324.TIME from item324)  
          union select item319.TIME from item319 where item319.TIME NOT IN(select item324.TIME from item324)
		  union select item320.TIME from item320 where item320.TIME NOT IN(select item324.TIME from item324)
          union select item322.TIME from item322 where item322.TIME NOT IN(select item324.TIME from item324)
          union select item221.TIME from item221 where item221.TIME NOT IN(select item324.TIME from item324)
          union select item323.TIME from item323 where item323.TIME NOT IN(select item324.TIME from item324)
          union select item328.TIME from item328 where item328.TIME NOT IN(select item324.TIME from item324)
          union select item329.TIME from item329 where item329.TIME NOT IN(select item324.TIME from item324);
          

ALTER TABLE t1 ADD Value int DEFAULT 0;
CREATE TABLE walkwayswitch_1 SELECT * FROM item324 UNION ALL SELECT * FROM t1 ORDER BY Time ASC;

create table t2 select item324.TIME from item324 where item324.TIME NOT IN(select item307.TIME from item307)  
		  union select item319.TIME from item319 where item319.TIME NOT IN(select item307.TIME from item307)
          union select item320.TIME from item320 where item320.TIME NOT IN(select item307.TIME from item307)
          union select item322.TIME from item322 where item322.TIME NOT IN(select item307.TIME from item307)
          union select item221.TIME from item221 where item221.TIME NOT IN(select item307.TIME from item307)
          union select item323.TIME from item323 where item323.TIME NOT IN(select item307.TIME from item307)
          union select item328.TIME from item328 where item328.TIME NOT IN(select item307.TIME from item307)
          union select item329.TIME from item329 where item329.TIME NOT IN(select item307.TIME from item307);
          

ALTER TABLE t2 ADD Value int DEFAULT 0;
CREATE TABLE walkwayswitch_2 SELECT * FROM item307 UNION ALL SELECT * FROM t2 ORDER BY Time ASC;

create table t3 select item324.TIME from item324 where item324.TIME NOT IN(select item319.TIME from item319)  
		  union select item307.TIME from item307 where item307.TIME NOT IN(select item319.TIME from item319)
          union select item320.TIME from item320 where item320.TIME NOT IN(select item319.TIME from item319)
          union select item322.TIME from item322 where item322.TIME NOT IN(select item319.TIME from item319)
          union select item221.TIME from item221 where item221.TIME NOT IN(select item319.TIME from item319)
          union select item323.TIME from item323 where item323.TIME NOT IN(select item319.TIME from item319)
          union select item328.TIME from item328 where item328.TIME NOT IN(select item319.TIME from item319)
          union select item329.TIME from item329 where item329.TIME NOT IN(select item319.TIME from item319);
          

ALTER TABLE t3 ADD Value int DEFAULT 0;
CREATE TABLE walkwayswitch_3 SELECT * FROM item319 UNION ALL SELECT * FROM t3 ORDER BY Time ASC;

create table t4 select item324.TIME from item324 where item324.TIME NOT IN(select item320.TIME from item320)  
		  union select item307.TIME from item307 where item307.TIME NOT IN(select item320.TIME from item320)
          union select item319.TIME from item319 where item319.TIME NOT IN(select item320.TIME from item320)
          union select item322.TIME from item322 where item322.TIME NOT IN(select item320.TIME from item320)
          union select item221.TIME from item221 where item221.TIME NOT IN(select item320.TIME from item320)
          union select item323.TIME from item323 where item323.TIME NOT IN(select item320.TIME from item320)
          union select item328.TIME from item328 where item328.TIME NOT IN(select item320.TIME from item320)
          union select item329.TIME from item329 where item329.TIME NOT IN(select item320.TIME from item320);
          

ALTER TABLE t4 ADD Value int DEFAULT 0;
CREATE TABLE walkwayswitch_4 SELECT * FROM item320 UNION ALL SELECT * FROM t4 ORDER BY Time ASC;

create table t5 select item324.TIME from item324 where item324.TIME NOT IN(select item322.TIME from item322)  
		  union select item307.TIME from item307 where item307.TIME NOT IN(select item322.TIME from item322)
          union select item319.TIME from item319 where item319.TIME NOT IN(select item322.TIME from item322)
          union select item320.TIME from item320 where item320.TIME NOT IN(select item322.TIME from item322)
          union select item221.TIME from item221 where item221.TIME NOT IN(select item322.TIME from item322)
          union select item323.TIME from item323 where item323.TIME NOT IN(select item322.TIME from item322)
          union select item328.TIME from item328 where item328.TIME NOT IN(select item322.TIME from item322)
          union select item329.TIME from item329 where item329.TIME NOT IN(select item322.TIME from item322);
          

ALTER TABLE t5 ADD Value int DEFAULT 0;
CREATE TABLE walkwayswitch_5 SELECT * FROM item322 UNION ALL SELECT * FROM t5 ORDER BY Time ASC;

create table t6 select item324.TIME from item324 where item324.TIME NOT IN(select item221.TIME from item221)  
		  union select item307.TIME from item307 where item307.TIME NOT IN(select item221.TIME from item221)
          union select item319.TIME from item319 where item319.TIME NOT IN(select item221.TIME from item221)
          union select item320.TIME from item320 where item320.TIME NOT IN(select item221.TIME from item221)
          union select item322.TIME from item322 where item322.TIME NOT IN(select item221.TIME from item221)
          union select item323.TIME from item323 where item323.TIME NOT IN(select item221.TIME from item221)
          union select item328.TIME from item328 where item328.TIME NOT IN(select item221.TIME from item221)
          union select item329.TIME from item329 where item329.TIME NOT IN(select item221.TIME from item221);
          

ALTER TABLE t6 ADD Value int DEFAULT 0;
CREATE TABLE walkwaylight SELECT * FROM item221 UNION ALL SELECT * FROM t6 ORDER BY Time ASC;

create table t7 select item324.TIME from item324 where item324.TIME NOT IN(select item323.TIME from item323)  
		  union select item307.TIME from item307 where item307.TIME NOT IN(select item323.TIME from item323)
          union select item319.TIME from item319 where item319.TIME NOT IN(select item323.TIME from item323)
          union select item320.TIME from item320 where item320.TIME NOT IN(select item323.TIME from item323)
          union select item322.TIME from item322 where item322.TIME NOT IN(select item323.TIME from item323)
          union select item221.TIME from item221 where item221.TIME NOT IN(select item323.TIME from item323)
          union select item328.TIME from item328 where item328.TIME NOT IN(select item323.TIME from item323)
          union select item329.TIME from item329 where item329.TIME NOT IN(select item323.TIME from item323);
          

ALTER TABLE t7 ADD Value int DEFAULT 0;
CREATE TABLE walkwayswitch_6 SELECT * FROM item323 UNION ALL SELECT * FROM t7 ORDER BY Time ASC;

create table t8 select item324.TIME from item324 where item324.TIME NOT IN(select item329.TIME from item329)  
		  union select item307.TIME from item307 where item307.TIME NOT IN(select item329.TIME from item329)
          union select item319.TIME from item319 where item319.TIME NOT IN(select item329.TIME from item329)
          union select item320.TIME from item320 where item320.TIME NOT IN(select item329.TIME from item329)
          union select item322.TIME from item322 where item322.TIME NOT IN(select item329.TIME from item329)
          union select item221.TIME from item221 where item221.TIME NOT IN(select item329.TIME from item329)
          union select item328.TIME from item328 where item328.TIME NOT IN(select item329.TIME from item329)
          union select item323.TIME from item323 where item323.TIME NOT IN(select item329.TIME from item329);
          

ALTER TABLE t8 ADD Value int DEFAULT 0;
CREATE TABLE walkwayswitch_7 SELECT * FROM item329 UNION ALL SELECT * FROM t8 ORDER BY Time ASC;

create table t9 select item324.TIME from item324 where item324.TIME NOT IN(select item328.TIME from item328)  
		  union select item307.TIME from item307 where item307.TIME NOT IN(select item328.TIME from item328)
          union select item319.TIME from item319 where item319.TIME NOT IN(select item328.TIME from item328)
          union select item320.TIME from item320 where item320.TIME NOT IN(select item328.TIME from item328)
          union select item322.TIME from item322 where item322.TIME NOT IN(select item328.TIME from item328)
          union select item221.TIME from item221 where item221.TIME NOT IN(select item328.TIME from item328)
          union select item323.TIME from item323 where item323.TIME NOT IN(select item328.TIME from item328)
          union select item329.TIME from item329 where item329.TIME NOT IN(select item328.TIME from item328);
          

ALTER TABLE t9 ADD Value int DEFAULT 0;
CREATE TABLE walkwayswitch_8 SELECT * FROM item328 UNION ALL SELECT * FROM t9 ORDER BY Time ASC;
