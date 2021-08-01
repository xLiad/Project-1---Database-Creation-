
-- This is a small analysis of the database i created.
-- simply highlight every query you want to run and F5 / Execute
-- make sure to highlight and Execute USE University command first.


USE University ;

---------------------------------------
-- Query To Review The Students Table
---------------------------------------

SELECT *,
       CASE WHEN Status='Active Student' THEN A.Cost_Per_Year ELSE 0 END AS "This Year Fees"
FROM(
	SELECT s.StudentsID,
	       s.First_Name,
		   s.Last_Name,
	       s.Gender,
		   s.Email,
		   s.Phone,
		   s.City,
		   s.Address,
	       sc.School_Name,
		   sc.Cost_Per_Year,
		   s.Enrollment_Year,
          (s.Enrollment_Year+sc.Academic_Years) AS "Graduate Year",
          ((s.Enrollment_Year+sc.Academic_Years)-s.Enrollment_Year) * sc.Cost_Per_Year as "Total Tution Fees",
          CASE WHEN (s.Enrollment_Year+sc.Academic_Years) >= YEAR(Getdate()) THEN 'Active Student'
          ELSE 'Graduated' END AS "Status"
    FROM Students s JOIN Schools sc ON s.SchoolID=sc.SchoolID) A

;
--------------------------------------------------------------------------------------------------------
-- Query Showing This Year Revenue From Each School, Based On Tution Fees Of Students In The University
--------------------------------------------------------------------------------------------------------

SELECT A.School_Name ,FORMAT (SUM (A.Cost_Per_Year),'#,#.') AS "Total Revenue This Year"
FROM (
	SELECT s.StudentsID,
	       s.First_Name,
		   s.Last_Name,
	       s.Gender,
		   s.Email,
		   s.Phone,
		   s.City,
		   s.Address,
	       sc.School_Name,
		   sc.Cost_Per_Year,
		   s.Enrollment_Year,
          (s.Enrollment_Year+sc.Academic_Years) AS "Graduate_Year",
          ((s.Enrollment_Year+sc.Academic_Years)-s.Enrollment_Year) * sc.Cost_Per_Year as "Total",
          CASE WHEN (s.Enrollment_Year+sc.Academic_Years) >= YEAR(Getdate()) THEN 'Active Student'
          ELSE 'Graduated' END AS "Status"
    FROM Students S JOIN Schools SC ON (s.SchoolID = sc.SchoolID) ) A
    WHERE A.Graduate_Year > YEAR(GETDATE())
	GROUP BY A.School_Name
	ORDER BY SUM (A.Cost_Per_Year) DESC

-----------------------------------------------------------------------------
-- Query Showing How Many Active Students In The University From Each Gender 
-----------------------------------------------------------------------------

SELECT CASE WHEN S.Gender = 'F' THEN 'Female'
			WHEN S.Gender = 'M' THEN 'Male' END AS "Gender",
			COUNT (*) AS "Number of Students"
FROM Students S JOIN Schools SC ON S.SchoolID = SC.SchoolID
WHERE (S.Enrollment_Year + SC.Academic_Years) > YEAR (GETDATE())
GROUP BY S.Gender
ORDER BY [Number of Students] DESC

--------------------------------------
-- Query To Review The Schools Table
--------------------------------------

SELECT s.SchoolID,
       s.School_Name,
	   s.School_Description,
       m.First_Name+' '+m.Last_Name AS "Head Professor",
       s.Cost_Per_Year, 
	   s.Academic_Years,
       b.BuildingID,
	   b.Number_Of_Floors
FROM Schools S JOIN Management M ON (s.Head_ProfessorID = m.ManagerID) 
               JOIN Buildings B ON (s.BuildingId = b.BuildingID)



--------------------------------------
-- Query To Review The Courses Table
--------------------------------------

