from carriage import Carriage
from course import Course
from driver import Driver
from locomotive import Locomotive
from station import Station
import random
from datetime import date, timedelta

def generate_courses_from_given_state(stations, drivers, connections, start_time, number_of_courses):
    for i in range(number_of_courses):
        # select station
        start_station = random.choice(stations)
        if len(start_station.locomotives) != 0 and len(start_station.carriages) != 0:

