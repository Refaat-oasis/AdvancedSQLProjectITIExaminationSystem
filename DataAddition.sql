-- branches
INSERT INTO Branch (branchName, branchLocation)
VALUES
('Cairo','Nasr City'),('Giza','Dokki'),('Alex','Smouha'),('Mansoura','Talkha'),
('Tanta','El Bahr'),('Zagazig','Downtown'),('Assiut','City Center'),
('Sohag','East'),('Minya','Corniche'),('Fayoum','Central'),
('Ismailia','El Sheikh Zayed'),('Suez','Port'),('Damietta','New Damietta'),
('Port Said','Canal'),('Hurghada','Touristic'),('Sharm','Naama Bay'),
('Luxor','Temple Area'),('Aswan','Nile Side'),('Banha','Ring Road'),
('Menofia','Shebin');
-- tracks 
INSERT INTO Track (trackName)
VALUES
('.NET Full Stack'),('Java Backend'),('Python AI'),('Data Science'),
('Cyber Security'),('DevOps'),('Cloud Computing'),('Mobile Development'),
('Embedded Systems'),('Game Development'),('Frontend Angular'),
('Frontend React'),('AI Engineering'),('Big Data'),('Blockchain'),
('QA Automation'),('System Administration'),('UI/UX Design'),
('IT Support'),('Network Engineering');
-- branchTrack
INSERT INTO branchTracks (branchId, trackId)
SELECT TOP 20 b.branchId, t.trackId
FROM Branch b
CROSS JOIN Track t;
-- instructor
INSERT INTO Instructor
(instructorSocialSecurityNumber, instructorName, instructorEmail,
 instructorPasswordHased, isntructorPasswordSalt,
 instructorPhoneNumber, instructorBranchId)
VALUES
('29810000000001','Ahmed Ali','ahmed@iti.gov.eg','H1','S1','0100000001',1),
('29810000000002','Mona Hassan','mona@iti.gov.eg','H2','S2','0100000002',2),
('29810000000003','Omar Khaled','omar@iti.gov.eg','H3','S3','0100000003',3),
('29810000000004','Sara Adel','sara@iti.gov.eg','H4','S4','0100000004',4),
('29810000000005','Kareem Said','kareem@iti.gov.eg','H5','S5','0100000005',5),
('29810000000006','Nour Tamer','nour@iti.gov.eg','H6','S6','0100000006',6),
('29810000000007','Hany Salah','hany@iti.gov.eg','H7','S7','0100000007',7),
('29810000000008','Dina Fathy','dina@iti.gov.eg','H8','S8','0100000008',8),
('29810000000009','Mostafa Eid','mostafa@iti.gov.eg','H9','S9','0100000009',9),
('29810000000010','Laila Samir','laila@iti.gov.eg','H10','S10','0100000010',10),
('29810000000011','Youssef Magdy','youssef@iti.gov.eg','H11','S11','0100000011',11),
('29810000000012','Heba Kamal','heba@iti.gov.eg','H12','S12','0100000012',12),
('29810000000013','Amr Nabil','amr@iti.gov.eg','H13','S13','0100000013',13),
('29810000000014','Salma Younes','salma@iti.gov.eg','H14','S14','0100000014',14),
('29810000000015','Islam Ashraf','islam@iti.gov.eg','H15','S15','0100000015',15),
('29810000000016','Rania Zaki','rania@iti.gov.eg','H16','S16','0100000016',16),
('29810000000017','Tarek Hassan','tarek@iti.gov.eg','H17','S17','0100000017',17),
('29810000000018','Mariam Adel','mariam@iti.gov.eg','H18','S18','0100000018',18),
('29810000000019','Sherif Mahmoud','sherif@iti.gov.eg','H19','S19','0100000019',19),
('29810000000020','Aya Hamdy','aya@iti.gov.eg','H20','S20','0100000020',20);
go
INSERT INTO Instructor
(instructorSocialSecurityNumber, instructorName, instructorEmail,
 instructorPasswordHased, isntructorPasswordSalt, instructorPhoneNumber,
 instructorBranchId)
