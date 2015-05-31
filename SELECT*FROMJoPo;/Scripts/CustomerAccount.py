class CustomerAccount:
   def __init__(self, customer_id, permission, customer_tier, gender, zip, state, income_level, num_registrations, reg_source, regDate, language):
      self.customer_id = customer_id
      self.permission = permission
      self.customer_tier = customer_tier
      self.gender = gender
      if zip:
         self.zip = zip
      else:
         self.zip = 0
      self.state = state
      self.income_level = income_level
      self.num_registrations = num_registrations
      self.reg_source = reg_source
      self.regDate = regDate
      self.language = language

   def __eq__(self, other):
      if not isinstance(other, CustomerAccount):
         return False

      return (self.customer_id == other.customer_id and
              self.permission == other.permission and
              self.customer_tier == other.customer_tier and
              self.gender == other.gender and
              self.zip == other.zip and
              self.state == other.state and
              self.income_level == other.income_level and
              self.num_registrations == other.num_registrations)

   def __str__(self):
      return str(self.customer_id) + ', ' + str(self.permission) +  ', "' + self.customer_tier + '", "' + self.gender + '", ' + str(self.zip) + ', "' + \
             str(self.state) + '", "' + str(self.income_level) + '", ' + str(self.num_registrations) + ', ' + str(self.reg_source) + ', "' + str(self.regDate) + '", "' + str(self.language) + '"'

   def __hash__(self):
      return hash(customer_id)
