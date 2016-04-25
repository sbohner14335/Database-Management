-- Stephen Bohner Final Project Script 4/20/2016

-- Create Statements for all tables in the database.
CREATE TABLE ZipCodes (
    zipCode int NOT NULL,
    state text NOT NULL,
    city text NOT NULL,
  PRIMARY KEY(zipCode)
);

CREATE TABLE People (
    pID int NOT NULL,
    name text NOT NULL,
    ssn int NOT NULL,
    gender text NOT NULL CHECK (gender IN ('MALE', 'FEMALE')),
    birthDate DATE NOT NULL,
    phoneNum text NOT NULL,
    homeAddress text NOT NULL,
    zipCode int NOT NULL REFERENCES ZipCodes(zipCode),
  PRIMARY KEY(pID)
);

CREATE TABLE Patients (
    patID int NOT NULL,
    pID int NOT NULL REFERENCES People(pID),
    insuranceCo text,
  PRIMARY KEY(patID)
);

CREATE TABLE Receptionists (
    recID int NOT NULL,
    pID int NOT NULL REFERENCES People(pID),
    hourlySalary numeric(12,2) NOT NULL,
    hoursWorkedPerWeek int NOT NULL,
  PRIMARY KEY(recID)
);

CREATE TABLE Doctors (
    docID int NOT NULL,
    pID int NOT NULL REFERENCES People(pID),
    universityAttended text NOT NULL,
    yearSalary numeric(12,2) NOT NULL,
  PRIMARY KEY(docID)
);

CREATE TABLE Assistants (
    assistID int NOT NULL,
    pID int NOT NULL REFERENCES People(pID),
    yearSalary numeric(12,2) NOT NULL,
  PRIMARY KEY(assistID)
);

CREATE TABLE Calls (
    callID int NOT NULL,
    timeCalled time NOT NULL,
    recID int NOT NULL REFERENCES Receptionists(recID),
    patID int NOT NULL REFERENCES Patients(patID),
  PRIMARY KEY(callID)
);

CREATE TABLE Drugs (
    drugID int NOT NULL,
    name text NOT NULL,
    company text NOT NULL,
    illnessTreated text NOT NULL,
  PRIMARY KEY(drugID)
);

CREATE TABLE Prescriptions (
    prescID int NOT NULL,
    amtPerDayInGrams int NOT NULL,
    weeksTakenFor int NOT NULL,
  PRIMARY KEY(prescID)
);

CREATE TABLE DrugsPerPrescription (
    prescID int NOT NULL REFERENCES Prescriptions(prescID),
    drugID int NOT NULL REFERENCES Drugs(drugID),
  PRIMARY KEY(prescID, drugID)
);

CREATE TABLE Appointments (
    dateTimeOfAppt timestamp NOT NULL,
    callID int NOT NULL REFERENCES Calls(callID),
    docID int NOT NULL REFERENCES Doctors(docID),
    assistID int NOT NULL REFERENCES Assistants(assistID),
    prescID int NOT NULL REFERENCES Prescriptions(prescID),
    roomNum int NOT NULL,
    costUSD numeric(12,2) NOT NULL,
  PRIMARY KEY(dateTimeOfAppt)
);


-- All sample data inserted into various tables.

INSERT INTO ZipCodes VALUES (11501, 'NY', 'Mineola');
INSERT INTO ZipCodes VALUES (11596, 'NY', 'Williston Park');
INSERT INTO ZipCodes VALUES (15027, 'PA', 'Conway');
INSERT INTO ZipCodes VALUES (12601, 'NY', 'Poughkeepsie');
INSERT INTO ZipCodes VALUES (07712, 'NJ', 'Asbury Park');
INSERT INTO ZipCodes VALUES (01057, 'MA', 'Monson');
INSERT INTO ZipCodes VALUES (10007, 'NY', 'New York');

SELECT * FROM ZipCodes;

