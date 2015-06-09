INSERT INTO Carriers (Carrier_Name)
SELECT DISTINCT Carrier
FROM temp_CP_Device_Model
WHERE Carrier != '';

DELETE FROM temp_CP_Device_Model
WHERE Device_Model = 'ASDASDASDCH-I535RWBVZW' and Device_Name = ''
LIMIT 1;

DELETE FROM temp_CP_Device_Model
WHERE Device_Model = 'ASDASDASDCH-I5QWE5ZKBVZW' and Device_Name = ''
LIMIT 1;

DELETE FROM temp_CP_Device_Model
WHERE Device_Model = 'ASDASDASDM-G920PZWFASDASDASDPR'
LIMIT 1;

INSERT INTO Device_Models (Device_Model, Device_Name, Device_Type, Carrier_Key)
SELECT Device_Model, Device_Name, Device_Type, Carrier_Key
FROM temp_CP_Device_Model
LEFT JOIN Carriers ON Carriers.Carrier_Name = temp_CP_Device_Model.Carrier;

INSERT INTO Reg_Source (Reg_Source_ID, Reg_Source_Name)
SELECT DISTINCT RegSourceID, RegSourceName
FROM temp_CP_Account
LEFT JOIN Reg_Source ON Reg_Source.Reg_Source_ID = temp_CP_Account.RegSourceID
WHERE Reg_Source.Reg_Source_ID is NULL;

INSERT INTO Reg_Source (Reg_Source_ID, Reg_Source_Name)
SELECT DISTINCT SourceID, SourceName
FROM temp_CP_device
LEFT JOIN Reg_Source ON Reg_Source.Reg_Source_ID = temp_CP_device.SourceID
WHERE Reg_Source.Reg_Source_ID is NULL;

INSERT INTO Customers (CustomerID)
SELECT DISTINCT CustomerID
FROM temp_CP_Account;

INSERT INTO Customer_Data (Customer_Key, Zip, State, Gender, Income_Level, Permission, Language, Registration_Date, Customer_Tier, Reg_Source_Key)
SELECT Customer_Key, Zip, State, Gender, IncomeLevel, Permission, Language, RegDate, CustomerTier, Reg_Source_Key
FROM temp_CP_Account
LEFT JOIN Customers ON Customers.CustomerID = temp_CP_Account.CustomerID
LEFT JOIN Reg_Source ON Reg_Source.Reg_Source_ID = temp_CP_Account.RegSourceID;

INSERT INTO Email_Addresses (Customer_Key, Email_ID, Email_Domain)
SELECT DISTINCT Customer_Key, EmailID, DomainName
FROM temp_CP_Account
LEFT JOIN Customers ON Customers.CustomerID = temp_CP_Account.CustomerID;

INSERT INTO Stores(Name, State, City)
SELECT DISTINCT PurchaseStoreName, PurchaseStoreState, PurchaseStoreCity 
FROM temp_CP_Device;

INSERT INTO Device_Registrations (Registration_ID, Registration_Date, Reg_Source_Key, Store_Key, Ecomm_Flag, Purchase_Date, Device_Key, Serial_Number, Customer_Key, Num_Registrations)
SELECT RegistrationID, RegistrationDate, Reg_Source_Key, Store_Key, Ecomm, PurchaseDate, Device_Key, SerialNumber, Customer_Key, NumberOfRegistrations
FROM temp_CP_Device
LEFT JOIN Reg_Source ON Reg_Source.Reg_Source_ID = temp_CP_Device.SourceID
LEFT JOIN Stores ON Stores.Name = temp_CP_Device.PurchaseStoreName
	AND Stores.State = temp_CP_Device.PurchaseStoreState
	and Stores.City = temp_CP_Device.PurchaseStoreCity
LEFT JOIN Device_Models ON Device_Models.Device_Model = temp_CP_Device.DeviceModel
LEFT JOIN Customers ON Customers.CustomerID = temp_CP_Device.CustomerID;

INSERT INTO Messages (Audience, Campaign_Name, Version, Subject_Line)
SELECT DISTINCT AudienceSegment, EmailCampaignName, EmailVersion, SubjectLineCode
FROM temp_CP_Email;