VALUES
('111111111','Ahmed Hassan','ahmed@iti.gov.eg','hash1','salt1','0100000001',1),
('222222222','Mohamed Ali','mohamed@iti.gov.eg','hash2','salt2','0100000002',2),
('333333333','Sara Adel','sara@iti.gov.eg','hash3','salt3','0100000003',3),
('444444444','Mona Samir','mona@iti.gov.eg','hash4','salt4','0100000004',4),
('555555555','Youssef Kamal','youssef@iti.gov.eg','hash5','salt5','0100000005',5),
('666666666','Nour Khaled','nour@iti.gov.eg','hash6','salt6','0100000006',6),
('777777777','Hany Said','hany@iti.gov.eg','hash7','salt7','0100000007',7),
('888888888','Dina Mostafa','dina@iti.gov.eg','hash8','salt8','0100000008',8),
('999999999','Omar Fathy','omar@iti.gov.eg','hash9','salt9','0100000009',9),
('101010101','Reem Tarek','reem@iti.gov.eg','hash10','salt10','0100000010',10),
('111111112','Ali Nasser','ali@iti.gov.eg','hash11','salt11','0100000011',11),
('121212121','Salma Ashraf','salma@iti.gov.eg','hash12','salt12','0100000012',12),
('131313131','Khaled Zaki','khaled@iti.gov.eg','hash13','salt13','0100000013',13),
('141414141','Nada Wael','nada@iti.gov.eg','hash14','salt14','0100000014',14),
('151515151','Tamer Adel','tamer@iti.gov.eg','hash15','salt15','0100000015',15),
('161616161','Rania Samy','rania@iti.gov.eg','hash16','salt16','0100000016',16),
('171717171','Hossam Mahmoud','hossam@iti.gov.eg','hash17','salt17','0100000017',17),
('181818181','Mai Reda','mai@iti.gov.eg','hash18','salt18','0100000018',18),
('191919191','Islam Yasser','islam@iti.gov.eg','hash19','salt19','0100000019',19),
('202020202','Heba Eid','heba@iti.gov.eg','hash20','salt20','0100000020',20);

--student
INSERT INTO Student
(studentSocialSecurityNumber, studentName, studentEmail,
 studentPasswordHased, studentPasswordSalt,
 studentPhoneNumber, TrackId)
VALUES
('300000000001','Ali Ahmed','ali@student.com','PH1','PS1','0110000001',1),
('300000000002','Sara Mohamed','sara@student.com','PH2','PS2','0110000002',1),
('300000000003','Omar Adel','omar@student.com','PH3','PS3','0110000003',1),
('300000000004','Mona Saeed','mona@student.com','PH4','PS4','0110000004',1),
('300000000005','Hassan Youssef','hassan@student.com','PH5','PS5','0110000005',5),
('300000000006','Laila Tamer','laila@student.com','PH6','PS6','0110000006',6),
('300000000007','Khaled Magdy','khaled@student.com','PH7','PS7','0110000007',7),
('300000000008','Nour Ali','nour@student.com','PH8','PS8','0110000008',8),
('300000000009','Mahmoud Eid','mahmoud@student.com','PH9','PS9','0110000009',9),
('300000000010','Aya Samir','aya@student.com','PH10','PS10','0110000010',10),
('300000000011','Islam Mostafa','islam@student.com','PH11','PS11','0110000011',11),
('300000000012','Rania Kamal','rania@student.com','PH12','PS12','0110000012',12),
('300000000013','Tarek Salah','tarek@student.com','PH13','PS13','0110000013',13),
('300000000014','Dina Nabil','dina@student.com','PH14','PS14','0110000014',14),
('300000000015','Yara Fathy','yara@student.com','PH15','PS15','0110000015',15),
('300000000016','Ziad Hassan','ziad@student.com','PH16','PS16','0110000016',16),
('300000000017','Nada Adel','nada@student.com','PH17','PS17','0110000017',17),
('300000000018','Sherif Mahmoud','sherif@student.com','PH18','PS18','0110000018',18),
('300000000019','Heba Younes','heba@student.com','PH19','PS19','0110000019',19),
('300000000020','Mostafa Kamal','mostafa@student.com','PH20','PS20','0110000020',20);
INSERT INTO Student
(studentSocialSecurityNumber, studentName, studentEmail,
 studentPasswordHased, studentPasswordSalt, studentPhoneNumber, TrackId)
