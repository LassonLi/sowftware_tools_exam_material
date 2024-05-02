Drop table if exists event;
Drop table if exists commit;
Drop table if exists student;
Create table student (
email varchar(100) unique ,
name varchar(100),
id int,
skill int
);
Create table commit (
role varchar(100),
stemail varchar(100)
);
Create table event (
dat Date,
location varchar(100),
name varchar(100),
des varchar(100),
stemail varchar(100)
);
