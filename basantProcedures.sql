-- create database AdvancedSQLExamSystem
-- 
-- use AdvancedSQLExamSystem
-- 
-- 
-- create table Branch
-- (
-- branchId int identity(1,1) primary Key ,
-- branchName varchar(50) not null,
-- branchLocation varchar(50) not null
-- )
-- 
-- create table Track
-- (
-- trackId int identity(1,1) primary key,
-- trackName varchar(50) not null,
-- )
-- 
-- create table branchTracks
-- (
-- branchId int,
-- trackId int,
-- foreign key (branchId) references Branch(branchId),
-- foreign key (trackId )references track(trackId),
-- primary Key (branchId,trackId)
-- );
-- 
-- create table Instructor
-- (
-- instructorId int identity(1,1) primary key,
-- studentSocialSecurityNumber varchar(20) unique,
-- instructorName varchar (50),
-- instructorEmail varchar(50),
-- instructorPasswordHashed varchar(100),
-- isntructorPasswordSalt varchar(50),
-- instructorPhoneNumber varchar (20),
-- instructorhireDate date default getdate(),
-- instructorBranchId int,
-- instructorActive bit default 1,
-- foreign key (instructorbranchId) references branch (branchid)
-- )
-- 
-- 
-- create table Student
-- (
-- studentID int identity(1,1) primary key,
-- studentSocialSecurityNumber varchar(20) unique,
-- studentName varchar (50),
-- studentEmail varchar(50),
-- studentPasswordHashed varchar(100),
-- studentPasswordSalt varchar(50),
-- studentPhoneNumber varchar (20),
-- studentEnrollementDate date default (getdate()),
-- TrackId int,
-- foreign key (trackid) references track (trackid)
-- )
-- 
-- create table course
-- (
-- courseId int identity(1,1) primary key,
-- courseName varchar (50),
-- courseCode varchar (10),
-- courseDiscription varchar(200)
-- )
-- 
-- create table trackCourse
-- (
-- trackId int ,
-- courseId int
-- foreign key (trackid) references track (trackid),
-- foreign key (courseid) references course (courseid)
-- primary key (trackid,courseid)
-- )
-- 
-- create table topic
-- (
-- topicId int identity(1,1) primary key,
-- topicName varchar (50) not null,
-- courseId int
-- foreign key (courseid) references course (courseid)
-- )
-- 
-- 
-- create table examDetails
-- (
-- examId int identity(1,1) primary key,
-- examTitle varchar (50),
-- examDuration int,
-- examDate Date default getdate(),
-- examDescription varchar (200),
-- courseID int,
-- foreign key (courseid) references course (courseid)
-- )
-- 
-- 
-- create table studentExam
-- (
-- studentId int,
-- examId int,
-- grade int
-- foreign key (studentid) references student (studentid),
-- foreign key (examid) references examDetails (examid),
-- primary key (studentid , examid)
-- )
-- 
-- create table teaches
-- (
-- instructorId int ,
-- courseId int,
-- teachingYear date default(getdate()),
-- foreign key (instructorid) references instructor(instructorID),
-- foreign key (courseid) references course (courseid),
-- primary key (courseid,trackid,teachingyear)
-- )
-- 
-- create table question
-- (
-- questionId int identity(1,1) primary key,
-- questionText varchar (100) not null,
-- questionGrade int,
-- questionType bit,
-- courseId int
-- foreign key (courseid) references course(courseid)
-- )
-- 
-- create table choice 
-- (
-- choiceId int identity (1,1) primary key,
-- choiceText varchar (50) not null,
-- questionId int
-- foreign key (questionid) references question (questionid)
-- )
-- 
-- create table modelAnswer
-- (
-- questionID int,
-- choiceId int,
-- unique(questionID),
-- foreign key (choiceid) references choice (choiceid),
-- foreign key (questionid) references question (questionid) ,
-- primary key (questionid,choiceid)
-- )
-- 
-- create table examQuestionsPool
-- (
-- examQuestionsPool int,
-- examId int,
-- questionId int ,
-- choiceAnswerId int,
-- studentId int,
-- foreign key (choiceAnswerId) references choice (choiceID),
-- foreign key (questionid) references question (questionID),
-- foreign key (examID) references examDetails (examiD),
-- foreign key (studentid) references student (studentid),
-- primary key (examQuestionsPool,examId , questionId , studentid)
-- )


-------------------------------------------WithReferentialIntegrity------------------------------------------------------------------
drop database AdvancedSQLExamSystem
CREATE DATABASE AdvancedSQLExamSystem;
GO

USE AdvancedSQLExamSystem;
GO

CREATE TABLE Branch
(
    branchId INT IDENTITY(1,1) PRIMARY KEY,
    branchName VARCHAR(50) NOT NULL,
    branchLocation VARCHAR(50) NOT NULL
);
GO

