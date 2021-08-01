-- Data base creation

USE master;

IF exists 
		(SELECT *
		FROM sys.databases
		WHERE name = 'University')
		DROP database University

GO

Create Database University

GO

USE University

-- Table Creation

GO

-- Students Table Creation

Create Table Students
(
StudentsID varchar(9) primary key,
First_Name varchar(30) not null,
Last_Name varchar(30) not null,
Gender varchar(1) Constraint Check_Gender_Stud check (Gender in('F','M')),
Email varchar(30) unique 
Constraint Check_Email_Stud check (Email like '%@%' and Email like '%.%'),
Phone varchar(10) unique Constraint Check_Phone_Stud check (Phone not like '%[a-z]%'),
City varchar(30),
Address varchar(30),
Enrollment_Year Varchar(4) Constraint Check_Enrollment_Year_Stud
check (Year(Enrollment_Year)>1995 and Enrollment_Year not like '%[a-z]%')
)

GO

-- Schools Table Creation

Create Table Schools
(
SchoolID varchar(3) primary key,
School_Name varchar(30) not null unique,
School_Description varchar(30)
)

GO

-- Professors Table Creation

Create Table Professors 
(
ProfessorID varchar(5) primary key
Constraint Check_ProfessorID check(ProfessorID like 'P-%___'),
First_Name varchar(30) not null,
Last_Name varchar(30) not null,
Gender varchar(1) Constraint Check_Gender_Prof check (Gender in('F','M')),
Email varchar(30) unique
Constraint Check_Email_Prof check (Email like '%@%' and Email like '%.%'),
Phone varchar(10) unique
Constraint Check_Phone_Prof check (Phone not like '%[a-z]%'),
City varchar(30),
Address varchar(30),
Academic_Degree Varchar(10) not null,
Monthly_Salary money default 5300,
Hire_Date date
)

GO

-- Courses Table Creation

Create Table Courses
(
CourseID varchar(7) primary key constraint Check_CourseID check (CourseID like '___-___'),
CourseName varchar(30) not null unique,
Number_Of_Semesters Varchar(2) not null
)

GO

-- Lecturers Table Creation

Create Table Lecturers
(
LecturerID Varchar(5) primary key
constraint Check_LecturerID check (LecturerID like 'L-%___'),
First_Name varchar(30) not null,
Last_Name varchar(30) not null,
Gender varchar(1) Constraint Check_Gender_Lect check (Gender in('F','M')),
Email varchar(30) unique
Constraint Check_Email_Lect check (Email like '%@%' and Email like '%.%'),
Phone varchar(10) unique
Constraint Check_Phone_Lect check (Phone not like '%[a-z]%'),
City varchar(30),
Address varchar(30),
Academic_Degree Varchar(10) not null,
Monthly_Salary money default 5300,
Hire_Date date
)

GO

-- Counselors Table Creation

Create Table Counselors
(
CounselorID varchar(5) primary key
constraint Check_CounselorID check (CounselorID like 'C-%___'),
First_Name varchar(30) not null,
Last_Name varchar(30) not null,
Gender varchar(1) Constraint Check_Gender_Counselor check (Gender in('F','M')),
Email varchar(30) unique
Constraint Check_Email_Counselor check (Email like '%@%' and Email like '%.%'),
Phone varchar(10) unique
Constraint Check_Phone_Counselor check (Phone not like '%[a-z]%'),
City varchar(30),
Address varchar(30),
Monthly_Salary money default 5300,
Hire_Date date
)

GO

-- University Staff Table Creation

Create Table Staff
(
StaffID varchar(9) primary key,
First_Name varchar(30) not null,
Last_Name varchar(30) not null,
Job_Title Varchar(30) not null,
Gender varchar(1) Constraint Check_Gender_Staff check (Gender in('F','M')),
Email varchar(30) unique
Constraint Check_Email_Staff check (Email like '%@%' and Email like '%.%'),
Phone varchar(10) unique
Constraint Check_Phone_Staff check (Phone not like '%[a-z]%'),
City varchar(30),
Address varchar(30),
Monthly_Salary money default 5300,
Hire_Date date
)

GO

-- Buildings Table Creation

Create Table Buildings
(
BuildingID varchar(2) primary key,
Building_Type varchar(30) constraint Check_Building_Type 
check (Building_Type in('Managment','Staff','School','Other')),
Building_Description varchar(30),
Number_Of_Floors varchar(2)
)

GO

-- Rooms Table Creation

Create Table Rooms
(
RoomID varchar(5) primary key 
constraint Check_RoomID check(RoomID like '[a-z]-%__'),
Floor varchar(2),
Capacity int
)

GO

-- Libary Table Creation

Create Table Libary
(
BookID int identity (1,1) primary key,
Book_Name Varchar(30) not null,
Topic Varchar(30),
Number_Of_Pages int,
Area varchar(2)
)

GO

-- Managment Table Creation

Create Table Management
(
ManagerID Varchar(5) primary key 
Constraint Check_ManagerID check (ManagerID like 'M-%___'),
First_Name varchar(30) not null,
Last_Name varchar(30) not null,
Role varchar(20),
Gender varchar(1) Constraint Check_Gender_Management check (Gender in('F','M')),
Email varchar(30) unique
Constraint Check_Email_Management check (Email like '%@%' and Email like '%.%'),
Phone varchar(10) unique
Constraint Check_Phone_Management check (Phone not like '%[a-z]%'),
City varchar(30),
Address varchar(30),
Monthly_Salary money default 5300,
Hire_Date date
)

GO


-- Adding Foreign Keys to tables

