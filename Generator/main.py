#-*- coding: utf-8 -*-

from objects.carriage import Carriage
from objects.driver import Driver
from objects.locomotive import Locomotive
from objects.station import Station
import random
from datetime import date, timedelta, datetime
from generateCourses import generate_courses_from_given_state
from xlwt import Workbook

from static_data import *


# do uzupełnienia współrzędne
# dopisac liczbe ludnosci - wplyw na liczbe pasazerow i wagonow

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

# OPIS LOSOWANIA
# 1. Tworzymy lokomotywy i maszynistów (maszynisci = 1.5 lokomotywy, wagonow 10* lokomotywy i rozmieszczamy proporcjonalnie)
# 2. kazdej lokomotywe umieszczamy w stacji bazowej (tworzymy zbiory lokomotyw i wagonow na stacjach)
# 3. patrzymy na kursy dostepne z stacji bazowej i wybieramy jeden oraz wybieramy lokomotywe i wagony (ilosc losowo (1-7))
# 4. realizujemy kurs z maksymalna dozowloną predkością ( + 0-25 % czasu losowo) zabierajac lokomotywe i wagony ze stacji
# i dodajac je do innej (to samo robimy z maszynistami)
# 5. z prawodopodbienstwem wynoszącym dlugosc kursu/100  % losujemy awarie (w przypadku lokomotyw * 3)
# 6. powtarzamy kolejno dla lokomotyw az do uzyskania odpowiedniej ilosci
#
# pociagi jezdza falowo
# wszystkie jadą - dojezdzają do celu, znowu jadą
# stacje maja 3 zbiory: maszynistow, wagonow i lokomotyw - na poczatku losujemy maszyniste, lokomotywe i wagony
# globalny czas: od startu inkremetnowany o najdluzszy przejazd + 15 minut
# powtarzamy do momentu kiedy uzysakmy zadaną liczbę kursów (np. 500 000)
# id kursow inkrementowane za kazdym razem


stations = generate_stations()
locomotives = generate_locomotives(stations)
carriages = generate_carriages(stations)
connections_array = connections_array()
drivers = generate_drivers(stations)
start_date = datetime.now()

bulk_file = open("bulks/driver.bulk", "w")
for driv in drivers:
    bulk_file.write(driv.toBulk() + "\n")
    #print(driv.toBulk())
bulk_file.close()

bulk_file = open("bulks/locomotive.bulk", "w")
for loc in locomotives:
    bulk_file.write(loc.toBulk() + "\n")
    #print(loc.toBulk())
bulk_file.close()

bulk_file = open("bulks/carriage.bulk", "w")
for carr in carriages:
    bulk_file.write(carr.toBulk() + "\n")
    #print(carr.toBulk())
bulk_file.close()

bulk_file = open("bulks/station.bulk", "w")
for st in stations:
    bulk_file.write(st.toBulk() + "\n")
    #print(st.toBulk())
bulk_file.close()

#T1
courses, c_cars, loc_fails, car_fails, end_time = generate_courses_from_given_state(stations, connections_array, start_date, 50)

#BULKI

bulk_file = open("bulks/courseCarriage.bulk", "w")
for c_car in c_cars:
    bulk_file.write(c_car.toBulk() + "\n")
    #print(c_car.toBulk())
bulk_file.close()

bulk_file = open("bulks/course.bulk", "w")
for cours in courses:
    bulk_file.write(cours.toBulk() + "\n")
    #print(cours.toBulk())
bulk_file.close()



# Generacja arkusza

wb_t1 = Workbook()
wb_t2 = Workbook()

sheet1_t1 = wb_t1.add_sheet('Lokomotywy')
sheet1_t1.write(0, 0, "Nr rej. lokomotywy")
sheet1_t1.write(0, 1, "Id maszynisty")
sheet1_t1.write(0, 2, "Data zgloszenia")
sheet1_t1.write(0, 3, "Typ awarii")
sheet1_t1.write(0, 4, "Koszt naprawy")

sheet1_t2 = wb_t2.add_sheet('Lokomotywy')
sheet1_t2.write(0, 0, "Nr rej. lokomotywy")
sheet1_t2.write(0, 1, "Id maszynisty")
sheet1_t2.write(0, 2, "Data zgloszenia")
sheet1_t2.write(0, 3, "Typ awarii")
sheet1_t2.write(0, 4, "Koszt naprawy")

