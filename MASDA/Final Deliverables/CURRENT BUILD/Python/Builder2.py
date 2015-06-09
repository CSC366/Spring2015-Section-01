import csv
import hashlib
from sets import Set


def HashString(my_str):
    my_hash = hashlib.md5(my_str).hexdigest()[-8:]
    return int (my_hash, 16) - 2**31


def BuildModels(reader, output):
    id_set = Set()
    for line in reader:
        output.write("INSERT INTO Models\n")
        output.write("(id, model_id, name, model_type, carrier)\n")
        output.write("VALUES\n")
        my_id = HashString(line["Device Model"])
        model_id = line["Device Model"]
        id_set.add(model_id)
        name = line["Device Name"]
        model_type = line["Device Type"]
        carrier = HashString(line["Carrier"])
        output.write("(%s, '%s', '%s', '%s', %s)" % (my_id, model_id, name,
            model_type, carrier))
        output.write(";\n")
    return id_set

def InsertNewId(id_str):
    output.write("INSERT INTO Models\n")
    output.write("(id, model_id)\n")
    output.write("VALUES\n")
    output.write("(%s, '%s');\n" % (HashString(id_str), id_str))

def BuildDevices(reader, output, id_set):
    device_set = Set()
    for line in reader:
        my_id = HashString(line["SerialNumber"])
        serial_num = line["SerialNumber"]
        model = line["DeviceModel"]
        if model not in id_set:
            InsertNewId(model)
            id_set.add(model)
        model = HashString(model)
        if line["SerialNumber"]:
            if my_id not in device_set:
                device_set.add(my_id)
                output.write("INSERT INTO Devices\n")
                output.write("(id, serial_num, model)\n")
                output.write("VALUES\n")
                output.write("(%s, '%s', %s)" % (my_id, serial_num, model))
                output.write(";\n") 

with open('CP_Device_Model.csv', 'r') as inputCSV:
    with open('insert-Models.sql', 'w') as output:
        reader = csv.DictReader(inputCSV)
        id_set = BuildModels(reader, output)

with open('CP_Device.csv', 'r') as inputCSV:
    with open('insert-Devices.sql', 'w') as output:
        reader = csv.DictReader(inputCSV)
        BuildDevices(reader, output, id_set)