Alter Table Students
add SchoolID varchar(3) foreign key (SchoolID) references Schools (SchoolID)

GO

Alter Table Schools
add ManagerID varchar(5) foreign key (ManagerID) references Management (ManagerID)

GO 

Alter Table Schools
add BuildingId varchar(2) foreign key (BuildingId) references Buildings (BuildingId)

GO

Alter Table Courses
add ProfessorID varchar(5) foreign key (ProfessorID) references Professors (ProfessorID)

GO

Alter Table Courses
Add LecturerID Varchar(5) foreign key (LecturerID) references Lecturers (LecturerID)

GO

Alter Table Courses
Add CounselorID varchar(5) foreign key (CounselorID) references Counselors (CounselorID)

GO

Alter Table Professors
add SchoolID varchar(3) foreign key (SchoolID) references Schools (SchoolID)

GO

Alter Table Lecturers
add SchoolID varchar(3) foreign key (SchoolID) references Schools (SchoolID)

GO

Alter Table Counselors
add SchoolID varchar(3) foreign key (SchoolID) references Schools (SchoolID)

GO

Alter Table Rooms
add BuildingID varchar(2) foreign key (BuildingID) references Buildings (BuildingID)

GO

Alter Table Staff
add ManagerID varchar(5) foreign key (ManagerID) references Management (ManagerID)

GO

-- Name Change for some Foreign Key columns

Sp_ReName 'Staff.ManagerID', 'ReportsTo', 'Column'

GO 

Sp_ReName 'Schools.ManagerID', 'Head_ProfessorID', 'Column'

GO

-- Altering some tables adding some more neseccary columns

Alter Table Libary
add SchoolID varchar(3) foreign key (SchoolID) references Schools (SchoolID)


GO

Alter Table Schools
add Cost_Per_Year money default 10000

GO

Alter Table Schools
add Academic_Years int default (3)

GO

-- Insering data to tables


insert into Management values 

-- (ManagerID, First_Name, Role, Gender, Email, Phone, City, Address, Salary, Hire_Date)

('M-019','Liad','Levi','President','M','Liad019@University.com','0403772890',
'Kiryat Motzkin','Ansho 3',100000,'2008-07-19'),

('M-064','Suzy','Chang','Vice President','F','Suzy064@University.com','0403442290',
'Haifa','Effo 7',32000,'2009-08-13'),

('M-097','David','Stern','CFO','M','David097@University.com','0403772899',
'Herzliya','Shalom Alihem 11',17000,'2017-02-26'),

('M-103','Abigail','Cohen','Dean of Students','F','Abigail103@University.com','0403272895',
'Haifa','Ehed Am 101',16000,'2016-03-19'),

('M-303','Richard','Pink','HR Manager','M','Richard303@University.com','0423774891',
'Kiryat Haim','Agdola 22',16000,'2011-07-03'),

('M-334','Anna','McDean','Libary Manager','F','Anna334@University.com','0401752891',
'Tel Aviv','Yera 11',15670,'2010-05-08'),

('M-220','Avi','Abitbul','Marketing Director','M','Avi220@University.com','0423752390',
'Karmiel','Ferol 11',16320,'2016-01-15'),

('M-101','Sara','Levi','Director of Finance','F','Sara101@University.com','0403572195',
'Natanya','Anilevitz 5',16890,'2014-03-26'),

('M-443','Kara','Burns','Business Department','F','Kara443@University.com','0403442820',
'Rehovot','Baruch 10',12005,'2011-01-15'),

('M-285','Jac','Davies','Medicine Department','M','Jac285@University.com','0453712340',
'Kiryat Motzkin','Ein Eli 2',13250,'2010-04-23'),

('M-139','Kaydan','Fitzgerald','Art Department','M','Kaydan139@University.com','0402762690',
'Herzliya','Marom 12',13250,'2013-02-15'),

('M-234','Reid','Wallis','Comms Department','M','Reid234@University.com','0423374810',
'Tel Aviv','Ben Galim 3',15200,'2012-06-12'),

('M-190','Arnie','Bouvet','Education Department','M','Arnie190@University.com','0423132891',
'Jerusalem','Avda 5',14320,'2017-11-11'),

('M-448','Naima','Bonnila','Law Department','F','Naima448@University.com','0423732530',
'Rehovot','Maliga 8',12600,'2016-10-25'),

('M-901','Yoav','Sinai','Science Department','M','Yoav901@University.com','0421772532',
'Karmiel','Detter 12',11570,'2015-08-29')


GO


insert into Buildings values 

-- (BuildingID, Building_Type, Building_Description, Number_of_Floors)

('A','Managment','Adminstratiton Building','3'),
('B','Staff','Marketing and HR','2'),
('C','Staff','Utility','2'),
('D','Other','Auditorium','1'),
('E','Other','Cafeteria','1'),
('F','School','Medicine Building','3'),
('G','School','Art Building','2'),
('H','School','Buisness Building','3'),
('I','School','Communications Building','2'),
('J','School','Education Building','2'),
('K','School','Law Building','3'),
('L','School','Science Building','3'),
('M','Other','Libary','2')


GO


insert into Rooms values

-- (RoomID, Floor, Capacity, BuildingID) 

('F-10','1',25,'F'),
('F-11','1',30,'F'),
('F-12','1',15,'F'),
('F-13','1',22,'F'),
('F-14','1',30,'F'),
('F-20','2',25,'F'),
('F-21','2',18,'F'),
('F-22','2',18,'F'),
('F-23','2',30,'F'),
('F-24','2',25,'F'),
('F-30','3',28,'F'),
('F-31','3',20,'F'),
('F-32','3',35,'F'),

