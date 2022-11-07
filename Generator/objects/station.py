#-*- coding: utf-8 -*-

class Station:
    def __init__(self, name, x_position, y_position, number_of_platforms, capacity):
        self.name = name
        self.x_position = x_position
        self.y_position = y_position
        self.number_of_platforms = number_of_platforms
        self.capacity = capacity
        self.locomotives = []
        self.carriages = []
        self.drivers = []
        
    def toBulk(self):
        return self.name + "," + str(self.number_of_platforms) + "," + str(self.capacity)