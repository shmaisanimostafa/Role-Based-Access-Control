CREATE DATABASE RBAC;

CREATE TABLE subject (
     id int,
     PRIMARY KEY (id),
    firstName varchar(50),
    middleName varchar(50),
    lastName varchar(50),
    phone int,
    email varchar(50),
    salt varchar(50),
    rigsteredAt datetime,
    lastLogin datetime,
    description varchar(255),
);
--Add 3 subjects Mostafa, Mortada, and Mojtaba
Insert INTO subject
Values(10120082,"Mostafa","Hassan","Shmaisani",70185306,"Shmaisanimostafa@gmail.com", 13, "19/4/2023", "19/4/2023","Computer Scientist");
Insert INTO subject
Values(10120073,"Mortada","Youssef","Shmaisani",81303455,"Shmaisanimostafa@gmail.com", 10, "19/4/2023", "19/4/2023","Mechinal Engineer");
Insert INTO subject
Values(10120080,"Mojtaba","Moussa","Shmaisani",70843268,"Shmaisanimoussa@gmail.com", 8, "19/4/2023", "19/4/2023","Civil Engineer");

CREATE TABLE subjectRole (
   FOREIGN KEY (subjectId) REFERENCES subject(id),
   FOREIGN KEY (roleid) REFERENCES role(id),
    createdAt datetime,
    UpdatedAt datetime,
);

INSERT INTO subjectRole
VALUES(10120082, 0, "19/4/2023","19/4/2023");
INSERT INTO subjectRole
VALUES(10120073, 1, "19/4/2023","19/4/2023");
INSERT INTO subjectRole
VALUES(10120080, 2, "19/4/2023","19/4/2023");


CREATE TABLE role (
    id int,
    PRIMARY KEY (id),
    title varchar(50),
    active boolean,
    creator varchar(50),
    createdAt datetime,
    UpdatedAt datetime,
    description varchar(255),
    content text,
);
--Add 3 roles Student, Instructor, and Administrator
INSERT INTO role
VALUES(0,"admin",true,"Mostafa Shmaisani", "19/4/2023","19/4/2023", "Can do everything","All the preiviliges");
INSERT INTO role
VALUES(1,"instructor",true,"Mostafa Shmaisani", "19/4/2023","19/4/2023", "Can do everything without delete","All the preiviliges without remove");
INSERT INTO role
VALUES(2,"student",true,"Mostafa Shmaisani", "19/4/2023","19/4/2023", "can view only","only read");

CREATE TABLE rolePermission (
    FOREIGN KEY (roleIdd) REFERENCES role(id),
    FOREIGN KEY (permissionId) REFERENCES permission(id),
    createdAt datetime,
    UpdatedAt datetime,
);
-- Let the administrator read, write, and delete
INSERT INTO rolePermission
VALUES (0,1,"19/4/2023","19/4/2023");
INSERT INTO rolePermission
VALUES (0,2,"19/4/2023","19/4/2023");
INSERT INTO rolePermission
VALUES (0,3,"19/4/2023","19/4/2023");
-- Let the Instructor read, and write
INSERT INTO rolePermission
VALUES (1,1,"19/4/2023","19/4/2023");
INSERT INTO rolePermission
VALUES (1,2,"19/4/2023","19/4/2023");
--Let the Student only read
INSERT INTO rolePermission
VALUES (2,1,"19/4/2023","19/4/2023");

CREATE TABLE permission (
     id int,
     PRIMARY KEY (id),
    title varchar(50),
    active boolean,
    creator varchar(50),
    createdAt datetime,
    UpdatedAt datetime,
    description varchar(255),
);
--Insert 3 privileges Read, Write,and Delete
INSERT INTO permission
VALUES(1,"read",true,"Mostafa Shmaisani", "19/4/2023","19/4/2023", "Read the file content");
INSERT INTO permission
VALUES(2,"write",true,"Mostafa Shmaisani", "19/4/2023","19/4/2023", "write to the file content");
INSERT INTO permission
VALUES(3,"delete",true,"Mostafa Shmaisani", "19/4/2023","19/4/2023", "delete some file contents");

CREATE TABLE Objects (
     id int,
     PRIMARY KEY (id),
    title varchar(50),
    creator varchar(50),
    createdAt datetime,
    description varchar(255),
);



