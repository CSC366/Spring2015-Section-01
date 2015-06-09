import csv
import hashlib

def ConvertDate(date_string):
    myList = date_string.split("/")
    date = myList[1]
    month = myList[0]
    year = myList[2]
    return "%s-%s-%s" % (year, month, date)

def HashString(my_str):
    my_hash = hashlib.md5(my_str).hexdigest()[-8:]
    return int (my_hash, 16) - 2 ** 31

def MakeEmptyToNull(my_str):
    if (my_str == "''" or my_str == ""):
        my_str = 'NULL'

def BuildRegistrations(reader, output):
    for line in reader:
        output.write("INSERT INTO Registrations\n")
        output.write("(id, reg_id, customer, device, model, source_id, source_name, reg_date)\n")
        output.write("VALUES\n")
        my_id = HashString(line["RegistrationID"])
        reg_id = "'" + line["RegistrationID"] + "'"
        if (reg_id == "''"):
           reg_id = 'NULL'
        customer = HashString(line["CustomerID"])
        if (line["CustomerID"] == ""):
            customer = 'NULL'
        device = HashString(line["SerialNumber"])
        if (line["SerialNumber"] == ""):
           device = 'NULL'
        model = HashString(line["DeviceModel"])
        if (line["DeviceModel"] == ""):
           model = 'NULL'
        source_id = "'" + line["SourceID"] + "'"
        if (source_id == "''"):
           source_id = 'NULL'
        reg_date = "'" + ConvertDate(line["RegistrationDate"]) + "'"
        output.write("(%s, %s, %s, %s, %s, %s, %s)" % (my_id, reg_id,
            customer, device, model, source_id, reg_date))
        output.write(";\n") 

def BuildStores(reader, output):
    for line in reader:
        output.write("INSERT INTO Stores\n")
        output.write("(id, name, state, city, ecomm, purchase_date)\n")
        output.write("VALUES\n")
        my_id = HashString(line["RegistrationID"])
        name = "'" + line["PurchaseStoreName"] + "'"
        if (name == "''"):
           name = 'NULL'
        state = "'" + line["PurchaseStoreState"] + "'"
        if (state == "''"):
           state = 'NULL'
        city = "'" + line["PurchaseStoreCity"] + "'"
        if (city == "''"):
           city = 'NULL'
        ecomm = line["Ecomm"]
        if (line["Ecomm"] == ""):
           ecomm = 'NULL'
        purchase_date = "'" + ConvertDate(line["PurchaseDate"]) + "'"
        if (purchase_date == "''"):
           purchase_date = 'NULL'
        output.write("(%s, %s, %s, %s, %s, %s)" % (my_id, name, state, 
            city, ecomm, purchase_date))
        output.write(";\n") 

def BuildEmailAddresses(reader, output):
    for line in reader:
        output.write("INSERT INTO EmailAddresses\n")
        output.write("(id, email_id, customer, domain)\n")
        output.write("VALUES\n")
        my_id = HashString(line["EmailID"])
        email_id = "'" + line["EmailID"] + "'"
        if (email_id == "''"):
           email_id = 'NULL'
        customer = HashString(line["CustomerID"])
        if (line["CustomerID"] == ""):
           customer = 'NULL'
        domain = "'" + line["DomainName"] + "'"
        if (domain == "''"):
           domain = 'NULL'
        output.write("(%s, %s, %s, %s)" % (my_id, email_id, 
            customer, domain))
        output.write(";\n")

with open('CP_Device.csv', 'r') as inputCSV:
    with open('insert-Registrations.sql', 'w') as output:
        reader = csv.DictReader(inputCSV)
        BuildRegistrations(reader, output)

with open('CP_Device.csv', 'r') as inputCSV:
    with open('insert-Stores.sql', 'w') as output:
        reader = csv.DictReader(inputCSV)
        BuildStores(reader, output)

with open('CP_Account.csv', 'r') as inputCSV:
    with open('insert-EmailAddresses.sql', 'w') as output:
        reader = csv.DictReader(inputCSV)
        BuildEmailAddresses(reader, output)