VALUES
('900001','Student One','s1@mail.com','h1','s1','0110000001',1),
('900002','Student Two','s2@mail.com','h2','s2','0110000002',2),
('900003','Student Three','s3@mail.com','h3','s3','0110000003',3),
('900004','Student Four','s4@mail.com','h4','s4','0110000004',4),
('900005','Student Five','s5@mail.com','h5','s5','0110000005',5),
('900006','Student Six','s6@mail.com','h6','s6','0110000006',6),
('900007','Student Seven','s7@mail.com','h7','s7','0110000007',7),
('900008','Student Eight','s8@mail.com','h8','s8','0110000008',8),
('900009','Student Nine','s9@mail.com','h9','s9','0110000009',9),
('900010','Student Ten','s10@mail.com','h10','s10','0110000010',10),
('900011','Student Eleven','s11@mail.com','h11','s11','0110000011',11),
('900012','Student Twelve','s12@mail.com','h12','s12','0110000012',12),
('900013','Student Thirteen','s13@mail.com','h13','s13','0110000013',13),
('900014','Student Fourteen','s14@mail.com','h14','s14','0110000014',14),
('900015','Student Fifteen','s15@mail.com','h15','s15','0110000015',15),
('900016','Student Sixteen','s16@mail.com','h16','s16','0110000016',16),
('900017','Student Seventeen','s17@mail.com','h17','s17','0110000017',17),
('900018','Student Eighteen','s18@mail.com','h18','s18','0110000018',18),
('900019','Student Nineteen','s19@mail.com','h19','s19','0110000019',19),
('900020','Student Twenty','s20@mail.com','h20','s20','0110000020',20);

-- courses
INSERT INTO Course (courseName, courseCode, courseDiscription)
VALUES
('C#','CS101','C# fundamentals'),
('ASP.NET','CS102','Web backend'),
('SQL Server','DB201','Database'),
('Python','PY101','Python basics'),
('AI','AI301','Artificial Intelligence'),
('Networking','NW101','Networking basics'),
('Security','SEC201','Cyber security'),
('Linux','OS101','Linux admin'),
('Docker','DV301','Containers'),
('Kubernetes','DV401','Orchestration'),
('React','FE101','Frontend'),
('Angular','FE102','Frontend'),
('Flutter','MB101','Mobile'),
('Android','MB102','Mobile'),
('Embedded C','EM101','Embedded'),
('Testing','QA101','QA automation'),
('UI Design','UX101','UX'),
('DevOps','DV201','DevOps'),
('Cloud','CL101','Cloud'),
('Blockchain','BC101','Blockchain');
--questions
DECLARE @i INT = 1;
WHILE @i <= 20
BEGIN
    INSERT INTO question
    (questionText, questionGrade, questionType, courseId)
    VALUES
    (
        CONCAT('Question ', @i),
        5,
        CASE WHEN @i % 2 = 0 THEN 0 ELSE 1 END,
        ((@i - 1) % 20) + 1
    );
    SET @i += 1;
END;
go
INSERT INTO Question (questionText, questionGrade, questionType, courseId)
VALUES
('C# is a strongly typed language',5,0,1),
('SQL Server is a NoSQL database',5,0,3),
('HTML is a programming language',5,0,4),
('ASP.NET MVC follows MVC pattern',5,0,5),
('Primary keys allow duplicate values',5,0,3),
('Classes support inheritance in C#',5,0,1),
('JavaScript runs only on servers',5,0,4),
('Indexes improve query performance',5,0,3),
('CLR manages memory in .NET',5,0,1),
('CSS controls webpage styling',5,0,4);
INSERT INTO Question (questionText, questionGrade, questionType, courseId)
VALUES
('Which keyword is used for inheritance in C#?',5,1,1),
('Which SQL command retrieves data?',5,1,3),
('Which tag is used for hyperlinks?',5,1,4),
('Which method starts MVC app?',5,1,5),
('Which datatype stores text in SQL?',5,1,3),
('Which keyword creates object in C#?',5,1,1),
('Which CSS property changes color?',5,1,4),
('Which join returns all records?',5,1,3),
('Which layer handles logic in MVC?',5,1,5),
('Which tool manages packages in .NET?',5,1,1);

