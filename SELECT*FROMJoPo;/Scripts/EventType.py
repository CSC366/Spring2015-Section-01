import hashlib

class EventType:
	def __init__(self, event_type_id, event_type_name):
		self.event_type_id = event_type_id
		self.event_type_name = event_type_name

	def __eq__(self, other):
		if not isinstance(other, EventType):
			return False

		return (self.event_type_id == other.event_type_id and
				self.event_type_name == other.event_type_name)

	def __str__(self):
		return str(self.event_type_id) + ', "' + self.event_type_name + '"'
