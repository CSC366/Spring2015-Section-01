import hashlib

class Deployment:
   def __init__(self, deployment_id, deployment_date, fk_campaign_name):
      self.deployment_id = deployment_id
      self.deployment_date = deployment_date
      self.fk_campaign_name = fk_campaign_name

   def __eq__(self, other):
      if not isinstance(other, Deployment):
         return False
      
      return (self.deployment_id == other.deployment_id and
              self.deployment_date == other.deployment_date and
              self.fk_campaign_name == other.fk_campaign_name)

   def __str__(self):
      return  str(self.deployment_id) + ', "' + str(self.deployment_date)+ '", "' + str(self.fk_campaign_name) + '"'

   def __hash__(self):
      return hash(self.deployment_id)
