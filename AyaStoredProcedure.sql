-- aya storedprocedure

--branch 
USE AdvancedSQLExamSystem
--1
create procedure createBranch 
@branchName varchar(50),
@branchLocation varchar(50)
as
begin
insert into Branch (branchName , branchLocation)
values(@branchName , @branchLocation) ; 
end ;

go 
--2
create procedure GetAllBranches
as
begin
select * from Branch ;
end;
go 
GetAllBranches ; 
go 
--3
create procedure UpdateBranch 
@BranchId int ,
@BranchName varchar(50) ,
@BranchLocation varchar(50) 
as
begin

   if not exists (select 1 from Branch where branchId = @branchId)
    begin
        THROW 50020, 'Branch not found.', 1;
    end;
 update Branch
 set 
 branchName = @BranchName , 
 branchLocation = @BranchLocation
 where branchId = @BranchId ;
end;
go

EXEC UpdateBranch 1, 'Cairo', 'New Cairo';
go
--4
create procedure DeleteBranch 
@BranchId int
as
begin
if not exists (select 1 from Branch where branchId = @BranchId)
begin
   THROW 50021, 'Branch not found.', 1;
end ; 
delete from Branch
where branchId = @BranchId;
end ; 
go 
GetAllBranches ;
EXEC DeleteBranch 2;
GetAllBranches ;


---------------------------------------------------------------------------
--topic

--1
create proc CreateTopic 
@topicName varchar(100),
@courseId int
as 
begin 
if not exists (select 1 from Course where courseId=@courseId)
begin
   THROW 50030, 'Course not found.', 1;
end;
insert into Topic (topicName , courseId)
values(@topicName , @courseId);
end;
go

select * from Course;
EXEC CreateTopic 'variables', 1;
go   
--2
create proc GetTopicsByCourse
    @courseId INT
as
begin 

    select 
        t.topicId,
        t.topicName,
        c.courseName
    from Topic t
    join Course c on t.courseId = c.courseId
    where c.courseId = @courseId;
end;
go
GetTopicsByCourse 1;

--3
create proc UpdateTopic
@topicId int , 
@topicName varchar(100) , 
@courseId int 
as
begin

if not exists (select 1 from Topic where topicId = @topicId)
begin 
  THROW 50031, 'Topic not found.', 1;
end;
if not exists (select 1 from Course where courseId = @courseId)
begin
      THROW 50032, 'Course not found.', 1;
end ; 

update Topic 
set 
topicName = @topicName , 
courseId = @courseId 
where topicId = @topicId ; 
end;

--4
create proc DeleteTopic
@topicId int 
as
begin 
  if not exists (select 1 from Topic where topicId = @topicId)
  begin
    THROW 50033, 'Topic not found.', 1;
  end ; 
  delete from Topic  
  where topicId = @topicId;
end ; 
GetTopicsByCourse 1
DeleteTopic 1 ; 
GetTopicsByCourse 1


----------------------------------------------------------------------------------------------
--------------------------------------------reports-------------------------------------------

--student answer

GO
CREATE TYPE AnswerList AS TABLE
(
    QuestionID INT,
    ChoiceAnswerID INT
);
GO
create PROCEDURE InsertStudentExamAnswers
    @ExamID INT,
    @StudentID INT,
    @Answers AnswerList READONLY
AS
BEGIN
    SET NOCOUNT ON;

  
    INSERT INTO examQuestionsPool (examId, studentId, questionId, choiceAnswerId)
    SELECT 
        @ExamID,
        @StudentID,
        a.QuestionID,
        a.ChoiceAnswerID
    FROM @Answers a
    WHERE NOT EXISTS (
        SELECT 1
        FROM examQuestionsPool eq
        WHERE eq.examId = @ExamID
          AND eq.studentId = @StudentID
          AND eq.questionId = a.QuestionID
    );


    UPDATE eq
    SET eq.choiceAnswerId = a.ChoiceAnswerID
    FROM examQuestionsPool eq
    JOIN @Answers a
        ON eq.questionId = a.QuestionID
    WHERE eq.examId = @ExamID
      AND eq.studentId = @StudentID;
END;
GO


select * from modelAnswer ; 
select * from question ; 
select * from choice ; 
select * from examQuestionsPool ;
select * from examDetails ; 
select * from Student ;


go
DECLARE @MyAnswers AS AnswerList;

INSERT INTO @MyAnswers (QuestionID, ChoiceAnswerID)
VALUES 
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 11);

EXEC InsertStudentExamAnswers 
    @ExamID = 5,
    @StudentID = 1,
    @Answers = @MyAnswers;
go

SELECT *
FROM examQuestionsPool
WHERE examId = 5
  AND studentId = 1;


------------------
--exam correction 
create proc ExamCorrection 
@examId int , 
@studentId int 
as 
begin
set nocount on ; 
declare @studentScore decimal(10,2);
declare @totalPossibleScore decimal(10,2);
declare @percentGrade decimal (5,2);

select @studentScore = ISNULL(sum(q.questionGrade),0)
from  examQuestionsPool eq
join question q on eq.questionId = q.questionId
join modelAnswer m on  m.questionId =q.questionId 
join choice c on c.choiceId = m.choiceId 
where  eq.studentID = @studentId and eq.examId = @examId
and eq.choiceAnswerId = m.choiceId;



select @totalPossibleScore = ISNULL(sum(q.questionGrade),0)
from examQuestionsPool eq 
join question q
on q.questionId = eq.questionId
where  eq.studentID = @studentId and eq.examId = @examId ; 

if @totalPossibleScore> 0 
   set @percentGrade = (@studentScore/@totalPossibleScore)*100 ; 
else
  set @percentGrade = 0 ;

  update studentExam
  set studentExam.grade = @percentGrade
  where  studentExam.examId = @examId 
  and studentExam.studentId = @studentId;

  select e.grade from studentExam e where e.studentId= @studentId ; 

end


 exec ExamCorrection  5 , 1
 