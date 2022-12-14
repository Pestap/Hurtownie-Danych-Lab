import random
from datetime import date, timedelta, datetime
from objects.driver import *
from objects.course import  *
from objects.station import *
from objects.locomotive import *
from objects.courseCarriage import *
from objects.carriage import *

NUMBER_OF_LOCOMOTIVES = 20

# do uzupełnienia współrzędne
# dopisac liczbe ludnosci - wplyw na liczbe pasazerow i wagonow
cities = [
    ("Gdynia", 54.521299, 18.529363), #0
    ("Gdańsk", 54.355576, 18.643762), #1
    ("Warszawa", 52.228842, 21.004143), #2
    ("Kraków", 50.068133, 19.947853), #3
    ("Poznań", 52.402947, 16.912091), #4
    ("Szczecin", 53.418070, 14.548652), #5
    ("Białystok", 53.133272, 23.135023), #6
    ("Olsztyn", 53.785647, 20.496411), #7
    ("Rzeszów", 50.043042, 22.006011), #8
    ("Łódź", 51.769580, 19.464495), #9
    ("Katowice", 50.257079, 19.017134), #10
    ("Bydgoszcz", 53.135806, 17.933008), #11
    ("Toruń", 53.026402, 18.633792), #12
    ("Lublin", 51.228749, 22.564697), #13
    ("Zakopane", 49.300791, 19.962889), #14
    ("Jelenia Góra", 50.902293, 15.757610), #15
    ("Wrocław", 51.098405, 17.035916), #16
    ("Kielce", 50.873494, 20.617694), #17
    ("Częstochowa", 50.808467, 19.120782), #18
]
locomotive_models = [
    #model #produced_from #produced_to #power [kW] #type #vmax[km/h] #waga [t]
    ("EU07", 1964, 1974, 2000, "elektryczna", 125, 80),
    ("EP09", 1986, 1997, 2920, "elektryczna", 160, 83.5),
    ("EU07A", 2010, 2022, 3200, "elektryczna", 160, 80),
    ("ET25", 2009, 2022, 5000, "elektryczna", 120, 120),
    ("111Eb", 2012, 2022, 5600, "elektryczna", 160, 84),
    ("EU44", 2005, 2022, 6400, "elektryczna", 230, 86),
    ("SM42", 1963, 1993, 588, "spalinowa", 90, 70),
    ("ST44", 1965, 1988, 1472, "spanlinowa", 100, 116.5),
    ("ST40", 2007, 2022, 2133, "spalinowa", 100, 118)
]
carriage_models = [
    #model #produced_from #to #passanger #vmax[km/h] #waga [t]
    ("136A", 1991, 1994, 66, 160, 38),
    ("141A", 1990, 2022, 60, 160, 40),
    ("159A", 2009, 2022, 72, 200, 50),
    ("170A", 2015, 2022, 66, 160, 52),
    ("174A", 2018, 2022, 60, 160, 51),
    ("Twindexx", 2008, 2022, 136, 160, 50),
    ("416B", 2014, 2015, 130, 160, 57),
    ("B91", 1991, 1992, 66, 160, 38),
    ("Z1B", 1996, 1997, 66, 200, 49)
]
names = [ ("Adam", "male"), ("Piotr", "male"), ("Marek", "male"), ("Grzegorz", "male"), ("Anna", "female"), ("Jan", "male"), ("Filip", "male"), ("Szymon", "male"),
          ("Stanisław", "male"), ("Wojciech", "male"), ("Mikołaj", "male"), ("Wiktor", "male"), ("Joanna", "female"), ("Elżbieta", "female"), ("Henryk", "male"),
          ("Andrzej", "male"), ("Jarosław", "male")
]
surnames = ["Nowak", "Wójcik", "Kowalczyk", "Pesta", "Woźniak", "Mazur",
            "Krawczyk", "Zając", "Wróbel", "Stępień", "Sikora", "Małysz", "Stoch", "Baran",
            "Duda", "Bąk", "Wilk"]

failures_lokomotywa = [
    "Awaria silnika",
    "Awaria komputera",
    "Awaria hamulca",
    "Awaria elektroniki"
]

