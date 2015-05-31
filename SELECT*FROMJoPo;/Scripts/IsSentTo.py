class IsSentTo:
   def __init__(self, fk_campaign_name, fk_email_id, deployment_id, deployment_date):
      self.fk_campaign_name = fk_campaign_name
      self.fk_email_id = fk_email_id
      self.deployment_id = deployment_id
      self.deployment_date = deployment_date

   def __eq__(self, other):
      if not isinstance(other, IsSentTo):
         return False
      
      return (self.fk_campaign_name == other.fk_campaign_name and
              self.fk_email_id == other.fk_email_id and
              self.deplyoment_id == other.deployment_id and
              self.deployment_date == other.deployment_date)

   def __str__(self):
      return str(self.fk_campaign_name) + ', ' + str(self.fk_email_id) + ', ' + str(self.deployment_id) + ', "' + str(self.deployment_date) + '"'

   def __hash__(self):
      return hash(fk_campaign_name) + hash(fk_email_id)
	
