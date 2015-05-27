CREATE TABLE IF NOT EXISTS Customers (
CustomerID INT,
RegSourceID INT,
RegSourceName VARCHAR(64),
ZIP CHAR(5),
State CHAR(64),
Gender CHAR(1),
IncomeLevel VARCHAR(32),
Permission BOOLEAN,
Language CHAR(2),
CustomerTier CHAR(3),
CONSTRAINT PK_CustomerID PRIMARY KEY (CustomerID)
);

CREATE TABLE IF NOT EXISTS EmailAddresses (
EmailID INT,
EmailDomain VARCHAR(64) NOT NULL,
CustomerID INT NOT NULL,
CONSTRAINT PK_EmailID PRIMARY KEY (EmailID),
CONSTRAINT FK_CustomerID FOREIGN KEY (CustomerID)
REFERENCES Customers(CustomerID)
);

CREATE TABLE IF NOT EXISTS EmailMessages (
EmailMessageID INT,
Audience VARCHAR(64) NOT NULL,
Version VARCHAR(64) NOT NULL,
SubjectLine VARCHAR(4) NOT NULL,
CampaignName VARCHAR(64) NOT NULL,
CONSTRAINT PK_EmailMessageID PRIMARY KEY(EmailMessageID),
CONSTRAINT UC_EmailMessages UNIQUE (Audience, Version, SubjectLine, CampaignName)
);

CREATE TABLE IF NOT EXISTS EmailMessagesSent (
EmailMessageID INT,
EmailID INT,
DeploymentID INT NOT NULL,
DeploymentDate DATE NOT NULL,
CONSTRAINT PK_EmailMessagesSent PRIMARY KEY (EmailMessageID, EmailID),
CONSTRAINT FK_EmailMessageID FOREIGN KEY (EmailMessageID)
REFERENCES EmailMessages(EmailMessageID),
CONSTRAINT FK_EmailID FOREIGN KEY (EmailID)
REFERENCES EmailAddresses(EmailID)
);

CREATE TABLE IF NOT EXISTS EventTypes (
EventTypeID INT,
EventTypeName VARCHAR(64),
CONSTRAINT PK_EventTypes PRIMARY KEY (EventTypeID)
);

CREATE TABLE IF NOT EXISTS Events (
EventDate DATETIME NOT NULL,
EventTypeID INT NOT NULL,
EmailID INT,
EmailMessageID INT,
CONSTRAINT PK_Events PRIMARY KEY (EmailID, EmailMessageID, EventTypeID),
CONSTRAINT FK_EventType FOREIGN KEY (EventTypeID)
REFERENCES EventTypes(EventTypeID),
CONSTRAINT FK_EmailMessagesSent FOREIGN KEY (EmailMessageID, EmailID)
REFERENCES EmailMessagesSent(EmailMessageID, EmailID)
);

CREATE TABLE IF NOT EXISTS Links (
LinkName VARCHAR(128),
LinkURL VARCHAR(255),
EmailMessageID INT,
CONSTRAINT PK_Links PRIMARY KEY (LinkName, LinkURL, EmailMessageID),
CONSTRAINT FK_Links FOREIGN KEY (EmailMessageID)
REFERENCES EmailMessages (EmailMessageID)
);

CREATE TABLE IF NOT EXISTS EventLinkLookUp (
LinkName VARCHAR(128),
LinkURL VARCHAR(255),
EmailMessageID INT,
EmailID INT,
EventTypeID INT,
CONSTRAINT PK_EventLinkLookUp PRIMARY KEY (EmailID, EmailMessageID, EventTypeID, LinkName, LinkURL),
CONSTRAINT FK_EventLinkLookUpEMS FOREIGN KEY (EmailMessageID, EmailID)
REFERENCES EmailMessagesSent(EmailMessageID, EmailID),
CONSTRAINT FK_EventLookUpLink FOREIGN KEY (LinkName, LinkURL)
REFERENCES Links(LinkName, LinkURL),
CONSTRAINT FK_EventLinkLookUpET FOREIGN KEY (EventTypeID)
REFERENCES EventTypes(EventTypeID)
);

CREATE TABLE IF NOT EXISTS DeviceModels (
DeviceModel VARCHAR(64),
DeviceName VARCHAR(64),
DeviceType VARCHAR(64),
Carrier VARCHAR(64),
CONSTRAINT PK_DeviceModel PRIMARY KEY (DeviceModel)
);

CREATE TABLE IF NOT EXISTS Devices (
DeviceID INT,
SerialNumber VARCHAR(64) NOT NULL,
DeviceModel VARCHAR(64) NOT NULL,
CONSTRAINT PK_DeviceID PRIMARY KEY (DeviceID),
CONSTRAINT FK_DeviceModel FOREIGN KEY (DeviceModel)
REFERENCES DeviceModels(DeviceModel)
);

CREATE TABLE IF NOT EXISTS Purchases (
PurchaseID INT,
PurchaseDate DATETIME,
PurchaseStoreName VARCHAR(64),
PurchaseStoreCity VARCHAR(64),
PurchaseStoreState CHAR(4),
ECommFlag BOOLEAN,
CustomerID INT,
DeviceID INT,
DeviceModel VARCHAR(64) NOT NULL,
CONSTRAINT PK_PurchaseID PRIMARY KEY (PurchaseID),
CONSTRAINT FK_PurchasesCustomerID FOREIGN KEY (CustomerID)
REFERENCES Customers(CustomerID),
CONSTRAINT FK_PurchasesDeviceID FOREIGN KEY (DeviceID)
REFERENCES Devices(DeviceID),
CONSTRAINT FK_PurchasesDeviceModels FOREIGN KEY (DeviceModel)
REFERENCES DeviceModels(DeviceModel)
);

CREATE TABLE IF NOT EXISTS Registrations (
RegistrationDate DATE,
RegistrationID INT,
RegistrationSourceID INT,
RegistrationSourceName VARCHAR(64),
DeviceModel VARCHAR(64) NOT NULL,
CustomerID INT,
DeviceID INT,
CONSTRAINT PK_Registrations PRIMARY KEY (RegistrationID),
CONSTRAINT FK_RegistrationsCustomerID FOREIGN KEY (CustomerID)
REFERENCES Customers(CustomerID),
CONSTRAINT FK_RegistrationsDeviceID FOREIGN KEY (DeviceID)
REFERENCES Devices(DeviceID),
CONSTRAINT FK_RegistrationsDeviceModel FOREIGN KEY (DeviceModel)
REFERENCES DeviceModels(DeviceModel)
);

