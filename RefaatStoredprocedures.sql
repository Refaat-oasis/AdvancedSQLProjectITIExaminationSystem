
--------------------------------------------COURSE---------------------------------------------------------


CREATE PROCEDURE addCourse 
    @courseName VARCHAR(100), 
    @courseCode VARCHAR(50), 
    @courseDescription VARCHAR(200), 
    @trackName VARCHAR(50)
AS
BEGIN
    DECLARE @courseID INT, @trackId INT;

    INSERT INTO Course (courseName, courseCode, courseDiscription)
    VALUES (@courseName, @courseCode, @courseDescription);

    SET @courseID = SCOPE_IDENTITY();

    SELECT TOP 1 @trackId = trackId 
    FROM Track 
    WHERE trackName like '%' +@trackName+ '%';

    INSERT INTO trackCourse (trackId, courseId)
    VALUES (@trackId, @courseID);
END;



CREATE PROCEDURE readCourseData
    @courseName VARCHAR(100)
AS
BEGIN
    SELECT *
    FROM Course
    WHERE courseName LIKE '%' + @courseName + '%'
END

create procedure updateCourseData
    @courseName VARCHAR(100), 
    @courseCode VARCHAR(50), 
    @courseDescription VARCHAR(200)
as
begin
    update Course
    set 
    courseCode = @coursecode ,
    courseDiscription = @courseDescription,
    courseName = @courseName
    where courseName like  '%' + @courseName + '%'
end

create procedure deleteCourse 
    @courseName varchar (100)
as
begin
    select 'you are not allowed to delete any course' 
end


-------------------------------------------------EXAM GENERATION----------------------------------------------------

-- create procedure GenerateExam  
-- @title varchar(50),@duration int,@description varchar (100), @courseName varchar(50) ,@trueFalse int, @MCQ int
-- as
-- begin 
-- 
-- declare @courseID int , @createdExamId int , @numberOfStudents int
-- select @courseID = courseId from Course where courseName like '%' +@courseName+'%'
-- insert into examDetails (examTitle,examDescription,examDuration,courseID) values 
-- (@title,@description,@duration,@courseID)
-- 
-- SET @createdExamId = SCOPE_IDENTITY();
-- 
-- insert into studentExam (studentId ,examId)
-- select studentID , @createdExamId from course as c
-- join trackCourse as tc
-- on c.courseId = tc.courseId
-- join track as t
-- on t.trackId = tc.trackId
-- join Student s
-- on s.TrackId = t.trackId
-- where c.courseId = @courseID
-- 
-- select @numberofstudents= count(studentID) from course as c
-- join trackCourse as tc
-- on c.courseId = tc.courseId
-- join track as t
-- on t.trackId = tc.trackId
-- join Student s
-- on s.TrackId = t.trackId
-- where c.courseId = @courseID
-- 
-- declare @numberOfQuestion int =10
-- 
-- while @numberOfStudents >=0
-- begin
--     
--     while @numberOfQuestion >=0
--     begin
--         if (@trueFalse >=0)
--             begin
--                 insert into examQuestionsPool (examId,studentId,questionId)
--                 select @createdExamId ,
-- 
--             end
--     end
-- 
-- 
-- end
-- 
-- 
-- 
-- 
-- 
-- 
-- end

-- drop proc generateexam

-- EXEC GenerateExam
--     @title = 'Final SQL Exam',
--     @duration = 60,
--     @description = 'Final exam for SQL course',
--     @courseName = 'ai',
--     @trueFalse = 3,
--     @MCQ = 7;
-- 
-- 
-- 
-- CREATE PROCEDURE GenerateExam  
--     @title       VARCHAR(50),
--     @duration    INT,
--     @description VARCHAR(100),
--     @courseName  VARCHAR(50),
--     @trueFalse   INT,
--     @MCQ         INT
-- AS
-- BEGIN
--     IF (@trueFalse + @MCQ) <> 10
--     BEGIN
--         THROW 50010, 'MCQ + True/False must equal exactly 10.', 1;
--     END;
-- 
--     DECLARE @courseID INT;
--     DECLARE @examId INT;
-- 
--     BEGIN TRY
--         BEGIN TRANSACTION;
-- 
--         SELECT TOP (1) @courseID = courseId
--         FROM Course
--         WHERE courseName LIKE '%' + @courseName + '%';
-- 
--         IF @courseID IS NULL
--         BEGIN
--             THROW 50011, 'Course not found.', 1;
--         END;
-- 
-- 
--         INSERT INTO examDetails (examTitle, examDescription, examDuration, courseID)
--         VALUES (@title, @description, @duration, @courseID);
-- 
--         SET @examId = SCOPE_IDENTITY();
-- 
--         INSERT INTO studentExam (examId, studentId)
--         SELECT
--             @examId,
--             s.studentID
--         FROM Course c
--         JOIN trackCourse tc ON c.courseId = tc.courseId
--         JOIN track t ON t.trackId = tc.trackId
--         JOIN Student s ON s.TrackId = t.trackId
--         WHERE c.courseId = @courseID;
-- 
-- 
--         ;WITH StudentsInCourse AS
--         (
--             SELECT DISTINCT s.studentID
--             FROM Course c
--             JOIN trackCourse tc ON c.courseId = tc.courseId
--             JOIN track t ON t.trackId = tc.trackId
--             JOIN Student s ON s.TrackId = t.trackId
--             WHERE c.courseId = @courseID
--         ),
--         RandomizedQuestions AS
--         (
--             SELECT
--                 s.studentID,
--                 q.questionID,
--                 q.QuestionType,
--                 ROW_NUMBER() OVER
--                 (
--                     PARTITION BY s.studentID, q.QuestionType
--                     ORDER BY NEWID()
--                 ) AS rn
--             FROM StudentsInCourse s
--             CROSS JOIN question q
--             WHERE q.questionType IN (0, 1)
--         )
--         INSERT INTO examQuestionsPool (examId, studentId, questionId)
--         SELECT
--             @examId,
--             studentID,
--             questionID
--         FROM RandomizedQuestions
--         WHERE
--               (QuestionType = 0  AND rn <= @trueFalse)
--            OR (QuestionType = 1 AND rn <= @MCQ);
-- 
--         COMMIT TRANSACTION;
-- 
--         SELECT @examId AS CreatedExamId;
-- 
--     END TRY
--     BEGIN CATCH
--         IF XACT_STATE() <> 0
--             ROLLBACK TRAN;
-- 
--         THROW;
--     END CATCH
-- END;
-- GO


