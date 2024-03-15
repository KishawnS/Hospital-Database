--------------------------------------
--  DDL Statement for Hospital entity
--------------------------------------
CREATE TABLE Hospital (
     Hospital_Name varchar(50) NOT NULL,
     Address varchar(50) NOT NULL,
     PRIMARY KEY (Hospital_Name)
);

----------------------------------------
--  DDL Statement for Department entity
----------------------------------------
CREATE TABLE Department (
     Dept_ID int NOT NULL,
     Dept_Name varchar(50) NOT NULL,
     PRIMARY KEY (Dept_ID)
);

------------------------------------------
--  DDL Statement for Located In relation
------------------------------------------
CREATE TABLE Located_In (
     Dept_ID int NOT NULL,
     Hospital_Name varchar(50) NOT NULL,
     Patient_Capacity int NOT NULL,
     FOREIGN KEY (Dept_ID) REFERENCES Department(Dept_ID),
     FOREIGN KEY (Hospital_Name) REFERENCES Hospital(Hospital_Name),
     PRIMARY KEY (Dept_ID, Hospital_Name)
);

------------------------------------
--  DDL Statement for Person entity
------------------------------------
CREATE TABLE Person (
     Person_ID int NOT NULL,
     Age int,
     Gender varchar(50),
     Ethnicity varchar(50),
     Phone_Number int,
     PRIMARY KEY (Person_ID)
);

--------------------------------------
--  DDL Statement for Employee entity
--------------------------------------
CREATE TABLE Employee (
     Employee_ID int NOT NULL,
     Hospital_Name varchar(50) NOT NULL,
     Dept_ID int,
     Role varchar(50) NOT NULL,
     FOREIGN KEY (Hospital_Name) REFERENCES Hospital(Hospital_Name),
     FOREIGN KEY (Dept_ID) REFERENCES Department(Dept_ID),
     FOREIGN KEY (Employee_ID) REFERENCES Person(Person_ID),
     PRIMARY KEY (Employee_ID)
);

-------------------------------------
--  DDL Statement for Patient entity
-------------------------------------
CREATE TABLE Patient (
     Patient_ID int NOT NULL,
     Date_of_Death DATE,
     FOREIGN KEY (Patient_ID) REFERENCES Person(Person_ID),
     PRIMARY KEY (Patient_ID)
);

----------------------------------------------
--  DDL Statement for Admission Record entity
----------------------------------------------
CREATE TABLE Admission_Record (
     Record_ID int NOT NULL,
     Admission_Date DATE NOT NULL,
     Discharge_Date DATE,
     Patient_ID int NOT NULL,
     Hospital_Name varchar(50) NOT NULL,
     FOREIGN KEY (Patient_ID) REFERENCES Patient(Patient_ID),
     FOREIGN KEY (Hospital_Name) REFERENCES Hospital(Hospital_Name),
     PRIMARY KEY (Record_ID)
);

---------------------------------
--  DDL Statement for ICU entity
---------------------------------
CREATE TABLE ICU (
     ICU_Name varchar(50) NOT NULL,
     ICU_Capacity int NOT NULL,
     Hospital_Name varchar(50) NOT NULL,
     FOREIGN KEY (Hospital_Name) REFERENCES Hospital(Hospital_Name),
     PRIMARY KEY (ICU_Name, Hospital_Name)
);

--------------------------------------
--  DDL Statement for In ICU relation
--------------------------------------
CREATE TABLE In_ICU (
     Record_ID int NOT NULL,
     ICU_Name varchar(50) NOT NULL,
     Hospital_Name varchar(50) NOT NULL,
     Entry_Date DATE NOT NULL,
     Exit_Date DATE,
     FOREIGN KEY (Record_ID) REFERENCES Admission_Record(Record_ID),
     FOREIGN KEY (ICU_Name, Hospital_Name) REFERENCES ICU(ICU_Name, Hospital_Name),
     PRIMARY KEY (Record_ID, ICU_Name, Hospital_Name)
);

----------------------------------------
--  DDL Statement for Lab Record entity
----------------------------------------
CREATE TABLE Lab_Record (
     Lab_ID int NOT NULL,
     Patient_ID int NOT NULL,
     FOREIGN KEY (Patient_ID) REFERENCES Patient(Patient_ID),
     PRIMARY KEY (Lab_ID)
);

-----------------------------------------
--  DDL Statement for table Medical Test
-----------------------------------------
CREATE TABLE Medical_Test (
     Test_ID int NOT NULL,
     Test_Name varchar(50) NOT NULL,
     Test_Type varchar(50),
     PRIMARY KEY (Test_ID)
);

-----------------------------------------
--  DDL Statement for Test Data relation
-----------------------------------------
CREATE TABLE Test_Data (
     Test_ID int NOT NULL,
     Lab_ID int NOT NULL,
     Date_of_Test DATE NOT NULL,
     Value_of_Test varchar(50) NOT NULL,
     Outcome varchar(50) NOT NULL,
     FOREIGN KEY (Test_ID) REFERENCES Medical_Test(Test_ID),
     FOREIGN KEY (Lab_ID) REFERENCES Lab_Record(Lab_ID),
     PRIMARY KEY (Test_ID, Lab_ID)
);

-------------------------------------
--  DDL Statement for Disease entity
-------------------------------------
CREATE TABLE Disease (
     Disease_ID int NOT NULL,
     Disease_Name varchar(50) NOT NULL,
     Category varchar(50),
     PRIMARY KEY (Disease_ID)
);

----------------------------------------------
--  DDL Statement for Diagnosed With relation
----------------------------------------------
CREATE TABLE Diagnosed_With (
     Patient_ID int NOT NULL,
     Disease_ID int NOT NULL,
     Date_of_Diagnosis DATE NOT NULL,
     FOREIGN KEY (Patient_ID) REFERENCES Patient(Patient_ID),
     FOREIGN KEY (Disease_ID) REFERENCES Disease(Disease_ID),
     PRIMARY KEY (Patient_ID, Disease_ID)
);

------------------------------------------
--  DDL Statement for Prescription entity
------------------------------------------
CREATE TABLE Prescription (
     RX_Number int NOT NULL,
     Start_Date DATE NOT NULL,
     End_Date DATE NOT NULL,
     Record_ID int NOT NULL,
     FOREIGN KEY (Record_ID) REFERENCES Admission_Record(Record_ID),
     PRIMARY KEY (RX_Number)
);

----------------------------------
--  DDL Statement for Drug entity
----------------------------------
CREATE TABLE Drug (
     Drug_ID int NOT NULL,
     Drug_Name varchar(50) NOT NULL,
     Drug_Type varchar(50),
     Manufacturer varchar(50),
     PRIMARY KEY (Drug_ID)
);

-------------------------------------------------
--  DDL Statement for Administered With relation
-------------------------------------------------
CREATE TABLE Administered_With (
     Drug_ID int NOT NULL,
     RX_Number int NOT NULL,
     Dosage varchar(50) NOT NULL,
     FOREIGN KEY (Drug_ID) REFERENCES Drug(Drug_ID),
     FOREIGN KEY (RX_Number) REFERENCES Prescription(RX_Number),
     PRIMARY KEY (Drug_ID, RX_Number)
);
