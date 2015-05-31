
# CREATE TABLE PurchaseInformation(
#    purchase_store_id INT,
#    purchase_store_name VARCHAR(50),
#    purchase_store_state CHAR(2),
#    purchase_store_city VARCHAR(50),
#    ecomm_flag BOOLEAN,
#    PRIMARY KEY(purchase_store_id),
#    UNIQUE(purchase_store_name, purchase_store_state, purchase_store_city)
# );

import hashlib

class PurchaseInformation:
	def __init__(self, purchase_store_id, purchase_store_name, purchase_store_state, purchase_store_city, ecomm_flag):
		self.purchase_store_id = purchase_store_id
		self.purchase_store_name = purchase_store_name
		self.purchase_store_state = purchase_store_state
		self.purchase_store_city = purchase_store_city
		self.ecomm_flag = ecomm_flag

	def __eq__(self, other):
		if not isinstance(other, PurchaseInformation):
			return False

		return (self.purchase_store_id == other.purchase_store_id and
				self.purchase_store_name == other.purchase_store_name and
				self.purchase_store_state == other.purchase_store_state and
				self.purchase_store_city == other.purchase_store_city and
				self.ecomm_flag == ecomm_flag)

	def __str__(self):
		return (str(self.purchase_store_id) + ', "' + self.purchase_store_name + '", "' + self.purchase_store_state 
			+ '", "' + self.purchase_store_city + '", ' + self.ecomm_flag)

	def __hash__(self):
		return hash(self.purchase_store_name) + hash(self.purchase_store_state) + hash(self.purchase_store_city)

