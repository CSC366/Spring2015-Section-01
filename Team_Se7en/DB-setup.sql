CREATE TABLE RegSources (
    Id INT PRIMARY KEY,
    Name VARCHAR(20)
);

CREATE TABLE URLs (
    URL VARCHAR(255),
    Link VARCHAR(25),
    PRIMARY KEY (URL, Link)
);

CREATE TABLE Devices (
    Model INT PRIMARY KEY,
    Name VARCHAR(50),
    Type VARCHAR(6),
    Carrier VARCHAR(20)
);

CREATE TABLE Customers (
    Id VARCHAR(30) PRIMARY KEY,
    Zip INT,
    State CHAR(2),
    Gender CHAR(1),
    Income VARCHAR(25),
    Permission VARCHAR(6),
    Language VARCHAR(20),
    RegDate DATE,
    Tier VARCHAR(25),
    NumReg INT
);

CREATE TABLE Emails (
    Id INT PRIMARY KEY,
    Domain VARCHAR(20)
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
    Name VARCHAR(50) PRIMARY KEY,
    Audience VARCHAR(25)
);

CREATE TABLE Messages (
    DeployId INT PRIMARY KEY,
    DeployDate DATETIME,
    Subject VARCHAR(50),
    Version VARCHAR(25)
);

CREATE TABLE Events (
    TypeId PRIMARY KEY,
    TypeName VARCHAR(20)
);
