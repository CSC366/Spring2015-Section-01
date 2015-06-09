import csv
import hashlib
from sets import Set

def ConvertDate(date_string):
    myList = date_string.split("/")
    year_time_list = myList[2].split()
    date = myList[1]
    month = myList[0]
    year = year_time_list[0] 
    time = year_time_list[1]
    return "%s-%s-%s %s" % (year, month, date, time)


def HashString(my_str):
    my_hash = hashlib.md5(my_str).hexdigest()[-8:]
    return int (my_hash, 16) - 2**31

def CheckNull(my_str):
  if not my_str:
    return "\n"
  else:
    return my_str

def BuildGenerate(reader, output):
    id_set = Set()
    for line in reader:
        emailstr = line["EmailID"]
        messagestr = (line["EmailCampaignName"] + 
            line["AudienceSegment"] + line["EmailVersion"] +
            line["SubjectLineCode"])
        my_id = HashString(line["EmailEventDateTime"] + messagestr
             + emailstr + line["EmailEventKey"])
        event_date = "'" + ConvertDate(line["EmailEventDateTime"]) + "'"
        recieve = HashString(messagestr + emailstr)
        event_type = line["EmailEventKey"]
        if (my_id not in id_set):
            id_set.add(my_id)
            output.write("INSERT INTO Generate\n")
            output.write("(id, event_date, recieve, event_type)\n")
            output.write("VALUES\n")
            output.write("(%s, %s, %s, %s)" % (my_id, event_date,
                recieve, event_type))
            output.write(";\n") 

def BuildLinks(reader, output):
    id_set = Set()
    for line in reader:
        my_id = HashString(line["HyperlinkName"] + line["EmailURL"]
            + line["EmailCampaignName"] + line["AudienceSegment"] +
            line["EmailVersion"] + line["SubjectLineCode"])
        name = line["HyperlinkName"]
        url = line["EmailURL"]
        message = HashString(line["EmailCampaignName"] + 
            line["AudienceSegment"] + line["EmailVersion"]
            + line["SubjectLineCode"] + line["Fulldate"])
        if name  and url:
            if (my_id not in id_set):
                id_set.add(my_id) 
                output.write("INSERT INTO Links\n")
                output.write("(id, name, url, message)\n")
                output.write("VALUES\n")
                output.write("(%s, \"%s\", \"%s\", %s)" % (my_id, name, url, 
                    message))
                output.write(";\n")


def BuildClicked(reader, output):
    id_set = Set()
    for line in reader:
        emailstr = line["EmailID"]
        messagestr = (line["EmailCampaignName"] + 
            line["AudienceSegment"] + line["EmailVersion"] +
            line["SubjectLineCode"])
        generatedstr = (line["EmailEventDateTime"] + messagestr
            + emailstr + line["EmailEventKey"])
        linkstr = (line["HyperlinkName"] + line["EmailURL"]
            + line["EmailCampaignName"] + line["AudienceSegment"] +
            line["EmailVersion"] + line["SubjectLineCode"])
        my_id = HashString(generatedstr + linkstr)
        if line["EmailEventType"] == "Click":
            if (my_id not in id_set):
                id_set.add(my_id)
                output.write("INSERT INTO Clicked\n")
                output.write("(id, generated, link)\n")
                output.write("VALUES\n")
                output.write("(%s, %s, %s)" % (my_id, 
                    HashString(generatedstr), HashString(linkstr)))
                output.write(";\n")



with open('CP_Email.csv', 'r') as inputCSV:
    # with open('insert-Generate.sql', 'w') as output:
    reader = csv.DictReader(inputCSV)
        # BuildGenerate(reader, output)
    # inputCSV.seek(0)
    # with open('insert-Links.sql', 'w') as output:
    #     BuildLinks(reader, output)
    # inputCSV.seek(0)
    with open('insert-Clicked.sql', 'w') as output:
        BuildClicked(reader, output)


