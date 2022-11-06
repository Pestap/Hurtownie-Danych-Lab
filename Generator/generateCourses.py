from carriage import Carriage
from course import Course
from driver import Driver
from locomotive import Locomotive
from station import Station
import random
import geopy.distance
from datetime import date, timedelta

def generate_courses_from_given_state(stations, drivers, connections, start_date, number_of_courses, start_id =0):
    courses = []
    course_id = start_id
    for i in range(number_of_courses // len(stations)):
        # select station
        for idx, start_station in enumerate(stations):
            if len(start_station.locomotives) != 0 and len(start_station.carriages) != 0 and len(start_station.drivers) != 0:
                #select locomotive
                locomotive = start_station.locomotives.pop()
                #select carriages
                upper_bound = 5
                if len(start_station.carriages) < upper_bound:
                    upper_bound = len(start_station.carriages) // 2
                if upper_bound == 0 :
                    break
                number_of_carriages = random.randint(1, upper_bound)

                carriages = []

                for j in range(upper_bound):
                    carriages.append(start_station.carriages.pop())

                #select driver
                driver = start_station.drivers.pop()

                #select end station

                possible_destinations = connections[idx]
                destination = random.choice(possible_destinations)

                #calculate distance

                distance = geopy.distance.geodesic((start_station.x_position, start_station.y_position), (destination.x_position, destination.y_position)).km

                #time
                # find slowest part

                speed = locomotive.vmax
                for car in carriages:
                    if car.vmax < speed:
                        speed = car.vmax

                time_in_hours =



                course = Course(course_id, )
            else:
                i -= 1

            #advance time after

