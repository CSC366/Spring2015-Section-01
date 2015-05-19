CREATE TABLE UniqueOpen AS (
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
    AND UniqueSent.num - Bounce.num >= 0
);

-- Report #1 Datacube
CREATE TABLE EmailCampaignPerformance AS (
   SELECT EmailSent.campaign_name AS `Campaign Name`, EmailSent.audience AS `Audience`, EmailSent.version as `Version`,       
          EmailSent.subject_line AS `Subject Line`, UniqueDeliver.deployment_date as `Deployment Date`,       
          UniqueDeliver.num AS `Unique Emails Delivered`, UniqueOpen.num AS `Unique Emails Opened`, UniqueClick.num AS `Unique Clickers`,       
          (UniqueOpen.num/UniqueDeliver.num) as `Open Rate`, (UniqueClick.num/UniqueDeliver.num) as `Click Rate`,      
          ((UniqueClick.num/UniqueDeliver.num)/(UniqueOpen.num/UniqueDeliver.num)) as `Click To Open Rate`, (UniqueUnsub.num/UniqueOpen.num) as `Unsub Rate`    
          FROM UniqueClick JOIN UniqueUnsub ON (UniqueClick.fk_email_sent_id = UniqueUnsub.fk_email_sent_id 
               AND UniqueClick.deployment_date = UniqueUnsub.deployment_date)          
          JOIN UniqueDeliver ON (UniqueClick.fk_email_sent_id = UniqueDeliver.fk_email_sent_id AND UniqueClick.deployment_date = UniqueDeliver.deployment_date) 
          JOIN UniqueOpen ON (UniqueOpen.fk_email_sent_id = UniqueClick.fk_email_sent_id AND UniqueOpen.deployment_date = UniqueClick.deployment_date)         
          JOIN EmailSent ON (EmailSent.email_sent_id = UniqueOpen.fk_email_sent_id)
);

-- Report #2 Datacube
CREATE TABLE AccountRegistrationReport (
   SELECT CustomerAccount.state, MONTHNAME(CustomerAccount.regDate), CustomerAccount.permission, COUNT(*) as CustomerIDCount
   FROM CustomerAccount
   GROUP BY  CustomerAccount.state, MONTHNAME(CustomerAccount.regDate), CustomerAccount.permission
);

-- Report #3 Datacube
CREATE TABLE DeviceRegistrationReport AS (
   SELECT DeviceModel.carrier, DeviceModel.device_model, MONTHNAME(DeviceRegistration.registration_date), COUNT(*) 
   FROM DeviceRegistration, DeviceModel, CustomerAccount, IsRegisteredVia 
   WHERE DeviceRegistration.fk_device_model_id = DeviceModel.device_model 
         AND DeviceRegistration.registration_id = IsRegisteredVia.fk_registration_id 
         AND CustomerAccount.customer_id = IsRegisteredVia.fk_customer_id 
   GROUP BY DeviceModel.carrier, DeviceModel.device_model, MONTHNAME(DeviceRegistration.registration_date)
 );
