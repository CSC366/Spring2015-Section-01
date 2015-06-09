# CREATE TABLE EmailSent(
#    campaign_name VARCHAR(100),
#    version VARCHAR(50),
#    subject_line VARCHAR(100),
#    audience VARCHAR(100),
#    fk_link_name VARCHAR(30),
#    PRIMARY KEY(campaign_name),
#    FOREIGN KEY(fk_link_name) REFERENCES Link(link_name)
# );

import hashlib

class EmailSent:
   def __init__(self, campaign_id, campaign_name, version, subject_line, audience):
      self.campaign_id = campaign_id
      self.campaign_name = campaign_name
      self.version = version
      self.subject_line = subject_line
      self.audience = audience

   def __eq__(self, other):
		if not isinstance(self, other):
			return False

		return (self.campaign_id == campaign_id and
            self.campaign_name == other.campaign_name and
				self.version == other.version and
				self.subject_line == other.subject_line and
				self.audience == other.audience)

   def __str__(self):
		return (str(self.campaign_id) + ', "' + self.campaign_name + '", "' + self.version + '", "' + self.subject_line + '", "' + self.audience + '"')

   def __hash__(self):
		return hash(self.campaign_name)
	