('G-10','1',32,'G'),
('G-11','1',25,'G'),
('G-12','1',30,'G'),
('G-13','1',18,'G'),
('G-20','2',25,'G'),
('G-21','2',35,'G'),
('G-22','2',31,'G'),
('G-23','2',25,'G'),
('G-24','2',27,'G'),

('H-10','1',18,'H'),
('H-11','1',18,'H'),
('H-12','1',22,'H'),
('H-13','1',40,'H'),
('H-14','1',27,'H'),
('H-15','1',18,'H'),
('H-20','2',30,'H'),
('H-21','2',24,'H'),
('H-22','2',22,'H'),
('H-23','2',27,'H'),
('H-24','2',18,'H'),
('H-25','2',32,'H'),
('H-30','3',40,'H'),
('H-31','3',27,'H'),
('H-32','3',25,'H'),
('H-33','3',25,'H'),
('H-34','3',32,'H'),
('H-35','3',30,'H'),

('I-10','1',40,'I'),
('I-11','1',18,'I'),
('I-12','1',28,'I'),
('I-20','2',25,'I'),
('I-21','2',25,'I'),

('J-10','1',30,'I'),
('J-11','1',18,'I'),
('J-12','1',18,'I'),
('J-20','2',25,'I'),
('J-21','2',35,'I'),
('J-22','2',35,'I'),

('K-10','1',19,'K'),
('K-11','1',16,'K'),
('K-12','1',22,'K'),
('K-13','1',30,'K'),
('K-14','1',27,'K'),
('K-15','1',18,'K'),
('K-20','2',20,'K'),
('K-21','2',25,'K'),
('K-22','2',22,'K'),
('K-23','2',23,'K'),
('K-24','2',18,'K'),
('K-25','2',22,'K'),
('K-30','3',40,'K'),
('K-31','3',27,'K'),
('K-32','3',25,'K'),
('K-33','3',25,'K'),
('K-34','3',32,'K'),
('K-35','3',20,'K'),

('L-10','1',30,'L'),
('L-11','1',18,'L'),
('L-12','1',18,'L'),
('L-20','2',25,'L'),
('L-21','2',35,'L'),
('L-22','2',35,'L'),

('M-10','1',20,'M'),
('M-11','1',18,'M'),
('M-12','1',28,'M'),
('M-20','2',35,'M'),
('M-21','2',35,'M'),
('M-22','2',27,'M')


GO

insert into Schools (SchoolID,School_Name,School_Description,Head_ProfessorID,BuildingId) values

--(SchoolID, School_Name, School_Description, Head_ProfessorID, BuildingID) 

('101','Medicine',null,'M-285','F'),
('102','Art',null,'M-139','G'),
('103','Business',null,'M-443','H'),
('104','Communications',null,'M-234','I'),
('105','Education',null,'M-190','J'),
('106','Law',null,'M-448','K'),
('107','Science',null,'M-901','L')


GO

insert into Libary values 

--(Book_Name, Topic, Number_of_Pages, Area)

('Why We Sleep','Health and Medicine',234,'A','101'),
('Fast Feast Repeat','Health and Medicine',155,'A','101'),
('Brain','Health and Medicine',322,'A','101'),
('No More Crab','Health and Medicine',142,'A','101'),
('Liver Rescue','Health and Medicine',211,'A','101'),
('Nursing 101','Health and Medicine',164,'A','101'),
('Celery Juice','Health and Medicine',321,'A','101'),
('Plague','Health and Medicine',153,'A','101'),
('Real Food Pregnancy','Health and Medicine',201,'A','101'),
('Beyond The Pill','Health and Medicine',211,'A','101'),
('Health Gut Zone','Health and Medicine',142,'A','101'),

('Ways of Seeing','Art',164,'B','102'),
('On Photography','Art',136,'B','102'),
('Modern Artifacts','Art',209,'B','102'),
('Abstract Art','Art',234,'B','102'),
('The Avant-Grade','Art',178,'B','102'),
('Oberlin Drawings','Art',152,'B','102'),

('Atomic Habits','Business',122,'C','103'),
('Think Again','Business',179,'C','103'),
('Big Money Energy','Business',209,'C','103'),
('Rich Dad Poor Dad','Business',165,'C','103'),
('Think and Grow Rich','Business',340,'C','103'),
('Change Your World','Business',180,'C','103'),
('7 High Effecitve People','Business',142,'C','103'),
('The Millionaire Next Door','Business',287,'C','103'),

('Caste','Communications',105,'D','104'),
('Hate Inc','Communications',122,'D','104'),
('Harvey The Heart','Communications',198,'D','104'),
('Fragile','Communications',209,'D','104'),
('Attached','Communications',150,'D','104'),

('Me and My Feelings','Education',260,'E','105'),
('Anger Managment for Kids','Education',153,'E','105'),
('How to Make Kids Listen','Education',206,'E','105'),
('What to Except','Education',245,'E','105'),

('The Rule of Law','Law',230,'F','106'),
('Justice is Wilderness','Law',432,'F','106'),
('Color of Law','Law',457,'F','106'),
('The FBI Way','Law',287,'F','106')


GO

insert into Staff values

--(StaffID, First_Name, Last_Name, Job_Title, Gender, Email, Phone, City, Address, Salary, Hire_Date)

('413464021','Matteo','Albert','Marketing','M','afer10@Email.com','0623552830','Haifa','Begin 25',6300,'2016-04-15','M-220'),
('426459031','Aarush','Lozano','Marketing','M','asdad89@Email.com','0603742140','Tel Aviv','Haim 15',6300,'2017-03-22','M-220'),
('456469476','Sienna','Hopkins','Marketing','F','whate23@Email.com','0602732870','Jerusalem','Cero 32',6300,'2019-05-27','M-220'),
('486467073','Honor','Cairns','Cafeteria','F','deel93@Email.com','0612452324','Jerusalem','Kal 41',Default,'2019-07-12','M-303'),
('432366051','Jaydan','Becker','Cafeteria','M','jeol9@Email.com','0633352893','Haifa','Retor 18',Default,'2015-01-05','M-303'),
('412463060','Zack','Aarons','Janitor','M','heiro39@Email.com','0643752631','Haifa','Deli 22',Default,'2019-01-09','M-303'),
('443409071','Nabeel','Wolfgate','Janitor','M','isitske3@Email.com','0613742890','Tel Aviv','Llama 7',Default,'2021-01-01','M-303'),
('403449271','Riyad','Rosales','Gardner','M','nevr30@Email.com','0623553890','Rehovot','Betor 31',6000,'2019-03-17','M-303'),
('421459031','Kelsey','Yates','Secretary','F','terw2@Email.com','0633472811','Karmiel','Nirim 13',5900,'2015-06-12','M-303'),
('441439278','Aidan','Bowman','Security','M','hdasda3@Email.com','0653475830','Sderot','Shalom 62',6300,'2017-08-13','M-303'),
('406269035','Tonicha','Williams','Secretary','F','trexx44@Email.com','0623332590','Tel Aviv','Katan 21',5900,'2018-09-22','M-303'),
('452365121','Gething','Madden','Secretary','F','mndw234@Email.com','0633232490','Haifa','Trevor 18',5900,'2017-11-24','M-303'),
('413465271','Lacey','Daniels','Cafeteria','F','rewqw884@Email.com','0603332540','Jerusalem','Jeopard 14',Default,'2019-12-26','M-303'),
('406409071','Daniel','Haim','Security','M','nbed32w@Email.com','0613732250','Kfar Vradim','Ein-Eli 19',6300,'2019-10-11','M-303'),
('415369871','Oliver','Mostly','Security','M','fdw22s@Email.com','0623372530','Binyamina','Mevot 13',Default,'2018-11-09','M-303'),
('438468070','Haydon','Sanders','Janitor','M','deer23@Email.com','0673372810','Herzeliya','Tafkitidom 17',Default,'2017-10-05','M-303'),
('406469071','Marnie','Cooley','Janitor','M','grews366@Email.com','0634752691','Haifa','Yahalom 12',Default,'2018-05-29','M-303'),
('466469071','Luc','Tanner','Janitor','M','23213c@Email.com','0621721890','Kiryat Ata','Tikva 19',Default,'2016-02-18','M-303'),
('476459071','Kanye','West','Gardner','M','bedcd@Email.com','0646372820','Maalot','Liad 32',Default,'2016-05-11','M-303'),
('436467071','David','Brooks','Security','M','xsed3@Email.com','0634762390','Kiryat Yam','Sapphire 9',6300,'2017-08-07','M-303'),
('416449071','Aisha','Alaric','Librarian','F','hae3@Email.com','0623514890','Sderot','Halomot 3',6250,'2018-09-19','M-334'),
('456869071','John','Brown','Librarian','M','nacde@Email.com','0613312860','Jerusalem','Derech 4',6250,'2018-02-17','M-334'),
('426169771','Imani','Ford','Librarian','F','eeqwss@Email.com','0643244810','Rehovot','Mom 16',6250,'2018-01-12','M-334'),
('416868071','Faith','Levi','Marketing','F','ttreewq@Email.com','0643244210','Kiryat Ata','Begin 27',Default,'2019-03-27','M-220'),
('416467051','Jessica','Reed','Janitor','F','ddcdc65@Email.com','0633732890','Tel Aviv','Sintra 36',Default,'2017-06-29','M-303')


GO


insert into Counselors values

--(CounselorID, First_Name, Last_Name, Gender, Email, Phone, City, Address, Salary, Hire_Date)

('C-102','Lucie','Fisher','F','Lucie102@University.com','0323471890','Tel Aviv','Ben Hur 14',7500,'2017-02-07','101'),
('C-202','Margo','Cruz','F','Margo202@University.com','0343222850','Haifa','Begin 28',6780,'2018-06-30','101'),
('C-331','Kaison','Lamela','F','Kaison331@University.com','0314752290','Maalot','Menshra 21',9860,'2019-04-28','102'),
('C-421','Lila','Naji','F','Lile421@University.com','0323473810','Kfar Vradim','Tzefa 07',6490,'2020-06-21','102'),
('C-221','Nancy','Baxter','F','Nancy221@University.com','0313722193','Haifa','Tova 03',6320,'2016-08-11','103'),
('C-109','Ross','Wyatt','M','Ross109@University.com','0323232491','Kiryat Biyalik','Shalom 05',7120,'2018-11-06','103'),
('C-304','Opal','Pickett','F','Opal304@University.com','0313432520','Jerusalem','Derech 02',7890,'2017-12-12','104'),
('C-988','Roan','Ward','M','Roan988@University.com','0340672590','Herzeliya','Malim 21',6540,'2018-11-19','104'),
('C-732','Manha','Destiny','F','Manha732@University.com','0313072320','Tel Aviv','Sasson 43',8990,'2016-10-28','105'),
('C-105','Tyrese','Fern','M','Tyrese105@University.com','0335762160','Karmiel','Kelkoli 57',6570,'2019-07-21','105'),
('C-272','Donald','Cohen','M','Donald272@University.com','0353172391','Kiryat Ata','Yaffo 29',6980,'2018-08-12','106'),
('C-819','Benjamin','Botton','M','Benjamin819@University.com','0323176990','Akko','Halomot 81',7490,'2018-09-06','106'),
('C-326','Richard','Chear','M','Richard326@University.com','0313772842','Kiryat Shmona','Barim 17',8790,'2018-03-05','107'),
('C-429','Abrahm','Haim','M','Abrahm429@University.com','0323713260','Dimona','Merina 14',7650,'2020-05-09','107')


