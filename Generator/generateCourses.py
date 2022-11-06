from carriage import Carriage
from course import Course
from driver import Driver
from locomotive import Locomotive
from station import Station
from courseCarriage import CourseCarriage
import random
import geopy.distance
from datetime import date, timedelta, datetime
from generateFailures import generateFailureCarriage
from generateFailures import  generateFailureLocomotive

def generate_courses_from_given_state(stations, connections, start_date, number_of_courses, start_id =0):
    courses = []
    course_carriage = []
    loc_failures = []
    car_failures =[]
    course_id = start_id
    start_time = start_date
    for i in range(number_of_courses // len(stations)):
        # select station

        longest_time = timedelta() # 0 seconds
        valid_stations = []
        for station in stations:
            if len(station.locomotives) != 0 and len(station.carriages) != 0 and len(station.drivers) != 0:
                valid_stations.append(station)

        for idx, start_station in enumerate(valid_stations):
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
                car = start_station.carriages.pop()
                course_carriage.append(CourseCarriage(car.id, course_id))
                carriages.append(car)


            #select driver
            driver = start_station.drivers.pop()

            #select end station



            possible_destinations = []

            for i, e in enumerate(connections[idx]):
                if e == 1:
                    possible_destinations.append(i)


            destination = stations[random.choice(possible_destinations)]

            #calculate distance

            distance = geopy.distance.geodesic((start_station.x_position, start_station.y_position), (destination.x_position, destination.y_position)).km

            #time
            # find slowest part

            speed = locomotive.vmax
            for car in carriages:
                if car.vmax < speed:
                    speed = car.vmax

            time_in_hours = distance/speed + random.random()*0.25*distance/speed

            # compare if the longest
            time_datetime = timedelta(hours=time_in_hours)

            if time_datetime.seconds > longest_time.seconds:
                longest_time = time_datetime

            #start and end time
            start = start_time
            end = start + time_datetime

            #issues
            if random.random() <= 0.05:
                #locomotive failure
                loc_failures.append(generateFailureLocomotive(locomotive.id, driver.id, end))
            for car in carriages:
                if random.random() <= 0.02:
                    car_failures.append(generateFailureCarriage(car.id, driver.id, end))

            #number_of_passangers

            total_capacity = 0

            for car in carriages:
                total_capacity+= car.capacity

            number_of_passangers = random.randint(1,total_capacity)


            course = Course(course_id, start_station.name +"-"+destination.name, start, end, distance,
                            time_in_hours, number_of_passangers, locomotive, start_station, destination,driver, carriages)
            courses.append(course)

            # move train and driver

            destination.locomotives.append(locomotive)
            destination.drivers.append(driver)
            for car in carriages:
                destination.carriages.append(car)

            course_id += 1
        else:
            print("DUPA")

        start_time += longest_time

    return courses, course_carriage, loc_failures, car_failures

