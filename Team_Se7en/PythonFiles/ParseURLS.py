file = open("CP_Email_Final.csv")
outfile = open("ParseURLS.sql", "w")

file.readline()

outfile.write("INSERT INTO URLS (Link, URL) VALUES \n")


string1 = ""
for x in file.readlines():
    count = 0
    string2 = ""
    for y in x.split(","):
        count += 1
        if count == 1: #EmailID
            pass
        elif count == 2: #Audience
            pass
        elif count == 3: #Campaign
            pass
        elif count == 4: #Version
            pass
        elif count == 5: #Subject
            pass
        elif count == 6: #Date
            pass
        elif count == 7: #DeploymentID
            pass
        elif count == 8: #EmailEventKey
            pass
        elif count == 9: #EmailType
            pass
        elif count == 10: #DateTime
            pass
        elif count == 13: #EmailID
            pass
        else:
            #y = y.strip()
            string2 += y.strip() + ","
    string1 += "(" + string2[:-1] + "),\n"
outfile.write(string1[:-2] + ";")
    
outfile.close()


#Create table with string and alter to date

#UPDATE RECIEPTS SET PurchaseDate = str_to_date(PurchaseDate, '%d-%M-%Y');
#ALTER TABLE RECIEPTS MODIFY PurchaseDate DATE;