SELECT c.CourseID, 
       c.CourseName, 
	   sc.School_Name, 
	   c.Number_Of_Semesters,
       p.First_Name+' '+p.Last_Name AS "Professor",
       l.First_Name+' '+l.Last_Name AS "Lecturer",
       co.First_Name+' '+co.Last_Name AS "Counselr"
FROM Courses C JOIN Professors p ON (c.ProfessorID = p.ProfessorID)
               JOIN Lecturers L ON (c.LecturerID = l.LecturerID) 
			   JOIN Counselors co ON (c.CounselorID = co.CounselorID)
               JOIN Schools sc ON (c.SchoolID = sc.SchoolID)

---------------------------------------------------
-- Query To Show Number of Courses In Each School
---------------------------------------------------

SELECT sc.School_Name, COUNT(*) AS "Number of Courses"
FROM Courses C JOIN Professors p ON (c.ProfessorID = p.ProfessorID)
               JOIN Lecturers L ON (c.LecturerID = l.LecturerID) 
			   JOIN Counselors co ON (c.CounselorID = co.CounselorID)
               JOIN Schools sc ON (c.SchoolID = sc.SchoolID)
GROUP BY sc.School_Name
ORDER BY [Number of Courses] DESC


---------------------------------------
-- Query To Review The Professors Table
---------------------------------------

SELECT p.ProfessorID,
       p.First_Name,
	   p.Last_Name,
       p.Gender,
	   p.Email,
	   p.Phone,
	   p.City,
	   p.Address,
       p.Academic_Degree,
	   s.School_Name,
	   p.Monthly_Salary,
	   p.Hire_Date
FROM Professors p JOIN Schools s ON (p.SchoolID = s.SchoolID)

----------------------------------------------------------
-- Query Showing What Academic Degrees The Professors Have
----------------------------------------------------------

SELECT p.Academic_Degree, COUNT (*) AS "Number of Professors With This Degree"
FROM Professors p JOIN Schools s ON (p.SchoolID = s.SchoolID)
GROUP BY P.Academic_Degree
ORDER BY [Number of Professors With This Degree] DESC

----------------------------------------------------------
-- Query Showing How Many Professors Were Hired Each Year
----------------------------------------------------------

SELECT YEAR(p.Hire_Date) AS "Year", COUNT (*) AS "Number of Professors Hired That Year"
FROM Professors p JOIN Schools s ON (p.SchoolID = s.SchoolID)
GROUP BY YEAR(p.Hire_Date)
ORDER BY YEAR(p.Hire_Date) DESC

----------------------------------------------------------
-- Query Showing How Many Professors In Each School
----------------------------------------------------------

SELECT s.School_Name, COUNT (*) AS "Number of Professors"
FROM Professors p JOIN Schools s ON (p.SchoolID = s.SchoolID)
GROUP BY s.School_Name
ORDER BY [Number of Professors] DESC

---------------------------------------
-- Query To Review The Lecturers Table
---------------------------------------

SELECT l.LecturerID,
       L.First_Name,
	   L.Last_Name,
       l.Gender,
	   l.Email,
	   l.Phone,
	   l.City,
	   l.Address,
       l.Academic_Degree,
	   s.School_Name,
	   l.Monthly_Salary,
	   l.Hire_Date
FROM Lecturers L JOIN Schools s ON (L.SchoolID = s.SchoolID)

---------------------------------------
-- Query To Review The Counselors Table
---------------------------------------

SELECT c.CounselorID,
       c.First_Name, 
       c.Last_Name,
       c.Gender,
       c.Email,
       c.Phone, 
       c.City,
       c.Address, 
       s.School_Name,
       c.Monthly_Salary,
       c.Hire_Date
FROM Counselors c JOIN Schools s ON (c.SchoolID = s.SchoolID)

---------------------------------------------
-- Query To Review The University Staff Table
---------------------------------------------

SELECT s.StaffID,
       s.First_Name,
       s.Last_Name,
       s.Job_Title,
       m.First_Name+' '+m.Last_Name AS "Manager",
       m.ManagerID,
       s.Gender,
       s.Email, 
       s.Phone,
       s.city,
       s.Address,
       s.Monthly_Salary,
       s.Hire_Date
