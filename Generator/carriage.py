#-*- coding: utf-8 -*-

class Carriage:
    def __init__(self, id, model, prod_date, capacity, vmax, mass, station):
        self.id = id
        self.model = model
        self.prod_date = prod_date
        self.capacity = capacity
        self.vmax = vmax
        self.mass = mass
        self.station = station
    
    def toBulk(self):
        return str(self.id) + "," + str(self.model) + "," + str(self.prod_date) + "," + str(self.capacity) + "," + str(self.vmax) + "," + str(self.mass) + "," + str(self.station.name)
