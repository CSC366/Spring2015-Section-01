import hashlib

class Event:
   def __init__(self, event_id, email_id, event_date, fk_event_type_id, fk_campaign_name):
      self.event_id = event_id
      self.email_id = email_id
      self.event_date = event_date
      self.fk_event_type_id = fk_event_type_id
      self.fk_campaign_name = fk_campaign_name

   def __eq__(self, other):
      if not isinstance(other, Event):
         return False
      
      return (self.email_id == other.email_id and
              self.event_date == other.event_date and
              self.fk_event_type_id == other.fk_event_type_id and
              self.fk_campaign_name == other.fk_campaign_name)

   def __str__(self):
      return   str(self.event_id) + ', ' + str(self.email_id) + ', "' + str(self.event_date) + '", ' + str(self.fk_event_type_id) + ', ' + str(self.fk_campaign_name)

   def __hash__(self):
      return hash(self.email_id) + hash(self.fk_event_type_id)
