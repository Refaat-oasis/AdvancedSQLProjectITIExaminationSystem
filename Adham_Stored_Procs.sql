use AdvancedSQLExamSystem;


------------------------1--------------------------------

CREATE PROCEDURE SP_Select_Teaches
    @InstructorId INT = NULL,
    @CourseId INT = NULL,
    @Year DATE = NULL
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        SELECT 
            i.instructorid AS InstructorId,
            i.instructorname AS InstructorName,

            c.courseid AS CourseId,
            c.coursename AS CourseName,

            t.teachingyear
            
        FROM Teaches t
        INNER JOIN Instructor i
            ON t.instructorid = i.instructorid
        INNER JOIN Course c
            ON t.courseid = c.courseid
        WHERE
            (@InstructorId IS NULL OR t.instructorid = @InstructorId)
            AND (@CourseId IS NULL OR t.courseid = @CourseId)
            AND (@Year IS NULL OR t.teachingyear = @Year)
        ORDER BY i.instructorname, c.coursename;
    END TRY
    BEGIN CATCH
        THROW;
    END CATCH
END;

select * from Instructor;
select * from Course;


EXEC SP_Select_Teaches;

EXEC SP_Select_Teaches @InstructorId = 3;

EXEC SP_Select_Teaches @CourseId = 5;

EXEC SP_Select_Teaches @Year = '2024';


-------------------------- 2- Update Teaches (year) --------------------------
CREATE PROCEDURE SP_Update_Teaches
    @InstructorId INT,
    @CourseId INT,
    @Year DATE = NULL

AS
BEGIN
    SET NOCOUNT ON;

    -- Validation
    IF @InstructorId IS NULL OR @CourseId IS NULL
    BEGIN
        RAISERROR ('InstructorId and CourseId are required', 16, 1);
        RETURN;
    END

    -- Check if record exists
    IF NOT EXISTS (
        SELECT 1 
        FROM Teaches 
        WHERE instructorid = @InstructorId 
          AND courseid = @CourseId
    )
    BEGIN
        RAISERROR ('Teaches record not found', 16, 1);
        RETURN;
    END

    BEGIN TRY
        BEGIN TRANSACTION;

        UPDATE Teaches
        SET
            teachingyear = ISNULL(@Year, teachingyear)
            
        WHERE
            instructorid = @InstructorId
            AND courseid = @CourseId;

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        THROW;
    END CATCH
END;

EXEC SP_Update_Teaches 
    @InstructorId = 2,
    @CourseId = 4;

EXEC SP_Update_Teaches 
    @InstructorId = 1,
    @CourseId = 3,
    @Year = 2025;







	--------------------------------- 3 ---------------------------------

	CREATE PROCEDURE SP_GetInstructorCoursesWithStudentCount
    @InstructorId INT
AS
BEGIN
    SET NOCOUNT ON;

    -- Validation
    IF @InstructorId IS NULL
    BEGIN
        RAISERROR ('Instructor ID is required', 16, 1);
        RETURN;
    END

    -- Check instructor teaches something
    IF NOT EXISTS (
        SELECT 1
        FROM Teaches
        WHERE instructorid = @InstructorId
    )
    BEGIN
        RAISERROR ('This instructor does not teach any courses', 16, 1);
        RETURN;
    END

    BEGIN TRY
        SELECT
            c.courseid AS CourseId,
            c.coursename AS CourseName,
            COUNT(DISTINCT s.studentid) AS NumberOfStudents
        FROM Teaches t
        INNER JOIN Course c
            ON t.courseid = c.courseid
        LEFT JOIN Trackcourse tc
            ON c.courseid = tc.courseid
        LEFT JOIN Student s
            ON tc.trackid = s.trackid
        WHERE t.instructorid = @InstructorId
        GROUP BY c.courseid, c.coursename
        ORDER BY c.coursename;
    END TRY
    BEGIN CATCH
        THROW;
    END CATCH
END;

select * from Trackcourse;

select *from track;

EXEC SP_GetInstructorCoursesWithStudentCount @InstructorId = 2;



-----------------------------3-----------------------------------------------



CREATE PROCEDURE GetExamForPDF-- //وحده يعني pdf هنقسم كل طالب ف pdf بس هنا بجيب الاسئلة كلها بتاعت الطلاب بس مرتبة واحنا بنربط بال 
    @ExamID INT
AS
BEGIN
   
    SELECT studentId, questionId, choiceAnswerId
    FROM examQuestionsPool
    WHERE examId = @ExamID
    ORDER BY studentId, questionId;
END



EXEC GetExamForPDF @ExamId = 21;






