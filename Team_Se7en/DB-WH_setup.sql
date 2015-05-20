/*
 * Setup for the Rosetta Project Data Warehouse
 */

CREATE TABLE DeviceRegData (
   CustomerID INT,
   Carrier VARCHAR(20),
   RegDate DATE,
   Name VARCHAR(35),
   PRIMARY KEY (CustomerID, Carrier, RegDate, Name)
);

CREATE TABLE CustomerData (
   CustomerID INT PRIMARY KEY,
   State VARCHAR(50),
   RegDate DATE,
   Permission INT
);

CREATE TABLE EmailData (
   MsgID INT,
   CustomerID INT,
   CampaignName VARCHAR(50),
   Audience VARCHAR(50),
   Version VARCHAR(50),
   Subject VARCHAR(3),
   DeployDate DATE,
   DeployID INT,
   UniqueOpens INT,
   UniqueDelivers INT,
   UniqueClicks INT,
   UniqueUnsubs INT,
   PRIMARY KEY (MsgID, CustomerID)
);

CREATE TABLE EventData (
   MsgID INT,
   EventName VARCHAR(40)
);
