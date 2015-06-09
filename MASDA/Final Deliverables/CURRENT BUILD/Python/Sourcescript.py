#Takes information from Cp_devices.csv csv and creates the Source table
# takes in the file CP_devices.csv for the data
#outputs script insert-Source.sql with appropriate insert statments


import csv
import hashlib

def HashString(my_str):
    my_hash = hashlib.md5(my_str).hexdigest()[-8:]
    return int (my_hash, 16) -  2 ** 31

def main():
   ll = []
   f = open('insert-Source.sql', 'w')
   file_name = 'CP_Device.csv'
   with open(file_name, 'r') as csvfile:
      firstline = True
      mycsv = csv.reader(csvfile)
      for row in mycsv:
         if firstline:
            firstline = False
         else:
            temp = row[1] 
            if temp not in ll:
               ll.append(temp)
               f.write('INSERT INTO Sources VALUES (' + row[1] + ", '" + row[2] + "');\n")
      f.close()
main();