CREATE DATABASE AcademyTask2;


USE AcademyTask2;


CREATE TABLE Groups
(
    Id INT PRIMARY KEY IDENTITY,
    No NVARCHAR(5)
);

CREATE TABLE Students
(
    Id INT PRIMARY KEY IDENTITY,
    FullName NVARCHAR(20),
    Point TINYINT CHECK(Point>=0 AND Point<=100),
    GroupId INT FOREIGN KEY REFERENCES Groups(Id)
);

CREATE TABLE Exams
(
    Id INT PRIMARY KEY IDENTITY,
    SubjectName NVARCHAR(20),
    StartDate DATETIME2,
    EndDate DATETIME2
);

CREATE TABLE StudentExams
(
    StudentId INT,
    ExamId INT,
    ResultPoint TINYINT,
    PRIMARY KEY (StudentId, ExamId),
    FOREIGN KEY (StudentId) REFERENCES Students(Id),
    FOREIGN KEY (ExamId) REFERENCES Exams(Id)
);

INSERT INTO Groups (No)
VALUES
('P328'),
('P318'),
('P338'),
('P228'),
('D268'),
('D568');

INSERT INTO Students(FullName,Point,GroupId)
VALUES
('Elmeddin Mirzeyev', 100,1),
('Elshad Rzaquliyev', 90,1),
('Rza Mirzeyev', 80,3),
('Amirali Sarsilmaz', 85,2),
('Xaliq Maemmedov', 95,3),
('Mehemmed Musayev', 55, 4),
('Murad Quliyev', 45,5),
('Elshen Memmedov', 50,6);

INSERT INTO Exams(SubjectName, StartDate,EndDate)
VALUES
('Frontend', '2023-04-30 14:00', '2023-04-30 17:00'),
('Backend', '2023-04-03 14:00', '2023-04-03 17:00'),
('SQL', '2023-04-03 14:00', '2023-04-03 17:00'),
('Math', '2023-04-29 14:00', '2023-04-29 17:00'),
('Science', '2023-04-30 13:00', '2023-04-30 16:00'),
('Biology', '2023-05-01 14:00', '2023-05-01 17:00'),
('History', '2023-05-02 12:00', '2023-05-02 15:00')


INSERT INTO StudentExams(StudentId, ExamId, ResultPoint)
VALUES
(1, 1, 90),
(1, 2, 80),
(2, 1, 85),
(2, 2, 95),
(3, 1, 75),
(3, 2, 70)



INSERT INTO StudentExams(StudentId, ExamId, ResultPoint)
VALUES
(4, 3, 90),
(5, 4, 85),
(6, 1, 70);


SELECT FullName, Point, G.No  FROM Students AS S
JOIN Groups AS G ON S.GroupId=G.Id




SELECT  S.FullName,  S.Point,  G.No,    COUNT(SE.ExamId) AS ExamCount
FROM  Students AS S
    JOIN Groups AS G ON S.GroupId = G.Id
    LEFT JOIN StudentExams AS SE ON S.Id = SE.StudentId
GROUP BY S.Id, S.FullName, S.Point, G.No;


SELECT E.SubjectName FROM Exams AS E
LEFT JOIN StudentExams SE ON E.Id = SE.ExamId
WHERE SE.ExamId IS NULL



SELECT E.SubjectName, E.StartDate, S.FullName, SE.ResultPoint
FROM Exams AS E
INNER JOIN StudentExams AS SE ON E.Id = SE.ExamId
INNER JOIN Students AS S ON SE.StudentId = S.Id
WHERE E.EndDate >= DATEADD(DAY,-1,GETDATE()) 

SELECT SE.ExamId, SE.StudentId, S.FullName, SE.ResultPoint, G.No  FROM StudentExams AS SE
LEFT JOIN Students AS S ON SE.StudentId=S.Id
JOIN Groups AS G ON G.Id=S.GroupId


SELECT S.FullName, AVG(CAST(ResultPoint AS FLOAT)) AS AveragePoint
FROM Students AS S
INNER JOIN StudentExams AS SE ON S.Id = SE.StudentId
GROUP BY S.FullName;
