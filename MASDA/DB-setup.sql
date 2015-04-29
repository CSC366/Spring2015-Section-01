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
    name VARCHAR(30) UNIQUE
);


create table Models (
    id INT PRIMARY KEY AUTO_INCREMENT, -- added key
    model_id VARCHAR(30) UNIQUE,
    name VARCHAR(30),
    model_type VARCHAR(30),
    carrier INT,
    FOREIGN KEY (carrier) REFERENCES Carrier(id)
    
);


create table Devices (
    id INT PRIMARY KEY AUTO_INCREMENT,
    serial_num VARCHAR(30) UNIQUE, 
    model INT,
    FOREIGN KEY (model) REFERENCES Models(id)
);


create table Registrations (
    id INT PRIMARY KEY AUTO_INCREMENT, -- added key
    reg_id VARCHAR(30) UNIQUE,
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
    email_id VARCHAR(30) UNIQUE,
    customer VARCHAR(30),
    domain VARCHAR(30),
    FOREIGN KEY (customer) REFERENCES CustomerAccounts(customer_id)
);

create table Messages (
    id INT PRIMARY KEY AUTO_INCREMENT, -- added key
    campaign_name VARCHAR(30),
    audience VARCHAR(30),
    version VARCHAR(30),
    subject_line VARCHAR(30),
    dep_date DATETIME,
    deployment VARCHAR(30),
    campaign INT,
    FOREIGN KEY (campaign) REFERENCES Campaigns(id),
    UNIQUE(campaign_name, audience, version)
);

create table Recieve (
    id INT PRIMARY KEY AUTO_INCREMENT, -- added key
    message INT,
    email INT,
    FOREIGN KEY (message) REFERENCES Messages(id),
    FOREIGN KEY (email) REFERENCES EmailAddresses(id),
    UNIQUE(message, email) 
);

create table EventTypes (
    id INT PRIMARY KEY AUTO_INCREMENT, -- added key
    type_id VARCHAR(30) UNIQUE,
    name VARCHAR(30)
);

create table Generate (
    id INT PRIMARY KEY AUTO_INCREMENT, -- added key
    event_date DATETIME,
    email INT,
    message INT,
    event_type INT,
    FOREIGN KEY (email) REFERENCES EmailAddresses(id)
    FOREIGN KEY (message) REFERENCES Messages(id)
    FOREIGN KEY (event_type) REFERENCES EventTypes(type_id)
    UNIQUE(event_date, email, message, event_type)
);

create table Links (
    id INT PRIMARY KEY AUTO_INCREMENT, -- added key
    name VARCHAR(30),
    url VARCHAR(30),
    message INT,
    FOREIGN KEY (message) REFERENCES Messages(id),
    UNIQUE(name, url, message)
);

create table Clicked (
    id INT PRIMARY KEY AUTO_INCREMENT, -- added key
    generated INT,
    link INT,
    FOREIGN KEY (generated) REFERENCES Generate(id),
    FOREIGN KEY (link) REFERENCES Links(id),
    UNIQUE(generated, link)
);
