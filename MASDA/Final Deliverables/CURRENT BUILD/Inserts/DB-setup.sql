-- Database schema create tables 1
-- Group Masda cpe 366-01

create table CustomerAccounts (
    id INT PRIMARY KEY, -- added key
    customer_id varchar(50) UNIQUE,
    permission varchar(50),
    reg_date DATE,
    tier varchar(50),
    num_registrations INT
);


create table Customers (
    account INT PRIMARY KEY,
    income varchar(50),
    zip INT,
    state varchar(30),
    language varchar(50),
    gender varchar(10), 
    FOREIGN KEY (account) REFERENCES CustomerAccounts(id)
);


create table Carrier (
    id INT PRIMARY KEY, -- added key 
    name varchar(50) UNIQUE
);


create table Models (
    id INT PRIMARY KEY, -- added key
    model_id varchar(50) UNIQUE,
    name varchar(50),
    model_type varchar(50),
    carrier INT,
    FOREIGN KEY (carrier) REFERENCES Carrier(id)
    
);


create table Devices (
    id INT PRIMARY KEY,
    serial_num varchar(50) UNIQUE, 
    model INT,
    FOREIGN KEY (model) REFERENCES Models(id)
);

create table Sources (
    source_id varchar(50) PRIMARY KEY,
    source_name varchar(50)
); 

create table Registrations (
    id INT PRIMARY KEY, -- added key
    reg_id varchar(50) UNIQUE,
    customer int,
    device INT, 
    model INT, 
    source_id varchar(50),
    reg_date DATE,
    FOREIGN KEY (customer) REFERENCES CustomerAccounts(id),
    FOREIGN KEY (device) REFERENCES Devices(id),
    FOREIGN KEY (model) REFERENCES Models(id),
    FOREIGN KEY (source_id) REFERENCES Sources(source_id)

);



create table Stores (
    id INT PRIMARY KEY,
    name varchar(50),
    state varchar(30),
    city varchar(50),
    ecomm INT,
    purchase_date DATE,
    FOREIGN KEY (id) REFERENCES Registrations(id)
);


create table EmailAddresses (
    id INT PRIMARY KEY, -- added key
    email_id varchar(50) UNIQUE,
    customer int,
    domain varchar(50),
    FOREIGN KEY (customer) REFERENCES CustomerAccounts(id)
);

create table Messages (
    id INT PRIMARY KEY, -- added key
    campaign_name varchar(50),
    audience varchar(50),
    version varchar(50),
    subject_line varchar(50),
    dep_date DATETIME,
    deployment varchar(50),
    UNIQUE(campaign_name, audience, version, subject_line, dep_date)
);

create table Recieve (
    id INT PRIMARY KEY, -- added key
    message INT,
    email INT,
    FOREIGN KEY (message) REFERENCES Messages(id),
    FOREIGN KEY (email) REFERENCES EmailAddresses(id),
    UNIQUE(message, email) 
);

create table EventTypes (
    id INT PRIMARY KEY,
    name varchar(50)
);

create table Generate (
    id INT PRIMARY KEY, -- added key
    event_date DATETIME,
    recieve INT,
    event_type INT,
    FOREIGN KEY (recieve) REFERENCES Recieve(id),
    FOREIGN KEY (event_type) REFERENCES EventTypes(id),
    UNIQUE(event_date, recieve, event_type)
);

create table Links (
    id INT PRIMARY KEY, -- added key
    name varchar(50),
    url varchar(50),
    message INT,
    FOREIGN KEY (message) REFERENCES Messages(id),
    UNIQUE(name, url, message)
);

create table Clicked (
    id INT PRIMARY KEY, -- added key
    generated INT,
    link INT,
    FOREIGN KEY (generated) REFERENCES Generate(id),
    FOREIGN KEY (link) REFERENCES Links(id),
    UNIQUE(generated, link)
);
