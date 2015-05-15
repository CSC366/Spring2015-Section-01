
CREATE TABLE RegSrcs (
   RegSrcID INT PRIMARY KEY,
   Name VARCHAR(30)
);

CREATE TABLE Devices (
   Model VARCHAR(50) PRIMARY KEY,
   Name VARCHAR(35),
   Type VARCHAR(6),
   Carrier VARCHAR(20)
);

CREATE TABLE Customers (
   CustomerID INT PRIMARY KEY,
   Zip VARCHAR(5) DEFAULT 'N/A',
   State CHAR(50) DEFAULT 'N/A',
   Gender CHAR(1),
   Income VARCHAR(20) 'N/A',
   Permission INT,
   Language CHAR(2),
   RegDate VARCHAR(20),
   Tier CHAR(3) 'N/A',
   NumRegs INT,
   RegSrcID INT,
   FOREIGN KEY (RegSrcID) REFERENCES RegSrcs(RegSrcID)
);

CREATE TABLE Registrations (
   RegID INT PRIMARY KEY,
   PurchaseDate VARCHAR(20),
   PurchaseStoreName VARCHAR(30),
   PurchaseStoreState VARCHAR(3),
   PurchaseStoreCity VARCHAR(50),
   Ecomm INT,
   Serial VARCHAR(20),
   Model VARCHAR(50),
   RegDate VARCHAR(20),
   CustomerID INT,
   RegSrcID INT,
   FOREIGN KEY (Model) REFERENCES Devices(Model),
   FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
   FOREIGN KEY (RegSrcID) REFERENCES RegSrcs(RegSrcID)
);

CREATE TABLE Emails (
   EmailID INT PRIMARY KEY,
   Domain VARCHAR(50),
   CustomerID INT,
   FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

CREATE TABLE Campaigns (
   CampaignID INT PRIMARY KEY AUTO_INCREMENT,
   Name VARCHAR(50) UNIQUE
);

CREATE TABLE Messages (
   MsgID INT PRIMARY KEY AUTO_INCREMENT,
   DeployID INT,
   DeployDate VARCHAR(20),
   Subject VARCHAR(3) DEFAULT 'N/A',
   Version VARCHAR(50) DEFAULT 'NoVersion',
   Audience VARCHAR(50) DEFAULT 'NoAudience',
   CampaignID INT,
   EmailID INT,
   FOREIGN KEY (CampaignID) REFERENCES Campaigns(CampaignID),
   FOREIGN KEY (EmailID) REFERENCES Emails(EmailID),
   UNIQUE (DeployID, CampaignID, EmailID, Audience, Version, Subject, DeployDate)
);

CREATE TABLE Links (
   LinkID INT PRIMARY KEY AUTO_INCREMENT,
   URL VARCHAR(255),
   LinkName VARCHAR(100),
   MsgID INT,
   FOREIGN KEY (MsgID) REFERENCES Messages(MsgID),
   UNIQUE (URL, LinkName, MsgID)
);

CREATE TABLE EventTypes (
   EventID INT PRIMARY KEY,
   Name VARCHAR(40)
);

CREATE TABLE Events (
   MsgID INT,
   EventID INT,
   LinkID INT,
   EmailEventDateTime VARCHAR(20),
   PRIMARY KEY (MsgID, EventID, LinkID, EmailEventDateTime),
   FOREIGN KEY (MsgID) REFERENCES Messages(MsgID),
   FOREIGN KEY (LinkID) REFERENCES Links(LinkID),
   FOREIGN KEY (EventID) REFERENCES EventTypes(EventId)
);
