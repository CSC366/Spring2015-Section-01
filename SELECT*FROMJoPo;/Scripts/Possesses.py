import hashlib

class Possesses:
   def __init__(self, fk_email_id, fk_customer_id):
      self.fk_email_id = fk_email_id
      self.fk_customer_id = fk_customer_id

   def __eq__(self, other):
      if not isinstance(other, Possesses):
         return False
      
      return (self.fk_email_id == other.fk_email_id and
              self.fk_customer_id == other.fk_customer_id)

   def __str__(self):
      return str(self.fk_email_id) + ',' + str(self.fk_customer_id)

   def __hash__(self):
      return hash(self.fk_email_id) + hash(fk_customer_id)
