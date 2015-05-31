import hashlib

class IsRegisteredVia:
   def __init__(self, fk_registration_id, fk_customer_id):
      self.fk_registration_id = fk_registration_id
      self.fk_customer_id = fk_customer_id

   def __eq__(self, other):
      if not isinstance(other, IsRegisteredVia):
         return False
      
      return (self.fk_registration_id == other.fk_registration_id and
              self.fk_customer_id == other.fk_customer_id)

   def __str__(self):
      return str(self.fk_registration_id) + ', ' + str(self.fk_customer_id)

   def __hash__(self):
      return hash(self.fk_registration_id) + hash(fk_customer_id)
