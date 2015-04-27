/* Green Team */

CREATE TABLE Customers (
   CustomerID INT PRIMARY KEY,
   RegSourceID INT,
   RegSourceName VARCHAR(64),
   ZIP CHAR(5),
   State CHAR(2),
   Gender CHAR(1),
   IncomeLevel INT,
   Permission BOOLEAN,
   Language VARCHAR(64),
   CustomerTier VARCHAR(64)
);

CREATE TABLE EmailCampaigns (
   CampaignName VARCHAR(64),
   CONSTRAINT PK_EmailCampaignID PRIMARY KEY (CampaignName)
);

CREATE TABLE EmailMessages (
   Audience VARCHAR(64),
   Version VARCHAR(64),
   SubjectLine VARCHAR(64),
   EmailID VARCHAR(64),
   CONSTRAINT PK_EmailMessageID PRIMARY KEY (Audience, Version, SubjectLine, EmailID)
   CONSTRAINT FK_EmailID FOREIGN KEY (EmailID)
   REFERENCES EmailAddresses(EmailID)
);

CREATE TABLE EmailAddresses (
   EmailID VARCHAR(64),
   EmailDomain VARCHAR(64),
   CustomerID INT,
   CONSTRAINT PK_EmailID PRIMARY KEY (EmailID),
   CONSTRAINT FK_CustomerID FOREIGN KEY (FK_CustomerID)
   REFERENCES Customers(FK_CustomerID)
);

CREATE TABLE Events (
   EventDate DATETIME,
   LinkName VARCHAR(64),
   LinkURL VARCHAR(128),
   EventTypeId INT,
   CONSTRAINT PK_Events PRIMARY KEY (EventDate, LinkName, LinkURL),
   CONSTRAINT FK_EventType FOREIGN KEY (EventTypeId)
   REFERENCES EventTypes(EventTypeId),
   CONSTRAINT FK_Links FOREIGN KEY (LinkName, LinkURL)
   REFERENCES Links(LinkName, LinkURL)
);

CREATE TABLE Links (
   LinkName VARCHAR(64),
   LinkURL VARCHAR(128)
);

CREATE TABLE EventTypes(
   EventTypeId INT,
   EventTypeName VARCHAR(64),
   CONSTRAINT PK_EventTypes PRIMARY KEY (EventTypeId)
);

CREATE TABLE DeviceModels (
   DeviceModel VARCHAR(64),
   DeviceName VARCHAR(64),
   DeviceType VARCHAR(64),
   Carrier VARCHAR(64),
   CONSTRAINT PK_DeviceModel PRIMARY KEY (DeviceModel)
);

CREATE TABLE Devices(
   SerialNumber VARCHAR(64),
   DeviceModel VARCHAR(64) NOT NULL,
   CONSTRAINT PK_SerialNumber PRIMARY KEY (SerialNumber),
   CONSTRAINT FK_DeviceModel FOREIGN KEY (DeviceModel)
   REFERENCES DeviceModels(DeviceModel)
);

CREATE TABLE Purchases (
   PurchaseDate DATETIME,
   PurchaseStoreName VARCHAR(64),
   PurchaseStoreCity VARCHAR(64),
   PurchaseStoreState CHAR(2),
   ECommFlag BOOLEAN,
   CustomerID INT,
   SerialNumber VARCHAR(64),
   CONSTRAINT PK_CustomerID PRIMARY KEY (CustomerID),
   CONSTRAINT FK_CustomerID FOREIGN KEY (CustomerID)
   REFERENCES Customers(CustomerID)
   CONSTRAINT FK_SerialNumber FOREIGN KEY (SerialNumber)
   REFERENCES Devices(SerialNumber)
);

CREATE TABLE Registrations (
   RegistrationDate DATE,
   RegistrationID INT,
   RegistrationSourceID INT,
   RegistrationSourceName VARCHAR(64),
   DeviceModel VARCHAR(64),
   CustomerID VARCHAR(64),
   SerialNumber VARCHAR(64),
   CONSTRAINT PK_Registrations PRIMARY KEY (RegistrationID),
   CONSTRAINT FK_CustomerID FOREIGN KEY (CustomerID)
   REFERENCES Customers(CustomerID)
   CONSTRAINT FK_SerialNumber FOREIGN KEY (SerialNumber)
   REFERENCES Devices(SerialNumber)
);
