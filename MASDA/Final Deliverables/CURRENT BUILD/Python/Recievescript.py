#Takes information from email data csv and creates the Recieve table
# takes in teh file CP_Email_Final for the data
#outputs script insert-Recieve.sql with appropriate insert statments

import hashlib
import csv
def HashString(my_str):
    my_hash = hashlib.md5(my_str).hexdigest()[-8:]
    return int (my_hash, 16) - 2 ** 31


def date2mysql(oracleDate):
  dateComponents = oracleDate.split('/')
  month = dateComponents[0]
  day = dateComponents[1]
  year = dateComponents[2]
  mysqlDate = "'" + year +'-'+month+'-'+day + "'"
  return(mysqlDate)
  
def main():
    f = open('insert-Recieve.sql', 'w')
    file_name = 'CP_Email.csv'
    with open(file_name, 'r') as csvfile:
        mycsv = csv.reader(csvfile)
        firstline = True
        for row in mycsv:
            if firstline:
                firstline = False
            else:
                messagekey = str(HashString(str(row[2]) + str(row[1]) + str(row[3]) + str(row[4]) + date2mysql(row[5])))
                emailkey = (row[0]) #email id from email
                finalkey = str(HashString(messagekey + emailkey))
                f.write('INSERT INTO Recieve VALUES')
                f.write("(%s, %s, %s);\n" % (finalkey, messagekey, HashString(emailkey)))
    f.close()
main();