CREATE TABLE Track
(
    trackId INT IDENTITY(1,1) PRIMARY KEY,
    trackName VARCHAR(50) NOT NULL
);
GO

CREATE TABLE branchTracks
(
    branchId INT,
    trackId INT,
    PRIMARY KEY (branchId, trackId),
    FOREIGN KEY (branchId) REFERENCES Branch(branchId)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (trackId) REFERENCES Track(trackId)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);
GO

CREATE TABLE Instructor
(
    instructorId INT IDENTITY(1,1) PRIMARY KEY,
    instructorSocialSecurityNumber VARCHAR(20) UNIQUE,
    instructorName VARCHAR(50),
    instructorEmail VARCHAR(50),
    instructorPasswordHased VARCHAR(100),
    isntructorPasswordSalt VARCHAR(50),
    instructorPhoneNumber VARCHAR(20),
    instructorhireDate DATE DEFAULT GETDATE(),
    instructorBranchId INT,
    instructorActive BIT DEFAULT 1,
    FOREIGN KEY (instructorBranchId) REFERENCES Branch(branchId)
        ON DELETE NO ACTION
        ON UPDATE CASCADE
);
GO

CREATE TABLE Student
(
    studentID INT IDENTITY(1,1) PRIMARY KEY,
    studentSocialSecurityNumber VARCHAR(20) UNIQUE,
    studentName VARCHAR(50),
    studentEmail VARCHAR(50),
    studentEnrollementDate DATE DEFAULT GETDATE(),
    studentPasswordHased VARCHAR(100),
    studentPasswordSalt VARCHAR(50),
    studentPhoneNumber VARCHAR(20),
    TrackId INT,
    FOREIGN KEY (TrackId) REFERENCES Track(trackId)
        ON DELETE NO ACTION
        ON UPDATE CASCADE
);
GO

CREATE TABLE Course
(
    courseId INT IDENTITY(1,1) PRIMARY KEY,
    courseName VARCHAR(50),
    courseCode VARCHAR(10),
    courseDiscription VARCHAR(200)
);
GO

CREATE TABLE trackCourse
(
    trackId INT,
    courseId INT,
    PRIMARY KEY (trackId, courseId),
    FOREIGN KEY (trackId) REFERENCES Track(trackId)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (courseId) REFERENCES Course(courseId)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);
GO

CREATE TABLE Topic
(
    topicId INT IDENTITY(1,1) PRIMARY KEY,
    topicName VARCHAR(50) NOT NULL,
    courseId INT,
    FOREIGN KEY (courseId) REFERENCES Course(courseId)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);
GO

CREATE TABLE examDetails
(
    examId INT IDENTITY(1,1) PRIMARY KEY,
    examTitle VARCHAR(50),
    examDuration INT,
    examDate DATE DEFAULT GETDATE(),
    examDescription VARCHAR(200),
    courseID INT,
    FOREIGN KEY (courseID) REFERENCES Course(courseId)
        ON DELETE NO ACTION
        ON UPDATE CASCADE
);
GO

CREATE TABLE studentExam
(
    studentId INT,
    examId INT,
    grade INT,
    PRIMARY KEY (studentId, examId),
    FOREIGN KEY (studentId) REFERENCES Student(studentID)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (examId) REFERENCES examDetails(examId)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);
GO

CREATE TABLE teaches
(
    instructorId INT,
    courseId INT,
    teachingYear DATE DEFAULT GETDATE(),
    PRIMARY KEY (instructorId, courseId, teachingYear),
    FOREIGN KEY (instructorId) REFERENCES Instructor(instructorId)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (courseId) REFERENCES Course(courseId)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);
GO

CREATE TABLE question
(
    questionId INT IDENTITY(1,1) PRIMARY KEY,
    questionText VARCHAR(100) NOT NULL,
    questionGrade INT,
    questionType BIT,
    courseId INT,
    FOREIGN KEY (courseId) REFERENCES Course(courseId)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);
GO

CREATE TABLE choice
(
    choiceId INT IDENTITY(1,1) PRIMARY KEY,
    choiceText VARCHAR(50) NOT NULL,
    questionId INT,
    FOREIGN KEY (questionId) REFERENCES question(questionId)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);
GO

CREATE TABLE modelAnswer
(
    questionID INT,
    choiceId INT,
    UNIQUE (questionID),
    PRIMARY KEY (questionID, choiceId),
    FOREIGN KEY (questionID) REFERENCES question(questionId),
    FOREIGN KEY (choiceId) REFERENCES choice(choiceId)
);
GO

