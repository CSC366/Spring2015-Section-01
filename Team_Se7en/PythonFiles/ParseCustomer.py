file = open("CP_Account.csv")
outfile = open("Customer.sql", "w")

file.readline()

outfile.write("INSERT INTO CUSTOMERS (CustomerID, RegSrcID, Zip, State, Gender, Income, Permission, Language, RegDate, CustomerTier) VALUES \n")
string1 = ""
for x in file.readlines():
    count = 0
    string2 = ""
    for y in x.split(","):
        count += 1
        if count == 2: #EmailID
            pass
        elif count == 4: #RegSourceName
            pass
        elif count == 12: #DomainName
            pass
        else:
            y = y.strip()
            #y = y.strip("'")
            #string2 += "'" + y + "'" + ","
            string2 += y + ","
    string1 += "(" + string2[:-1] + "),\n"
outfile.write(string1[:-2] + ";")
    
outfile.close()


#Create table with string and alter to date

#UPDATE RECIEPTS SET PurchaseDate = str_to_date(PurchaseDate, '%d-%M-%Y');
#ALTER TABLE RECIEPTS MODIFY PurchaseDate DATE;
