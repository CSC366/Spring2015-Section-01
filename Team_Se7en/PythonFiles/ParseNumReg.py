file = open("CP_Device.csv")
outfile = open("Customer2.sql", "w")

file.readline()

#outfile.write("UPDATE CUSTOMERS (Id, RegSrcID, Zip, State, Gender, Income, Permission, Language, RegDate, Tier) VALUES \n")
string1 = ""
ID = ""
for x in file.readlines():
    count = 0
    string2 = "Update CUSTOMERS\nSET NumRegs = "
    for y in x.split(","):
        count += 1
        if count == 1:
            ID = y.strip() + ";\n"
        if count == 12: #NumRegs
            y = y.strip()
            string2 += y + "\nWHERE CustomerID = " + ID

    string1 += string2
outfile.write(string1)
    
outfile.close()

#[:-2]
#Create table with string and alter to date

#UPDATE RECIEPTS SET PurchaseDate = str_to_date(PurchaseDate, '%d-%M-%Y');
#ALTER TABLE RECIEPTS MODIFY PurchaseDate DATE;
