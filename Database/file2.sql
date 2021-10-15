--Changed datatype of phone to varchar
ALTER TABLE users MODIFY phone VARCHAR(20);

--Inserting data in users table
INSERT INTO users(firstname,lastname,phone,email,dob,gender) 
    VALUES ('Rashad','Mitchel','9191919191','rashad@gmail.com',20000101,'m'),
    ('Hedy','Stanley','9292929292','hedy@gmail.com',19990102,'m'),
    ('Haley','Ray','9393939393','haley@gmail.com',20020103,'f'),
    ('Neve','Callahan','9494949494','neve@gmail.com',19980104,'f'),
    ('India','Woodard','9595959595','india@gmail.com',19970105,'f') ;

-- Inserting data in Address Table

INSERT INTO address(userid,line1,line2,locality,landmark,city,province,pincode)
VALUES 
(1,'1745 t street','','Southeast','Headingly Circle','Washington','DC',200201),
(4,'6007 Applegate','Cargill Apt','avenue road','','Lousville','Kentucky',402194),
(6,'560 Penstock','','Driveway hill','','Grass Valley','California',959452),
(5,'150 carter street','','Kiwi Garden','Jake Soccer Club','Manchester','Connecticut',060405),
(7,'637 Densmore Road','Britania Drive','West Crocus','Britannia Drive','Vallejo','California',945913);


--Inserting data in studentAttributes table

INSERT INTO studentAttributes (
    user_id,usn,addressid
) VALUES (
    7,'usn7',20
),
(
    6,'usn6',18
),
(
    5,'usn5',19
),
(
    1,'usn1',16
),
(
    4,'usn4',17
);

--roles insert
 INSERT INTO roles(roleName) 
 VALUES(
     'Faculty'
 ),
 (
     'Student'
 );

 --user roles insert

 INSERT INTO userRoles VALUES (
     1,2
 ),
 (
     4,2
 ),
 (
     5,1
 ),
 (
     6,2
 ),
 (
     7,1
 );

--deleting faculty records in student table
 delete from studentAttributes where user_id=5;

 --faculty attributes

 insert into facultyattributes (userid,facultyID,addressId) VALUES (
     5,'Fac1',19
 ),
 (
     7,'Fac2',20
 );

--Departments table
alter table departments change deptname deptname varchar(255) not null unique;

 INSERT INTO departments (deptName,deptCode) VALUES(
     'Computer Science','CS'
 ),
 (
     'Information Science','IS'
 ),
 (
     'Electronics Communication','EC'
 ),
 (
     'Mathematics','MA'
 );

 --Dept HOD
 INSERT INTO deptHod (deptId,userID) VALUES(
     5,5
 ),(
     6,7
 );

 --subjects
ALTER table subject change subname subname varchar(255) not null unique;
 INSERT INTO subject (subName,code,deptId,credit) VALUES(
     'Data Structures and Algorithms','20CS21',5,3
 ),(
     'Networking','20CS22',5,3
 ),(
     'Machine Learning','20IS23',6,3
 ),(
     'Object Oriented Programming','20CS24',5,3
 );

 --Faculty dept

 INSERT into facultyDept (facultyID,deptId) VALUES(
     1,5
 ),(
     2,6
 );

 --userSub
  alter table usersub add completed bool not null default false;
 INSERT INTO userSub (userId,subid) VALUE(
     1,1
 ),(
     1,2
 ),(
     1,3
 ),(
     1,4
 ),(
     4,1
 ),(
     4,2
 ),(
     4,3
 ),(
     4,4
 ),(
     6,1
 ),(
     6,2
 ),(
     6,3
 ),(
     6,4
 );

 --class

 INSERT INTO class (name,section,deptID,classteacher) VALUES(
     'CSE','A',5,5
 ),('CSE','B',5,7);

 --semester

 INSERT INTO semester(name,semorder) VALUES (
     'I',1
 ),('II',2),('III',3),('IV',4),(
     'V',5
 ),('VI',6),('VII',7),('VIII',8);

 --users class

 INSERT INTO usersclass (classid,userid,currentsem) VALUES (
     3,1,3
 ),(3,4,3),(4,6,3);


 --slots
 insert into slots (day,starttime) VALUES(
     'mon',20210101083000
 ),('mon',20210101093000),('tue',20210102083000),('tue',20210102093000);

 --classSlots

 INSERT INTO classSlots (classid,slotid,facultyid,subid) VALUES 
 (3,1,1,1),
 (3,2,2,3),
 (3,3,1,1),
 (3,4,2,3),
 (4,1,1,1),
 (4,2,2,3),
 (4,3,1,1),
 (4,4,2,3);


 --exams
INSERT INTO exam (name,maxmarks,weightage) VALUES
('IA1',30,10),
('IA2',30,10),
('IA3',30,10),
('ABA1',10,10),
('ABA2',10,10),
('SEE',50,50);

--Attendance

INSERT INTO Attendance (classslotid,userid,Attendance,classdate) VALUES
(9,1,true,20211011),
(9,4,true,20211011),
(13,6,true,20211011),
(10,1,true,20211011),
(10,4,true,20211011),
(11,1,true,20211012),
(11,4,true,20211012),
(12,1,true,20211012),
(14,6,true,20211011),
(15,6,true,20211012),
(16,6,true,20211012);


--marks
INSERT INTO studentMarks (userid,subid,examid,marks,markedby) VALUES
(1,1,1,30,5),
(1,2,1,20,7),
(4,1,1,30,5);