GO


insert into Lecturers values

--(LecurerID, First_Name, Last_Name, Gender, Email, Phone, City, Address, Academic_Degree ,Salary, Hire_Date)

('L-245','David','Kfir','M','David245@University.com','0233352810','Jerusalem','Tavorim 12','BA',8900,'2017-07-01','101'),
('L-321','Aaron','Levi','M','Aaron321@University.com','0241232515','Tel Aviv','Maromim 8','BA',9400,'2016-08-06','101'),
('L-102','Marie','Cohen','F','Marie102@University.com','0212723813','Haifa','Sardinim 6','MA',7900,'2015-05-13','102'),
('L-142','Hen','Stifler','M','Hen142@University.com','0253112812','Sderot','Kibutz Galoyot 15','BA',9400,'2018-08-21','102'),
('L-973','Sharon','Yanko','F','Sharon973@University.com','0233172150','Binyamina','Derech Erez 24','MA',9050,'2019-04-16','103'),
('L-566','Gal','Ronen','M','Gal566@University.com','0223312810','Akko','Adi 2','MA',10890,'2013-05-19','103'),
('L-326','Daniel','Greenberg','M','Daniel326@University.com','0243312490','Kiryat Haim','Hayin 17','MA',11200,'2014-06-11','104'),
('L-421','Nathan','Cohen','M','Nathan421@University.com','0223752430','Kiryat Motzkin','Beromim 41','MA',9800,'2016-07-15','104'),
('L-262','Dvir','Shirani','M','Dvir262@University.com','0263432811','Haifa','Vered 11','BA',9200,'2019-08-01','105'),
('L-341','Yosef','Baruch','M','Yosef341@University.com','0213762890','Tel Aviv','Narkisim 4','BA',9870,'2015-05-28','105'),
('L-551','Zur','Yakobi','M','Zur551@University.com','0223762890','Haifa','Aolem 7','MA',7690,'2014-10-28','101'),
('L-199','Dror','Mashieh','M','Dror199@University.com','0203232896','Jerusalem','Gefilte 9','MA',9760,'2015-12-15','105'),
('L-174','Eli','Yaron','M','Eli174@University.com','0203756990','Jerusalem','Marimim 16','MA',10890,'2016-10-18','103'),
('L-899','Koren','Nitzba','M','Koren899@University.com','0233212897','Haifa','Kfar 24','MA',10230,'2018-08-11','106'),
('L-640','Lotem','Buganim','F','Lotem640@University.com','0213162890','Kiryat Ata','Nemo 10','MA',8900,'2019-09-13','106'),
('L-877','Yuval','Shreder','F','Yuval877@University.com','0223132898','Akko','Harishim 11','BA',7600,'2016-04-17','107'),
('L-763','Shalev','Pelkovic','M','Shalev763@University.com','0263162892','Haifa','Malgot 16','MA',9570,'2016-06-11','107'),
('L-746','Shaked','Yom Tov','F','Shaked746@University.com','0243001890','Tel Aviv','Sharon 4','MA',8890,'2015-07-08','107'),
('L-420','Matilda','Ben Haim','F','Matilda420@University.com','0213172194','Kfar Saba','Zalman 8','MA',8790,'2016-03-04','106'),
('L-209','Shalom','Guttenberg','M','Shalom209@University.com','0253772890','Kfar Vradim','Menachem 24','MA',9670,'2013-09-01','101'),
('L-115','Greta','Thunberg','F','Greta115@University.com','0233772892','Natanya','Dare 9','BA',Default,'2011-08-30','107')


GO


insert into Professors values 

--(ProfessorID, First_Name, Last_Name, Gender, Email, Phone, City, Address, Academic_Degree, Salary, Hire_Date)

