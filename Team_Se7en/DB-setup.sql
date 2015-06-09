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
   State VARCHAR(50) DEFAULT 'N/A',
   Gender CHAR(1),
   Income VARCHAR(20) DEFAULT 'N/A',
   Permission INT,
   Language CHAR(2),
   RegDate DATE,
   Tier CHAR(3) DEFAULT 'N/A',
   NumRegs INT,
   RegSrcID INT,
   FOREIGN KEY (RegSrcID) REFERENCES RegSrcs(RegSrcID)
);

CREATE TABLE Registrations (
   RegID INT PRIMARY KEY,
   PurchaseDate DATE,
   PurchaseStoreName VARCHAR(30),
   PurchaseStoreState VARCHAR(3),
   PurchaseStoreCity VARCHAR(50),
   Ecomm INT,
   Serial VARCHAR(20),
   Model VARCHAR(50),
   RegDate DATE,
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
   DeployDate DATE,
   Subject VARCHAR(3) DEFAULT 'N/A',
   Version VARCHAR(50) DEFAULT 'N/A',
   Audience VARCHAR(50) DEFAULT 'N/A',
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

INSERT INTO Links (URL, LinkName, MsgID) VALUES ('N/A', 'N/A', null);

CREATE TABLE EventTypes (
   EventID INT PRIMARY KEY,
   Name VARCHAR(40)
);

CREATE TABLE Events (
   MsgID INT,
   EventID INT,
   LinkID INT,
   EmailEventDateTime DATETIME,
   PRIMARY KEY (MsgID, EventID, LinkID, EmailEventDateTime),
   FOREIGN KEY (MsgID) REFERENCES Messages(MsgID),
   FOREIGN KEY (LinkID) REFERENCES Links(LinkID),
   FOREIGN KEY (EventID) REFERENCES EventTypes(EventID)
);
