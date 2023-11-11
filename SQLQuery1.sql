--CREATE DATABASE Hospital2
--GO
--USE Hospital2
--Go
CREATE TABLE [Departments](
    [Id] INT PRIMARY KEY IDENTITY,
	[Building] INT NOT NULL,
	[Financing] MONEY NOT NULL DEFAULT(0),
	[Floor] INT NOT NULL,
	[Name] NVARCHAR(100) NOT NULL UNIQUE,
	CONSTRAINT CHK_Building CHECK ([Building] <= 5 AND [Building] >= 1),
	CONSTRAINT CHK_Financing CHECK ([Financing] >= 0),
	CONSTRAINT CHK_Floor CHECK ([Floor] >= 1),
);

CREATE TABLE [Diseases](
    [Id] INT PRIMARY KEY IDENTITY,
	[Name] NVARCHAR(100) NOT NULL UNIQUE,
	[Severity] INT NOT NULL DEFAULT(1),
	CONSTRAINT CHK_Severity CHECK ([Severity] >= 1),
);

CREATE TABLE [Doctors](
    [Id] INT PRIMARY KEY IDENTITY,
	[Name] NVARCHAR(MAX) NOT NULL,
	[Phone] CHAR(10) NOT NULL,
	[Premium] MONEY NOT NULL DEFAULT(0),
	[Salary] MONEY NOT NULL,
	[Surname] NVARCHAR(MAX) NOT NULL,
	CONSTRAINT CHK_Premium CHECK ([Premium] >= 0),
	CONSTRAINT CHK_Salary CHECK ([Salary] > 0),
);

CREATE TABLE [Examinations](
    [Id] INT PRIMARY KEY IDENTITY,
	[DayOfWeek] INT NOT NULL,
	[EndTime] TIME NOT NULL,
	[Name] NVARCHAR(100) NOT NULL UNIQUE,
	[StartTime] TIME NOT NULL,
	CONSTRAINT CHK_DayOfWeek CHECK ([DayOfWeek] >= 1 AND [DayOfWeek] <= 7),
	CONSTRAINT CHK_Times CHECK ([EndTime] > [StartTime]),
	CONSTRAINT CHK_StartTime CHECK ([StartTime] > '8:00:00' AND [StartTime] < '18:00:00'),
);

CREATE TABLE [Wards](
    [Id] INT PRIMARY KEY IDENTITY,
	[Building] INT NOT NULL,
	[Floor] INT NOT NULL,
	[Name] NVARCHAR(20) NOT NULL UNIQUE,
	CONSTRAINT CHK_BuildingWards CHECK ([Building] <= 5 AND [Building] >= 1),
	CONSTRAINT CHK_FloorWards CHECK ([Floor] >= 1),
);

INSERT INTO Departments (Building, Financing, Floor, Name) VALUES
(1, 35000, 1, 'Cardiology'),
(2, 15000, 2, 'Neurology'),
(3, 20000, 3, 'Oncology'),
(4, 8000, 2, 'Pediatrics'),
(5, 25000, 4, 'Surgery');

INSERT INTO Diseases (Name, Severity) VALUES
('Influenza', 2),
('Common Cold', 1),
('Pneumonia', 3),
('Malaria', 4),
('Tuberculosis', 3);

INSERT INTO Doctors (Name, Phone, Premium, Salary, Surname) VALUES
('John', '1234567890', 1000, 5000, 'Doe'),
('Alice', '9876543210', 800, 4800, 'Smith'),
('Michael', '2345678901', 1200, 5500, 'Johnson'),
('Emily', '7890123456', 900, 5200, 'Williams'),
('Daniel', '3456789012', 1100, 5300, 'Brown');


INSERT INTO Examinations (DayOfWeek, EndTime, Name, StartTime) VALUES
(1, '12:00:00', 'Checkup', '9:00:00'),
(2, '13:30:00', 'Screening', '10:00:00'),
(3, '11:30:00', 'Diagnosis', '9:30:00'),
(4, '14:00:00', 'Analysis', '11:00:00'),
(5, '15:00:00', 'Examination', '11:30:00');