INSERT INTO People VALUES (0, 'John Searen', 044825487, 'MALE', '1994-02-24', 5165484554, '5 Durkin Drive', 10007);
INSERT INTO People VALUES (1, 'Billy Currington', 487596455, 'MALE', '1992-05-14', 84545628788, '52 Old Ridge Road', 11501);
INSERT INTO People VALUES (2, 'Hannah Pullip', 2140331400, 'FEMALE', '1982-10-31', 6314582647, '174 Oak Street', 01057);
INSERT INTO People VALUES (3, 'Evan Brooks', 478447168, 'MALE', '1972-06-25', 5475893120, '235 Houston Avenue', 10007);
INSERT INTO People VALUES (4, 'Kirsten Sullivan', 487651234, 'FEMALE', '1995-04-02', 8451023458, '6 Foch Street', 10007);
INSERT INTO People VALUES (5, 'Stephen Bohner', 488756325, 'MALE', '1996-12-06', 3014896558, '2446 Lords Way', 12601);
INSERT INTO People VALUES (6, 'Christian Menk', 0856417854, 'MALE', '1986-12-22', 6945778166, '4440 Jefferson Court', 11596);
INSERT INTO People VALUES (7, 'Chris Iacobellis', 1875889456, 'MALE', '1996-07-30', 5425897555, '24 Birch Road', 07712);
INSERT INTO People VALUES (8, 'Reagan Fowler', 657123468, 'FEMALE', '1990-02-04', 6314517410, '4538 James Street', 11501);
INSERT INTO People VALUES (9, 'George Daniels', 587106485, 'MALE', '1993-04-02', 6873495458, '6246 Creek Road', 11501);
INSERT INTO People VALUES (10, 'Linda Owens', 487164589, 'FEMALE', '1997-01-03', 4781002544, '3090 Park Avenue', 10007);
INSERT INTO People VALUES (11, 'David Emory', 316022315, 'MALE', '1992-01-16', 1249764264, '1201 Sunset Drive', 15027);
INSERT INTO People VALUES (12, 'Danielle Codd', 122687901, 'FEMALE', '1992-08-08', 5481089979, '9024 College Street', 07712);
INSERT INTO People VALUES (13, 'Bob Fracker', 312049874, 'MALE', '1999-02-15', 4421655477, '554 Country Club Road', 10007);
INSERT INTO People VALUES (14, 'Katie Gonzalez', 265483120, 'FEMALE', '1984-09-18', 5478471300, '568 Hillcrest Drive', 15027);
INSERT INTO People VALUES (15, 'Ester Tatum', 1785493200, 'FEMALE', '1964-06-11', 8451548755, '757 Cleveland Street', 07712);
INSERT INTO People VALUES (16, 'Devon Elliot', 224014787, 'MALE', '1973-08-10', 4584783256, '4228 Cottage Street', 11596);
INSERT INTO People VALUES (17, 'Alfred Wayne', 589789944, 'MALE', '1984-07-07', 4579014486, '2805 Mechanic Street', 15027);
INSERT INTO People VALUES (18, 'Thorton Earl', 102645877, 'MALE', '1983-11-19', 2714587767, '73 Route 9', 11501);


INSERT INTO Patients VALUES (0, 2, 'Vista Health');
INSERT INTO Patients VALUES (1, 4, 'United Care');
INSERT INTO Patients VALUES (2, 6, 'Aetna');
INSERT INTO Patients VALUES (3, 8, 'GHI');
INSERT INTO Patients VALUES (4, 9, 'Vista Health');
INSERT INTO Patients VALUES (5, 13, 'Embassy Health');
INSERT INTO Patients VALUES (6, 14, 'Humana');


INSERT INTO Receptionists VALUES (0, 7, 10, 25);
INSERT INTO Receptionists VALUES (1, 10, 12, 30);
INSERT INTO Receptionists VALUES (2, 12, 11, 40);
INSERT INTO Receptionists VALUES (3, 15, 11, 40);


INSERT INTO Doctors VALUES (0, 1, 'University of Buffalo', 140000.00);
INSERT INTO Doctors VALUES (1, 3, 'University of Massachussetts Amherst', 135000.00);
INSERT INTO Doctors VALUES (2, 5, 'University of Maryland', 160000.00);


INSERT INTO Assistants VALUES (0, 0, 90000.00);
INSERT INTO Assistants VALUES (1, 11, 95000.00);
INSERT INTO Assistants VALUES (2, 16, 87500.00);
INSERT INTO Assistants VALUES (3, 17, 100000.00);
INSERT INTO Assistants VALUES (4, 18, 985200.00);


INSERT INTO Calls VALUES (0, '04:00:00 PM', 0, 0);
INSERT INTO Calls VALUES (1, '02:47:00 PM', 3, 2);
INSERT INTO Calls VALUES (2, '10:28:00 AM', 3, 1);
INSERT INTO Calls VALUES (3, '04:10:00 PM', 2, 4);
INSERT INTO Calls VALUES (4, '09:17:00 AM', 2, 3);
INSERT INTO Calls VALUES (5, '11:55:00 AM', 1, 6);
INSERT INTO Calls VALUES (6, '03:15:00 PM', 0, 5);


INSERT INTO Drugs VALUES (0, 'Adderall', 'Shire', 'ADHD');
INSERT INTO Drugs VALUES (1, 'Tramadol', 'Shire', 'Pain Killer');
INSERT INTO Drugs VALUES (2, 'Prozac', 'Eli Lilly', 'Depression');
INSERT INTO Drugs VALUES (3, 'Melatonin', 'Natural Grocery Company', 'Insomnia');
INSERT INTO Drugs VALUES (4, 'Reductil', 'Abbott', 'High Cholestrol');


