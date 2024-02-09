

--CREATE TABLE EmployeeDemo 
--(EmployeeID int,
--FirstName varchar,
--LastName varchar,
--Age int,
--Gender varchar)

--INSERT INTO EmployeeDemographics VALUES 
-- (1002,'Pam', 'Beasley', 30, 'Female'),
-- (1003,'Dwight', 'Schrute', 29, 'Male'),
-- (1004,'Angela', 'Martin', 31, 'Female'),
-- (1005,'Toby', 'Flenderson', 32, 'Male'),
-- (1006,'Michael', 'Scott', 35, 'Male'),
-- (1007,'Meredith', 'Palmer', 32, 'Female'),
-- (1008,'Stanley', 'Hudson', 38, 'Male'),
-- (1009,'Kevin', 'Malone', 31, 'Male')

--INSERT INTO EmployeeSalary VALUES
--(1001,'Salesman', 45000),
--(1002,'Receptionist', 36000),
--(1003,'Salesman', 63000),
--(1004,'Accountant', 47000),
--(1005,'HR', 50000),
--(1006,'Regional Manager', 65000),
--(1007,'Supplier Relations', 41000),
--(1008,'Salesman', 48000),
--(1009,'Accountant', 42000)

--SELECT * FROM EmployeeDemographics
--SELECT TOP 5 * FROM EmployeeDemographics
--SELECT DISTINCT(Gender) from EmployeeDemographics
--SELECT COUNT(LastName) AS LastNameCount FROM EmployeeDemographics
--SELECT * FROM EmployeeSalary
--SELECT MAX(Salary) AS MaxSalary FROM EmployeeSalary
--SELECT MIN(Salary) AS MinSalary FROM EmployeeSalary
--SELECT AVG(Salary) AS AvgSalary FROM EmployeeSalary

--SELECT * FROM EmployeeDemographics WHERE FirstName != 'Jim'
--SELECT * FROM EmployeeDemographics WHERE Gender = 'Male' AND AGE > 30
--SELECT * FROM EmployeeDemographics WHERE LastName LIKE '%son' AND LastName LIKE '%der%'

--SELECT * FROM EmployeeDemographics WHERE AGE is NOT NULL
--SELECT * FROM EmployeeDemographics WHERE LastName IN ('Schrute', 'Halpert')

--SELECT Gender,Age, COUNT(Gender) 
--AS GenderCount 
--FROM EmployeeDemographics 
--WHERE Age > 30
--GROUP BY Gender, Age
--ORDER BY 2 DESC, 1 DESC

--SELECT * FROM EmployeeDemographics WHERE (Gender = 'Male' AND FirstNAME LIKE 'J%') OR FirstName LIKE 'M%' ORDER BY Age DESC
--SELECT * FROM EmployeeDemographics WHERE NOT FirstName  = 'Jim'
--SELECT * FROM EmployeeDemographics WHERE FirstName NOT LIKE 'J%'
--SELECT * FROM EmployeeDemographics WHERE Age NOT BETWEEN 27 AND 30

-- UPDATE SYNTAX

--INSERT INTO EmployeeDemographics(FirstName,LastName,Gender) VALUES ('Daniel','Olajubu', 'Male')
--UPDATE EmployeeDemographics SET EmployeeID = 1010, Age = 27 WHERE Age IS NULL
--DELETE FROM EmployeeDemographics WHERE FirstName = 'Daniel'

--SELECT TOP 4 FirstName, LastName FROM EmployeeDemographics

--SELECT TOP 5 FirstName FROM EmployeeDemographics ORDER BY FirstName
--SELECT * FROM EmployeeDemographics WHERE Age > (SELECT AVG(Age) FROM EmployeeDemographics)

--SELECT FirstName FROM EmployeeDemographics WHERE FirstName LIKE 'M_r%'
--SELECT LastName FROM EmployeeDemographics WHERE LastName LIKE '[sb]%'
--SELECT LastName FROM EmployeeDemographics WHERE LastName LIKE '[a-f]%'

--SELECT * FROM EmployeeDemographics WHERE EmployeeID IN (SELECT EmployeeID FROM EmployeeSalary WHERE Salary > 50000)
--SELECT * FROM EmployeeDemographics AS E,EmployeeSalary AS S WHERE E.EmployeeID = S.EmployeeID AND S.Salary > 50000
--SELECT FirstName + ' ' + LastName AS [Full Names] FROM EmployeeDemographics
--SELECT FirstName FROM EmployeeDemographics WHERE FirstName not LIKE '[jks]%' OR FirstName not LIKE '%[mly]'

