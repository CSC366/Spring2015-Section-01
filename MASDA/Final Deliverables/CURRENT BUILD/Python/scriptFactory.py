import csv
import hashlib
import datetime
from oracle2mysql import *

def HashString(my_str):
    my_hash = hashlib.md5(my_str).hexdigest()[-8:]
    return int (my_hash, 16) - (2 ** 31) # subtract max_int

def SqlString(str):
	if not str:
		return "''"
	else:
		return "'" + str + "'"

# returns true if date1 < date2
def DateCmp(str1, str2):
	date1 = map(int, str1.split("/"))
	date2 = map(int, str2.split("/"))
	date_left = datetime.date(date1[2], date1[0], date1[1]) 
	date_right = datetime.date(date2[2], date2[0], date2[1])
	return date_left < date_right
 
#open up .sql and .csv file
source = open('CP_Account.csv', 'r')
script = open('insert-CustomerAccounts.sql', 'w')

my_dict = dict()

try:
	reader = csv.reader(source)	
	
	#eat the first line
	reader_iter = iter(reader)
	next(reader_iter)

	#first pass: find most recent customers
	for tokens in reader:
		if (tokens[0] not in my_dict) or (DateCmp(my_dict[tokens[0]], tokens[10])):
			my_dict[tokens[0]] = tokens[10]

	#second pass: insert latest account activations
	source.close()
	source = open('CP_Account.csv', 'r')
	reader = csv.reader(source)
	reader_iter = iter(reader)
	next(reader_iter)

	for tokens in reader:
		if (my_dict[tokens[0]] == tokens[10]):
			script.write("INSERT INTO CustomerAccounts VALUES (" + str(HashString(tokens[0])) + ", " + SqlString(tokens[0]) + ", " 
			+ SqlString(tokens[8]) + ", " + SqlString(date2mysql(tokens[10])) 
			+ ", " + SqlString(tokens[12]) + ", 0);\n"); 

#close the two files
finally:
	source.close
	script.close
