class Locomotive:
    def __init__(self, id, model, prod_date, power, type, vmax, mass, station):
        self.id = id
        self.model = model
        self.prod_date = prod_date
        self.power = power
        self.type = type
        self.vmax = vmax
        self.mass = mass
        self.station = station

    def toBulk(self):
        return str(self.id) + "," + str(self.model) + "," + str(self.prod_date) + "," + str(self.power) + "," + str(self.type) + "," + str(self.vmax) + "," + str(self.mass) + "," + str(self.station)
