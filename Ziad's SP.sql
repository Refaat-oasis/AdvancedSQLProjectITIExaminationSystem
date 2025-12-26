USE AdvancedSQLExamSystem2;

--Instructor SP
----------------------------------------
CREATE PROCEDURE usp_CreateInstructor
    @instructorSocialSecurityNumber VARCHAR(20),
    @instructorName VARCHAR(50),
    @instructorEmail VARCHAR(50),
    @instructorPasswordHased VARCHAR(100),
    @isntructorPasswordSalt VARCHAR(50),
    @instructorPhoneNumber VARCHAR(20),
    @instructorBranchId INT
AS
BEGIN
    INSERT INTO Instructor (
        instructorSocialSecurityNumber,
        instructorName,
        instructorEmail,
        instructorPasswordHased,
        isntructorPasswordSalt,
        instructorPhoneNumber,
        instructorBranchId,
        instructorActive
    )
    VALUES (
        @instructorSocialSecurityNumber,
        @instructorName,
        @instructorEmail,
        @instructorPasswordHased,
        @isntructorPasswordSalt,
        @instructorPhoneNumber,
        @instructorBranchId,
        1
    );
END
GO



CREATE PROCEDURE usp_GetInstructorById
    @instructorId INT
AS
BEGIN
    SELECT instructorId,
           instructorSocialSecurityNumber,
           instructorName,
           instructorEmail,
           instructorPasswordHased,
           isntructorPasswordSalt,
           instructorPhoneNumber,
           instructorhireDate,
           instructorBranchId,
           instructorActive
    FROM Instructor
    WHERE instructorId = @instructorId;
END
GO



CREATE PROCEDURE usp_UpdateInstructor
    @instructorId INT,
    @instructorName VARCHAR(50) = NULL,
    @instructorEmail VARCHAR(50) = NULL,
    @instructorPhoneNumber VARCHAR(20) = NULL,
    @instructorBranchId INT = NULL
AS
BEGIN
    UPDATE Instructor
    SET
        instructorName = COALESCE(@instructorName, instructorName),
        instructorEmail = COALESCE(@instructorEmail, instructorEmail),
        instructorPhoneNumber = COALESCE(@instructorPhoneNumber, instructorPhoneNumber),
        instructorBranchId = COALESCE(@instructorBranchId, instructorBranchId)
    WHERE instructorId = @instructorId;
END
GO




CREATE PROCEDURE usp_DeleteInstructor
    @instructorId INT
AS
BEGIN
    UPDATE Instructor
    SET instructorActive = 0
    WHERE instructorId = @instructorId;
END
GO



-- Question SP
------------------------------------
CREATE PROCEDURE usp_CreateQuestion
    @questionText VARCHAR(100),
    @questionGrade INT,
    @questionType BIT,
    @courseId INT
AS
BEGIN
    INSERT INTO question (questionText, questionGrade, questionType, courseId)
    VALUES (@questionText, @questionGrade, @questionType, @courseId);
END
GO



CREATE PROCEDURE usp_UpdateQuestion
    @questionId INT,
    @questionText VARCHAR(100) = NULL,
    @questionGrade INT = NULL,
    @questionType BIT = NULL
AS
BEGIN
    IF EXISTS (
        SELECT 1
        FROM examQuestionsPool
        WHERE questionId = @questionId
    )
    BEGIN
        SELECT 'Cannot update question because it exists in an exam.'
        RETURN;
    END

    UPDATE question
    SET
        questionText = COALESCE(@questionText, questionText),
        questionGrade = COALESCE(@questionGrade, questionGrade),
        questionType = COALESCE(@questionType, questionType)
    WHERE questionId = @questionId;
END
GO



CREATE PROCEDURE usp_DeleteQuestion
    @questionId INT
AS
BEGIN
    IF EXISTS (
        SELECT 1
        FROM examQuestionsPool
        WHERE questionId = @questionId
    )
    BEGIN
        SELECT 'Cannot delete question because it exists in an exam.'
        RETURN;
    END

    DELETE FROM question
    WHERE questionId = @questionId;
END
GO




-- Choice SP
------------------------------------
CREATE PROCEDURE usp_CreateChoice
    @choiceText VARCHAR(50),
    @questionId INT
AS
BEGIN
    INSERT INTO choice (choiceText, questionId)
    VALUES (@choiceText, @questionId);
END
GO


CREATE PROCEDURE usp_UpdateChoice
    @choiceId INT,
    @choiceText VARCHAR(50) = NULL
AS
BEGIN
    IF EXISTS (
        SELECT 1
        FROM examQuestionsPool
        WHERE choiceAnswerId = @choiceId
        OR EXISTS (SELECT 1 FROM modelAnswer WHERE choiceId = @choiceId)
    )

    BEGIN
        SELECT 'Cannot update choice because it exists in an exam or as a model answer.'
        RETURN;
    END

    UPDATE choice
    SET choiceText = COALESCE(@choiceText, choiceText)
    WHERE choiceId = @choiceId;
END
GO



CREATE PROCEDURE usp_DeleteChoice
    @choiceId INT
AS
BEGIN
    IF EXISTS (
        SELECT 1
        FROM examQuestionsPool
        WHERE choiceAnswerId = @choiceId
        OR EXISTS (SELECT 1 FROM modelAnswer WHERE choiceId = @choiceId)
    )

    BEGIN
        SELECT 'Cannot delete choice because it exists in an exam or as a model answer.'
        RETURN;
    END

    
    DELETE FROM choice
    WHERE choiceId = @choiceId;
END
GO





-- Topics SP
CREATE PROCEDURE usp_GetTopicsByCourse
    @courseId INT
AS
BEGIN
    SELECT 
        topicId,
        topicName,
        courseId
    FROM Topic
    WHERE courseId = @courseId;
END
GO