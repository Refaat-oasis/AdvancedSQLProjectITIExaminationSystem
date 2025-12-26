
------------------- Insert Into Teaches -------------------------------

INSERT INTO Teaches (instructorid, courseid, teachingyear)
VALUES
-- Course 1: C#
(1, 1, '2022'),
(7, 1, '2023'),
(14, 1, '2024'),

-- Course 2: ASP.NET
(1, 2, '2022'),
(8, 2, '2023'),
(14, 2, '2024'),

-- Course 3: SQL Server
(2, 3, '2022'),
(8, 3, '2023'),
(15, 3, '2024'),

-- Course 4: Python
(2, 4, '2022'),
(8, 4, '2023'),
(15, 4, '2024'),

-- Course 5: AI
(2, 5, '2022'),
(9, 5, '2023'),
(15, 5, '2024'),

-- Course 6: Networking
(2, 6, '2022'),
(9, 6, '2023'),
(16, 6, '2024'),

-- Course 7: Security
(3, 7, '2022'),
(9, 7, '2023'),
(16, 7, '2024'),

-- Course 8: Linux
(3, 8, '2022'),
(10, 8, '2023'),
(16, 8, '2024'),

-- Course 9: Docker
(3, 9, '2022'),
(10, 9, '2023'),
(17, 9, '2024'),

-- Course 10: Kubernetes
(4, 10, '2022'),
(10, 10, '2023'),
(17, 10, '2024'),

-- Course 11: React
(4, 11, '2022'),
(11, 11, '2023'),
(17, 11, '2024'),

-- Course 12: Angular
(4, 12, '2022'),
(11, 12, '2023'),
(18, 12, '2024'),

-- Course 13: Flutter
(5, 13, '2022'),
(11, 13, '2023'),
(18, 13, '2024'),

-- Course 14: Android
(5, 14, '2022'),
(12, 14, '2023'),
(18, 14, '2024'),

-- Course 15: Embedded C
(5, 15, '2022'),
(12, 15, '2023'),
(19, 15, '2024'),

-- Course 16: Testing
(6, 16, '2022'),
(12, 16, '2023'),
(19, 16, '2024'),

-- Course 17: UI Design
(6, 17, '2022'),
(13, 17, '2023'),
(19, 17, '2024'),

-- Course 18: DevOps
(6, 18, '2022'),
(13, 18, '2023'),
(20, 18, '2024'),

-- Course 19: Cloud
(7, 19, '2022'),
(13, 19, '2023'),
(20, 19, '2024'),

-- Course 20: Blockchain
(7, 20, '2022'),
(14, 20, '2023'),
(20, 20, '2024');


---------------------------------------------------


INSERT INTO TrackCourse (trackid, courseid)
VALUES
-- .NET Full Stack
(1, 1), (1, 2), (1, 3),

-- Java Backend
(2, 3), (2, 6),

-- Python AI
(3, 4), (3, 5), (3, 3),

-- Data Science
(4, 4), (4, 5), (4, 3),

-- Cyber Security
(5, 6), (5, 7), (5, 8),

-- DevOps
(6, 9), (6, 10), (6, 18), (6, 19),

-- Cloud Computing
(7, 18), (7, 19), (7, 9),

-- Mobile Development
(8, 13), (8, 14),

-- Embedded Systems
(9, 15),

-- Game Development
(10, 4),

-- Frontend Angular
(11, 12), (11, 17),

-- Frontend React
(12, 11), (12, 17),

-- AI Engineering
(13, 5), (13, 4), (13, 3),

-- Big Data
(14, 3), (14, 4),

-- Blockchain
(15, 20),

-- QA Automation
(16, 16),

-- System Administration
(17, 8), (17, 6),

-- UI/UX Design
(18, 17),

-- IT Support
(19, 6), (19, 8),

-- Network Engineering
(20, 6), (20, 7);



