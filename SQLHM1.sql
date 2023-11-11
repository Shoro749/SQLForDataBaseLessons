--CREATE DATABASE Academy
--GO
USE Academy
GO

CREATE TABLE Departments(
    [Id] INT PRIMARY KEY IDENTITY,
	[Financing] MONEY NOT NULL DEFAULT(0),
	[Name] NVARCHAR(100) NOT NULL UNIQUE,
	CONSTRAINT CHK_Financing CHECK ([Financing] >= 0),
);

CREATE TABLE Faculties(
    [Id] INT PRIMARY KEY IDENTITY,
	[Dean] NVARCHAR(MAX) NOT NULL,
	[Name] NVARCHAR(100) NOT NULL UNIQUE,
);

CREATE TABLE Groups(
    [Id] INT PRIMARY KEY IDENTITY,
	[Name] NVARCHAR(10) NOT NULL UNIQUE,
	[Rating] INT NOT NULL,
	[Year] INT NOT NULL,
	CONSTRAINT CHK_Rating CHECK ([Rating] BETWEEN 0 AND 5),
	CONSTRAINT CHK_Year CHECK ([Year] BETWEEN 1 AND 5),
);

CREATE TABLE Teachers(
    [Id] INT PRIMARY KEY IDENTITY,
	[EmploymentDate] DATE NOT NULL,
	[IsAssistant] BIT NOT NULL DEFAULT(0),
	[IsProfessor] BIT NOT NULL DEFAULT(0),
	[Name] NVARCHAR(MAX) NOT NULL,
	[Position] NVARCHAR(MAX) NOT NULL,
	[Premium] MONEY NOT NULL DEFAULT(0),
	[Salary] MONEY NOT NULL,
	[Surname] NVARCHAR(MAX) NOT NULL,
	CONSTRAINT EmploymentDate CHECK (EmploymentDate > '01.01.1990'),
	CONSTRAINT CHK_Premium CHECK ([Premium] >= 0),
	CONSTRAINT CHK_Salary CHECK ([Salary] > 0),
);

INSERT INTO Departments (Financing, Name) VALUES 
(10000, 'Department of Computer Science'),
(15000, 'Department of Mathematics'),
(12000, 'Department of Physics');

INSERT INTO Faculties (Dean, Name) VALUES 
('Dr. Smith', 'Faculty of Engineering'),
('Dr. Johnson', 'Faculty of Science'),
('Dr. Williams', 'Faculty of Arts');

INSERT INTO Groups (Name, Rating, Year) VALUES 
('Group A', 4, 2),
('Group B', 5, 3),
('Group C', 3, 1);

INSERT INTO Teachers (EmploymentDate, IsAssistant, IsProfessor, Name, Position, Premium, Salary, Surname)
VALUES
    ('1995-05-15', 1, 0, 'John', 'Lecturer', 500, 3000, 'Doe'),
    ('2000-02-20', 0, 1, 'Alice', 'Professor', 1000, 6000, 'Smith'),
    ('2005-08-10', 1, 0, 'Bob', 'Lecturer', 600, 3500, 'Johnson');

-- 1. Вивести таблицю кафедр, але розташувати її поля у зворотному порядку.
select [Name], Financing from Departments
-- 2. Вивести назви груп та їх рейтинги, використовуючи, як назви полів, що виводяться, “Group Name” та “Group Rating” відповідно.
select [Name] as 'Group Name', Rating as 'Group Rating' from Groups
-- 3. Вивести для викладачів їхнє прізвище, відсоток ставки по відношенню до надбавки та відсоток ставки по відношенню до зарплати (сума ставки та надбавки).
select [Surname], Premium * 100 / Salary AS 'Percentage of Premium to Salary',
    (Salary + Premium) * 100 / Salary AS 'Percentage of Total Compensation to Salary'
from Teachers
-- 4. Вивести таблицю факультетів у вигляді одного поля у такому форматі: “The dean of faculty [faculty] is [dean].
select 'The dean of faculty ' + [Name] + ' is ' + Dean as 'Table of faculties'
from Faculties
-- 5. Вивести прізвища викладачів, які є професорами та ставка яких перевищує 1050.
select Surname
from Teachers
where IsProfessor = 1 and Salary > 1050
-- 6. Вивести назви кафедр, фонд фінансування яких менший за 11000 або більше 25000.
select [Name]
from Departments
where Financing between 11000 and 25000
-- 7. Вивести назви факультетів, окрім факультету “Computer Science”.
select [Name] 
from Faculties
where [Name] != 'Computer Science'
-- 8. Вивести прізвища та посади викладачів, які не є професорами.
select Surname, Position
from Teachers
where IsProfessor = 0
-- 9. Вивести прізвища, посади, ставки та надбавки асистентів, у яких надбавка у діапазоні від 160 до 550.
select [Name], Position, Salary, Premium
from Teachers
where IsAssistant = 1 and Premium between 160 and 550
-- 10. Вивести прізвища та ставки асистентів
select Surname, Salary from Teachers
where IsAssistant = 1
-- 11. Вивести прізвища та посади викладачів, які були прийняті на роботу до 01.01.2000.
select Surname, Position 
from Teachers
where EmploymentDate < '01.01.2000'
-- 12.Вивести назви кафедр, які в алфавітному порядку розміщуються до кафедри “Software Development”. Поле, що виводиться повинно мати назву “Name of Department”.
select [Name] as 'Name of Department'
from Departments
where [Name] < 'Software Development'
order by [Name]
-- 13. Вивести прізвища асистентів, які мають зарплату (сума ставки та надбавки) не більше 1200.
select Surname
from Teachers
where IsAssistant = 1 and (Salary + Premium) < 1200
-- 14. Вивести назви груп 5-го курсу, які мають рейтинг у діапазоні від 2 до 4.
select [Name]
from Groups
where [Year] = 5 and Rating between 2 and 4
-- 15. Вивести прізвища асистентів зі ставкою менше 550 або надбавкою менше 200.
select [Surname]
from Teachers
where IsAssistant = 1 and (Salary < 550 or Premium < 200)

DROP TABLE Departments
DROP TABLE Faculties
DROP TABLE Groups
DROP TABLE Teachers