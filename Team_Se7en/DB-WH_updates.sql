
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

INSERT INTO EmailData (MsgID, CustomerID, CampaignName,
 Audience, Version, Subject, DeployDate, DeployID)
   SELECT DISTINCT M.MsgID, E.CustomerID, C.Name, M.Audience,
      M.Version, M.Subject, M.DeployDate, M.DeployID
   FROM Campaigns C, Emails E, Messages M
   WHERE M.EmailID = E.EmailID
      AND C.CampaignID = M.CampaignID
;
