CREATE TABLE RegSrcs(
   RegSrcID INT PRIMARY KEY,
   Name VARCHAR(30)
);

CREATE TABLE Devices(
   Model VARCHAR(50) PRIMARY KEY,
   Name VARCHAR(35),
   Type VARCHAR(6),
   Carrier VARCHAR(20)
);

CREATE TABLE Customers(
   CustomerID INT PRIMARY KEY,
   Zip INT,
   State VARCHAR(14),
   Gender CHAR(1),
   Income VARCHAR(20),
   Permission INT,
   Language CHAR(2),
   RegDate VARCHAR(20),
   Tier CHAR(3),
   NumRegs INT,
   RegSrcID INT,
   FOREIGN KEY (RegSrcID) REFERENCES RegSrcs(RegSrcID)
);

CREATE TABLE Registrations(
   RegID INT PRIMARY KEY,
   PurchaseDate VARCHAR(20),
   PurchaseStoreName VARCHAR(21),
   PurchaseStoreState CHAR(2),
   PurchaseStoreCity VARCHAR(50),
   Ecomm INT,
   Serial VARCHAR(20),
   Model VARCHAR(50),
   RegDate VARCHAR(20),
   FOREIGN KEY (Model) REFERENCES Devices(Model),
   CustomerID INT,
   FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
   RegSrcID INT,
   FOREIGN KEY (RegSrcID) REFERENCES RegSrcs(RegSrcID)
);

CREATE TABLE Emails(
   EmailID INT PRIMARY KEY,
   Domain VARCHAR(30),
   CustomerID INT,
   FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

CREATE TABLE Campaigns(
   CampaignID INT PRIMARY KEY AUTO_INCREMENT,
   Name VARCHAR(50) UNIQUE
);

CREATE TABLE Messages(
   MsgID INT PRIMARY KEY AUTO_INCREMENT,
   DeployID INT,
   DeployDate VARCHAR(20),
   Subject VARCHAR(3),
   Version VARCHAR(30),
   Audience VARCHAR(40),
   CampaignID INT,
   FOREIGN KEY (CampaignID) REFERENCES Campaigns(CampaignID),
   EmailID INT,
   FOREIGN KEY (EmailID) REFERENCES Emails(EmailID),
   UNIQUE(DeployID, CampaignID, EmailID, Audience, Version, Subject, DeployDate)
);

CREATE TABLE Links(
   LinkID INT PRIMARY KEY AUTO_INCREMENT,
   URL VARCHAR(255),
   LinkName VARCHAR(40),
   MsgID INT,
   FOREIGN KEY (MsgID) REFERENCES Messages(MsgID),
   UNIQUE(URL, LinkName, MsgID)
);

CREATE TABLE Events(
   EventNum INT PRIMARY KEY AUTO_INCREMENT,
   MsgID INT,
   FOREIGN KEY (MsgID) REFERENCES Messages(MsgID),
   EventID INT,
   UNIQUE(MsgID, EventID),
   LinkID INT,
   EmailEventDateTime VARCHAR(20),
   FOREIGN KEY (LinkID) REFERENCES Links(LinkID)
);

CREATE TABLE EventTypes(
   EventNum INT PRIMARY KEY,
   FOREIGN KEY (EventNum) REFERENCES Events(EventNum)
   Name VARCHAR(20)
);
