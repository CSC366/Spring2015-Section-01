CREATE TABLE DeviceRegData (
   NumCustomers INT,
   Carrier VARCHAR(20),
   RegDate VARCHAR(20),
   Name VARCHAR(35),
   PRIMARY KEY (Carrier, RegDate, Name)
);

CREATE TABLE CustomerData (
   NumCustomers INT,
   State VARCHAR(50),
   RegDate VARCHAR(20),
   Permission INT,
   PRIMARY KEY(State, RegDate, Permission)
);

CREATE TABLE EmailData (
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
   PRIMARY KEY (CampaignName, Audience, Version, Subject, DeployDate, DeployID)
);

CREATE TABLE EventData (
   MsgID INT,
   EventName VARCHAR(40),
   PRIMARY KEY(MsgID, EventName)
);
