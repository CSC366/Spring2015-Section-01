CREATE TABLE CampaignPerformanceCube4D (
    campaign_name varchar(50),
    audience varchar(50),
    version varchar(50),
    subject_line varchar(50),
    dep_date DATETIME,
    Unique_Emails_Delivered DOUBLE(10, 3),
    Unique_Emails_Opened DOUBLE(10, 3),
    Unique_Clickers DOUBLE(10, 3),
    Unsubscribed DOUBLE(10, 3),
    PRIMARY KEY(campaign_name, audience, version, subject_line,
        dep_date)
);

CREATE TABLE AccountRegCube3D (
    State VARCHAR(50),
    Month INT,
    YEAR INT, 
    Permission VARCHAR(50),
    Num_Customers INT
);

CREATE TABLE DevicesOLAP (
    id INT PRIMARY KEY,
    model_id VARCHAR(50),
    name VARCHAR(50),
    model_type VARCHAR(50)
);

CREATE TABLE DeviceRegCube3D (
    Carrier_Name VARCHAR(50),
    Month INT,
    Year INT,
    Device_Name INT,
    Num_Customers INT,
    PRIMARY KEY(Carrier_Name, Month, Year, Device_Name),
    FOREIGN KEY (Device_Name) REFERENCES DevicesOLAP(id)
);
