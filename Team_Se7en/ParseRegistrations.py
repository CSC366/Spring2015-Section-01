file = open("CP_Devices.csv")
outfile = open("ParseRegistrations.sql", "w")

file.readline()

outfile.write("INSERT INTO MESSAGES (Serial, PurchaseDate, PurchaseStore, PurchaseState, PurchaseCity, Ecomm) VALUES \n")


string1 = ""
for x in file.readlines():
    count = 0
    string2 = ""
    for y in x.split(","):
        count += 1
        if count == 1: #CustomerID
            pass
        elif count == 2: #SourceID
            pass
        elif count == 3: #SourceName
            pass
        elif count == 4: #DeviceModel
            pass
        elif count == 11: #RegDate
            pass
        elif count == 12: #NumReg
            pass
        elif count == 13: #RegId
            pass
        else:
            #y = y.strip()
            string2 += y.strip() + ","
    string1 += "(" + string2[:-1] + "),\n"
outfile.write(string1[:-2] + ";")
    
outfile.close()
