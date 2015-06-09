import csv
import hashlib
from oracle2mysql import *

def HashString(my_str):
    my_hash = hashlib.md5(my_str).hexdigest()[-8:]
    return int (my_hash, 16) - (2 ** 31)

#open up .sql and .csv file
source = open('CP_Device.csv', 'r')
script = open('update-CustomerAccounts.sql', 'w')

#source.readline() #get rid of top line
#lines = source.read().splitlines()

my_dict = dict()

try:
	reader = csv.reader(source)	
	
	#eat the first line
	reader_iter = iter(reader)
	next(reader_iter)

	for tokens in reader:
		if (tokens[11] not in my_dict) or (my_dict[tokens[0]] < tokens[11]):
			my_dict[tokens[0]] = tokens[11]
			
	
	for key in my_dict:
		script.write("UPDATE CustomerAccounts SET num_registrations = " + my_dict[key] 
		+ " WHERE id = " + str(HashString(key)) + ";\n"); 

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