-- execute  GenerateExam
--     @title       ='newExam',
--     @duration    =120,
--     @description ='exam for the best students',
--     @courseName  ='react',
--     @trueFalse   =5,
--     @MCQ         =5



CREATE PROCEDURE GenerateExam  
    @title       VARCHAR(50),
    @duration    INT,
    @description VARCHAR(100),
    @courseName  VARCHAR(50),
    @trueFalse   INT,
    @MCQ         INT
AS
BEGIN
  
    IF (@trueFalse + @MCQ) <> 10
    BEGIN
        THROW 50010, 'MCQ + True/False must equal exactly 10.', 1;
    END;

    DECLARE @courseID INT;
    DECLARE @examId INT;
    DECLARE @studentID INT;
    DECLARE @questionID INT;

    BEGIN TRY
        BEGIN TRAN;

        SELECT TOP (1) @courseID = courseId
        FROM Course
        WHERE courseName LIKE '%' + @courseName + '%';

        IF @courseID IS NULL
        BEGIN
            THROW 50011, 'Course not found.', 1;
        END;

        INSERT INTO examDetails (examTitle, examDescription, examDuration, courseID)
        VALUES (@title, @description, @duration, @courseID);

        SET @examId = SCOPE_IDENTITY();

        INSERT INTO studentExam (examId, studentId)
        SELECT @examId, s.studentID
        FROM Course c
        JOIN trackCourse tc ON c.courseId = tc.courseId
        JOIN track t ON t.trackId = tc.trackId
        JOIN Student s ON s.TrackId = t.trackId
        WHERE c.courseId = @courseID;

        DECLARE student_cursor CURSOR FOR
             SELECT s.studentID
             FROM Course c
             JOIN trackCourse tc ON c.courseId = tc.courseId
             JOIN track t ON t.trackId = tc.trackId
             JOIN Student s ON s.TrackId = t.trackId
        WHERE c.courseId = @courseID;

        OPEN student_cursor;
        FETCH NEXT FROM student_cursor INTO @studentID;

        WHILE @@FETCH_STATUS = 0
        BEGIN

            DECLARE @tf_count INT = 0;
            WHILE @tf_count < @trueFalse
            BEGIN
                SELECT TOP 1 @questionID = questionID
                FROM question
                WHERE QuestionType = 0 -- True/False
                ORDER BY NEWID();

                INSERT INTO examQuestionsPool (examId, studentId, questionId)
                VALUES (@examId, @studentID, @questionID);

                SET @tf_count = @tf_count + 1;
            END

            DECLARE @mcq_count INT = 0;
            WHILE @mcq_count < @MCQ
            BEGIN
                SELECT TOP 1 @questionID = questionID
                FROM Question
                WHERE QuestionType = 1 
                ORDER BY NEWID();

                INSERT INTO examQuestionsPool (examId, studentId, questionId)
                VALUES (@examId, @studentID, @questionID);

                SET @mcq_count = @mcq_count + 1;
            END

            FETCH NEXT FROM student_cursor INTO @studentID;
        END

        CLOSE student_cursor;
        DEALLOCATE student_cursor;

        COMMIT TRAN;

        SELECT @examId AS CreatedExamId;

    END TRY
    BEGIN CATCH
        IF XACT_STATE() <> 0
            ROLLBACK TRAN;

        THROW;
    END CATCH
END;
GO


---------------------------------Student Exam details------------------------------------
use AdvancedSQLExamSystem
 

create procedure getStudentExamData 
@studentID int,
@Examid int
as
begin
      SELECT 
    ed.examId,
    ed.examTitle,
    ed.examDuration,
    ed.examDescription,
    ed.examDate,
    se.grade AS studentExamGrade,
    q.questionId,
    q.questionText AS theQuestion,
    q.questionGrade,
    q.questionType,
    c.choiceId,
    c.choiceText,
    eqp.choiceAnswerId AS studentAnswerId, 
    ma.choiceId AS modelAnswerId   
FROM Student AS s
JOIN studentExam AS se
    ON s.studentID = se.studentId
JOIN examDetails AS ed
    ON ed.examId = se.examId
JOIN examQuestionsPool AS eqp
    ON eqp.examId = ed.examId AND eqp.studentId = s.studentID
LEFT JOIN question AS q
    ON q.questionId = eqp.questionId
LEFT JOIN choice AS c
    ON c.questionId = q.questionId
LEFT JOIN modelAnswer AS ma
    ON ma.questionID = q.questionId AND ma.choiceId = c.choiceId
WHERE ed.examId = @Examid
  AND s.studentID = @studentID

end