CREATE TABLE examQuestionsPool
(
    examQuestionsPool INT IDENTITY(1,1),
    examId INT,
    questionId INT,
    choiceAnswerId INT,
    studentId INT,
    PRIMARY KEY (examQuestionsPool, examId, questionId, studentId),
    FOREIGN KEY (examId) REFERENCES examDetails(examId),
    FOREIGN KEY (questionId) REFERENCES question(questionId),
    FOREIGN KEY (choiceAnswerId) REFERENCES choice(choiceId),
    FOREIGN KEY (studentId) REFERENCES Student(studentID)

);
GO

	


	
-- track + track branch
-- create
alter procedure createTrack @trackName varchar(20) , @branchId int
as
if not exists (select branchId from Branch where branchId=@branchId)
begin 
select 'invalid branch id'
return
end
if not exists (select * from Track join branchTracks on track.trackId=branchTracks.trackId where branchTracks.branchId=@branchId and trackName=@trackName)
begin
if not exists (select*from Track where trackName=@trackName)
begin
insert into Track(trackName)values(@trackName)
end
declare @trackID int
select @trackID=Track.trackId from Track where trackName=@trackName
insert into branchTracks values(@branchId,@trackId)
end
else
begin
select 'this track is already inserted to this branch'
end

createTrack 'basanttedit' , 30000


--read
create procedure GetTracks
as
select * from Track


GetTracks


--read get track by id

create procedure GetTrack @id int
as
select * from Track where trackId=@id

GetTrack 1



--update track
create procedure updateTrack @id int  , @name varchar(20)
as
update Track set trackName=@name
where trackId=@id


updateTrack 1 , '.net full stack'


--student
--create
create procedure create_student @SSN VARCHAR(20), @StudentName VARCHAR(50), 
@StudentEmail VARCHAR(50), @StudentPassword NVARCHAR(100),
@StudentPhone VARCHAR(20), @TrackId INT,@EnrollmentDate DATE  
,@hashpassword varchar(50),@salt varchar(50)
as
begin try 
if exists (select studentSocialSecurityNumber from Student where studentSocialSecurityNumber =@SSN)
begin
select 'duplicate ssn'
end
if not exists(select Track.trackId from Track where trackId=@TrackId)
begin
select 'invalid track id'
end
insert into Student(studentSocialSecurityNumber,
            studentName,
            studentEmail,
            studentEnrollementDate,
            studentPasswordHased,
            studentPasswordSalt,
            studentPhoneNumber,
            TrackId)values(@SSN , @StudentName,@StudentEmail,@EnrollmentDate,@hashpassword,@salt,@StudentPhone,@TrackId)
end try
begin catch
select ERROR_MESSAGE();
end catch


create_student '333333399010112347','jod Mohamed','jod.m@example.com','SecurePass123', '01012345678',1,'2025-01-15','pp123','ss123'
   



   --read
   create procedure read_students
   as
   select * from Student
   read_students


   --update ??
   alter procedure update_student @SSN VARCHAR(20), 
   @StudentName VARCHAR(50), @StudentEmail VARCHAR(50), 
   @StudentPassword NVARCHAR(100), @StudentPhone VARCHAR(20), 
   @TrackId INT,@EnrollmentDate DATE  ,@hashpassword varchar(50),@salt varchar(50)
as
begin try 
if not exists(select Track.trackId from Track where trackId=@TrackId)
begin
select 'invalid track id'
return
end

if not exists (select studentSocialSecurityNumber from Student where studentSocialSecurityNumber =@SSN)
begin
select 'invalid student'
end
else
begin
update Student set 
            studentName=@StudentName,
            studentEmail=@StudentEmail,
            studentEnrollementDate=@EnrollmentDate,
            studentPasswordHased=@hashpassword,
            studentPasswordSalt=@salt,
            studentPhoneNumber=@StudentPhone,
            TrackId=@TrackId
			where studentSocialSecurityNumber=@ssn


end
end try
begin catch
select ERROR_MESSAGE();
end catch

update_student '333333399010112347','joud Mohamned','joud.m@example.com','SecurePass123', '01012345678',1,'2025-01-15','pp123','ss123'

   -- students of the track
   --join??
   alter procedure get_Students_Track @trackID int
   as
   if not exists(select trackId from Track where trackId=@trackID)
   begin
   select 'invalid track id '
   end
   else
   begin
   select s.studentName from Student s join Track t on s.TrackId=t.trackId where s.TrackId=@trackID
   end

   get_Students_Track 2



   -- student grades
   alter procedure student_courses_grades @studentID int
   as
   if not exists(select studentID from Student where studentID=@studentID)
   begin
   select 'invalid student id '
   end
   else
   begin
   select c.courseName  , se.grade from Course c
   join examDetails ed  on c.courseId=ed.courseId
      join studentExam se on ed.examId=se.examId
   join Student s on s.studentID=se.studentId
   where s.studentID=@studentID


   end


   student_courses_grades 1