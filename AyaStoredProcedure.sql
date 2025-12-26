-- aya storedprocedure

--branch 

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


--CREATE PROCEDURE SubmitExamAnswers
--    @examId INT,
--    @studentId INT,
--    @question1Answer INT = NULL,
--    @question2Answer INT = NULL,
--    @question3Answer INT = NULL,
--    @question4Answer INT = NULL,
--    @question5Answer INT = NULL,
--    @question6Answer INT = NULL,
--    @question7Answer INT = NULL,
--    @question8Answer INT = NULL,
--    @question9Answer INT = NULL,
--    @question10Answer INT = NULL
--AS
--BEGIN
--    DECLARE @totalScore DECIMAL(5,2) = 0;
--    DECLARE @correctAnswers INT = 0;
--    DECLARE @questionId INT;
--    DECLARE @questionGrade DECIMAL(5,2);
--    DECLARE @correctChoiceId INT;
    
--    BEGIN TRY
--        BEGIN TRANSACTION;
        
--        -- 1. Validate student exists
--        IF NOT EXISTS (
--            SELECT 1 
--            FROM Student 
--            WHERE studentId = @studentId
--        )
--        BEGIN
--            THROW 50020, 'Student not found.', 1;
--        END;
        
--        -- 2. Validate exam exists for this student
--        IF NOT EXISTS (
--            SELECT 1 
--            FROM examQuestionsPool 
--            WHERE examId = @examId 
--            AND studentId = @studentId
--        )
--        BEGIN
--            THROW 50021, 'Exam not assigned to this student.', 1;
--        END;
        
--        -- 3. Check if already submitted
--        IF EXISTS (
--            SELECT 1 
--            FROM examQuestionsPool 
--            WHERE examId = @examId 
--            AND studentId = @studentId
--            AND choiceAnswerId IS NOT NULL
--        )
--        BEGIN
--            THROW 50022, 'Exam already submitted by this student.', 1;
--        END;
        
--        -- 4. Create temporary table for answers
--        DECLARE @AnswerTable TABLE (
--            QuestionOrder INT,
--            StudentChoiceId INT
--        );
        
--        INSERT INTO @AnswerTable VALUES
--        (1, @question1Answer),
--        (2, @question2Answer),
--        (3, @question3Answer),
--        (4, @question4Answer),
--        (5, @question5Answer),
--        (6, @question6Answer),
--        (7, @question7Answer),
--        (8, @question8Answer),
--        (9, @question9Answer),
--        (10, @question10Answer);
        
--        -- 5. Process all answers
--        DECLARE @QuestionOrder INT = 1;
        
--        WHILE @QuestionOrder <= 10
--        BEGIN
--            DECLARE @studentChoiceId INT;
            
--            -- Get answer for current question
--            SELECT @studentChoiceId = StudentChoiceId 
--            FROM @AnswerTable 
--            WHERE QuestionOrder = @QuestionOrder;
            
--            -- Get the question ID for this order
--            SELECT @questionId = questionId
--            FROM (
--                SELECT 
--                    questionId,
--                    ROW_NUMBER() OVER (ORDER BY examQuestionsPool) AS RowNum
--                FROM examQuestionsPool
--                WHERE examId = @examId 
--                AND studentId = @studentId
--            ) AS OrderedQuestions
--            WHERE RowNum = @QuestionOrder;
            
--            -- Update student's answer in examQuestionsPool using choiceAnswerId column
--            UPDATE examQuestionsPool
--            SET choiceAnswerId = @studentChoiceId
--            WHERE examId = @examId 
--            AND studentId = @studentId
--            AND questionId = @questionId;
            
--            -- Get question grade from question table
--            SELECT @questionGrade = questionGrade
--            FROM question
--            WHERE questionsId = @questionId;
            
--            -- Get correct answer from modelAnswer table
--            SELECT @correctChoiceId = ma.choiceId
--            FROM modelAnswer ma
--            WHERE ma.questionID = @questionId;
            
--            -- Calculate score
--            IF @studentChoiceId = @correctChoiceId
--            BEGIN
--                SET @totalScore = @totalScore + ISNULL(@questionGrade, 0);
--                SET @correctAnswers = @correctAnswers + 1;
--            END
            
--            SET @QuestionOrder = @QuestionOrder + 1;
--        END
        
--        -- 6. Create or Update studentExam table
--        IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'studentExam')
--        BEGIN
--            CREATE TABLE studentExam (
--                studentExamId INT IDENTITY(1,1) PRIMARY KEY,
--                examId INT,
--                studentId INT,
--                score DECIMAL(5,2),
--                submittedDate DATETIME DEFAULT GETDATE(),
--                status VARCHAR(20),
--                correctAnswers INT
--            );
--        END
        
--        -- Check if record exists and update or insert
--        IF EXISTS (
--            SELECT 1 
--            FROM studentExam 
--            WHERE examId = @examId 
--            AND studentId = @studentId
--        )
--        BEGIN
--            UPDATE studentExam
--            SET 
--                score = @totalScore,
--                submittedDate = GETDATE(),
--                status = 'Completed',
--                correctAnswers = @correctAnswers
--            WHERE examId = @examId 
--            AND studentId = @studentId;
--        END
--        ELSE
--        BEGIN
--            INSERT INTO studentExam (examId, studentId, score, submittedDate, status, correctAnswers)
--            VALUES (@examId, @studentId, @totalScore, GETDATE(), 'Completed', @correctAnswers);
--        END
        
--        COMMIT TRANSACTION;
        
--        -- 7. Return results
--        SELECT 
--            @examId AS ExamId,
--            @studentId AS StudentId,
--            @correctAnswers AS CorrectAnswers,
--            @totalScore AS TotalScore,
--            CASE 
--                WHEN @totalScore >= 60 THEN 'Pass'
--                ELSE 'Fail'
--            END AS Status,
--            GETDATE() AS SubmissionDate,
--            'Exam submitted successfully' AS Message;
            
--    END TRY
--    BEGIN CATCH
--        IF @@TRANCOUNT > 0
--            ROLLBACK TRANSACTION;
        
--        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
--        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
--        DECLARE @ErrorState INT = ERROR_STATE();
        
--        THROW 50000, @ErrorMessage, 1;
--    END CATCH
--END;
--GO



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
  
    IF NOT EXISTS (SELECT 1 FROM Student WHERE studentID = @StudentID)
    BEGIN
        RAISERROR('StudentID %d does not exist in Student table.', 16, 1, @StudentID);
        RETURN;
    END
    INSERT INTO examQuestionsPool (examId, questionId, choiceAnswerId, studentId)
    SELECT @ExamID, QuestionID, ChoiceAnswerID, @StudentID
    FROM @Answers;

    PRINT 'Answers inserted successfully.';
END

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