FROM Staff S JOIN Management M ON (s.ReportsTo = m.ManagerID)

----------------------------------------------------------------------------
-- Query Showing The Monthly Expenses On Each Kind of Job In The University
----------------------------------------------------------------------------

SELECT s.Job_Title, FORMAT (SUM (s.Monthly_Salary),'#,#') AS "Total Monthly Expenses"
FROM Staff S JOIN Management M ON (s.ReportsTo = m.ManagerID)
GROUP BY s.Job_Title
ORDER BY [Total Monthly Expenses] DESC

---------------------------------------------
-- Query To Review The Building Table
---------------------------------------------

SELECT *
FROM Buildings

-----------------------------------
-- Query To Review The Rooms Table
-----------------------------------

SELECT r.RoomID,
       r.Floor,
	   r.Capacity,
	   b.BuildingID,
	   b.Building_Description,
	   b.Number_Of_Floors
FROM Rooms R JOIN Buildings B ON (r.BuildingID = b.BuildingID)

-------------------------------------------------------------------
-- Query Showing What Is The Capacity of People Each Building Has
-------------------------------------------------------------------

SELECT b.BuildingID, SUM (R.Capacity) AS "Total Capacity"
FROM Rooms R JOIN Buildings B ON (r.BuildingID = b.BuildingID)
GROUP BY B.BuildingID
ORDER BY [Total Capacity] DESC

-------------------------------------------------------------
-- Query Showing How Many Rooms Are Dedicated To Each School
-------------------------------------------------------------

SELECT b.Building_Description, COUNT (*) AS "Total Rooms"
FROM Rooms R JOIN Buildings B ON (r.BuildingID = b.BuildingID)
GROUP BY b.Building_Description
ORDER BY [Total Rooms] DESC

-------------------------------------
-- Query To Review The Library Table
-------------------------------------

SELECT l.BookID, 
       l.Book_Name,
	   l.Topic,
	   l.Number_Of_Pages,
	   l.Area
FROM Libary L JOIN Schools S ON (l.SchoolID = s.SchoolID)

--------------------------------------------------------------------------
-- Query Showing The Avreage Number of Pages Each Book Has Based On Topic
--------------------------------------------------------------------------

SELECT l.Topic, AVG (l.Number_Of_Pages) AS "Avreage Number Of Pages"
FROM Libary L JOIN Schools S ON (l.SchoolID = s.SchoolID)
GROUP BY L.Topic
ORDER BY [Avreage Number Of Pages] DESC

-------------------------------------
-- Query To Review The Managment Table
-------------------------------------

SELECT ManagerID,
       First_Name+' '+Last_Name AS "Manager Name",
       Role,
	   Gender,
	   Email,
	   Phone,
	   Address+','+' '+City AS "Address",
       Monthly_Salary, 
	   Hire_Date
FROM Management

-----------------------------------------------------------------
-- Query To Calcuate The Total Monthly Expanses of The University 
-----------------------------------------------------------------
;

DECLARE @PMS INT,
        @LMS INT,
		@CMS INT,
		@SMS INT,
		@MMS INT,
		@TotalMonthlyExpanses INT

SELECT @PMS = SUM (Monthly_Salary)
FROM Professors

SELECT @LMS = SUM (Monthly_Salary)
FROM Lecturers

SELECT @CMS = SUM (Monthly_Salary)
FROM Counselors

SELECT @SMS = SUM (Monthly_Salary)
FROM Staff

SELECT @MMS = SUM (Monthly_Salary)
FROM Management

SET @TotalMonthlyExpanses = @PMS + @LMS + @CMS + @SMS + @MMS

PRINT '------------------------------------------------'
PRINT 'The Total Monthly Expanses Of The University  '  
PRINT @TotalMonthlyExpanses
PRINT '------------------------------------------------'

-------------------------------------------------------------------------
-- THE END 
-------------------------------------------------------------------------