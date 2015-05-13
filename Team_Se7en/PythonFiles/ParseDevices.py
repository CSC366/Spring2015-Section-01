file = open("CP_Device_Model.csv")
outfile = open("ParseDeviceModels.sql", "w")

file.readline()

outfile.write("INSERT INTO DEVICES (Model, Name, Type, Carrier) VALUES \n")
string1 = ""
for x in file.readlines():
    string2 = ""
    for y in x.split(","):
        y = y.strip()
        string2 += y + ","
    string1 += "(" + string2[:-1] + "),\n"
outfile.write(string1[:-2] + ";")
    
outfile.close()


#Create table with string and alter to date

#UPDATE RECIEPTS SET PurchaseDate = str_to_date(PurchaseDate, '%d-%M-%Y');
#ALTER TABLE RECIEPTS MODIFY PurchaseDate DATE;
