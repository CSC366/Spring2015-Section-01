file = open("CP_Email_Final_Test.csv")
outfile = open("ParseMessages.sql", "w")

file.readline()

outfile.write("INSERT INTO MESSAGES (EmailID, Audience, CampaignID, Version, Subject, DeployDate, DeployID) VALUES \n")


string1 = ""
for x in file.readlines():
    count = 0
    string2 = ""
    for y in x.split(","):
        count += 1
        if count == 2: #fixNullAudience
            if y == "":
                string2 += "noAudience,"
            else:
                string2 += y.strip() + ","
        elif count == 4: #fixVersion
            if y == "":
                string2 += "noVersion,"
            else:
                string2 += y.strip() + ","
        elif count == 5: #fixSubject
            if y == "":
                string2 += "N/A,"
            else:
                string2 += y.strip() + ","
        elif count == 8: #EmailEventKey
            pass
        elif count == 9: #EmailType
            pass
        elif count == 11: #Hyperlink Name
            pass
        elif count == 12: #EmailURL
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
