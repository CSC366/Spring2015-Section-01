
import hashlib

class DeviceModel:
   def __init__(self, device_id, device_name, device_model, device_type, carrier):
      self.device_id = device_id
      self.device_name = device_name
      self.device_model = device_model
      self.device_type = device_type
      self.carrier = carrier

   def __eq__(self, other):
      if not isinstance(other, DeviceModel):
         return False
      
      return (self.device_name == other.device_name and
              self.device_model == other.device_model and
              self.device_type == other.device_type and
              self.carrier == other.carrier)

   def __str__(self):
      return str(self.device_id) + ', "' + str(self.device_model) + '", "' + self.device_name + '", "' + self.device_type + '", "' + self.carrier + '"'

   def __hash__(self):
      return hash(self.device_model)
      