failures2_wagon = [
    "Awaria elektroniki",
    "Awaria podwozia",
    "Awaria drzwi",
    "Awaria klimatyzacji"
]


connections = [
    (0, 1), (0, 2), (0, 4), (0, 5), (0, 9), (0, 11), (0, 12), (0, 14), (0, 15), (0, 16),
    (1, 2), (1, 3), (1, 6), (1, 7), (1, 11), (1, 12),
    (2, 3), (2, 4), (2, 5), (2, 6), (2, 8), (2, 9), (2, 10), (2, 13), (2, 15), (2, 17),
    (3, 5), (3, 7), (3, 8), (3, 9), (3, 12), (3, 14), (3, 16), (3, 17), (3, 18),
    (4, 5), (4, 7), (4, 8), (4, 9), (4, 10), (4, 11), (4, 16), (4, 18),
    (5, 8), (5, 9), (5, 10), (5, 16), (5, 17), (5, 18),
    (6, 7), (6, 8), (6, 12), (6, 13), (6,17),
    (7, 11), (7, 12), (7, 13),
    (8, 9), (8, 10), (8, 13), (8, 16), (8, 17), (8, 18),
    (9, 10), (9, 11), (9, 14), (9, 15), (9, 16), (9, 17), (9,18),
    (10, 11), (10, 13), (10, 14), (10, 16), (10, 17), (10, 18),
    (11, 12), (11, 16), (11, 16),
    (12, 13), (12, 17), (12, 18),
    (13, 16), (13, 17),
    (14, 16),
    (15, 16),
    (16, 18),
    (17, 18)
]

#GENERATE CONNECTIONS ARRAY

def connections_array():

    connections_array = []
    for i in range(19):
        connections_array.append([0] * 19)

    # konwersja do dwuwmariaowej tablicy
    for tuple in connections:
        connections_array[tuple[0]][tuple[1]] = 1
        connections_array[tuple[1]][tuple[0]] = 1

    return connections_array

#GENERATE Stations
def generate_stations():
    stations = []

    for city in cities:
        new_station = Station(city[0], city[1], city[2], 4, 100)
        stations.append(new_station)
    return stations

#GENERATE LOCOMOTIVES
def generate_locomotives(stations):
    locomotives = []
    loc_index = 0
    for i in range(NUMBER_OF_LOCOMOTIVES):
        locomotive_model = random.choice(locomotive_models)
        production_date = random.randint(locomotive_model[1], locomotive_model[2])

        station = random.choice(stations)
        locomotive = Locomotive("L" + str(loc_index), locomotive_model[0],
                                production_date, locomotive_model[3],
                                locomotive_model[4], locomotive_model[5], locomotive_model[6], station)
        locomotives.append(locomotive)
        station.locomotives.append(locomotive)

        loc_index += 1

    return locomotives

#GENERETE CARRIAGES
def generate_carriages(stations):

    carriages = []
    carriage_index = 0
    for i in range(NUMBER_OF_LOCOMOTIVES * 20):
        carriage_model = random.choice(carriage_models)
        production_date = random.randint(carriage_model[1], carriage_model[2])
        station = random.choice(stations)
        carriage = Carriage("W" + str(carriage_index), carriage_model[0], production_date, carriage_model[3],
                            carriage_model[4], carriage_model[5], station)
        carriages.append(carriage)
        station.carriages.append(carriage)
        carriage_index += 1

    return carriages

#GENERATE DRIVERS

def generate_drivers(stations):

    drivers = []
    driver_id = 0
    lowest_date = date(1957, 11, 1)
    end_date = date(2000, 11, 1)
    dates_dif = end_date - lowest_date
    total_days = dates_dif.days
    for i in range(NUMBER_OF_LOCOMOTIVES * 2):
        name_sex = random.choice(names)
        surname = random.choice(surnames)
        name = name_sex[0]
        sex = name_sex[1]
        dateOfBirth = lowest_date + timedelta(days=random.randint(0, total_days))
        driver = Driver(driver_id, name, surname, dateOfBirth, sex)
        drivers.append(driver)
        random.choice(stations).drivers.append(driver)
        driver_id += 1

    return drivers

