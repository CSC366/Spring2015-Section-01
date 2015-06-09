import csv
import hashlib
from oracle2mysql import *

def HashString(my_str):
    my_hash = hashlib.md5(my_str).hexdigest()[-8:]
    return int (my_hash, 16) - (2 ** 31)

def SqlString(str):
	if not str:
		return "''"
	else:
		return "'" + str + "'"

#open up .sql and .csv file
source = open('CP_Device_Model.csv', 'r')
script = open('insert-Carrier.sql', 'w')

#source.readline() #get rid of top line
#lines = source.read().splitlines()

carriers = list()

try:
	reader = csv.reader(source)	
	
	#eat the first line
	reader_iter = iter(reader)
	next(reader_iter)

	for tokens in reader:
		#print row
		#script.write(row);
		if tokens[3] not in carriers:
			carriers.append(tokens[3])
			script.write("INSERT INTO Carrier VALUES (" + str(HashString(tokens[3])) + ", " + SqlString(tokens[3]) + ");\n"); 

#loop through csv file and write sql commands

#for line in lines:
#	tokens = line.split(",")
#	if (line != ""): #get rid of last line
		#script.write("INSERT INTO VALUES (" + line + ");\n")
		#print("Tokens[12]: " + tokens[10] + "\n");

#		script.write("INSERT INTO CustomerAccounts VALUES (NULL, '" + tokens[0] + "', '" + tokens[8] + "', " + date2mysql(tokens[10]) + ", '" + tokens[12] + "', 0);\n"); 

#close the two files
finally:
	source.close
	script.close
