CREATE TABLE RegSources (
   Id INT PRIMARY KEY,
   Name VARCHAR(20)
);

CREATE TABLE URLs (
   Id INT AUTO_INCREMENT PRIMARY KEY,
   URL VARCHAR(255),
   Link VARCHAR(25),
   UNIQUE (URL, Link)
);

CREATE TABLE Devices (
   Model INT PRIMARY KEY,
   Name VARCHAR(50),
   Type VARCHAR(6),
   Carrier VARCHAR(20)
);

CREATE TABLE Customers (
   Id INT NOT NULL PRIMARY KEY,
   Zip INT,
   State CHAR(2),
   Gender CHAR(1),
   Income VARCHAR(25),
   Permission VARCHAR(6),
   Language VARCHAR(20),
   RegDate DATE,
   Tier VARCHAR(25),
   NumReg INT,
   RegSrc INT,
   FOREIGN KEY (RegSrc) REFERENCES RegSources(Id)
);

CREATE TABLE Emails (
   Id INT PRIMARY KEY,
   Customer INT,
   Domain VARCHAR(20),
   FOREIGN KEY (Customer) REFERENCES Customers(Id)
);

CREATE TABLE Registrations (
   Id INT PRIMARY KEY,
   PurchaseDate DATE,
   PurchaseStore VARCHAR(50),
   PurchaseState CHAR(2),
   PurchaseCity VARCHAR(30),
   Ecomm BOOLEAN,
   Serial INT
);

CREATE TABLE Campaigns (
   Id INT PRIMARY KEY AUTO_INCREMENT,
   Name VARCHAR(50) NOT NULL,
   Audience VARCHAR(25),
   UNIQUE(Name, Audience)
);

CREATE TABLE Messages (
   DeployId INT PRIMARY KEY,
   DeployDate DATETIME,
   Email INT,
   Subject VARCHAR(50),
   Version VARCHAR(25),
   FOREIGN KEY (Email) REFERENCES Emails(Id)
);

CREATE TABLE Events (
   TypeId INT PRIMARY KEY,
   TypeName VARCHAR(20)
);

