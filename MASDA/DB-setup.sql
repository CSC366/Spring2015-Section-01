-- Database schema create tables 1
-- Group Masda cpe 366-01
create table CustomerAccounts (
    id INT PRIMARY KEY AUTO_INCREMENT, -- added key
    customer_id VARCHAR(30),
    permission VARCHAR(30),
    reg_date DATE,
    tier VARCHAR(30),
    num_registrations INT,
    UNIQUE(customer_id)

);


create table Customers (
    account INT PRIMARY KEY,
    income FLOAT,
    zip INT,
    state VARCHAR(30),
    gender VARCHAR(30), 
    language VARCHAR(30),
    FOREIGN KEY (account) REFERENCES CustomerAccounts(id)
);


create table Carrier (
    id INT AUTO_INCREMENT PRIMARY KEY, -- added key 
    name VARCHAR(30) 
);


create table Models (
    id INT PRIMARY KEY AUTO_INCREMENT, -- added key
    model_id VARCHAR(30),
    name VARCHAR(30),
    model_type VARCHAR(30),
    carrier INT,
    FOREIGN KEY (carrier) REFERENCES Carrier(id)
    
);


create table Devices (
    id INT PRIMARY KEY AUTO_INCREMENT,
    serial_num VARCHAR(30), 
    model INT,
    FOREIGN KEY (model) REFERENCES Models(id)
);


create table Registrations (
    id INT PRIMARY KEY AUTO_INCREMENT, -- added key
    reg_id VARCHAR(30),
    customer VARCHAR(30),
    device INT, 
    model INT, 
    source_id VARCHAR(30),
    source_name VARCHAR(30),
    reg_date DATE,
    FOREIGN KEY (customer) REFERENCES CustomerAccounts(customer_id),
    FOREIGN KEY (model) REFERENCES Models(id),
    FOREIGN KEY (device) REFERENCES Devices(id)
);


create table Stores (
    id INT PRIMARY KEY,
    name VARCHAR(30),
    state VARCHAR(30),
    city VARCHAR(30),
    ecomm INT,
    purchase_date DATE,
    FOREIGN KEY (id) REFERENCES Registrations(id)
);


create table EmailAddresses (
    id INT PRIMARY KEY AUTO_INCREMENT, -- added key
    email_id VARCHAR(30),
    customer VARCHAR(30),
    domain VARCHAR(30),
    FOREIGN KEY (customer) REFERENCES CustomerAccounts(customer_id)
);

create table Campaigns (
    id INT PRIMARY KEY AUTO_INCREMENT, -- added key
    audience VARCHAR(30),
    campaign VARCHAR(30)
);

create table EmailInstances (
    id INT PRIMARY KEY AUTO_INCREMENT, -- added key
    email INT, -- assume this is never null
    version VARCHAR(30),
    subject_line VARCHAR(30),
    dep_date DATETIME,
    deployment VARCHAR(30),
    campaign INT,
    FOREIGN KEY (email) REFERENCES EmailAddresses(id),
    FOREIGN KEY (campaign) REFERENCES Campaigns(id)
);

create table Links (
    id INT PRIMARY KEY, -- added key
    name VARCHAR(30),
    url VARCHAR(30)
);

create table EventTypes (
    id INT PRIMARY KEY AUTO_INCREMENT, -- added key
    type_id VARCHAR(30),
    name VARCHAR(30)
);

create table Events (
    date DATETIME,
    event_type INT,
    email_instance INT,
    link INT, 
    PRIMARY KEY (date, event_type, email_instance, link),
    FOREIGN KEY (event_type) REFERENCES EventTypes(id),
    FOREIGN KEY (email_instance) REFERENCES EmailInstances(id),
    FOREIGN KEY (link) REFERENCES Links(id)
);