('P-101','Luna','Elliot','F','Luna101@University.com','0723732810','Haifa','Zafririm 19','Prof',19000,'2016-08-09','101'),
('P-331','Jesse','Brown','F','Jesse331@University.com','0713574893','Tel Aviv','Yarok 1','PhD',16000,'2014-01-15','101'),
('P-242','Olive','McAdams','F','Olive242@University.com','0743672291','Beit Shmesh','Tavor 2','PhD',13400,'2013-09-12','101'),
('P-342','Calvin','Klein','M','Calvin342@University.com','0754473891','Dimona','Shalom Alihem 18','PhD',15300,'2011-04-21','102'),
('P-189','Caleb','Hendrix','M','Caleb189@University.com','0713152890','Arad','Sharon 25','Prof',18400,'2012-03-26','103'),
('P-154','Lester','Herbert','M','Lester154@University.com','0733372491','Eilat','Yakobi 41','PhD',17500,'2013-10-24','102'),
('P-885','Tyler','Williams','M','Tyler885@University.com','0743372892','Maalot','Histadrut 17','PhD',16300,'2016-12-19','103'),
('P-666','Devin','Booker','M','Devin666@University.com','0753752893','Kfar Saba','Alrma 39','PhD',16100,'2015-01-29','104'),
('P-542','Chris','Paul','M','Chris542@University.com','0722742893','Jerusalem','Benjamin 50','PhD',13100,'2014-05-12','104'),
('P-187','James','Harden','M','James187@University.com','0743172895','Kfar Vradim','Moshe Sharet 22','PhD',17100,'2016-07-17','105'),
('P-176','Lemar','Boyce','M','Lemar176@University.com','0753712896','Akko','Kidumim 11','PhD',18100,'2019-03-18','105'),
('P-265','Alanah','Jones','F','Alanah265@University.com','0763732891','Nahariya','Shenkar 5','Prof',18300,'2016-04-29','105'),
('P-390','David','Lamb','M','David390@University.com','0723572899','Kiryat Shmona','Abigail 8','PhD',15200,'2013-06-25','106'),
('P-456','Trevor','Sanches','M','Trevor456@University.com','0733472897','Rehovot','Sagol 3','PhD',12100,'2011-08-23','106'),
('P-378','Lina','Gaines','F','Lina378@University.com','0743732898','Herzeliya','Katom 1','PhD',18100,'2010-09-21','106'),
('P-901','Fred','Rudd','M','Fred901@University.com','0703752893','Karmiel','Adomim 19','PhD',14100,'2014-08-25','107'),
('P-123','Giannis','McBride','M','Giannis123@University.com','0743472892','Kfar Tavor','Kadima 5','Prof',18100,'2012-08-28','107'),
('P-432','Alfred','Sykes','M','Alfred432@University.com','0713372891','Hagoshrim','Adi 19','PhD',18100,'2013-06-21','107'),
('P-543','Leo','Vargas','M','Leo543@University.com','0743702894','Haifa','Lohamim 20','PhD',15000,'2015-07-26','103'),
('P-621','Luis','Casey','M','Luis621@University.com','0753172895','Tel Aviv','Macabim 31','Prof',19000,'2013-11-24','104'),
('P-682','Jordi','Whitmore','M','Jordi682@University.com','0763572893','Jerusalem','Poalim 33','PhD',13500,'2014-06-15','106'),
('P-159','Andrea','Doston','M','Andrea159@University.com','0723762894','Kiryat Ata','Aluf 14','PhD',13400,'2015-05-07','107'),
('P-173','Thomas','Ballard','M','Thomas173@University.com','0743272895','Haifa','Giburi Israel 18','PhD',12400,'2017-07-06','101'),
('P-287','Violet','Todd','F','Violet287@University.com','0753312896','Haifa','Nero 14','PhD',15100,'2016-08-01','101'),
('P-941','Mary','Bain','F','Mary941@University.com','0763212897','Haifa','Abba 8','Prof',18000,'2016-03-01','107')


GO


insert into Courses values

--(CourseID, CourseName, Number_of_Semesters, Professor, Lecturer, Counselr)

('Med-101','Introduction to Medicine','1','P-101','L-209','C-102'),
('Med-103','General Medicine','2','P-173','L-245','C-102'),
('Med-106','Introduction to Surgery','1','P-242','L-321','C-102'),
('Med-109','General Surgery','2','P-101','L-551','C-102'),
('Med-201','Introduction to Psychiatry','1','P-331','L-551','C-102'),
('Med-203','Introduction to Neurology','1','P-101','L-551','C-102'),
('Med-209','Clinical Sciences','1','P-173','L-551','C-202'),
('Med-315','Life Cycle','2','P-101','L-209','C-202'),
('Med-325','Life Protection','2','P-287','L-209','C-202'),
('Med-343','Life Support','2','P-331','L-245','C-202'),
('Med-365','Life Maintenanace','2','P-242','L-321','C-202'),
('Med-370','Life Strucure','2','P-173','L-245','C-202'),
('Med-389','Life Control','2','P-331','L-321','C-202')


GO


insert into Courses values

--(CourseID, CourseName, Number_of_Semesters, Professor, Lecturer, Counselr)

('Art-101','Color Specialist','1','P-154','L-102','C-331'),
('Art-115','Design and Fine Craft','2','P-342','L-102','C-331'),
('Art-131','Dynamic Art','1','P-342','L-102','C-421'),
('Art-151','Image Consulting','1','P-154','L-142','C-421'),
('Art-167','Art Therapy','2','P-154','L-142','C-421')


GO


insert into Courses values

--(CourseID, CourseName, Number_of_Semesters, Professor, Lecturer, Counselr)

('Bui-101','Economics for Managers','1','P-189','L-174','C-109'),
('Bui-121','Business Analytics','2','P-543','L-566','C-109'),
('Bui-131','Financial Accounting','1','P-543','L-973','C-109'),
('Bui-151','Managment Essentials','1','P-885','L-174','C-109'),
('Bui-178','Leadership Principles','2','P-189','L-174','C-109'),
('Bui-200','Negotiation Mastery','1','P-543','L-174','C-221'),
('Bui-250','Disruptive Strategy','1','P-543','L-566','C-221'),
('Bui-260','Entrepreneurship Essentials','1','P-189','L-209','C-221'),
('Bui-280','Global Business','1','P-189','L-973','C-221'),
('Bui-300','Sustainable Buisness','1','P-885','L-973','C-221'),
('Bui-320','Leading With Finance','2','P-543','L-973','C-221')


GO

insert into Courses values

--(CourseID, CourseName, Number_of_Semesters, Professor, Lecturer, Counselr)

