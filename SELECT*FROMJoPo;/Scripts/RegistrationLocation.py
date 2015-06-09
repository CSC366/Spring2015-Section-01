class RegistrationLocation:
   def __init__(self, id, name):
      self.id = id
      self.name = name

   def __eq__(self, other):
      if not isinstance(other, RegistrationLocation):
         return False

      return (self.id == other.id and
              self.name == other.name)

   def __hash__(self):
      return hash(id)

   def __str__(self):
      return str(self.id) + ', "' + self.name + '"'
