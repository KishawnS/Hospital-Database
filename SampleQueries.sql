-- Sample Query 1
SELECT Employee_ID, Role
FROM Employee
WHERE (Hospital = 'Bellevue General Hospital' OR
       Hospital = 'Grand Oak Hospital') AND
       Department_ID IN (
        SELECT Department_ID
        FROM Department
        WHERE Department_Name = 'Cardiology');

-- Sample Query 2
SELECT AVG(Value) AS Average
FROM Contain
WHERE Test_ID IN (
      SELECT Test_ID
      FROM Test
      WHERE Test_Name = 'Blood Glucose Test');

-- Sample Query 3
SELECT PatientID, COUNT(PatientID) AS AdmissionCount
FROM AdmissionRecord
WHERE AdmitDate >= '2020-01-01'
GROUP BY PatientID
HAVING COUNT(PatientID) >= 3;

-- Sample Query 4
SELECT Type, COUNT(*) AS Count
FROM Contain, Test
WHERE Result = 'Abnormal' AND
      YEAR(Date) = '2020' AND
      Test.Test_ID = Contain.Test_ID
GROUP BY Type;

-- Sample Query 5
SELECT PersonID, Age, Gender
FROM Person
WHERE PersonID IN (
      SELECT PatientID
      FROM AdmissionRecord
      WHERE Adm_ID IN (
        SELECT Adm_ID
        FROM ICUStay
        WHERE (DateOut - DateIn) = (
            SELECT MAX(DateOut - DateIn)
            FROM ICUStay)));

-- Sample Query 6
SELECT Category, AVG(Age) AS avgAge
FROM Disease, Person, Diagnosed
WHERE Diagnosed.PatientID = Person.PersonID AND
      Disease.Disease_ID = Diagnosed.Disease_ID
GROUP BY Category;

-- Sample Query 7
SELECT Employee_ID
FROM Employee
WHERE Department_ID IS NOT NULL AND
      Employee_ID NOT IN (
        SELECT PatientID
        FROM Diagnosed
        WHERE Disease_ID IN (
            SELECT Disease_ID
            FROM Disease
            WHERE Disease_Name = 'Food Allergy' OR
                  Disease_Name = 'Flu' OR
                  Disease_Name = 'Conjunctivitis'));

-- Sample Query 8
SELECT Diagnosed.PatientID, Contain.Date
FROM Contain, Diagnosed, Labrecord
WHERE Contain.Date = Date_of_Diagnosis AND
      Contain.Result = 'Abnormal' AND
      LabRecord.PatientID = Diagnosed.PatientID AND
      LabRecord.Lab_ID = Contain.Lab_ID AND
      Diagnosed.Disease_ID IN (
        SELECT Disease_ID
        FROM Disease
        WHERE Category = 'Blood and Lymph');

-- Sample Query 9
SELECT COUNT(*) AS NonBigThreeCount
FROM Prescription
WHERE RX_Num NOT IN (
      SELECT RX_Num
      FROM HasDrug
      WHERE Drug_ID IN (
        SELECT Drug_ID
        FROM Drug
        WHERE Manufacturer = 'Pfizer' OR
              Manufacturer = 'Johnson & Johnson' OR
              Manufacturer = 'Bayer'));
        
-- Sample Query 10
SELECT DISTINCT hd1.Hospital, d1.Department_Name, hd1.PatientCapacity
FROM HasDept hd1 JOIN Department d1 ON hd1.Department_ID = d1.Department_ID
WHERE hd1.Hospital IN (
      SELECT hd2.Hospital
      FROM HasDept hd2
      GROUP BY hd2.Hospital
      HAVING COUNT(hd2.Hospital) = (
       SELECT COUNT(*)
       FROM Department d2));