-- CREATE PROCEDURE ChecksubjectObjectPermission
--    @subjectId INT,
--    @ObjectId INT,
--    @PermissionId INT,
--    @Result BIT OUTPUT
-- AS
-- BEGIN
--    SET NOCOUNT ON;

--    IF EXISTS (
--       SELECT 1
--       FROM subjectObjectPermission uop
--       WHERE uop.subjectId = @subjectId
--          AND uop.ObjectId = @ObjectId
--          AND uop.PermissionId = @PermissionId
--    )
--    BEGIN
--       SET @Result = 1;
--    END
--    ELSE
--    BEGIN
--       SET @Result = 0;
--    END
-- END

-- DECLARE @Result BIT;
-- EXEC ChecksubjectObjectPermission @subjectId = 1, @ObjectId = 1, @PermissionId = 1, @Result = @Result OUTPUT;
-- SELECT @Result;




--The more simple one
-- subject Table
CREATE TABLE subject(
    subjectId INT PRIMARY KEY,
    subjectName VARCHAR(50) NOT NULL
);

-- Role Table
CREATE TABLE Role (
    RoleId INT PRIMARY KEY,
    RoleName VARCHAR(50) NOT NULL
);

-- Permission Table
CREATE TABLE Permission (
    PermissionId INT PRIMARY KEY,
    PermissionName VARCHAR(50) NOT NULL
);

-- Object Table
CREATE TABLE Object (
    ObjectId INT PRIMARY KEY,
    ObjectName VARCHAR(50) NOT NULL
);

-- subjectRole Table
CREATE TABLE subjectRole (
    subjectId INT,
    RoleId INT,
    PRIMARY KEY (subjectId, RoleId),
    FOREIGN KEY (subjectId) REFERENCES subject(subjectId),
    FOREIGN KEY (RoleId) REFERENCES Role(RoleId)
);

-- RolePermission Table
CREATE TABLE RolePermission (
    RoleId INT,
    PermissionId INT,
    PRIMARY KEY (RoleId, PermissionId),
    FOREIGN KEY (RoleId) REFERENCES Role(RoleId),
    FOREIGN KEY (PermissionId) REFERENCES Permission(PermissionId)
);

-- subjectObjectPermission Table
CREATE TABLE subjectObjectPermission (
    subjectId INT,
    ObjectId INT,
    PermissionId INT,
    PRIMARY KEY (subjectId, ObjectId, PermissionId),
    FOREIGN KEY (subjectId) REFERENCES subject(subjectId),
    FOREIGN KEY (ObjectId) REFERENCES Object(ObjectId),
    FOREIGN KEY (PermissionId) REFERENCES Permission(PermissionId)
);

-- Sample Data
INSERT INTO subject (subjectId, subjectName) VALUES
(1, 'alice'),
(2, 'bob'),
(3, 'charlie');

INSERT INTO Role (RoleId, RoleName) VALUES
(1, 'admin'),
(2, 'manager'),
(3, 'subject');

INSERT INTO Permission (PermissionId, PermissionName) VALUES
(1, 'read'),
(2, 'write'),
(3, 'execute');

INSERT INTO Object (ObjectId, ObjectName) VALUES
(1, 'file1.txt'),
(2, 'file2.txt'),
(3, 'folder1'),
(4, 'folder2');

INSERT INTO subjectRole (subjectId, RoleId) VALUES
(1, 1),
(2, 2),
(3, 3);

INSERT INTO RolePermission (RoleId, PermissionId) VALUES
(1, 1),
(1, 2),
(1, 3),
(2, 1),
(2, 2),
(3, 1);

INSERT INTO subjectObjectPermission (subjectId, ObjectId, PermissionId) VALUES
(1, 1, 1),
(1, 1, 2),
(2, 1, 1),
(2, 2, 2),
(3, 3, 1),
(3, 4, 2);

-- Stored Procedure
-- CREATE PROCEDURE ChecksubjectObjectPermission
--    @subjectId INT,
--    @ObjectId INT,
--    @PermissionId INT,
--    @Result BIT OUTPUT
-- AS
-- BEGIN
--    SET NOCOUNT ON;

--    IF EXISTS (
--       SELECT 1
--       FROM subjectObjectPermission uop
--       WHERE uop.subjectId = @subjectId
--          AND uop.ObjectId = @ObjectId
--          AND uop.PermissionId = @PermissionId
--    )
--    BEGIN
--       SET @Result = 1;
--    END
--    ELSE
--    BEGIN
--       SET @Result = 0;
--    END
-- END
