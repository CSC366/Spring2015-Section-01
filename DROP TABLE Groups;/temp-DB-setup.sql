CREATE TABLE temp_CP_Account (
   ID INT NOT NULL AUTO_INCREMENT,
   CustomerID VARCHAR(10),
   EmailID VARCHAR(10),
   RegSourceID VARCHAR(2),
   RegSourceName VARCHAR(12),
   ZIP VARCHAR(5),
   State VARCHAR(40),
   Gender VARCHAR(1),
   IncomeLevel VARCHAR(20),
   Permission VARCHAR(1),
   `Language` VARCHAR(2),
   RegDate DATE,
   DomainName VARCHAR(33),
   CustomerTier VARCHAR(10),
   PRIMARY KEY (ID)
);

CREATE TABLE temp_CP_Device (
   ID INT NOT NULL AUTO_INCREMENT,
   CustomerID VARCHAR(10),
   SourceID VARCHAR(3),
   SourceName VARCHAR(30),
   DeviceModel VARCHAR(50),
   SerialNumber VARCHAR(18),
   PurchaseDate DATE,
   PurchaseStoreName VARCHAR(30),
   PurchaseStoreState VARCHAR(3),
   PurchaseStoreCity VARCHAR(40),
   Ecomm CHAR(1),
   RegistrationDate DATE,
   NumberOfRegistrations VARCHAR(2),
   RegistrationID VARCHAR(9),
   PRIMARY KEY (ID)
);

CREATE TABLE temp_CP_Device_Model (
   ID INT NOT NULL AUTO_INCREMENT,
   Device_Model VARCHAR(50),
   Device_Name VARCHAR(35),
   Device_Type VARCHAR(6),
   Carrier VARCHAR(17),
   PRIMARY KEY (ID)
);

CREATE TABLE temp_CP_Email (
   ID INT NOT NULL AUTO_INCREMENT,
   EmailID VARCHAR(10),
   AudienceSegment VARCHAR(44),
   EmailCampaignName VARCHAR(50),
   EmailVersion VARCHAR(28),
   SubjectLineCode VARCHAR(3),
   Fulldate date,
   DeploymentID VARCHAR(7),
   EmailEventKey VARCHAR(2),
   EmailEventType VARCHAR(22),
   EmailEventDateTime datetime,
   HyperlinkName VARCHAR(100),
   EmailURL VARCHAR(200),
   PRIMARY KEY (ID)
);


