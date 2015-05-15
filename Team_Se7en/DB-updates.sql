-- populating RegSrcs
INSERT INTO RegSrcs (RegSrcID, Name)
   (SELECT DISTINCT RegSrcID, RegSrcName
    FROM tempAccounts)
   UNION
   (SELECT DISTINCT RegSrcID, RegSrcName
    FROM tempDevices)
;

-- populating Devices
-- remove bad data
DELETE FROM tempModels
WHERE Name = '';
-- insert the devices found in both Device.csv and Device_Model.csv
INSERT INTO Devices (Model, Name, Type, Carrier)
SELECT DISTINCT Model, Name, Type, Carrier
FROM tempModels;
-- insert the devices found only in Device.csv
INSERT INTO Devices (Model, Name, Type, Carrier)
SELECT DISTINCT Model, null, null, null
FROM tempDevices
WHERE Model NOT IN (SELECT DISTINCT Model
                    FROM tempModels)
;

-- populating Customers that have at least 1 registered device
INSERT INTO Customers (CustomerID, Zip, State, Gender, Income,
   Permission, Language, RegDate, Tier, NumRegs, RegSrcID)
SELECT DISTINCT Ac.CustomerID, Ac.Zip, Ac.State, Ac.Gender, Ac.Income,
   Ac.Permission, Ac.Language, Ac.RegDate, Ac.Tier,
   D.numReg, Ac.RegSrcID
FROM (SELECT DISTINCT CustomerID, Zip, State, Gender, Income,
         Permission, Language, RegDate, Tier, RegSrcID
      FROM tempAccounts
      GROUP BY CustomerID
      ORDER BY RegDate DESC) Ac,
     (SELECT DISTINCT CustomerID, numReg
      FROM tempDevices) D
WHERE Ac.CustomerID = D.CustomerID
;

-- populating Customers that have no registered devices
INSERT INTO Customers (CustomerID, Zip, State, Gender, Income,
   Permission, Language, RegDate, Tier, NumRegs, RegSrcID)
SELECT DISTINCT CustomerID, Zip, State, Gender, Income, Permission, Language,
   RegDate, Tier, 0, RegSrcID
FROM tempAccounts
WHERE CustomerID NOT IN (SELECT DISTINCT CustomerID
                         FROM tempDevices)
GROUP BY CustomerID
;

-- populating Registrations
INSERT INTO Registrations (RegID, PurchaseDate, PurchaseStoreName,
   PurchaseStoreState, PurchaseStoreCity, Ecomm, Serial, Model,
   RegDate, CustomerID, RegSrcID)
SELECT DISTINCT RegID, PurchaseDate, PurchaseStoreName, PurchaseStoreState,
   PurchaseStoreCity, Ecomm, Serial, Model, RegDate,
   CustomerID, RegSrcID
FROM tempDevices
;

-- populating Emails
INSERT INTO Emails (EmailID, Domain, CustomerID)
SELECT DISTINCT EmailID, Domain, CustomerID
FROM tempAccounts
;

-- populating Campaigns
-- drop emailID2
ALTER TABLE tempEmails
DROP COLUMN EmailID2
;

INSERT INTO Campaigns (Name)
SELECT DISTINCT Campaign
FROM tempEmails
;

-- populating Messages
INSERT INTO Messages (DeployID, DeployDate, Subject, Version, Audience, CampaignID, EmailID)
SELECT DISTINCT DeployID, DeployDate, Subject, Version, Audience, CampaignID, EmailID
FROM tempEmails, Campaigns
WHERE tempEmails.Campaign = Campaigns.Name
;

-- populating Links
INSERT INTO Links (URL, LinkName, MsgID)
SELECT DISTINCT URL, LinkName, MsgID
FROM tempEmails T, Messages M, Campaigns C
WHERE C.CampaignID = M.CampaignID
AND T.DeployID = M.DeployID
AND T.DeployDate = M.DeployDate
AND T.EmailID = M.EmailID
AND T.Audience = M.Audience
AND T.Version = M.Version
AND T.Subject = M.Subject
AND T.Campaign = C.Name
AND URL != ''
;

-- populating EventTypes
INSERT INTO EventTypes (EventID, Name)
SELECT DISTINCT EventID, EventName
FROM tempEmails
;

-- populating Events
-- This should cause 4783 Duplicates/Warnings
INSERT IGNORE INTO Events (MsgID, EventID, LinkID, EmailEventDateTime)
SELECT M.MsgID, T.EventID, LinkID, EmailEventDateTime
FROM tempEmails T, Messages M, Links L, Campaigns C
WHERE C.CampaignID = M.CampaignID
AND T.DeployID = M.DeployID
AND T.DeployDate = M.DeployDate
AND T.EmailID = M.EmailID
AND T.Audience = M.Audience
AND T.Version = M.Version
AND T.Subject = M.Subject
AND T.Campaign = C.Name
AND L.MsgID = M.MsgID
;

UPDATE Customers
SET Zip = 'N/A'
WHERE Zip = ''
;

UPDATE Customers
SET State = 'N/A'
WHERE State = ''
;

UPDATE Customers
SET Income = 'N/A'
WHERE Income = ''
;

UPDATE Customers
SET Tier = 'N/A'
WHERE Tier = ''
;

UPDATE Messages
SET Subject = 'N/A'
WHERE Subject = ''
;

UPDATE Messages
SET Version = 'N/A'
WHERE Version = ''
;

UPDATE Messages
SET Audience = 'N/A'
WHERE Audience = ''
;

UPDATE Customers SET RegDate = str_to_date(RegDate, '%m/%d/%Y');
ALTER TABLE Customers MODIFY RegDate DATE;

UPDATE Registrations SET PurchaseDate = str_to_date(PurchaseDate, '%m/%d/%Y');
ALTER TABLE Registrations MODIFY PurchaseDate DATE;

UPDATE Registrations SET RegDate = str_to_date(RegDate, '%m/%d/%Y');
ALTER TABLE Registrations MODIFY RegDate DATE;

UPDATE Events SET EmailEventDateTime = str_to_date(EmailEventDateTime, '%m/%d/%Y %l:%i %p');
ALTER TABLE Events MODIFY EmailEventDateTime DATETIME;
