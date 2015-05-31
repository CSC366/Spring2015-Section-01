class DeviceToPurchaseInformation:
   def __init__(self, registration_id, purchase_store_id):
     self.registration_id = registration_id
     self.fk_purchase_store_id = purchase_store_id

   def __str__(self):
      return str(self.registration_id) + ', ' + str(self.fk_purchase_store_id)