INSERT INTO Email_Sent (Email_Key, Message_Key, Deployment_ID, Deployment_Date)
SELECT DISTINCT Email_Key, Message_Key, DeploymentID, Fulldate
FROM temp_CP_Email
LEFT JOIN Email_Addresses ON Email_Addresses.Email_ID = temp_CP_Email.EmailID
LEFT JOIN Messages ON Messages.Audience = temp_CP_Email.AudienceSegment
	AND Messages.Campaign_Name = temp_CP_Email.EmailCampaignName
    AND Messages.Version = temp_CP_Email.EmailVersion
    AND Messages.Subject_Line = temp_CP_Email.SubjectLineCode;

INSERT INTO Email_Event_Type (Event_Type_ID, Event_TypeName)
SELECT DISTINCT EmailEventKey, EmailEventType
FROM temp_CP_Email;

INSERT INTO Email_Link (Message_Key, Link_Name, URL)
SELECT DISTINCT Message_Key, HyperlinkName, EmailURL -- IF(HyperlinkName = '', NULL, HyperlinkName) AS HyperlinkName, IF(EmailURL = '', NULL, EmailURL) AS EmailURL
FROM temp_CP_Email
LEFT JOIN Messages ON Messages.Audience = temp_CP_Email.AudienceSegment
	AND Messages.Campaign_Name = temp_CP_Email.EmailCampaignName
    AND Messages.Version = temp_CP_Email.EmailVersion
    AND Messages.Subject_Line = temp_CP_Email.SubjectLineCode
WHERE temp_CP_Email.HyperlinkName != ""
    AND temp_CP_Email.EmailURL != "";

INSERT INTO Email_Action (Email_Sent_Key, Event_Type_Key, Event_Date)
SELECT DISTINCT Email_Sent_Key, Event_Type_Key, EmailEventDateTime
FROM temp_CP_Email
LEFT JOIN Messages ON Messages.Audience = temp_CP_Email.AudienceSegment
	AND Messages.Campaign_Name = temp_CP_Email.EmailCampaignName
    and Messages.Version = temp_CP_Email.EmailVersion
    and Messages.Subject_Line = temp_CP_Email.SubjectLineCode
LEFT JOIN Email_Addresses ON Email_Addresses.Email_ID = temp_CP_Email.EmailID
LEFT JOIN Email_Sent ON Email_Sent.Message_Key = Messages.Message_Key
	AND Email_Sent.Email_Key = Email_Addresses.Email_Key
    AND Email_Sent.Deployment_ID = temp_CP_Email.DeploymentID
    AND Email_Sent.Deployment_Date = temp_CP_Email.Fulldate
LEFT JOIN Email_Event_Type ON Email_Event_Type.Event_Type_ID = temp_CP_Email.EmailEventKey;

INSERT INTO Email_Action_Link (Email_Action_Key, Link_Key)
SELECT DISTINCT Email_Action_Key, Link_Key
FROM temp_CP_Email
LEFT JOIN Messages ON Messages.Audience = temp_CP_Email.AudienceSegment
	AND Messages.Campaign_Name = temp_CP_Email.EmailCampaignName
    AND Messages.Version = temp_CP_Email.EmailVersion
    AND Messages.Subject_Line = temp_CP_Email.SubjectLineCode
LEFT JOIN Email_Addresses ON Email_Addresses.Email_ID = temp_CP_Email.EmailID
LEFT JOIN Email_Sent ON Email_Sent.Message_Key = Messages.Message_Key
	AND Email_Sent.Email_Key = Email_Addresses.Email_Key
    AND Email_Sent.Deployment_ID = temp_CP_Email.DeploymentID
    AND Email_Sent.Deployment_Date = temp_CP_Email.Fulldate
LEFT JOIN Email_Event_Type ON Email_Event_Type.Event_Type_ID = temp_CP_Email.EmailEventKey
LEFT JOIN Email_Link ON Email_Link.Message_Key = Messages.Message_Key
    AND Email_Link.Link_Name = temp_CP_Email.HyperlinkName
    AND Email_Link.URL = temp_CP_Email.EmailURL
LEFT JOIN Email_Action ON Email_Action.Email_Sent_Key = Email_Sent.Email_Sent_Key
	AND Email_Action.Event_Type_Key = Email_Event_Type.Event_Type_Key
    AND Email_Action.Event_Date = temp_CP_Email.EmailEventDateTime;