INSERT INTO DeviceRegData (NumCustomers, Carrier, RegDate, Name)
   SELECT DISTINCT COUNT(*) NumCustomers, D.Carrier, MONTHNAME(R.RegDate) Month, D.Name
   FROM Registrations R, Devices D
   WHERE R.Model = D.Model
   GROUP BY D.Carrier, MONTHNAME(R.RegDate), D.Name
;

INSERT INTO CustomerData (NumCustomers, State, RegDate, Permission)
   SELECT DISTINCT COUNT(*) NumCustomers, State, MONTHNAME(RegDate) Month, Permission
   FROM Customers
   GROUP BY State, MONTHNAME(RegDate), Permission
;

INSERT INTO EventData (MsgID, EventName)
   SELECT DISTINCT MsgID, Name
   FROM Events, EventTypes
   WHERE Events.EventID = EventTypes.EventID
;

INSERT INTO EmailData (CampaignName, Audience, Version, Subject,
            DeployDate, DeployID, UniqueOpens, UniqueDelivers,
            UniqueClicks, UniqueUnsubs)
   SELECT C.Name, sent.Audience, sent.Version, sent.Subject, sent.DeployDate,
          sent.DeployID, opened.NumOpened,
          sent.NumSent - bounced.NumBounced NumDelivered,
          clicked.NumClicks, unsubbed.NumUnsubs
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
              M.DeployID) unsubbed,
   Campaigns C
   WHERE sent.DeployID = bounced.DeployID
     AND sent.DeployDate = bounced.DeployDate
     AND sent.Subject = bounced.Subject
     AND sent.Version = bounced.Version
     AND sent.Audience = bounced.Audience
     AND sent.Campaign = bounced.Campaign
     AND sent.DeployID = opened.DeployID
     AND sent.DeployDate = opened.DeployDate
     AND sent.Subject = opened.Subject
     AND sent.Version = opened.Version
     AND sent.Audience = opened.Audience
     AND sent.Campaign = opened.Campaign
     AND sent.DeployID = clicked.DeployID
     AND sent.DeployDate = clicked.DeployDate
     AND sent.Subject = clicked.Subject
     AND sent.Version = clicked.Version
     AND sent.Audience = clicked.Audience
     AND sent.Campaign = clicked.Campaign
     AND sent.DeployID = unsubbed.DeployID
     AND sent.DeployDate = unsubbed.DeployDate
     AND sent.Subject = unsubbed.Subject
     AND sent.Version = unsubbed.Version
     AND sent.Audience = unsubbed.Audience
     AND sent.Campaign = unsubbed.Campaign
     AND sent.Campaign = C.CampaignID
;
