CREATE TABLE UniqueOpen (
   SELECT Event.fk_email_sent_id, IsSentTo.deployment_date, COUNT(DISTINCT Event.email_id) as num 
   FROM Event JOIN IsSentTo ON (Event.email_id = IsSentTo.fk_email_id AND Event.fk_email_sent_id = IsSentTo.fk_email_sent_id) 
   WHERE Event.fk_event_type_id = 2 
   GROUP BY Event.fk_email_sent_id, IsSentTo.deployment_date
);

CREATE TABLE Bounce AS (
   SELECT Event.fk_email_sent_id, IsSentTo.deployment_date, COUNT(DISTINCT Event.email_id) as num 
   FROM Event JOIN IsSentTo ON (Event.email_id = IsSentTo.fk_email_id AND Event.fk_email_sent_id = IsSentTo.fk_email_sent_id) 
   WHERE fk_event_type_id >= 38 AND fk_event_type_id <= 42 
   GROUP BY Event.fk_email_sent_id, IsSentTo.deployment_date
);

CREATE TABLE UniqueSent AS (
   SELECT Event.fk_email_sent_id, IsSentTo.deployment_date, COUNT(DISTINCT Event.email_id) as num 
   FROM Event JOIN IsSentTo ON (Event.email_id = IsSentTo.fk_email_id AND Event.fk_email_sent_id = IsSentTo.fk_email_sent_id) 
   WHERE fk_event_type_id = 20 
   GROUP BY Event.fk_email_sent_id, IsSentTo.deployment_date
);

CREATE TABLE UniqueClick AS (
   SELECT Event.fk_email_sent_id, IsSentTo.deployment_date, COUNT(DISTINCT Event.email_id) as num 
   FROM Event JOIN IsSentTo ON (Event.email_id = IsSentTo.fk_email_id AND Event.fk_email_sent_id = IsSentTo.fk_email_sent_id) 
   WHERE fk_event_type_id = 0 
   GROUP BY Event.fk_email_sent_id, IsSentTo.deployment_date
);

CREATE TABLE UniqueUnsub AS (
   SELECT Event.fk_email_sent_id, IsSentTo.deployment_date, COUNT(DISTINCT Event.email_id) as num 
   FROM Event JOIN IsSentTo ON (Event.email_id = IsSentTo.fk_email_id AND Event.fk_email_sent_id = IsSentTo.fk_email_sent_id) 
   WHERE fk_event_type_id = 37 
   GROUP BY Event.fk_email_sent_id, IsSentTo.deployment_date
);

CREATE TABLE UniqueDeliver AS (
   SELECT Bounce.fk_email_sent_id, Bounce.deployment_date, UniqueSent.num - Bounce.num as num
   FROM Bounce, UniqueSent
   WHERE Bounce.fk_email_sent_id = UniqueSent.fk_email_sent_id
    AND Bounce.deployment_date = UniqueSent.deployment_date
    AND UniqueSent.num - Bounce.num > 0
);

CREATE TABLE UnsubAndClick AS
   SELECT UniqueClick.fk_email_sent_id, UniqueClick.deployment_date, UniqueClick.num as `UniqueClicks`, IF(ISNULL(UniqueUnsub.num), 0, UniqueUnsub.num) as `UniqueUnsubs`
   FROM UniqueClick LEFT OUTER JOIN UniqueUnsub ON (UniqueClick.fk_email_sent_id = UniqueUnsub.fk_email_sent_id 
      AND UniqueClick.deployment_date = UniqueUnsub.deployment_date)          
   UNION
   SELECT UniqueUnsub.fk_email_sent_id, UniqueUnsub.deployment_date, IF(ISNULL(UniqueClick.num), 0, UniqueClick.num) as `UniqueClicks`, UniqueUnsub.num as `UniqueUnsubs`
   FROM UniqueClick RIGHT OUTER JOIN UniqueUnsub ON (UniqueClick.fk_email_sent_id = UniqueUnsub.fk_email_sent_id 
      AND UniqueClick.deployment_date = UniqueUnsub.deployment_date)          
;

