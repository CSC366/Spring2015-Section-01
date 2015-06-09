SELECT campaign_name, audience, version, subject_line, dep_date, 
   Unique_Emails_Delivered AS delivered, Unique_Emails_Opened AS opened, Unique_Clickers AS clickers,
   Unique_Emails_Opened / Unique_Emails_Delivered AS open_rate,
   Unique_Clickers / Unique_Emails_Opened AS click_to_open_rate,
   Unique_Clickers / Unique_Emails_Delivered AS click_rate,
   Unsubscribed / Unique_Emails_Opened AS unsub_rate
FROM CampaignPerformanceCube4D
GROUP BY campaign_name, audience, version, subject_line, dep_date
;

-- CSV Query
/*SELECT CONCAT_WS(',', IFNULL(campaign_name, "NULL"), IFNULL(audience, "NULL"), IFNULL(version, "NULL"), IFNULL(subject_line, "NULL"), IFNULL(dep_date, "NULL"),  
   Unique_Emails_Delivered, Unique_Emails_Opened, Unique_Clickers,
   IFNULL(Unique_Emails_Opened / Unique_Emails_Delivered, "NULL"),
   IFNULL(Unique_Clickers / Unique_Emails_Opened, "NULL"),
   IFNULL(Unique_Clickers / Unique_Emails_Delivered,"NULL"),
   IFNULL(Unsubscribed / Unique_Emails_Opened, "NULL"))
FROM CampaignPerformanceCube4D
GROUP BY campaign_name, audience, version, subject_line, dep_date
;
*/