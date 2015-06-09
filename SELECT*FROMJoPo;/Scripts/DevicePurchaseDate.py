import hashlib

class DevicePurchaseDate:

	def __init__(self, purchase_date):
		self.purchase_date = purchase_date

	def __eq__(self, other):
		if not isinstance(other, DevicePurchaseDate):
			return False

		return (self.purchase_date == purchase_date)

	def __str__(self):
		return '"' + self.purchase_date + '"'

	def __hash__(self):
		return hash(self.purchase_date)