('Com-101','Culture and Society','2','P-542','L-326','C-304'),
('Com-108','New Media','1','P-621','L-326','C-304'),
('Com-124','Social Psychology','1','P-666','L-326','C-304'),
('Com-130','Digital Storytelling','1','P-542','L-421','C-304'),
('Com-142','Radio Broadcasting','2','P-621','L-421','C-988'),
('Com-154','Media Ethics','1','P-666','L-421','C-988'),
('Com-300','Humanistic Tought','1','P-666','L-326','C-988'),
('Com-420','Community Managment','2','P-621','L-421','C-988'),
('Com-441','Identity','1','P-542','L-421','C-988')

GO

insert into Courses values

--(CourseID, CourseName, Number_of_Semesters, Professor, Lecturer, Counselr)

('Edu-101','Introduction to Education','1','P-176','L-199','C-105'),
('Edu-105','The Education System','1','P-187','L-262','C-105'),
('Edu-124','Psychology of Teaching','2','P-265','L-341','C-105'),
('Edu-137','Sociology in Teaching','2','P-176','L-199','C-732'),
('Edu-189','Initiative Teacher','2','P-187','L-262','C-732'),
('Edu-290','Education Practicum','2','P-265','L-341','C-732')



GO


insert into Courses values

--(CourseID, CourseName, Number_of_Semesters, Professor, Lecturer, Counselr)

('Law-101','Administrative Law','2','P-378','L-420','C-272'),
('Law-122','Antitrust','1','P-390','L-640','C-272'),
('Law-132','Bankruptcy','1','P-456','L-899','C-272'),
('Law-135','Analytical Methods','2','P-682','L-321','C-272'),
('Law-147','Civil Procedure','1','P-378','L-899','C-272'),
('Law-190','Civil Right','1','P-390','L-420','C-819'),
('Law-201','History of Law','1','P-456','L-640','C-819'),
('Law-267','Contracts','1','P-682','L-420','C-819'),
('Law-389','Copyrights','1','P-682','L-640','C-819')


GO

insert into Courses values

--(CourseID, CourseName, Number_of_Semesters, Professor, Lecturer, Counselr)

('Sci-101','Introduction to Science','2','P-123','L-115','C-326'),
('Sci-120','Quantum Materils','2','P-159','L-746','C-326'),
('Sci-134','Optical Physics','2','P-432','L-763','C-326'),
('Sci-140','Reactor Physics','2','P-901','L-877','C-326'),
('Sci-150','Solid State Physics','2','P-941','L-877','C-326'),
('Sci-202','Biomedical Ultrasonics','2','P-123','L-746','C-429'),
('Sci-232','Cognitive Neuroscience','2','P-159','L-763','C-429'),
('Sci-302','Molecular Biophysics','2','P-432','L-115','C-429'),
('Sci-424','Quantom Mechanics','2','P-901','L-763','C-429'),
('Sci-540','Quantum Cicults','2','P-941','L-115','C-429')

GO

-- Updating some columns that were added to the table at the end

update Schools set Cost_Per_Year=12360
where SchoolID='101'

GO

update Schools set Cost_Per_Year=10000
where SchoolID='102'

GO

update Schools set Cost_Per_Year=12460
where SchoolID='103'

GO

update Schools set Cost_Per_Year=11000
where SchoolID='104'

GO

update Schools set Cost_Per_Year=10600
where SchoolID='105'

GO


update Schools set Cost_Per_Year=12420
where SchoolID='106'

GO

update Schools set Cost_Per_Year=13900
where SchoolID='107'

GO


insert into Students values

