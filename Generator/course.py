#-*- coding: utf-8 -*-

class Course:
    def __init__(self, id, name, start_date, end_date, length, time, number_of_passangers, locomotive, start_station, end_station, driver, carriages):
        self.id = id
        self.name = name
        self.start_date = start_date
        self.end_date = end_date
        self.length = length
        self.time = time
        self.number_of_passangers = number_of_passangers
        self.locomotive = locomotive
        self.start_station = start_station
        self.end_station = end_station
        self.driver = driver
        self.carriages = carriages

    def toBulk(self):
        return str(self.id) + "," + str(self.name) + "," + str(self.start_date) + "," + str(self.end_date) + "," + str(self.length) + "," + str(self.time) + "," + str(self.number_of_passangers)+ "," + str(self.locomotive.id) + "," + str(self.start_station.name) + "," + str(self.end_station.name) + "," + str(self.driver.id)
