DROP TABLE IF EXISTS tempModels;
DROP TABLE IF EXISTS tempAccounts;
DROP TABLE IF EXISTS tempDevices;
DROP TABLE IF EXISTS tempEmails;

CREATE TABLE tempModels (
   Model VARCHAR(50),
   Name VARCHAR(50),
   Type VARCHAR(6),
   Carrier VARCHAR(20),
   PRIMARY KEY(Model, Name, Type, Carrier)
);

CREATE TABLE tempAccounts (
   CustomerID INT,
   EmailID INT,
   RegSrcID INT,
   RegSrcName VARCHAR(30),
   Zip VARCHAR(5),
   State VARCHAR(50),
   Gender CHAR(1),
   Income VARCHAR(20),
   Permission INT,
   Language CHAR(2),
   RegDate VARCHAR(20),
   Domain VARCHAR(50),
   Tier CHAR(3),
   PRIMARY KEY(CustomerID, EmailID, RegSrcID, RegSrcName, Zip, State, Gender, Income, Permission, Language, RegDate, Domain, Tier)
);

CREATE TABLE tempDevices (
   CustomerID INT,
   RegSrcID INT,
   RegSrcName VARCHAR(30),
   Model VARCHAR(50),
   Serial VARCHAR(20),
   PurchaseDate VARCHAR(20),
   PurchaseStoreName VARCHAR(30),
   PurchaseStoreState VARCHAR(3),
   PurchaseStoreCity VARCHAR(50),
   Ecomm INT,
   RegDate VARCHAR(20),
   NumReg INT,
   RegID INT,
   PRIMARY KEY(CustomerID, RegSrcID, RegSrcName, Model, Serial, PurchaseDate, PurchaseStoreName, PurchaseStoreState, PurchaseStoreCity, Ecomm, RegDate, NumReg, RegID)
);

CREATE TABLE tempEmails (
   EmailID INT,
   Audience VARCHAR(50),
   Campaign VARCHAR(50),
   Version VARCHAR(50),
   Subject VARCHAR(3),
   DeployDate VARCHAR(20),
   DeployID INT,
   EventID INT,
   EventName VARCHAR(40),
   EmailEventDateTime VARCHAR(20),
   LinkName VARCHAR(100),
   URL VARCHAR(255),
   EmailID2 INT,
   PRIMARY KEY(EmailID, Audience, Campaign, Version, Subject, DeployDate, DeployID, EventID, EventName, EmailEventDateTime, LinkName, URL, EmailID2)
);

LOAD DATA LOCAL INFILE '/home/blivitsk/cpe366/project/CP_Device_Model.csv'
INTO TABLE tempModels
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES
(Model, Name, Type, Carrier);
-- should be 1 duplicate

LOAD DATA LOCAL INFILE '/home/blivitsk/cpe366/project/CP_Account.csv'
INTO TABLE tempAccounts
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES
(CustomerID, EmailID, RegSrcID, RegSrcName, Zip, State, Gender, Income, Permission, Language, RegDate, Domain, Tier);

LOAD DATA LOCAL INFILE '/home/blivitsk/cpe366/project/CP_Device.csv'
INTO TABLE tempDevices
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES
(CustomerID, RegSrcID, RegSrcName, Model, Serial, PurchaseDate, PurchaseStoreName, PurchaseStoreState, PurchaseStoreCity, Ecomm, RegDate, NumReg, RegID);

LOAD DATA LOCAL INFILE '/home/blivitsk/cpe366/project/CP_Email_Final.csv'
INTO TABLE tempEmails
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES
(EmailID, Audience, Campaign, Version, Subject, DeployDate, DeployID, EventID, EventName, EmailEventDateTime, LinkName, URL, EmailID2);
-- should be 70875 warnings
