class DeviceToSerial:
   def __init__(self, registration_id, serial_number):
     self.registration_id = registration_id
     self.fk_serial_number = serial_number

   def __str__(self):
      return str(self.registration_id) + ', ' + str(self.fk_serial_number)
