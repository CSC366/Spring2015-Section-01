class ClickedLink:
   def __init__(self, event_id, link_id):
      self.fk_event_id = event_id
      self.fk_link_id = link_id

   def __str__(self):
      return str(self.fk_event_id) + ', ' + str(self.fk_link_id)
