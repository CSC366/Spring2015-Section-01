/* Green Team */

CREATE TABLE Customers (
   CustomerID INT PRIMARY KEY,
   RegSourceID INT,
   RegSourceName VARCHAR(64),
   ZIP CHAR(5),
   State CHAR(2),
   Gender CHAR(1),
   IncomeLevel VARCHAR(16),
   Permission BOOLEAN,
   Language CHAR(2),
   CustomerTier CHAR(3)
);

CREATE TABLE EmailAddresses (
   EmailID INT,
   EmailDomain VARCHAR(64) NOT NULL,
   CustomerID INT NOT NULL,
   CONSTRAINT PK_EmailID PRIMARY KEY (EmailID),
   CONSTRAINT FK_CustomerID FOREIGN KEY (CustomerID) 
   REFERENCES Customers(CustomerID)
);

CREATE TABLE EmailMessages (
   EmailMessageID BIGINT AUTO_INCREMENT,
   Audience VARCHAR(64) NOT NULL,
   Version VARCHAR(64) NOT NULL,
   SubjectLine VARCHAR(64) NOT NULL,
   EmailID INT NOT NULL,
   DeploymentID INT NOT NULL,
   CampaignName VARCHAR(64) NOT NULL,
   CONSTRAINT PK_EmailMessageID PRIMARY KEY (EmailMessageID),
   CONSTRAINT FK_EmailID FOREIGN KEY (EmailID) 
   REFERENCES EmailAddresses(EmailID)
);

CREATE TABLE EventTypes(
   EventTypeID INT,
   EventTypeName VARCHAR(64),
   CONSTRAINT PK_EventTypes PRIMARY KEY (EventTypeID)
);

CREATE TABLE Events (
   EventDate DATETIME NOT NULL,
   EventTypeID INT NOT NULL,
   EmailID INT,
   EmailMessageID BIGINT,
   CONSTRAINT PK_Events PRIMARY KEY (EmailID, EmailMessageID, EventTypeID),
   CONSTRAINT FK_EventType FOREIGN KEY (EventTypeID)
   REFERENCES EventTypes(EventTypeID),
   CONSTRAINT FK_Emails FOREIGN KEY (EmailID) 
   REFERENCES EmailAddresses(EmailID),
   CONSTRAINT FK_EmailMessages FOREIGN KEY (EmailMessageID)
   REFERENCES EmailMessages(EmailMessageID)
);

CREATE TABLE Links (
   LinkName VARCHAR(64),
   LinkURL VARCHAR(128),
   EmailMessageID BIGINT,
   CONSTRAINT PK_Links PRIMARY KEY (LinkName, LinkURL, EmailMessageID),
   CONSTRAINT FK_Links FOREIGN KEY (EmailMessageID) 
   REFERENCES EmailMessages (EmailMessageID)
);

CREATE TABLE EventLinkLookUp(
   LinkName VARCHAR(64),
   LinkURL VARCHAR(128),
   EmailMessageID BIGINT,
   EmailID INT,
   EventTypeID INT,
   CONSTRAINT PK_EventLinkLookUp PRIMARY KEY (EmailID, EmailMessageID, EventTypeID, LinkName, LinkURL),
   CONSTRAINT FK_EventLinkLookUpEA FOREIGN KEY (EmailID) 
   REFERENCES EmailAddresses(EmailID),
   CONSTRAINT FK_EventLinkLookUpEM FOREIGN KEY (EmailMessageID) 
   REFERENCES EmailMessages(EmailMessageID),
   CONSTRAINT FK_EventLookUpLink FOREIGN KEY (LinkName, LinkURL)
   REFERENCES Links(LinkName, LinkURL),
   CONSTRAINT FK_EventLinkLookUpET FOREIGN KEY (EventTypeID)
   REFERENCES EventTypes(EventTypeID)
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
   DeviceModel VARCHAR(64) NOT NULL, 
   CONSTRAINT PK_CustomerID PRIMARY KEY (CustomerID, DeviceModel),
   CONSTRAINT FK_PurchasesCustomerID FOREIGN KEY (CustomerID) 
   REFERENCES Customers(CustomerID),
   CONSTRAINT FK_PurchasesSerialNumber FOREIGN KEY (SerialNumber) 
   REFERENCES Devices(SerialNumber),
   CONSTRAINT FK_PurchasesDeviceModels FOREIGN KEY (DeviceModel) 
   REFERENCES DeviceModels(DeviceModel)
);

CREATE TABLE Registrations (
   RegistrationDate DATE,
   RegistrationID INT,
   RegistrationSourceID INT,
   RegistrationSourceName VARCHAR(64),
   DeviceModel VARCHAR(64) NOT NULL,
   CustomerID INT,
   SerialNumber VARCHAR(64),
   CONSTRAINT PK_Registrations PRIMARY KEY (RegistrationID),
   CONSTRAINT FK_RegistrationsCustomerID FOREIGN KEY (CustomerID) 
   REFERENCES Customers(CustomerID),
   CONSTRAINT FK_RegistrationsSerialNumber FOREIGN KEY (SerialNumber) 
   REFERENCES Devices(SerialNumber),
   CONSTRAINT FK_RegistrationsDeviceModel FOREIGN KEY (DeviceModel)
   REFERENCES DeviceModels(DeviceModel)
);