-- choices
DECLARE @q INT = 1;
WHILE @q <= 20
BEGIN
    IF (SELECT questionType FROM question WHERE questionId = @q) = 0
        INSERT INTO choice VALUES ('True',@q),('False',@q);
    ELSE
        INSERT INTO choice VALUES ('A',@q),('B',@q),('C',@q),('D',@q);
    SET @q += 1;
END;
go
INSERT INTO Choice (choicetText, questionId)
VALUES
('True',1),('False',1),
('True',2),('False',2),
('True',3),('False',3),
('True',4),('False',4),
('True',5),('False',5),
('True',6),('False',6),
('True',7),('False',7),
('True',8),('False',8),
('True',9),('False',9),
('True',10),('False',10);
INSERT INTO Choice (choicetText, questionId)
VALUES
('this',11),('base',11),('extends',11),('inherits',11),
('GET',12),('FETCH',12),('SELECT',12),('READ',12),
('<link>',13),('<a>',13),('<href>',13),('<url>',13),
('Startup',14),('Main',14),('Run',14),('Begin',14),
('INT',15),('VARCHAR',15),('DATE',15),('BIT',15),
('make',16),('create',16),('new',16),('build',16),
('font-style',17),('color',17),('background',17),('display',17),
('INNER JOIN',18),('LEFT JOIN',18),('RIGHT JOIN',18),('FULL JOIN',18),
('View',19),('Controller',19),('Model',19),('Route',19),
('NuGet',20),('Docker',20),('Git',20),('NPM',20);


--model answer
INSERT INTO modelAnswer (questionID, choiceId)
SELECT q.questionId, MIN(c.choiceId)
FROM question q
JOIN choice c ON q.questionId = c.questionId
GROUP BY q.questionId;
go
INSERT INTO modelAnswer (questionID, choiceId)
VALUES
(1,1),
(2,4),
(3,6),
(4,7),
(5,10),
(6,11),
(7,14),
(8,15),
(9,17),
(10,19);
INSERT INTO modelAnswer (questionID, choiceId)
VALUES
(11,14),
(12,19),
(13,22),
(14,25),
(15,28),
(16,31),
(17,34),
(18,38),
(19,42),
(20,45);


-- exam details
INSERT INTO examDetails (examTitle, examDuration, examDescription, courseID)
SELECT CONCAT('Exam ', courseId), 90, 'Final Exam', courseId
FROM Course;
--studentExam
INSERT INTO studentExam (studentId, examId, grade)
SELECT studentID, examId, 70 + (studentID % 30)
FROM Student
JOIN examDetails ON examDetails.courseID = Student.TrackId;
INSERT INTO studentExam (studentId, examId, grade)
VALUES
(1,1,85),(2,1,90),(3,1,78),(4,1,88),(5,1,92),
(6,2,80),(7,2,75),(8,2,89),(9,2,91),(10,2,84),
(11,3,77),(12,3,85),(13,3,90),(14,3,88),(15,3,92),
(16,4,81),(17,4,79),(18,4,87),(19,4,90),(20,4,93);
--ExamQuestionPool
INSERT INTO examQuestionsPool
(examId, questionId, choiceAnswerId, studentId)
VALUES
(1,1,1,1),(1,2,4,2),(1,3,5,3),(1,4,8,4),(1,5,9,5),
(2,6,12,6),(2,7,15,7),(2,8,16,8),(2,9,19,9),(2,10,20,10),
(3,11,21,11),(3,12,24,12),(3,13,25,13),(3,14,28,14),(3,15,29,15),
(4,16,32,16),(4,17,35,17),(4,18,36,18),(4,19,39,19),(4,20,40,20);