INSERT INTO Prescriptions VALUES (0, 1, 5);
INSERT INTO Prescriptions VALUES (1, 2, 8);
INSERT INTO Prescriptions VALUES (2, 1, 3);
INSERT INTO Prescriptions VALUES (3, 3, 16);
INSERT INTO Prescriptions VALUES (4, 2, 10);

INSERT INTO DrugsPerPrescription VALUES (0, 1);
INSERT INTO DrugsPerPrescription VALUES (1, 3);
INSERT INTO DrugsPerPrescription VALUES (2, 4);
INSERT INTO DrugsPerPrescription VALUES (3, 0);
INSERT INTO DrugsPerPrescription VALUES (4, 2);


INSERT INTO Appointments VALUES ('2016-04-20 12:15:00', 0, 1, 4, 2, 125, 20.00);
INSERT INTO Appointments VALUES ('2016-03-25 01:37:28', 4, 0, 1, 0, 140, 25.00);
INSERT INTO Appointments VALUES ('2016-02-14 08:14:58', 2, 2, 1, 4, 241, 45.50);
INSERT INTO Appointments VALUES ('2016-02-27 05:15:00', 1, 1, 2, 3, 210, 200.00);
INSERT INTO Appointments VALUES ('2016-03-26 04:15:15', 3, 1, 3, 1, 110, 20.00);
INSERT INTO Appointments VALUES ('2016-04-01 11:48:13', 6, 2, 0, 1, 113, 30.00);



-- All views created.

CREATE VIEW AppointmentCost 
 AS SELECT pat.patID, p.name, a.costUSD
 FROM People p
 INNER JOIN Patients pat ON pat.pID = p.pID
 INNER JOIN Calls c ON c.patID = pat.patID
 INNER JOIN Appointments a ON a.callID = c.callID;

SELECT * FROM AppointmentCost;

CREATE VIEW DoctorAppointments
 AS SELECT d.docID, p.name, a.dateTimeOfAppt
 FROM People p
 INNER JOIN Doctors d ON d.pID = p.pID
 INNER JOIN Appointments a ON a.docID = d.docID;

SELECT * FROM DoctorAppointments;

CREATE VIEW PrescriptionDrug
 AS SELECT p.prescID, d.name
 FROM Drugs d
 INNER JOIN DrugsPerPrescription dpp ON dpp.drugID = d.drugID
 INNER JOIN Prescriptions p ON p.prescID = dpp.prescID;

SELECT * FROM PrescriptionDrug;


-- All reports that will be accessible.

SELECT p.prescID, d.name
FROM Drugs d
INNER JOIN DrugsPerPrescription dpp ON dpp.drugID = d.drugID
INNER JOIN Prescriptions p ON p.prescID = dpp.prescID;

SELECT AVG(yearSalary) AS AvgDoctorSalary
FROM Doctors;

SELECT AVG(yearSalary) AS AvgAssistantsSalary
FROM Assistants;

SELECT AVG(costUSD) AS AvgCostForAppointment
FROM Appointments

-- Stored Procedure.

CREATE FUNCTION negNumber() 
 RETURNS trigger AS $negNumber$
  BEGIN
	IF NEW.costUSD < 0 THEN
	 RAISE EXCEPTION 'cannot have a negative price';
	END IF;
  END;
  $negNumber$ LANGUAGE plpgsql;

-- Trigger.

CREATE TRIGGER checkNum BEFORE UPDATE OR INSERT
  ON Appointments
  FOR EACH ROW EXECUTE PROCEDURE negNumber();

-- All priveleges granted to the appropriate users. (Security)

GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO dbAdmin;

GRANT INSERT ON ZipCodes TO patientUser;
GRANT SELECT, INSERT ON People TO patientUser;
GRANT INSERT ON Patients TO patientUser;

GRANT INSERT ON ZipCodes TO receptionistUser;
GRANT SELECT, INSERT ON People TO receptionistUser;
GRANT SELECT, INSERT, UPDATE ON Receptionists TO receptionistUser;
GRANT SELECT, INSERT, UPDATE, DELETE ON Calls TO receptionistUser;
GRANT SELECT, INSERT, UPDATE, DELETE ON Appointments TO receptionistUser;

GRANT INSERT ON ZipCodes TO medicalStaff;
GRANT SELECT, INSERT ON People TO medicalStaff;
GRANT SELECT, INSERT, UPDATE ON Doctors TO medicalStaff;
Grant SELECT, INSERT, UPDATE ON Assistants TO medicalStaff;
GRANT SELECT, INSERT, UPDATE ON Prescriptions TO medicalStaff;
GRANT SELECT, INSERT, UPDATE ON Appointments TO medicalStaff;