index_loc = 1
for loc_fail in loc_fails:
    #print(loc_fail)
    loc_fail_data = loc_fail.split(";")
    sheet1_t1.write(index_loc, 0, loc_fail_data[0])
    sheet1_t1.write(index_loc, 1, loc_fail_data[1])
    sheet1_t1.write(index_loc, 2, loc_fail_data[2])
    sheet1_t1.write(index_loc, 3, loc_fail_data[3])
    sheet1_t1.write(index_loc, 4, loc_fail_data[4])

    sheet1_t2.write(index_loc, 0, loc_fail_data[0])
    sheet1_t2.write(index_loc, 1, loc_fail_data[1])
    sheet1_t2.write(index_loc, 2, loc_fail_data[2])
    sheet1_t2.write(index_loc, 3, loc_fail_data[3])
    sheet1_t2.write(index_loc, 4, loc_fail_data[4])

    index_loc += 1

sheet2_t1 = wb_t1.add_sheet('Wagony')
sheet2_t1.write(0, 0, "Nr rej. wagonu")
sheet2_t1.write(0, 1, "Id maszynisty")
sheet2_t1.write(0, 2, "Data zgloszenia")
sheet2_t1.write(0, 3, "Typ awarii")
sheet2_t1.write(0, 4, "Koszt naprawy")

sheet2_t2 = wb_t2.add_sheet('Wagony')
sheet2_t2.write(0, 0, "Nr rej. wagonu")
sheet2_t2.write(0, 1, "Id maszynisty")
sheet2_t2.write(0, 2, "Data zgloszenia")
sheet2_t2.write(0, 3, "Typ awarii")
sheet2_t2.write(0, 4, "Koszt naprawy")

index_car = 1
for car_fail in car_fails:
    #print(car_fail)
    car_fail_data = car_fail.split(";")
    sheet2_t1.write(index_car, 0, car_fail_data[0])
    sheet2_t1.write(index_car, 1, car_fail_data[1])
    sheet2_t1.write(index_car, 2, car_fail_data[2])
    sheet2_t1.write(index_car, 3, car_fail_data[3])
    sheet2_t1.write(index_car, 4, car_fail_data[4])

    sheet2_t2.write(index_car, 0, car_fail_data[0])
    sheet2_t2.write(index_car, 1, car_fail_data[1])
    sheet2_t2.write(index_car, 2, car_fail_data[2])
    sheet2_t2.write(index_car, 3, car_fail_data[3])
    sheet2_t2.write(index_car, 4, car_fail_data[4])

    index_car += 1

wb_t1.save('excel/awarie_t1.xls')



#modyfikacje
for locomotive in locomotives:
    if locomotive.model == "EU07":
        locomotive.vmax = 140
    if locomotive.model == "EP09":
        locomotive.model = "EP09A"





courses_2, c_cars2, loc_fails2, car_fails2, end_time = generate_courses_from_given_state(stations, connections_array, end_time, 20, len(courses))

for loc_fail in loc_fails2:
    #print(loc_fail)
    loc_fail_data = loc_fail.split(";")

    sheet1_t2.write(index_loc, 0, loc_fail_data[0])
    sheet1_t2.write(index_loc, 1, loc_fail_data[1])
    sheet1_t2.write(index_loc, 2, loc_fail_data[2])
    sheet1_t2.write(index_loc, 3, loc_fail_data[3])
    sheet1_t2.write(index_loc, 4, loc_fail_data[4])

    index_loc += 1

for car_fail in car_fails2:
    #print(car_fail)
    car_fail_data = car_fail.split(";")

    sheet2_t2.write(index_car, 0, car_fail_data[0])
    sheet2_t2.write(index_car, 1, car_fail_data[1])
    sheet2_t2.write(index_car, 2, car_fail_data[2])
    sheet2_t2.write(index_car, 3, car_fail_data[3])
    sheet2_t2.write(index_car, 4, car_fail_data[4])

    index_car += 1

wb_t2.save('excel/awarie_t2.xls')

#BULKI

bulk_file = open("bulks/courseCarriage2.bulk", "w")
for c_car in c_cars2:
    bulk_file.write(c_car.toBulk() + "\n")
    #print(c_car.toBulk())
bulk_file.close()

bulk_file = open("bulks/course2.bulk", "w")
for cours in courses_2:
    bulk_file.write(cours.toBulk() + "\n")
    #print(cours.toBulk())
bulk_file.close()