import sys
import csv
import datetime

import DeviceModel
import RegistrationLocation
import CustomerAccount
import CustomerEmail
import PurchaseInformation
import DeviceRegistration
import DeviceSerial
import DevicePurchaseDate
import Link
import Event
import EventType
import EmailSent
import Possesses
import IsSentTo
import IsRegisteredVia
import ClickedLink
import DeviceToSerial
import DeviceToPurchaseInformation

def main():
   device_models = {}
   registration_location = {}
   customer_email = {}
   customer_account = {}
   purchase_information = {}
   device_registration = {}
   purchase_date = {}
   serial_number = {}
   link = {}
   possesses = {}
   isregisteredvia = {}
   devicetoserial = {}
   devicetopurchaseinformation = {}
   purchase_information[""] = "NULL"
   device_counter = 0
   store_counter = 0
   purchase_date_counter = 0
   serial_counter = 0
   link_counter = 0

   # Read and parse Device Model csv
   with open('CP_Device_Model.csv', 'rb') as csvfile:
      deviceReader = csv.reader(csvfile, delimiter=',')
      
      deviceReader.next()                         #Skip Header Row
      
      for row in deviceReader:
         try:
            device_models[row[0]]                 # Try to index into the map with key
         except KeyError:                         # If it dosen't exist, put into map
            temp = DeviceModel.DeviceModel(device_counter, row[1], row[0], row[2], row[3]) 
            device_models[row[0]] = temp #device_counter
            device_counter = device_counter + 1
   
   # Read and parse Device csv
   with open('CP_Device.csv', 'rb') as csvfile:
      deviceReader = csv.reader(csvfile, delimiter=',')
      
      deviceReader.next()                         #Skip Header Row
      # Continue making Device Models
      for row in deviceReader:
         try:
            device_models[row[3]]
         except KeyError:
            temp = DeviceModel.DeviceModel(device_counter, '', row[3], '', '') 
            device_models[row[3]] = temp #device_counter
            device_counter = device_counter + 1
   
         try:
            if row[4]:
               serial_number[row[4]]
         except KeyError:
            temp = DeviceSerial.DeviceSerial(row[4])
            serial_number[row[4]] = serial_counter
            serial_counter = serial_counter + 1
         
         try:
            if row[5]:
               purchase_date[row[5]]
         except KeyError:
            temp = DevicePurchaseDate.DevicePurchaseDate(row[5])
            purchase_date[row[5]] = purchase_date_counter
            purchase_date_counter = purchase_date_counter + 1

   with open('CP_Account.csv', 'rb') as csvfile:
      deviceReader = csv.reader(csvfile, delimiter=',')
      
      deviceReader.next()
      for row in deviceReader:
         try:
            registration_location[row[2]]
         except KeyError:
            temp = RegistrationLocation.RegistrationLocation(row[2], row[3])
            registration_location[row[2]] = temp

         try:
            customer_account[row[0]] 
            # Customer Exists.. Replace
            temp = CustomerAccount.CustomerAccount(row[0], 'TRUE' if row[8] == '0' else 'FALSE', row[12], row[6], row[4], row[5], row[7], 0, row[2], datetime.datetime.strptime(row[10], "%m/%d/%Y").strftime("%Y/%m/%d"), row[9])
            customer_account[row[0]] = temp
         except KeyError:
            temp = CustomerAccount.CustomerAccount(row[0], 'TRUE' if row[8] == '0' else 'FALSE', row[12], row[6], row[4], row[5], row[7], 0, row[2], datetime.datetime.strptime(row[10], "%m/%d/%Y").strftime("%Y/%m/%d"), row[9])
            customer_account[row[0]] = temp
        
         try:
            customer_email[row[1] + row[11]]
         except KeyError:
            temp = CustomerEmail.CustomerEmail(row[1], row[11])
            customer_email[row[1] + row[11]] = temp

         try:
            possesses[row[0] + row[1]]   
         except KeyError:
            temp = Possesses.Possesses(row[1], row[0])
            possesses[row[0] + row[1]] = temp

   with open('CP_Device.csv', 'rb') as csvfile:
      deviceReader = csv.reader(csvfile, delimiter=',')
      
      deviceReader.next()                         #Skip Header Row
      # Continue making Device Models
      for row in deviceReader:
         try:
            device_models[row[3]]
         except KeyError:
            temp = DeviceModel.DeviceModel(device_counter, 'NULL', row[3], 'NULL', 'NULL') 
            device_models[row[3]] = temp
            device_counter = device_counter + 1
         
         try:
            cust = customer_account[row[0]]
            if row[11] > cust.num_registrations:
               cust.num_registrations = row[11]
         except KeyError:
            pass 
        
         found_purchase_info = None
         try:
            purchase_information[row[6] + row[7] + row[8]]
         except KeyError:
            temp = PurchaseInformation.PurchaseInformation(store_counter, row[6], row[7], row[8], row[9])
            purchase_information[row[6] + row[7] + row[8]] = store_counter 
            store_counter = store_counter + 1
         
         try:
            registration_location[row[1]]
         except KeyError:
            temp = RegistrationLocation.RegistrationLocation(row[1], row[2])
            registration_location[row[1]] = temp
        
         try:
            device_registration[row[12]]
         except KeyError:
            temp = DeviceRegistration.DeviceRegistration(row[12], datetime.datetime.strptime(row[10], "%m/%d/%Y").strftime("%Y/%m/%d"), device_models[row[3]].device_id,row[1], purchase_date[row[5]] if row[5] else "NULL") 
            device_registration[row[12]] = temp
   
         try:
            isregisteredvia[row[12] + row[0]]
         except KeyError:
            temp = IsRegisteredVia.IsRegisteredVia(row[12], row[0])
            isregisteredvia[row[12] + row[0]] = temp

         try:
            if row[4]:
               devicetoserial[row[12] + str(serial_number[row[4]])]
         except KeyError:
               temp = DeviceToSerial.DeviceToSerial(row[12], str(serial_number[row[4]]))
               devicetoserial[row[12] + str(serial_number[row[4]])] = temp

         try:
            devicetopurchaseinformation[row[12] + row[6] + row[7] + row[8]]
         except KeyError:
            if  purchase_information[row[6] + row[7] + row[8]] and purchase_information[row[6] + row[7] + row[8]] != "NULL":
               temp = DeviceToPurchaseInformation.DeviceToPurchaseInformation(row[12], purchase_information[row[6] + row[7] + row[8]]) 
               devicetopurchaseinformation[row[12] + row[6] + row[7] + row[8]] = temp

   event_type = {}
   event = {}
   event_counter = 0
   email_sent = {}
   email_sent_counter = 0
   issentto = {}
   clicked_link = {}

   with open('CP_Email.csv', 'rb') as csvfile:
      deviceReader = csv.reader(csvfile, delimiter=',')
      
      deviceReader.next()                         #Skip Header Row
      
      for row in deviceReader:
         try:
            link[row[10]]
         except KeyError:
            temp = Link.Link(link_counter, row[10], row[11])
            link[row[10]] = link_counter 
            link_counter = link_counter + 1

         try:
           event_type[row[7]] 
         except KeyError:
            temp = EventType.EventType(row[7], row[8])
            event_type[row[7]] = temp
         
         try:
            email_sent[row[2] + row[3] + row[4] + row[1]]
         except KeyError:
            temp = EmailSent.EmailSent(email_sent_counter, row[2], row[3], row[4], row[1])
            email_sent[row[2] + row[3] + row[4] + row[1]] = email_sent_counter 
            email_sent_counter = email_sent_counter + 1
         
         try:
            #if row[5] == '3/21/2013':
            #   print "FOUND IT"
            issentto[row[0] + row[2] + row[3] + row[4] + row[1] + row[5]]
         except KeyError:
            temp = IsSentTo.IsSentTo(email_sent[row[2] + row[3] + row[4] + row[1]], row[0], row[6], datetime.datetime.strptime(row[5], "%m/%d/%Y").strftime("%Y/%m/%d"))
            issentto[row[0] + row[2] + row[3] + row[4] + row[1] + row[5]] = temp
      
         try:
            event[row[0] + row[9] + row[7] + row[2] + row[3] + row[4] + row[1]]
         except KeyError:
            temp = Event.Event(event_counter, row[0], datetime.datetime.strptime(row[9], "%m/%d/%y %I:%M %p").strftime("%Y/%m/%d %H:%M:%S"), row[7], email_sent[row[2] + row[3] + row[4] + row[1]])
            event[row[0] + row[9] + row[7] + row[2] + row[3] + row[4] + row[1]] = temp
            event_counter = event_counter + 1

         try:
            clicked_link[row[0] + row[9] + row[7] + row[2] + row[3] + row[4] + row[1] + row[10]]
         except KeyError:
            aEvent = event[row[0] + row[9] + row[7] + row[2] + row[3] + row[4] + row[1]]
            aLink = link[row[10]]
            temp = ClickedLink.ClickedLink(aEvent.event_id, aLink)
            clicked_link[row[0] + row[9] + row[7] + row[2] + row[3] + row[4] + row[1] + row[10]] = temp
   
   for key, value in issentto.iteritems():
      print 'INSERT INTO IsSentTo VALUES(' + str(value) + ');'

   return 0

