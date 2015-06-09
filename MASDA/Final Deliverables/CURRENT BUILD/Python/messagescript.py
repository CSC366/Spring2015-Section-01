#Takes information from email CP_Email csv and creates the messages table
#takes in the file CP_Email.csv for the data
#outputs script Insert-Message.sql with appropriate insert statments

import csv
import hashlib

def SqlString(str):
   if not str:
      return "NULL"
   else:
      return "\"" + str + "\""

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
  x = 0;
  ll = []
  f = open('insert-Message.sql', 'w')
  file_name = 'CP_Email.csv'
  with open(file_name, 'r') as csvfile:
      mycsv = csv.reader(csvfile)
      firstline = True
      for row in mycsv:
        if firstline:
          firstline = False
        else:
         temp = str(HashString(str(row[2]) + str(row[1]) + str(row[3]) + str(row[4]) + date2mysql(row[5])))
         if temp not in ll:
          x+=1
          ll.append(temp)
          temp2 = "INSERT INTO Messages VALUES (" + temp + ', ' + SqlString(row[2]) + ', ' + SqlString(row[1]) + ', ' + SqlString(row[3]) + ', ' + SqlString(row[4]) + ', ' + date2mysql(row[5]) + ', ' + SqlString(row[6]) + ");\n"
          f.write(temp2)
  f.close()
  print(x)
main();