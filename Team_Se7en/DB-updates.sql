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
-- insert
INSERT INTO Devices (Model, Name, Type, Carrier)
   SELECT DISTINCT Model, Name, Type, Carrier
   FROM tempModels
;

-- populating Customers
INSERT INTO Customers (CustomerID, Zip, State, Gender, Income,
   Permission, Language, RegDate, Tier, NumRegs, RegSrcID)
   SELECT DISTINCT Ac.CustomerId, Ac.Zip, Ac.State, Ac.Gender, Ac.Income,
          Ac.Permission, Ac.Language, Ac.RegDate, Ac.Tier,
          D.numReg, Ac.RegSrcID
   FROM (SELECT DISTINCT CustomerID, Zip, State, Gender, Income,
                         Permission, Language, RegDate, Tier, RegSrcID
         FROM tempAccounts
         GROUP BY CustomerID) Ac,
        (SELECT DISTINCT CustomerID, numReg
         FROM tempDevices) D
   WHERE Ac.CustomerID = D.CustomerID
      OR Ac.CustomerID NOT IN (SELECT DISTINCT CustomerID
                               FROM tempDevices)
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
   FROM tempDevices
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
   WHERE C.Name = M.Campaign
     AND T.DeployID = M.DeployID
     AND T.DeployDate = M.DeployDate
     AND T.EmailID = M.EmailID
     AND T.Audience = M.Audience
     AND T.Version = M.Version
     AND T.Subject = M.Subject
     AND T.Campaign = M.Campaign
;

-- populating EventTypes
INSERT INTO EventTypes (EventID, Name)
   SELECT DISTINCT EventID, EventName
   FROM tempEmails
;

-- populating Events
INSERT INTO Events (EventID, MsgID, EventID, LinkID, EmailEventDateTime)
   SELECT EventID, MsgID, EventID, LinkID, EmailEventDateTime
   FROM tempEmails T, Messages M, Links L, EventTypes E, Campaigns C
   WHERE C.Name = M.Campaign
     AND T.DeployID = M.DeployID
     AND T.DeployDate = M.DeployDate
     AND T.EmailID = M.EmailID
     AND T.Audience = M.Audience
     AND T.Version = M.Version
     AND T.Subject = M.Subject
     AND T.Campaign = M.Campaign
     AND T.EventID = E.EventID
     AND L.MsgID = M.MsgID
;
