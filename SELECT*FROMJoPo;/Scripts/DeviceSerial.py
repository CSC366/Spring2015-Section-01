import hashlib

class DeviceSerial:

	def __init__(self, serial_number):
		self.serial_number = serial_number

	def __eq__(self, other):
		if not isinstance(other, DeviceSerial):
			return False

		return self.serial_number == other.serial_number

	def __str__(self):
		return '"' + self.serial_number + '"'

	def __hash__(self):
		return hash(self.serial_number)