INSERT INTO Wards (Building, Floor, Name) VALUES
(1, 1, 'A1'),
(1, 2, 'B1'),
(2, 1, 'C1'),
(2, 2, 'D1'),
(3, 1, 'E1');

----�����1 - ������� ���� ������� �����.
--SELECT * FROM Wards;
----�����2 - ������� ������� �� �������� ��� �����.
--SELECT [Name], [Phone] FROM Doctors;
----�����3 - ������� �� ������� ��� ���������, �� ���� ����������� ������.
--SELECT DISTINCT Floor FROM Wards;
----�����4 - ������� ����� ����������� �� ���� �Name of Disease� �� ������ ����� ������� �� ���� �Severity of Disease�.
--SELECT [Name] as 'Name of Disease', [Severity] as 'Severity of Disease' FROM Diseases
----�����5 - ������� ����� ����������� �� ���� �Name of Disease� �� ������ ����� ������� �� ���� �Severity of Disease�.
--SELECT [Building] as '������', [Financing] as 'Գ����������',
--[Floor] as '������', [Name] as '�����' FROM Departments
----�����6 - ������� ����� �������, ������������ � ������ 5 �� �� ����� ���� ������������ ����� 30000.
--SELECT [Name] FROM Departments
--WHERE [Building] = 5 and [Financing] < 30000
----�����7 - ������� ����� �������, ������������ � 3-�� ������ � ������ ������������ � ������� �� 12000 �� 15000.
--select [Name] from Departments
--where [Building] = 3 and [Financing] >= 12000 and [Financing] <= 15000
----�����8 - ������� ����� �����, ������������ � �������� 4 �� 5 �� 1-�� ������.
--select [Name] FROM Wards
--where [Building] = 4 and [Building] = 5 and [Floor] = 1
----�����9 - ������� �����, ������� �� ����� ������������ �������, ������������ � �������� 3 ��� 6 �� �� ����� ���� ������������ ����� 11000 ��� ����� 25000.
--select [Name], [Building], [Financing] from Departments
--where ([Building] = 3 or [Building] = 6) and ([Financing] <= 11000 or [Financing] >= 25000)
----�����10 - ������� ������� �����, ��� �������� (���� ������ �� ��������) �������� 1500
--select [Surname] from Doctors
--where [Salary]+[Premium] > 1500
----�����11 - ������� ������� �����, � ���� �������� �������� �������� ��������� ��������.
--select [Surname] from Doctors
--where ([Salary]+[Premium])/2 > [Premium]*3
----�����12 - ������� ����� ��������� ��� ���������, �� ����������� � ����� ��� �� ����� � 12:00 �� 15:00.
--select DISTINCT [Name] from Examinations
--where DayOfWeek between 1 and 3 and StartTime = '12:00:00' and EndTime = '15:00:00'
----�����13 - ������� ����� �� ������ ������� �������, ������������ � �������� 1, 3, 8 ��� 10. 
--select [Name], [Building] from Departments
--where [Building] IN (1,3,8,10)
----�����14 - ������� ����� ����������� ��� ������� �������, ��� 1-�� �� 2-��.
--select [Name] from Diseases
--where [Severity] BETWEEN 3 and 4
----�����15 - ������� ����� �������, �� �� �������������� � 1-�� �� 3-�� ������.
--select [Name] from Departments
--where [Building] != 1 and [Building] != 3
----�����16 - ������� ����� �������, �� �������������� � 1-�� ��� 3-�� ������.
--select [Name] from Departments
--where [Building] = 1 or [Building] = 3
----�����17 - ������� ������� �����, �� ����������� �� ����� �N�.
--select [Surname] from Doctors
--WHERE Surname LIKE 'N%';

DROP TABLE [Departments]
DROP TABLE [Diseases]
DROP TABLE [Doctors]
DROP TABLE [Examinations]
DROP TABLE [Wards]
