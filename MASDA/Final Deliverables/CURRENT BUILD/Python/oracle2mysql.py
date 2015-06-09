
## CSC 365
## Alex Dekhtyar 

## convert Oracle-style dates in 'DD/MM/YY' format
## to default MySQL 'YYYY/MM/DD' format
def date2mysql(oracleDate):
    #print 'Parsing: ' + oracleDate + '\n'
    dateComponents = oracleDate.split('/')  ## decompose the date

    month = dateComponents[0]
    day = dateComponents[1]
    year = dateComponents[2]

    mysqlDate = year+'-'+month+'-'+day      ## form the converted string
    return(mysqlDate)



## convert Oracle-style dates in 'DD-Mon-YY' format
## to default MySQL 'MM/DD/YYYY' format  
## This function takes as input a string in single quotes and returns back
## the single quotes as well
def date2mysqlQuotes(oracleDate):

    ## Dictionary of months
    months = {'JAN':'01', 'FEB':'02', 'MAR':'03', 'APR':'04',
              'MAY':'05', 'JUN':'06', 'JUL':'07', 'AUG':'08',
              'SEP':'09', 'OCT':'10', 'NOV':'11', 'DEC':'12'}

   
    dateComponents = oracleDate.strip("'").split('-')  ## decompose the date

    oracleMonth = dateComponents[1].upper()
    month = months[oracleMonth]  ## convert the month
  
    oracleYear = dateComponents[2].strip(" \n\r")
    year =""
    if len(oracleYear) == 2:
        year = '20'+oracleYear              ## convert the year
                                            ## this is cheating a bit
                                            ## but all dates in 365 DBs are in 
                                            ## the 21st century
    elif len(oracleYear) == 4:              ## if the year is already four characters
        year = oracleYear                   ## then keep it intact      

    day = dateComponents[0]                 ## extract day of month
 
    mysqlDate = "'"+year+'/'+month+'/'+day+"'"      ## form the converted string
    return(mysqlDate)

## convert Oracle default for time to MySQL time expression
## If the time value has [H]H:MM:SS format - do nothing
## if it has [M]M:SS format - add leading zeroes

def time2mysql(time):
   
   time = time.strip(" \n\r")
   timeComponents= time.split(":")   # decompose the time
   mysqlTime = ""

   if len(timeComponents) == 3:   # if the time is already in HH:MM:SS format 
       mysqlTime = time           # do nothing
   elif len(timeComponents) == 2: # otherwise, add "00" hours
       mysqlTime = '00:'+time

   return mysqlTime
    
 
## convert Oracle default for time to MySQL time expression
## If the time value has [H]H:MM:SS format - do nothing
## if it has [M]M:SS format - add leading zeroes

# this version preserves single quotes
def time2mysqlQuotes(time):
   
   time = time.strip(" \n\r'")
   timeComponents= time.split(":")   # decompose the time
   mysqlTime = ""

   if len(timeComponents) == 3:   # if the time is already in HH:MM:SS format 
       mysqlTime = "'"+time+"'"   # do nothing
   elif len(timeComponents) == 2: # otherwise, add "00" hours
       mysqlTime = "'00:"+time+"'"

   return mysqlTime
    
    
