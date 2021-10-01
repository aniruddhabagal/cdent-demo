CREATE DATABASE cdent;

USE cdent;

-- USERS table
CREATE TABLE users(id INT(11) PRIMARY KEY auto_increment ,firstName VARCHAR(50) not NULL ,lastname VARCHAR(50), phone int(10) UNIQUE NOT NULL,email VARCHAR(50) UNIQUE not NULL,dob DATE not NULL , gender enum('m','f','o') NOT NULL);

-- Student attribute table
CREATE TABLE studentAttributes(id int(11) PRIMARY KEY auto_increment, user_id int(11) NOT NULL, usn CHAR(10) NOT NULL UNIQUE, FOREIGN KEY (id) REFERENCES users(id) );

-- Address table 
CREATE TABLE address(id INT(11) PRIMARY KEY auto_increment,userId int(11) NOT NULL UNIQUE,
    line1 VARCHAR(100) NOT NULL,
    line2 VARCHAR(100) ,
    locality VARCHAR(50) NOT NULL,
    landmark VARCHAR(50),
    city VARCHAR(50) NOT NULL,
    province VARCHAR(50) NOT NULL,
    pincode INT(6),

FOREIGN KEY (userId) REFERENCES users(id)
);

-- Adding address Foreign key to StudentAttributes table
ALTER TABLE studentAttributes ADD addressId int(11) NOT NULL;
ALTER TABLE studentAttributes ADD FOREIGN KEY (addressId) REFERENCES address(id);

-- Faculty attribute table
CREATE TABLE facultyAttributes(id int(11) PRIMARY key auto_increment, 
    userId int(11) NOT NULL,
    facultyId VARCHAR(15) NOT NULL UNIQUE,
    addressId int(11) NOT NULL,

    FOREIGN KEY (addressId) REFERENCES address(id),
    FOREIGN KEY (userId) REFERENCES users(id)
);

-- roles table
CREATE TABLE roles(id int(11) PRIMARY key auto_increment,
    roleName VARCHAR(15) NOT NULL UNIQUE
);

-- userRoles table
CREATE TABLE userRoles(userId int(11) NOT NULL,
    roleId int(11) NOT NULL,

    CONSTRAINT userRolePK PRIMARY KEY (userId,roleId),

    FOREIGN KEY (userId) REFERENCES users(id),
    FOREIGN KEY (roleId) REFERENCES roles(id)
);

-- semester table
CREATE TABLE semester(id int(11) PRIMARY key auto_increment,
    name VARCHAR(10) UNIQUE,
    semOrder int(1)
);

-- usersClass table
CREATE TABLE usersClass(classId int(11) not NULL,
    userId INT(11) NOT NULL,
    currentSem INT(11) NOT NULL,

    CONSTRAINT usersClassPK PRIMARY KEY (classId,userId),

    FOREIGN KEY (currentSem) REFERENCES semester(id)
);

-- class table
CREATE TABLE class(id int(11) PRIMARY key auto_increment,
    name VARCHAR(5) NOT NULL,
    section CHAR(1) NOT NULL DEFAULT 'A',
    deptId int(11) NOT NULL,
    classTeacher int(11) NOT NULL,

    FOREIGN KEY (classTeacher) REFERENCES users(id)
);

-- Adding userClass foreign key to class
ALTER TABLE usersClass ADD FOREIGN KEY (classId) REFERENCES class(id);
--adding userclass foreign key to users
ALTER TABLE usersClass ADD FOREIGN KEY (userId) REFERENCES users(id);

--departments table
CREATE TABLE departments(id int(11) PRIMARY key auto_increment,
    deptName VARCHAR(20) NOT NULL UNIQUE,
    deptCode VARCHAR(5) NOT NULL UNIQUE
);

-- Adding deptId foreign key from departments table to class table 
ALTER TABLE class ADD FOREIGN KEY (deptId) REFERENCES departments(id);

-- facultyDept table
CREATE TABLE facultyDept(facultyId int(11) NOT NULL,
    deptId int(11) NOT null,

    CONSTRAINT facultyDeptPK PRIMARY KEY (facultyId,deptId),

    FOREIGN KEY (facultyId) REFERENCES facultyAttributes(id),
    FOREIGN KEY (deptId) REFERENCES departments(id)
);

--deptHod table
CREATE TABLE deptHod(deptId int(11) NOT null,
    userId int(11) NOT NULL,

    CONSTRAINT deptHodPK PRIMARY KEY (deptId,userId),

    FOREIGN KEY (deptId) REFERENCES departments(id),
    FOREIGN KEY (userId) REFERENCES users(id)
);

--subject table (Table for listing all the subjects)
CREATE TABLE subject(id int(11) PRIMARY KEY auto_increment,
    subName VARCHAR(25) NOT NULL UNIQUE,
    code VARCHAR(10) NOT null UNIQUE,
    deptId int(11) NOT NULL,
    credit INT(2),

    FOREIGN KEY (deptId) REFERENCES departments(id)
);

--userSub table (table for subject and user mapping)
CREATE TABLE userSub(userId INT(11) NOT NULL,
     subId int(11) NOT NULL,

     CONSTRAINT userSubPK PRIMARY KEY (userId,subId),

     FOREIGN KEY (userId) REFERENCES users(id),
     FOREIGN KEY (subId) REFERENCES subject(id)

);

-- exam table (Table for listing all the exams)
CREATE TABLE exam(id INT(11) PRIMARY key auto_increment,
    name VARCHAR(20) NOT NULL ,
    maxMarks INT(3) NOT NULL,
    weightage INT(3)
);

--studentMarks table (Table for listing marks of the students mapped with all the exams)
CREATE TABLE studentMarks(userId int(11) NOT null,
    subId int(11) NOT NULL,
    examId int(11) not null,
    marks int(3) NOT NULL DEFAULT 100,
    markedBy INT(11) NOT NULL,

    CONSTRAINT studMarksPK PRIMARY KEY (userId,subId),

    FOREIGN KEY (userId) REFERENCES users(id),
    FOREIGN KEY (subId) REFERENCES subject(id),
    FOREIGN KEY (examId) REFERENCES exam(id),
    FOREIGN KEY (markedBy) REFERENCES users(id)
);

-- slots table (table for listing timetable slots)
CREATE TABLE slots(id int(11) PRIMARY key auto_increment,
    day enum('sun','mon','tue','wed','thu','fri','sat') NOT NULL,
    startTime TIME NOT NULL
);

-- classSlots table ( Table for class timetables, mapping slots with class and subject)

CREATE TABLE classSlots(id int(11) NOT null auto_increment,
    classId int(11) NOT NULL,
    slotId int(11) NOT NULL,
    facultyId int(11) NOT NULL,
    subId int(11) not NULL,

    
    CONSTRAINT currentClassPK PRIMARY KEY (id,classId,slotId,subId),

    
    FOREIGN KEY (classId) REFERENCES class(id),
    FOREIGN KEY (slotId) REFERENCES slots(id),
    FOREIGN KEY (facultyId) REFERENCES facultyAttributes(id),
    FOREIGN KEY (subId) REFERENCES subject(id)
);

--attendance table (Table to store attendance )

CREATE TABLE attendance(id int(11) PRIMARY key auto_increment,
    classSlotId int(11) not NULL,
    userId int(11) NOT NULL,
    attendance bool DEFAULT TRUE,
    classDate date,

    FOREIGN KEY (classSlotId) REFERENCES classSlots(id),
    FOREIGN KEY (userId) REFERENCES users(id)
);
