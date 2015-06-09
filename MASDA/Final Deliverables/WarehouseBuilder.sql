-- ECamp1
-- CREATE TABLE ECamp1 AS
--     (SELECT campaign_name, audience, version, subject_line, 
--         COUNT(*) AS Unique_Emails_Delivered
--     FROM Recieve, Messages
--     WHERE Recieve.message = Messages.id
--     GROUP BY campaign_name, audience, version, subject_line);

-- ECamp2

CREATE TABLE CampaignPerformanceCube4D AS 
(
    SELECT 
        Messages.campaign_name, 
        Messages.audience, 
        Messages.version, 
        Messages.subject_line, 
        Messages.dep_date, 
        Unique_Emails_Delivered, 
        Unique_Emails_Opened, 
        Unique_Clickers, 
        Unsubscribed
    FROM
        Messages
        LEFT OUTER JOIN
        (
            SELECT Messages.id, campaign_name, audience, version, 
            subject_line, dep_date, COUNT(*) AS Unique_Emails_Delivered
            FROM Recieve, Messages, Generate, EventTypes
            WHERE 
                Recieve.message = Messages.id AND
                Generate.recieve = Recieve.id AND
                Generate.event_type = EventTypes.id AND
                EventTypes.name != "Unknown Bounce" AND
                EventTypes.name != "Technical/Other Bounce" AND
                EventTypes.name != "Hard Bounce" AND
                EventTypes.name != "Soft Bounce" AND
                EventTypes.name != "Block Bounce"
            GROUP BY Messages.id, campaign_name, audience, version, subject_line, dep_date
        ) Unique_Delivered
        ON Messages.id = Unique_Delivered.id
        LEFT OUTER JOIN     
        (
            SELECT Messages.id, campaign_name, audience, version, 
            subject_line, dep_date, COUNT(*) AS Unique_Emails_Opened
            FROM Generate, Recieve, Messages, EventTypes
            WHERE 
                Generate.recieve = Recieve.id AND
                Recieve.message = Messages.id AND
                Generate.event_type = EventTypes.id AND
                EventTypes.name = "Email Opened"
            GROUP BY Messages.id, campaign_name, audience, version, subject_line, dep_date
        ) Unique_Opened
        ON Messages.id = Unique_Opened.id
        LEFT OUTER JOIN
        (
            SELECT Messages.id, campaign_name, audience, version, 
            subject_line, dep_date, COUNT(distinct (customer)) AS Unique_Clickers
            FROM Generate, Recieve, Messages, EmailAddresses, EventTypes
            WHERE 
                Generate.recieve = Recieve.id AND
                Recieve.message = Messages.id AND
                Generate.event_type = EventTypes.id AND
                Recieve.email = EmailAddresses.id
            GROUP BY campaign_name, audience, version, subject_line, dep_date
        ) Unique_Clickers
        ON Messages.id = Unique_Clickers.id
        LEFT OUTER JOIN
        (
            SELECT Messages.id, campaign_name, audience, version, 
            subject_line, dep_date, COUNT(*) AS Unsubscribed
            FROM Generate, Recieve, Messages, EventTypes
            WHERE 
                Generate.recieve = Recieve.id AND
                Recieve.message = Messages.id AND
                Generate.event_type = EventTypes.id AND
                EventTypes.name = "Unsubscribe"
            GROUP BY campaign_name, audience, version, subject_line, dep_date
        ) Unsubbed
        ON Messages.id = Unsubbed.id
);

   


CREATE TABLE AccountRegCube3D AS
    (   SELECT state as State, MONTH(reg_date) as Month, YEAR(reg_date) 
        as Year, permission as Permission, COUNT(*) as Num_Customers
        FROM CustomerAccounts, Customers
        WHERE CustomerAccounts.id = Customers.account
        GROUP BY state, Month, Year, permission
    );

CREATE TABLE DeviceRegCube3D AS
    (   SELECT Carrier.name as Carrier_Name,
        MONTH(reg_date) as Month,
        YEAR(reg_date) as Year, Models.id as Device_Name, 
        COUNT(DISTINCT (customer)) AS Num_Customers
        FROM Registrations, Models, Carrier
        WHERE Registrations.model = Models.id
        AND Models.carrier = Carrier.id
        GROUP BY Carrier_Name, Month, Year, Device_Name
    );

CREATE TABLE DevicesOLAP AS
    (   SELECT id, model_id, name, model_type
        FROM Models
    );

CREATE INDEX ix_id
ON DevicesOLAP (id);

ALTER TABLE DeviceRegCube3D
ADD FOREIGN KEY (Device_Name)
REFERENCES DevicesOLAP(id);

UPDATE CampaignPerformanceCube4D 
SET Unique_Emails_Delivered = 0
WHERE Unique_Emails_Delivered IS NULL;

UPDATE CampaignPerformanceCube4D 
SET Unique_Emails_Opened = 0
WHERE Unique_Emails_Opened IS NULL;

UPDATE CampaignPerformanceCube4D 
SET Unique_Clickers = 0
WHERE Unique_Clickers IS NULL;

UPDATE CampaignPerformanceCube4D 
SET Unsubscribed = 0
WHERE Unsubscribed IS NULL;