('216439211','Trinity','Newton','F','coee1@Email.com','053312287','Tel Aviv','Shalom 7','2019','101'),
('312459074','Charlene','Solomon','F','ededa11@Email.com','054363285','Haifa','Kedomim 19','2019','101'),
('416169153','Kevin','Diaz','M','rfew32@Email.com','055342283','Ashdod','Kinorot 22','2019','101'),
('561364021','Delia','Levi','F','rkke23@Email.com','056363281','Jerusalem','Jero 15','2020','101'),
('616362012','Grover','Rice','M','elclel11@Email.com','051317283','Maalot','Nalla 11','2020','102'),
('716333054','Theia','Crouch','F','cool2@Email.com','053380284','Raanana','Ehed Am 3','2019','102'),
('813429713','Grayson','Parrish','M','nevermind7@Email.com','054324286','Kfar Saba','Adomim 8','2019','102'),
('913434576','Betty','Lambart','F','kiel6@Email.com','056371280','Hod Hasharon','Macabim 22','2019','102'),
('016362011','Tilly','Drew','F','gere21@Email.com','057380280','Ashkelon','Bello 5','2019','102'),
('166549371','Miguel','Ellis','M','attin65@Email.com','051324283','Sderot','Kfir 7','2019','102'),
('217668975','Rachel','Holding','F','rhrh21@Email.com','054309281','Eilat','Yanov 9','2019','103'),
('316365051','Toni','Gray','M','tonis7@Email.com','056314284','Akko','Yanko 42','2019','103'),
('411425571','Jodi','Buck','F','jojo55@Email.com','054332283','Nahariya','Saba 11','2019','103'),
('530369111','Bailey','Oconnor','M','bamba2@Email.com','051313282','Kiryat Biyalik','Eliezer 13','2019','103'),
('616443215','Robin','Walton','F','samor12@Email.com','056311281','Ramat Gan','Gezer 55','2019','103'),
('712233079','Patrick','Paul','M','selli@Email.com','055322285','Herzeliya','Orange 32','2020','101'),
('816229339','Adrian','Gray','M','adi17@Email.com','053324284','Dimona','Blue 7','2019','101'),
('913439078','Lucca','Orange','M','lucky09@Email.com','057380283','Beer Sheva','Fishman 22','2019','104'),
('016369378','Ellie','Golding','F','elel4@Email.com','058303282','Kfar Vradim','Yosef 18','2019','104'),
('116339377','Elsa','Greenberg','F','gho51@Email.com','053337281','Ramat Yishai','Eli Cohen 13','2019','104'),
('216421117','Sophie','Turner','F','soso09@Email.com','054323283','Afula','Kadima 7','2020','104'),
('312359271','Denver','Nugget','M','denver3@Email.com','059310284','Kiryat Shmona','Vered 23','2020','104'),
('416469071','Nicolas','Battum','M','momo999@Email.com','051363285','Zefat','Zuf 42','2019','101'),
('512269174','Ewan','Cher','M','betbet4@Email.com','050350286','Karmiel','Israel 1','2019','101'),
('611364573','Boris','Yanko','M','tre3@Email.com','053331287','Maale Adomim','Hashmal 15','2019','103'),
('716063021','Willy','Savich','M','formo90@Email.com','054330288','Beit Shemesh','Adom 63','2019','105'),
('846429373','Billy','Nice','M','wonka14@Email.com','055336280','Yahod','Yarok 46','2019','105'),
('916459672','Nigel','Lloyd','M','deniis1@Email.com','057321281','Rishon Lezion','Lomdim 2','2019','105'),
('016465071','Mazie','Sanders','F','ash3ly@Email.com','058323280','Petah Tikva','Lamda 4','2019','105'),
('116443073','Amber','Solomon','F','dmme27@Email.com','050345281','Kiryat Motzkin','Alpha 1','2019','105'),
('216462070','Pablo','Cohen','M','pbh5@Email.com','052363280','Kiryat Ata','Beta 77','2019','105'),
('316479070','Arthur','McDaniels','M','xert76@Email.com','053370283','Natanya','Charlie 25','2019','105'),
('416449070','David','Hanson','M','jpop1@Email.com','054334282','Kiryat Haim','Delta 42','2020','106'),
('516429072','Yosef','Levi','M','yohzja65@Email.com','055323281','Kiryat Yam','Gamma 27','2020','106'),
('616469073','Chen','Drori','F','lolipop9@Email.com','056356280','Rehovot','Halomim 31','2020','106'),
('712269071','Dor','Shema','M','memo123@Email.com','053372283','Ceasria','Reshon 1','2019','106'),
('816463073','Naama','Yosefi','F','elmo6@Email.com','051333284','Tiberias','David 32','2019','106'),
('916463074','Yaron','Lodon','M','ahalmel90@Email.com','050310285','Kiryat Arba','Reut 66','2019','106'),
('016463075','Menachem','Ben','M','londi4@Email.com','054355286','Ariel','Tikva 2','2019','106'),
('116469076','Dudu','Tasa','M','atat21@Email.com','052332287','Azur','Medina 53','2020','106'),
('216439077','Sapir','Ashe','F','masho76@Email.com','055316288','Holon','Purple 72','2020','107'),
('316469078','Kfir','Hoderov','M','loppere@Email.com','051362280','Tirat Carmel','John 4','2020','107'),
('416439074','Izhak','Levi','M','juyce32@Email.com','053373281','Atlit','Galim 5','2020','107'),
('516433072','Jacob','Cohen','M','seret09@Email.com','054326283','Hadera','Moresht 13','2019','107'),
('616463073','Ralph','Lauren','M','jamy32@Email.com','056339284','Givat Olga','Ovda 34','2019','107'),
('716469074','Marie','Poppins','F','maiii3@Email.com','057326286','Olesh','Jerusalem 13','2019','107'),
('816469075','Philipa','Sell','M','phipa6@Email.com','058383283','Modiin','Elite 53','2019','107'),
('916469076','Barack','Snelli','M','bs10@Email.com','050320282','Arad','Camel 9','2019','107'),
('016469072','Louis','Bitton','M','lbitton@Email.com','052339284','Kiryat Gat','Aroba 32','2020','107'),
('116469081','Darien','John','M','dari07@Email.com','053336286','Netivot','Zuf 21','2019','107'),
('216469371','Raz','Meir','F','razzit19@Email.com','051352287','Gan Yavne','Vered 17','2020','107'),
('011139211','Finished','Here','M','Finish101@Email.com','057777280','Eilat','Siyomet 99','2017','102')

GO

-- Updating some columns that were added to the table at the end

update Schools set Academic_Years=4
where SchoolID='101'

GO

update Schools set Academic_Years=2
where SchoolID='102'

GO

update Schools set Academic_Years=3
where SchoolID='103'

GO

update Schools set Academic_Years=3
where SchoolID='104'

GO

update Schools set Academic_Years=3
where SchoolID='105'

GO


update Schools set Academic_Years=3
where SchoolID='106'

GO

update Schools set Academic_Years=4
where SchoolID='107'

GO

Alter Table Courses
add SchoolID varchar(3) foreign key (SchoolID) references Schools (SchoolID)

GO

update Courses set SchoolID='101'
where Left(courseid,3)='Med'

GO

update Courses set SchoolID='102'
where Left(courseid,3)='Art'

GO

update Courses set SchoolID='103'
where Left(courseid,3)='Bui'

GO

update Courses set SchoolID='104'
where Left(courseid,3)='Com'

GO

update Courses set SchoolID='105'
where Left(courseid,3)='Edu'

GO

update Courses set SchoolID='106'
where Left(courseid,3)='Law'

GO

update Courses set SchoolID='107'
where Left(courseid,3)='Sci'

GO
