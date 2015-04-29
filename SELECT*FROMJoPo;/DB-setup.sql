CREATE TABLE RegistrationLocation(
   registration_source_id INT,
   source_name VARCHAR(100),
   PRIMARY KEY(registration_source_id)
);

CREATE TABLE Link(
   link_name VARCHAR(30),
   url VARCHAR(50),
   PRIMARY KEY(link_name)
);

CREATE TABLE DeviceModel(
   device_name VARCHAR(100),
   carrier VARCHAR(100),
   device_model VARCHAR(100),
   device_type VARCHAR(100),
   PRIMARY KEY(device_model)
);

CREATE TABLE EventType(
   event_type_id INT,
   event_type_name VARCHAR(20),
   PRIMARY KEY(event_type_id, event_type_name)
);

CREATE TABLE DeviceInformation (
   serial_number VARCHAR(50),
   device_model VARCHAR(100),
   purchase_date DATE,
   UNIQUE(device_model),
   PRIMARY KEY(serial_number)
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
   campaign_name VARCHAR(100),
   version VARCHAR(50),
   subject_line VARCHAR(100),
   audience VARCHAR(100),
   fk_link_name VARCHAR(30),
   PRIMARY KEY(campaign_name),
   FOREIGN KEY(fk_link_name) REFERENCES Link(link_name)
);

CREATE TABLE CustomerAccount(
   customer_id INT,
   permission BOOL,
   customer_tier VARCHAR(20),
   gender CHAR(1),
   zip INT,
   state CHAR(2),
   income_level VARCHAR(20),
   num_registrations INT,
   fk_registration_source_id INT,
   PRIMARY KEY(customer_id),
   FOREIGN KEY(fk_registration_source_id) REFERENCES RegistrationLocation(registration_source_id)
);

CREATE TABLE CustomerEmail(
   email_id INT,
   customer_id INT,
   email_domain VARCHAR(50),
   audience VARCHAR(100) UNIQUE,
   PRIMARY KEY(email_id),
   FOREIGN KEY (customer_id) REFERENCES CustomerAccount(customer_id)
);

CREATE TABLE IsSentTo(
   fk_campaign_name VARCHAR(100),
   fk_email_id INT,
   PRIMARY KEY(fk_campaign_name, fk_email_id),
   FOREIGN KEY(fk_campaign_name) REFERENCES EmailSent(campaign_name),
   FOREIGN KEY(fk_email_id) REFERENCES CustomerEmail(email_id)
);

CREATE TABLE DeviceRegistration(
   registration_id INT,
   registration_date DATE,
   fk_device_model VARCHAR(100),
   fk_purchase_store_id INT,
   fk_serial_number VARCHAR(50),
   fk_registration_source_id INT,
   PRIMARY KEY(registration_id),
   FOREIGN KEY(fk_device_model) REFERENCES DeviceModel(device_model), 
   FOREIGN KEY(fk_purchase_store_id) REFERENCES PurchaseInformation(purchase_store_id),
   FOREIGN KEY(fk_serial_number) REFERENCES DeviceInformation(serial_number),
   FOREIGN KEY(fk_registration_source_id) REFERENCES RegistrationLocation(registration_source_id)
);

CREATE TABLE IsRegisteredVia(
   fk_registration_id INT,
   fk_customer_id INT,
   PRIMARY KEY(fk_registration_id, fk_customer_id),
   FOREIGN KEY(fk_registration_id) REFERENCES DeviceRegistration(registration_id),
   FOREIGN KEY(fk_customer_id) REFERENCES CustomerAccount(customer_id)
);


CREATE TABLE Possesses(
   fk_email_id INT,
   fk_customer_id INT,
   PRIMARY KEY(fk_email_id, fk_customer_id),
   FOREIGN KEY(fk_email_id) REFERENCES CustomerEmail(email_id),
   FOREIGN KEY(fk_customer_id) REFERENCES CustomerAccount(customer_id)
);

CREATE TABLE Event(
   email_id INT,
   event_type INT,
   event_date DATE,
   fk_event_type_id INT,
   fk_campaign_name VARCHAR(100),
   PRIMARY KEY(email_id, fk_event_type_id),
   FOREIGN KEY(fk_event_type_id) REFERENCES EventType(event_type_id),
   FOREIGN KEY(fk_campaign_name) REFERENCES EmailSent(campaign_name),
   FOREIGN KEY(email_id) REFERENCES CustomerEmail(email_id)
);

CREATE TABLE Deployment(
   deployment_id INT,
   deployment_date DATE,
   fk_campaign_name VARCHAR(100),
   PRIMARY KEY(deployment_id),
   FOREIGN KEY(fk_campaign_name) REFERENCES EmailSent(campaign_name)
);
