import random

failures_locomotive = [
    "Awaria silnika",
    "Awaria komputera",
    "Awaria hamulca",
    "Awaria elektroniki"
]

failures_carriage = [
    "Awaria elektroniki",
    "Awaria podwozia",
    "Awaria drzwi",
    "Awaria klimatyzacji"
]


def generateFailureCarriage(carriage_id, driver_id, failure_date):
    failure_type = ""
    price = 0
    randomizer = random.randint(1, 10)

    if randomizer >= 1 and randomizer <= 2: # Awaria elektroniki
        failure_type = failures_carriage[0]
        price = round(random.uniform(800, 3500), 2)
    elif randomizer >= 3 and randomizer <= 3: # Awaria podwozia
        failure_type = failures_carriage[1]
        price = round(random.uniform(1000, 2000), 2)
    elif randomizer >= 4 and randomizer <= 7: # Awaria drzwi
        failure_type = failures_carriage[2]
        price = round(random.uniform(200, 700), 2)
    elif randomizer >= 8 and randomizer <= 10: # Awaria klimatyzacji
        failure_type = failures_carriage[3]
        price = round(random.uniform(100, 1000), 2)

    return str(carriage_id) + ";" + str(driver_id) + ";" + str(failure_date) + ";" + str(failure_type) + ";" + str(price)


def generateFailureLocomotive(locomotive_id, driver_id, failure_date):
    failure_type = ""
    price = 0
    randomizer = random.randint(1, 10)

    if randomizer >= 1 and randomizer <= 2:  # Awaria silnika
        failure_type = failures_locomotive[0]
        price = round(random.uniform(3000, 10000),2)
    elif randomizer >= 3 and randomizer <= 5:  # Awaria komputera
        failure_type = failures_locomotive[1]
        price = round(random.uniform(400, 5000), 2)
    elif randomizer >= 6 and randomizer <= 7:  # Awaria hamulca
        failure_type = failures_locomotive[2]
        price = round(random.uniform(1000, 2000), 2)
    elif randomizer >= 8 and randomizer <= 10:  # Awaria elekroniki
        failure_type = failures_locomotive[3]
        price = round(random.uniform(1000, 4000), 2)

    return str(locomotive_id) + ";" + str(driver_id) + ";" + str(failure_date) + ";" + str(failure_type) + ";" + str(price)