
INSERT INTO DeviceRegData (CustomerID, Carrier, RegDate, Name)
   SELECT DISTINCT R.CustomerID, D.Carrier, R.RegDate, D.Name
   FROM Registrations R, Devices D
   WHERE R.Model = D.Model
;

INSERT INTO CustomerData (CustomerID, State, RegDate, Permission)
   SELECT DISTINCT CustomerID, State, RegDate, Permission
   FROM Customers
;

INSERT INTO EventData (MsgID, EventName)
   SELECT DISTINCT MsgID, Name
   FROM Events, EventTypes
   WHERE Events.EventID = EventTypes.EventID
;

-- UNFINISHED
INSERT INTO EmailData (MsgID, CustomerID, CampaignName, Audience, Version,
Subject, DeployDate, DeployID, UniqueOpens, UniqueDelivers, UniqueClicks, UniqueUnsubs)
   SELECT DISTINCT M.MsgID, E.CustomerID, C.Name, M.Audience, M.Version,
      M.Subject, M.DeployDate, M.DeployID, t1.Opens, t2.Delivers, t3.Clicks, t4.Unsubs
   FROM Campaigns C, Emails E, Messages M, 
      (SELECT COUNT(EventID) AS Opens
       FROM Events
       WHERE EventID = 2) t1,
      (SELECT COUNT(EventID) AS Delivers
       FROM Events
       WHERE EventID = 20) t2,
      (SELECT COUNT(DISTINCT Messages.EmailID) AS Clicks
       FROM Events, Messages
       WHERE Events.MsgID = Messages.MsgID
          AND EventID = 0) t3,
      (SELECT COUNT(EventID) AS Unsubs
       FROM Events
       WHERE EventID = 37) t4
   WHERE M.EmailID = E.EmailID
      AND C.CampaignID = M.CampaignID
;

-- (SELECT COUNT(EventID) AS Bounced
--  FROM Events
--  WHERE EventID = 40) t5

--SELECT DISTINCT M.MsgID, E.CustomerID, C.Name, M.Audience, M.Version,
--      M.Subject, M.DeployDate, M.DeployID, t1.Opens, (t2.Delivers - t5.Bounced), t3.Clicks, t4.Unsubs
