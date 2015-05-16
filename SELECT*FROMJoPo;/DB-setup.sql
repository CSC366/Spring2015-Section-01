CREATE TABLE RegistrationLocation(
   registration_source_id INT,
   source_name VARCHAR(100),
   PRIMARY KEY(registration_source_id)
);

CREATE TABLE Link(
   link_id INT,
   link_name VARCHAR(100),
   url VARCHAR(500),
   UNIQUE(link_name),
   PRIMARY KEY(link_id)
);

CREATE TABLE DeviceModel(
   device_model_id INT,
   device_model VARCHAR(100),
   device_name VARCHAR(100),
   device_type VARCHAR(100),
   carrier VARCHAR(100),
   UNIQUE(device_model),
   PRIMARY KEY(device_model_id)
);

CREATE TABLE EventType(
   event_type_id INT,
   event_type_name VARCHAR(20),
   PRIMARY KEY(event_type_id, event_type_name)
);

CREATE TABLE DevicePurchaseDate (
   purchase_id INT,
   purchase_date DATE,
   UNIQUE(purchase_date),
   PRIMARY KEY(purchase_id)
);

CREATE TABLE DeviceSerial (
   serial_id INT,
   serial_number VARCHAR(50),
   UNIQUE(serial_number),
   PRIMARY KEY(serial_id)
);

CREATE TABLE PurchaseInformation(
   purchase_store_id INT,
   purchase_store_name VARCHAR(50),
   purchase_store_state CHAR(2),
   purchase_store_city VARCHAR(50),
   ecomm_flag BOOLEAN,
   PRIMARY KEY(purchase_store_id),
   UNIQUE(purchase_store_name, purchase_store_state, purchase_store_city)
);


CREATE TABLE EmailSent(
   email_sent_id INT,
   campaign_name VARCHAR(100),
   version VARCHAR(50),
   subject_line VARCHAR(100),
   audience VARCHAR(100),
   UNIQUE(campaign_name, version, subject_line, audience),
   PRIMARY KEY(email_sent_id)
);

CREATE TABLE CustomerAccount(
   customer_id BIGINT,
   permission BOOL,
   customer_tier VARCHAR(20),
   gender CHAR(1),
   zip INT,
   state VARCHAR(30),
   income_level VARCHAR(20),
   num_registrations INT,
   fk_registration_source_id INT,
   regDate DATE,
   language VARCHAR(10),
   PRIMARY KEY(customer_id),
   FOREIGN KEY(fk_registration_source_id) REFERENCES RegistrationLocation(registration_source_id)
);

CREATE TABLE CustomerEmail(
   email_id INT,
   email_domain VARCHAR(50),
   PRIMARY KEY(email_id)
);

CREATE TABLE IsSentTo(
   fk_email_sent_id INT,
   fk_email_id INT,
   deployment_id INT,
   deployment_date DATE,
   PRIMARY KEY(fk_email_sent_id, fk_email_id),
   FOREIGN KEY(fk_email_sent_id) REFERENCES EmailSent(email_sent_id),
   FOREIGN KEY(fk_email_id) REFERENCES CustomerEmail(email_id)
);

CREATE TABLE DeviceRegistration(
   registration_id INT,
   registration_date DATE,
   fk_device_model_id INT, 
   fk_registration_source_id INT,
   fk_purchase_id INT,
   PRIMARY KEY(registration_id),
   FOREIGN KEY(fk_device_model_id) REFERENCES DeviceModel(device_model_id), 
   FOREIGN KEY(fk_registration_source_id) REFERENCES RegistrationLocation(registration_source_id),
   FOREIGN KEY(fk_purchase_id) REFERENCES DevicePurchaseDate(purchase_id)
);

CREATE TABLE IsRegisteredVia(
   fk_registration_id INT,
   fk_customer_id BIGINT,
   PRIMARY KEY(fk_registration_id, fk_customer_id),
   FOREIGN KEY(fk_registration_id) REFERENCES DeviceRegistration(registration_id),
   FOREIGN KEY(fk_customer_id) REFERENCES CustomerAccount(customer_id)
);


CREATE TABLE Possesses(
   fk_email_id INT,
   fk_customer_id BIGINT,
   PRIMARY KEY(fk_email_id, fk_customer_id),
   FOREIGN KEY(fk_email_id) REFERENCES CustomerEmail(email_id),
   FOREIGN KEY(fk_customer_id) REFERENCES CustomerAccount(customer_id)
);

CREATE TABLE Event(
   event_id INT,
   email_id INT,
   event_date DATETIME,
   fk_event_type_id INT,
   fk_email_sent_id INT,
   PRIMARY KEY(event_id),
   UNIQUE(email_id, event_date, fk_event_type_id, fk_email_sent_id),
   FOREIGN KEY(fk_event_type_id) REFERENCES EventType(event_type_id),
   FOREIGN KEY(fk_email_sent_id) REFERENCES EmailSent(email_sent_id),
   FOREIGN KEY(email_id) REFERENCES CustomerEmail(email_id)
);

CREATE TABLE ClickedLink(
   fk_event_id INT,
   fk_link_id INT,
   PRIMARY KEY(fk_event_id, fk_link_id),
   FOREIGN KEY(fk_event_id) REFERENCES Event(event_id),
   FOREIGN KEY(fk_link_id) REFERENCES Link(link_id)
);

CREATE TABLE DeviceToSerial(
   fk_registration_id INT,
   fk_serial_id INT,
   PRIMARY KEY(fk_registration_id, fk_serial_id),
   FOREIGN KEY(fk_registration_id) REFERENCES DeviceRegistration(registration_id),
   FOREIGN KEY(fk_serial_id) REFERENCES DeviceSerial(serial_id)
);

CREATE TABLE DeviceToPurchaseInformation(
   fk_registration_id INT,
   fk_purchase_store_id INT,
   PRIMARY KEY(fk_registration_id, fk_purchase_store_id),
   FOREIGN KEY(fk_registration_id) REFERENCES DeviceRegistration(registration_id),
   FOREIGN KEY(fk_purchase_store_id) REFERENCES PurchaseInformation(purchase_store_id)
);