--WITH CTE_Person AS (SELECT *,COUNT(*) OVER () AS Cnt,ROW_NUMBER() OVER(ORDER BY Salary) AS row_num FROM EmployeeSalary)

--SELECT Salary AS median_Salary FROM CTE_Person WHERE row_num IN (FLOOR((Cnt+1)/2),FLOOR((Cnt+2)/2));

--SELECT AVG(Salary) AS 'Average Salary' FROM EmployeeDemographics
--INNER JOIN EmployeeSalary ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
--WHERE EmployeeSalary.JobTitle = 'Salesman'

--CASE STATEMENT
--SELECT FirstName + ' ' + LastName AS 'Full Name', JobTitle, Salary,
--CASE 
--	WHEN JobTitle = 'Salesman' THEN Salary + (Salary * 0.10)
--	WHEN JobTitle = 'HR' THEN Salary + (Salary * 0.05)
--	ELSE Salary
--END AS 'New Salary'
--FROM EmployeeDemographics
--INNER JOIN EmployeeSalary ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID

--HAVING CLAUSE

--SELECT JobTitle, Count(JobTitle)
--FROM EmployeeDemographics
--INNER JOIN EmployeeSalary ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
--GROUP BY JobTitle
--HAVING Count(JobTitle) > 1
--ORDER BY Count(JobTitle)

--SELECT * FROM EmployeeDemographics
--INSERT INTO EmployeeDemographics(FirstName,LastName) VALUES ('Oluwapelumi', 'Arubuola')
--DELETE FROM EmployeeDemographics
--WHERE Age IS NULL AND FirstName = 'Oluwapelumi'
--UPDATE EmployeeDemographics
--SET EmployeeID = 1011, Age = 24, Gender = 'Female'
--WHERE FirstName = 'Oluwapelumi'

--WITH CTE_Details AS ( SELECT FirstName+' '+LastName AS 'Full Name', JobTitle, Count(Gender) OVER (PARTITION BY Gender) AS 'Gender Count'
--FROM EmployeeDemographics
--INNER JOIN EmployeeSalary ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
--)
--SELECT * FROM CTE_Details ORDER BY 'Full Name'#

-- TEMP TABLES
--DROP TABLE IF EXISTS #Temp_Details
--CREATE TABLE #Temp_Details (
--FullName varchar(100),
--JobTitle varchar(100),
--GenderCount int )

--INSERT INTO #Temp_Details
--SELECT FirstName+' '+LastName AS 'Full Name', JobTitle, Count(Gender) OVER (PARTITION BY Gender) AS 'Gender Count'
--FROM EmployeeDemographics
--INNER JOIN EmployeeSalary ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
--ORDER BY 'Full Name'

--SELECT * FROM #Temp_Details

--CREATE TABLE EmployeeErrors (
--EmployeeID varchar(50),
--FirstName varchar(50),
--LastName varchar(50)
--)

--Insert into EmployeeErrors Values 
--('1001  ', 'Jimbo', 'Halpert'),
--('  1002','Pamela', 'Beasley'),
--('1005','TOby', 'Flenderson - Fired')

--SELECT * FROM [SQL Tutorial].dbo.EmployeeErrors
--UPDATE EmployeeErrors SET LastName = REPLACE(LastName,'- Fired','') WHERE FirstName = 'TOby'

--STORED PROCEDURE

--CREATE PROCEDURE Fuzzy_Match
--AS
--SELECT *
--FROM EmployeeErrors err
--INNER JOIN EmployeeDemographics dem
--ON err.EmployeeID = dem.EmployeeID
--WHERE SUBSTRING(err.FirstName,1,4) =  SUBSTRING(dem.FirstName,1,4)

--EXEC Fuzzy_Match @FirstName = 'Jimbo'
--SELECT EmployeeID,Salary, (Select AVG(Salary) From EmployeeSalary) FROM EmployeeSalary

--Subqueries
Select EmployeeID, JobTitle,Salary
from EmployeeSalary
where EmployeeID in (
		Select EmployeeID 
		from EmployeeDemographics 
		where Age > 30)


