CREATE DATABASE IF NOT EXISTS Project;
USE Project;

CREATE TABLE IF NOT EXISTS CustomerLookUp (
   key int PRIMARY KEY AUTO_INCREMENT,
   id varchar(20) UNIQUE
);

CREATE TABLE IF NOT EXISTS RegistrationSources (
   registrationSourceId varchar(50) PRIMARY KEY,
   registrationSourceName varchar(50)
);

CREATE TABLE IF NOT EXISTS Customers (
   key int PRIMARY KEY,
   registrationSourceId varchar(20),
   zip int, 
   state char(2),
   gender varchar(5),
   incomeLevel varchar(20),
   permission varchar(1),
   language varchar(2),
   registrationDate DATE,
   customerTier varchar(15),
   numRegistration int,
   FOREIGN KEY key REFERENCES CustomerLookUp(key),
   FOREIGN KEY registrationSourceId REFERENCES RegistrationSources(registrationSourceId)
);

CREATE TABLE IF NOT EXISTS EmailIds (
   id int PRIMARY KEY,
   customerKey int,
   emailDomain varchar(15),
   FOREIGN KEY customerKey REFERENCES CustomerLookUp(key)
);

CREATE TABLE IF NOT EXISTS EventTypes (
   eventTypeId int PRIMARY KEY,
   eventTypeName varchar(10)
);


CREATE TABLE IF NOT EXISTS Emails (
   subjectLine varchar(255),
   eventDate DATETIME PRIMARY KEY,
   emailId varchar(),
   FOREIGN KEY emailId REFERENCES EmailIds(id)
);

CREATE TABLE IF NOT EXISTS EmailEvents (
   eventTypeId int,
   emailId int,
   eventDate DATETIME,
   FOREIGN KEY eventTypeId REFERENCES EventTypes(eventTypeId),
   FOREIGN KEY emailId REFERENCES EmailIds(id),
   FOREIGN KEY eventDate REFERENCES Emails(eventDate)
);

CREATE TABLE IF NOT EXISTS Urls (
   linkName varchar(50) PRIMARY KEY,
   url varchar(50)
);

CREATE TABLE IF NOT EXISTS Batches (
   campaignName varchar(50),
   version varchar(10),
   audience varchar(50),
   deploymentId varchar(50) PRIMARY KEY,
   deploymentDate DATETIME
);

CREATE TABLE IF NOT EXISTS DeviceModels (
   model varchar(50) PRIMARY KEY,
   name varchar(50),
   type varchar(20),
   carrier varchar(20)
);

CREATE TABLE IF NOT EXISTS Devices (
   serialNo varchar(50) PRIMARY KEY,
   model varchar(50),
   FOREIGN KEY model REFERENCES DeviceModels(model)
);


CREATE TABLE IF NOT EXISTS DeviceRegistrations (
   registrationId int PRIMARY KEY,
   registrationSourceId varchar(50),
   customerKey int,
   registrationDate DATE,
   ecommFlags BOOLEAN,
   purchaseDate DATE,
   storeName varchar(50),
   storeCity varchar(50),
   storeState char(2),
   serialNo varchar(50),
   FOREIGN KEY registrationSourceId REFERENCES RegistrationSources(registrationSourceId),
   FOREIGN KEY customerKey REFERENCES Customer(key),
   FOREIGN KEY serial REFERENCES Devices(serialNo)
);
