CREATE TABLE Reg_Source (
   Reg_Source_Key INT NOT NULL AUTO_INCREMENT,
   Reg_Source_ID VARCHAR(100),
   Reg_Source_Name VARCHAR(100),
   PRIMARY KEY (Reg_Source_key),
   CONSTRAINT uc_Reg_Source UNIQUE (Reg_Source_ID, Reg_Source_Name)
);

CREATE TABLE Customers (
   Customer_Key INT NOT NULL auto_increment, 
   CustomerID VARCHAR(100) UNIQUE,
   PRIMARY KEY (Customer_Key)
);

CREATE TABLE Customer_Data (
   Customer_Data_Key INT NOT NULL AUTO_INCREMENT,
   Customer_Key INT,
   Zip char(5),
   State VARCHAR(40),
   Gender VARCHAR(20),
   Income_Level VARCHAR(100),
   Permission VARCHAR(100),
   Language VARCHAR(10),
   Registration_Date DATETIME,
   Customer_Tier VARCHAR(100),
   Reg_Source_Key INT,
   FOREIGN KEY (Customer_Key) REFERENCES Customers(Customer_Key),
   FOREIGN KEY (Reg_Source_Key) REFERENCES Reg_Source(Reg_Source_Key),
   PRIMARY KEY (Customer_Data_Key)
);


CREATE TABLE Email_Addresses (
   Email_Key INT NOT NULL auto_increment,
   Email_ID VARCHAR(100) UNIQUE,
   Customer_Key INT,
   Email_Domain VARCHAR(100),
   FOREIGN KEY (Customer_Key) REFERENCES Customers(Customer_Key), 
   PRIMARY KEY (Email_Key)
);

CREATE TABLE Carriers (
   Carrier_Key INT NOT NULL auto_increment,
   Carrier_Name VARCHAR(100) UNIQUE,
   PRIMARY KEY (Carrier_Key)
);

CREATE TABLE Device_Models (
   Device_Key INT NOT NULL auto_increment,
   Device_Model VARCHAR(100) UNIQUE,
   Device_Name VARCHAR(100),
   Device_Type VARCHAR(100),
   Carrier_Key INT,
   FOREIGN KEY (Carrier_Key) REFERENCES Carriers(Carrier_Key), 
   PRIMARY KEY (Device_Key)
);

CREATE TABLE Stores (
   Store_Key INT NOT NULL auto_increment,
   Name VARCHAR(100),
   State VARCHAR(3),
   City VARCHAR(100),
   PRIMARY KEY (Store_Key),
   CONSTRAINT uc_Stores UNIQUE (Name, State, City)
);

CREATE TABLE Device_Registrations (
   Registration_Key INT NOT NULL auto_increment,
   Registration_ID VARCHAR(100) UNIQUE,
   Registration_Date DATE,
   Reg_Source_Key INT,
   Store_Key INT,
   Ecomm_Flag CHAR(1),
   Purchase_Date DATETIME,
   Device_Key INT,
   Serial_Number VARCHAR(100),
   Customer_Key INT,
   Num_Registrations INT,
   FOREIGN KEY (Customer_Key) REFERENCES Customers(Customer_Key),
   FOREIGN KEY (Store_Key) REFERENCES Stores(Store_Key), 
   FOREIGN KEY (Reg_Source_Key) REFERENCES Reg_Source(Reg_Source_Key),
   FOREIGN KEY (Device_Key) REFERENCES Device_Models(Device_Key),
   PRIMARY KEY (Registration_Key)
);

CREATE TABLE Messages (
   Message_Key INT NOT NULL auto_increment,
   Audience VARCHAR(100),
   Campaign_Name VARCHAR(100),
   Version VARCHAR(100),
   Subject_Line VARCHAR(100),
   PRIMARY KEY (Message_Key),
   CONSTRAINT uc_Messages UNIQUE (Audience, Campaign_Name, Version, Subject_Line)
);

CREATE TABLE Email_Sent (
   Email_Sent_Key INT NOT NULL auto_increment,
   Email_Key INT,
   Message_Key INT,
   Deployment_ID VARCHAR(100),
   Deployment_Date DATETIME,
   FOREIGN KEY (Email_Key) REFERENCES Email_Addresses(Email_Key),
   FOREIGN KEY (Message_Key) REFERENCES Messages(Message_Key),
   PRIMARY KEY (Email_Sent_Key),
   CONSTRAINT uc_Email_Sent UNIQUE (Email_Key, Message_Key, Deployment_ID, Deployment_Date)
);

CREATE TABLE Email_Event_Type (
   Event_Type_Key INT NOT NULL auto_increment,
   Event_Type_ID VARCHAR(100) UNIQUE,
   Event_TypeName VARCHAR(100),
   PRIMARY KEY (Event_Type_Key)
);

CREATE TABLE Email_Link (
   Link_Key INT NOT NULL auto_increment,
   Message_Key INT,
   Link_Name VARCHAR(100),
   URL VARCHAR(255),
   PRIMARY KEY (Link_Key),
   FOREIGN KEY (Message_Key) REFERENCES Messages(Message_Key),
   CONSTRAINT uc_Email_Link UNIQUE (Message_Key, Link_Name, URL)
);

CREATE TABLE Email_Action (
   Email_Action_Key INT NOT NULL auto_increment,
   Email_Sent_Key INT,
   Event_Type_Key INT,
   Event_Date VARCHAR(20),
   Link_Key INT,
   PRIMARY KEY (Email_Action_Key),
   FOREIGN KEY (Link_Key) REFERENCES Email_Link(Link_Key),
   FOREIGN KEY (Email_Sent_Key) REFERENCES Email_Sent(Email_Sent_Key),
   FOREIGN KEY (Event_Type_Key) REFERENCES Email_Event_Type(Event_Type_Key),
   CONSTRAINT uc_Email_Action UNIQUE (Email_Sent_Key, Event_Type_Key, Event_Date, Link_Key)
);

