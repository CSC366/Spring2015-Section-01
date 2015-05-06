-- Database schema create tables 1
-- Group Masda cpe 366-01
create table CustomerAccounts (
    id INT PRIMARY KEY AUTO_INCREMENT, -- added key
    customer_id varchar(50),
    permission varchar(50),
    reg_date DATE,
    tier varchar(50),
    num_registrations INT,
    UNIQUE(customer_id)
);


create table Customers (
    account INT PRIMARY KEY,
    income FLOAT,
    zip INT,
    state varchar(50),
    gender varchar(50), 
    language varchar(50),
    FOREIGN KEY (account) REFERENCES CustomerAccounts(id)
);


create table Carrier (
    id INT AUTO_INCREMENT PRIMARY KEY, -- added key 
    name varchar(50) UNIQUE
);


create table Models (
    id INT PRIMARY KEY AUTO_INCREMENT, -- added key
    model_id varchar(50) UNIQUE,
    name varchar(50),
    model_type varchar(50),
    carrier INT,
    FOREIGN KEY (carrier) REFERENCES Carrier(id)
    
);


create table Devices (
    id INT PRIMARY KEY AUTO_INCREMENT,
    serial_num varchar(50) UNIQUE, 
    model INT,
    FOREIGN KEY (model) REFERENCES Models(id)
);


create table Registrations (
    id INT PRIMARY KEY AUTO_INCREMENT, -- added key
    reg_id varchar(50) UNIQUE,
    customer varchar(50),
    device INT, 
    model INT, 
    source_id varchar(50),
    source_name varchar(50),
    reg_date DATE,
    FOREIGN KEY (customer) REFERENCES CustomerAccounts(customer_id),
    FOREIGN KEY (model) REFERENCES Models(id),
    FOREIGN KEY (device) REFERENCES Devices(id)
);


create table Stores (
    id INT PRIMARY KEY,
    name varchar(50),
    state varchar(50),
    city varchar(50),
    ecomm INT,
    purchase_date DATE,
    FOREIGN KEY (id) REFERENCES Registrations(id)
);


create table EmailAddresses (
    id INT PRIMARY KEY AUTO_INCREMENT, -- added key
    email_id varchar(50) UNIQUE,
    customer varchar(50),
    domain varchar(50),
    FOREIGN KEY (customer) REFERENCES CustomerAccounts(customer_id)
);

create table Messages (
    id INT PRIMARY KEY AUTO_INCREMENT, -- added key
    campaign_name varchar(50),
    audience varchar(50),
    version varchar(50),
    subject_line varchar(50),
    dep_date DATETIME,
    deployment varchar(50),
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
    type_id INT UNIQUE,
    name varchar(50)
);

create table Generate (
    id INT PRIMARY KEY AUTO_INCREMENT, -- added key
    event_date DATETIME,
    email INT,
    message INT,
    event_type INT,
    FOREIGN KEY (email) REFERENCES EmailAddresses(id),
    FOREIGN KEY (message) REFERENCES Messages(id),
    FOREIGN KEY (event_type) REFERENCES EventTypes(type_id),
    UNIQUE(event_date, email, message, event_type)
);

create table Links (
    id INT PRIMARY KEY AUTO_INCREMENT, -- added key
    name varchar(50),
    url varchar(50),
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
