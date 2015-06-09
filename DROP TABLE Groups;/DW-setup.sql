
CREATE TABLE DW_Email_Action (
   DW_Email_Action_Key INT NOT NULL auto_increment,
   Message_Key INT,
   Event_TypeName VARCHAR(100),
   Count int,
   PRIMARY KEY (DW_Email_Action_Key),
   FOREIGN KEY (Message_Key) REFERENCES Messages(Message_Key),
   CONSTRAINT uc_Email_Action UNIQUE (Message_Key, Event_TypeName)
);

CREATE TABLE DW_Campaign_Performance (
	Audience VARCHAR(100),
	Campaign_Name VARCHAR(100),
	Version VARCHAR(100),
	Subject_Line VARCHAR(100),
    Deployment_Date DATETIME,
    numClicks INT,
    numComplaint INT,
    numOpened INT,
    numDelivered INT,
    numUnsubscribe INT,
    numBounce INT,
    numNotSent INT,
	PRIMARY KEY (Audience, Campaign_Name, Version, Subject_Line)
);


CREATE TABLE DW_Customer_Reg (
	State VARCHAR(50),
    Reg_Month INT,
    Reg_Year INT,
    Cust_Permission INT,
    Count INT,
    PRIMARY KEY (State, Reg_Month, Reg_Year, Cust_Permission)
);


CREATE TABLE DW_Device_Reg (
    Carrier VARCHAR(100),
    Reg_Month INT,
    Reg_Year INT,
    Device_Model VARCHAR(100),
    Count INT,
    PRIMARY Key (Carrier, Reg_Month, Reg_Year, Device_Model)
);