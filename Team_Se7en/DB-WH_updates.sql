
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
   SELECT
   FROM
   (SELECT COUNT(*) NumSent, M.DeployID DeployID, M.DeployDate DeployDate,
           M.Subject Subject, M.Version Version, M.Audience Audience,
           M.CampaignID Campaign
    FROM EventData ED, Emails E, Messages M
    WHERE ED.MsgID = M.MsgID
      AND M.EmailID = E.EmailID
      AND ED.EventName = 'Email Sent/Delivered'
     GROUP BY M.CampaignID, M.Audience, M.Version, M.Subject, M.DeployDate,
              M.DeployID) sent,
   (SELECT COUNT(*) NumBounced, M.DeployID DeployID, M.DeployDate DeployDate,
           M.Subject Subject, M.Version Version, M.Audience Audience,
           M.CampaignID Campaign
    FROM EventData ED, Emails E, Messages M
    WHERE ED.MsgID = M.MsgID
      AND M.EmailID = E.EmailID
      AND (ED.EventName = 'Unknown bounce'
        OR ED.EventName = 'Technical/Other bounce'
        OR ED.EventName = 'Hard bounce'
        OR ED.EventName = 'Soft bounce'
        OR ED.EventName = 'Block bounce')
     GROUP BY M.CampaignID, M.Audience, M.Version, M.Subject, M.DeployDate,
              M.DeployID) bounced,
   (SELECT COUNT(*) NumOpened, M.DeployID DeployID, M.DeployDate DeployDate,
           M.Subject Subject, M.Version Version, M.Audience Audience,
           M.CampaignID Campaign
    FROM EventData ED, Emails E, Messages M
    WHERE ED.MsgID = M.MsgID
      AND M.EmailID = E.EmailID
      AND ED.EventName = 'Email Opened'
     GROUP BY M.CampaignID, M.Audience, M.Version, M.Subject, M.DeployDate,
              M.DeployID) opened,
   (SELECT COUNT(*) NumClicks, M.DeployID DeployID, M.DeployDate DeployDate,
           M.Subject Subject, M.Version Version, M.Audience Audience,
           M.CampaignID Campaign
    FROM EventData ED, Emails E, Messages M
    WHERE ED.MsgID = M.MsgID
      AND M.EmailID = E.EmailID
      AND ED.EventName = 'Click'
     GROUP BY M.CampaignID, M.Audience, M.Version, M.Subject, M.DeployDate,
              M.DeployID) clicked,
   (SELECT COUNT(*) NumUnsubs, M.DeployID DeployID, M.DeployDate DeployDate,
           M.Subject Subject, M.Version Version, M.Audience Audience,
           M.CampaignID Campaign
    FROM EventData ED, Emails E, Messages M
    WHERE ED.MsgID = M.MsgID
      AND M.EmailID = E.EmailID
      AND ED.EventName = 'Unsubscribe'
     GROUP BY M.CampaignID, M.Audience, M.Version, M.Subject, M.DeployDate,
              M.DeployID) unsubbed
   WHERE
;


-- (SELECT COUNT(EventID) AS Bounced
--  FROM Events
--  WHERE EventID = 40) t5

-- SELECT DISTINCT M.MsgID, E.CustomerID, C.Name, M.Audience, M.Version,
--      M.Subject, M.DeployDate, M.DeployID, t1.Opens, (t2.Delivers - t5.Bounced), t3.Clicks, t4.Unsubs