CREATE TABLE UnsubClickOpen AS 
   SELECT UnsubAndClick.fk_email_sent_id, UnsubAndClick.deployment_date, UnsubAndClick.UniqueClicks, UnsubAndClick.UniqueUnsubs, IF(ISNULL(UniqueOpen.num), 0, UniqueOpen.num) as `UniqueOpens`
   FROM UnsubAndClick LEFT OUTER JOIN UniqueOpen ON (UniqueOpen.fk_email_sent_id = UnsubAndClick.fk_email_sent_id AND UniqueOpen.deployment_date = UnsubAndClick.deployment_date)         
   UNION
   SELECT UniqueOpen.fk_email_sent_id, UniqueOpen.deployment_date, 
          IF(ISNULL(UnsubAndClick.UniqueClicks), 0, UnsubAndClick.UniqueClicks) as `UniqueClicks`, 
          IF(ISNULL(UnsubAndClick.UniqueUnsubs), 0, UnsubAndClick.UniqueUnsubs) as `UniqueUnsubs`,
          UniqueOpen.num as `UniqueOpens`
   FROM UnsubAndClick RIGHT OUTER JOIN UniqueOpen ON (UniqueOpen.fk_email_sent_id = UnsubAndClick.fk_email_sent_id AND UniqueOpen.deployment_date = UnsubAndClick.deployment_date)         
;


-- Report #1 Datacube
CREATE TABLE EmailCampaignPerformance AS (
   SELECT EmailSent.campaign_name AS `Campaign Name`, EmailSent.audience AS `Audience`, EmailSent.version as `Version`,
          EmailSent.subject_line AS `Subject Line`, UniqueDeliver.deployment_date as `Deployment Date`,
          UniqueDeliver.num AS `Unique Emails Delivered`, 
          IF(ISNULL(UnsubClickOpen.UniqueOpens), 0, UnsubClickOpen.UniqueOpens) AS `Unique Emails Opened`, 
          IF(ISNULL(UnsubClickOpen.UniqueClicks), 0 ,UnsubClickOpen.UniqueClicks) AS `Unique Clickers`,       
          IF(ISNULL(UnsubClickOpen.UniqueOpens/UniqueDeliver.num), 0.0, UnsubClickOpen.UniqueOpens/UniqueDeliver.num) as `Open Rate`, 
          IF(ISNULL(UnsubClickOpen.UniqueClicks/UniqueDeliver.num), 0.0, UnsubClickOpen.UniqueClicks/UniqueDeliver.num) as `Click Rate`,      
          IF(ISNULL((UnsubClickOpen.UniqueClicks/UniqueDeliver.num)/(UnsubClickOpen.UniqueOpens/UniqueDeliver.num)), 0.0, (UnsubClickOpen.UniqueClicks/UniqueDeliver.num)/(UnsubClickOpen.UniqueOpens/UniqueDeliver.num)) as `Click To Open Rate`, 
          IF(ISNULL(UnsubClickOpen.UniqueUnsubs/UnsubClickOpen.UniqueOpens), 0.0, UnsubClickOpen.UniqueUnsubs/UnsubClickOpen.UniqueOpens) as `Unsub Rate`    
          FROM UniqueDeliver LEFT OUTER JOIN UnsubClickOpen ON (UnsubClickOpen.fk_email_sent_id = UniqueDeliver.fk_email_sent_id AND UnsubClickOpen.deployment_date = UniqueDeliver.deployment_date) 
          JOIN EmailSent ON (EmailSent.email_sent_id = UniqueDeliver.fk_email_sent_id)
);

-- Report #2 Datacube
CREATE TABLE AccountRegistrationReport (
   SELECT CustomerAccount.state, MONTHNAME(CustomerAccount.regDate), YEAR(CustomerAccount.regDate), CustomerAccount.permission, COUNT(*) as CustomerIDCount
   FROM CustomerAccount
   GROUP BY  CustomerAccount.state, MONTHNAME(CustomerAccount.regDate), YEAR(CustomerAccount.regDate), CustomerAccount.permission
);

-- Report #3 Datacube
CREATE TABLE DeviceRegistrationReport AS (
   SELECT DeviceModel.carrier, DeviceModel.device_model, MONTHNAME(DeviceRegistration.registration_date), YEAR(DeviceRegistration.registration_date), COUNT(*) 
   FROM DeviceRegistration, DeviceModel, CustomerAccount, IsRegisteredVia 
   WHERE DeviceRegistration.fk_device_model_id = DeviceModel.device_model 
         AND DeviceRegistration.registration_id = IsRegisteredVia.fk_registration_id 
         AND CustomerAccount.customer_id = IsRegisteredVia.fk_customer_id 
   GROUP BY DeviceModel.carrier, DeviceModel.device_model, MONTHNAME(DeviceRegistration.registration_date), YEAR(DeviceRegistration.registration_date)
 );
