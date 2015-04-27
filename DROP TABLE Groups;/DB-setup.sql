CREATE TABLE Reg_Source (
   Reg_Source_Key INT NOT NULL AUTO_INCREMENT,
   Reg_Source_ID VARCHAR(1000),
   Reg_Source_Name VARCHAR(1000),
   PRIMARY KEY (Reg_Source_key)
);

CREATE TABLE Customers (
   Customer_Key INT NOT NULL auto_increment, 
   CustomerID VARCHAR(1000),
   Zip char(5),
   State VARCHAR(1000),
   Gender VARCHAR(1000),
   Income_Level VARCHAR(1000),
   Permission VARCHAR(1000),
   Language VARCHAR(1000),
   Registration_Date DATETIME,
   Customer_Tier VARCHAR(1000),
   Reg_Source_Key INT,
   Num_Registrations INT,
   FOREIGN KEY (Reg_Source_Key) REFERENCES Reg_Source(Reg_Source_Key), 
   PRIMARY KEY (Customer_Key)
);

CREATE TABLE Email_Addresses (
   Email_Key INT NOT NULL auto_increment,
   Email_ID VARCHAR(1000),
   Customer_Key INT,
   Email_Domain VARCHAR(1000),
   FOREIGN KEY (Customer_Key) REFERENCES Customers(Customer_Key), 
   PRIMARY KEY (Email_Key)
);

CREATE TABLE Carriers (
   Carrier_Key INT NOT NULL auto_increment,
   Carrier_Name VARCHAR(1000),
   PRIMARY KEY (Carrier_Key)
);

CREATE TABLE Device_Models (
   Device_Key INT NOT NULL auto_increment,
   Device_Model VARCHAR(1000),
   Device_Name VARCHAR(1000),
   Device_Type VARCHAR(1000),
   Carrier_Key INT,
   FOREIGN KEY (Carrier_Key) REFERENCES Carriers(Carrier_Key), 
   PRIMARY KEY (Device_Key)
);

CREATE TABLE Stores (
   Store_Key INT NOT NULL auto_increment,
   Purchase_Store_Name VARCHAR(1000),
   Purchase_Store_State VARCHAR(1000),
   Purchase_Store_City VARCHAR(1000),
   PRIMARY KEY (Store_Key)
);

CREATE TABLE Device_Registrations (
   Registration_Key INT NOT NULL auto_increment,
   Registration_ID VARCHAR(1000),
   Registration_Date DATE,
   Reg_Source_Key INT,
   Store_Key INT,
   Ecomm_Flag BIT(1),
   Purchase_Date DATETIME,
   Device_Key INT,
   Serial_Number VARCHAR(1000),
   Customer_Key INT,
   FOREIGN KEY (Customer_Key) REFERENCES Customers(Customer_Key),
   FOREIGN KEY (Store_Key) REFERENCES Stores(Store_Key), 
   FOREIGN KEY (Reg_Source_Key) REFERENCES Reg_Source(Reg_Source_Key),
   FOREIGN KEY (Device_Key) REFERENCES Device_Models(Device_Key),
   PRIMARY KEY (Registration_Key)
);

CREATE TABLE Email_Variants (
   Email_Variant_Key INT NOT NULL auto_increment,
   Audience VARCHAR(1000),
   Campaign_Name VARCHAR(1000),
   Version VARCHAR(1000),
   Subject_Line VARCHAR(1000),
   Deployment_Date DATETIME,
   PRIMARY KEY (Email_Variant_Key)
);

CREATE TABLE Email_Sent (
   Email_Sent_Key INT NOT NULL auto_increment,
   Email_Key INT,
   Email_Variant_Key INT,
   Deployment_ID VARCHAR(1000),
   FOREIGN KEY (Email_Key) REFERENCES Email_Addresses(Email_Key),
   FOREIGN KEY (Email_Variant_Key) REFERENCES Email_Variants(Email_Variant_Key),
   PRIMARY KEY (Email_Sent_Key)
);

CREATE TABLE Email_Event_Type (
   Event_Type_Key INT NOT NULL auto_increment,
   Event_Type_ID VARCHAR(1000),
   Event_TypeName VARCHAR(1000),
   PRIMARY KEY (Event_Type_Key)
);

CREATE TABLE Email_Link (
   Link_Key INT NOT NULL auto_increment,
   Link_Name VARCHAR(1000),
   URL VARCHAR(1000),
   PRIMARY KEY (Link_Key)
);

CREATE TABLE Email_Action (
   Email_Action_Key INT NOT NULL,
   Email_Sent_Key INT,
   Event_Type_Key INT,
   Event_Date DATETIME,
   Link_Key INT,
   FOREIGN KEY (Link_Key) REFERENCES Email_Link(Link_Key),
   FOREIGN KEY (Email_Sent_Key) REFERENCES Email_Sent(Email_Sent_Key),
   FOREIGN KEY (Event_Type_Key) REFERENCES Email_Event_Type(Event_Type_Key)
);

