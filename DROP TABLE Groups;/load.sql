LOAD DATA INFILE '/Data/CP_Account.csv'
INTO TABLE temp_CP_Account
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES
(CustomerID, EmailID, RegSourceID, RegSourceName, ZIP, State, Gender, IncomeLevel, Permission, `Language`, @RegDate, DomainName, CustomerTier)
set RegDate = str_to_date(@RegDate, '%m/%d/%Y');

LOAD DATA INFILE '/Data/CP_Device.csv'
INTO TABLE temp_CP_Device
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES
(CustomerID, SourceID, SourceName, DeviceModel, SerialNumber, @PurchaseDate, PurchaseStoreName, PurchaseStoreState, PurchaseStoreCity, Ecomm, @RegistrationDate, NumberOfRegistrations, RegistrationID)
set PurchaseDate = str_to_date(@PurchaseDate, '%m/%d/%Y'),
RegistrationDate = str_to_date(@RegistrationDate, '%m/%d/%Y');

LOAD DATA INFILE '/Data/CP_Device_Model.csv'
INTO TABLE temp_CP_Device_Model
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES
(Device_Model, Device_Name, Device_Type, Carrier);

LOAD DATA INFILE '/Data/CP_Email.csv'
INTO TABLE temp_CP_Email
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES
(EmailID, AudienceSegment, EmailCampaignName, EmailVersion, SubjectLineCode, @Fulldate, DeploymentID, EmailEventKey, EmailEventType, @EmailEventDateTime, HyperlinkName, EmailURL, @ignore)
set Fulldate = str_to_date(@Fulldate, '%m/%d/%Y'),
EmailEventDateTime = str_to_date(@EmailEventDateTime, '%m/%d/%Y %h:%i %p');