"""
   
   for key, value in customer_account.iteritems():
      print 'INSERT INTO CustomerAccount VALUES(' + str(value) + ');'
   for key, value in devicetopurchaseinformation.iteritems():
      print 'INSERT INTO DeviceToPurchaseInformation VALUES(' + str(value) + ');'
   for key, value in devicetoserial.iteritems():
      print 'INSERT INTO DeviceToSerial VALUES(' + str(value) + ');'
   for key, value in device_registration.iteritems():
      print 'INSERT DeviceRegistration VALUES(' + str(value) + ');'
   for key, value in clicked_link.iteritems():
      print 'INSERT INTO ClickedLink VALUES(' + str(value) + ');'
   for key, value in device_models.iteritems():
      print 'INSERT INTO DeviceModel VALUES(' + str(value) + ');'
   for key, value in isregisteredvia.iteritems():
      print 'INSERT INTO IsRegisteredVia(' + str(value) + ');'
   for key, value in customer_email.iteritems():
      print 'INSERT INTO CustomerEmail(' + str(value) + ');'
   for key, value in email_sent.iteritems():
      print 'INSERT INTO EmailSent(' + str(value) + ');'
   for key, value in link.iteritems():
      print 'INSERT INTO Link(' + str(value) + ');'
   for key, value in event_type.iteritems():
      print 'INSERT INTO EventType(' + str(value) + ');'
   for key, value in purchase_information.iteritems():
      print 'INSERT INTO PurchaseInformation(' + str(value) + ');'
   for key, value in registration_location.iteritems():
      print 'INSERT INTO RegistrationLocation(' + str(value) + ');'
   for key, value in purchase_date.iteritems():
      print 'INSERT DevicePurchaseDate(' + str(value) + ', "' + datetime.datetime.strptime(key, "%m/%d/%Y").strftime("%Y/%m/%d") + '");'
   for key, value in device_registration.iteritems():
      print 'INSERT DeviceRegistration(' + str(value) + ');'
   for key, value in possesses.iteritems():
      print 'INSERT INTO Possesses VALUES(' + str(value) + ');'
   for key, value in event.iteritems():
      print 'INSERT INTO Event(' + str(value) + ');'
   
"""

if __name__ == "__main__":
   sys.exit(main())
