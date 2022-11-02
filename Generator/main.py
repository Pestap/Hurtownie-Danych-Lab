# do uzupełnienia współrzędne

cities = {
    ("Gdynia", 54.521299, 18.529363),
    ("Gdańsk", 54.355576, 18.643762),
    ("Warszawa", 52.228842, 21.004143),
    ("Kraków", 50.068133, 19.947853),
    ("Poznań", 52.402947, 16.912091),
    ("Szczecin", 53.418070, 14.548652),
    ("Białystok", 53.133272, 23.135023),
    ("Olsztyn", 53.785647, 20.496411),
    ("Rzeszów", 50.043042, 22.006011),
    ("Łódź", 51.769580, 19.464495),
    ("Katowice", 50.257079, 19.017134),
    ("Koszalin", 51.190194, 16.167601),
    ("Bydgoszcz", 53.135806, 17.933008),
    ("Toruń", 53.026402, 18.633792),
    ("Suwałki", 53.105627, 22.945121),
    ("Lublin", 51.228749, 22.564697),
    ("Zakopane", 49.300791, 19.962889),
    ("Gliwice", 50.300811, 18.677516),
    ("Opole", 50.662250, 17.927164),
    ("Jelenia Góra", 50.902293, 15.757610),
    ("Wrocław", 51.098405, 17.035916),
    ("Zielona Góra", 51.947593, 15.511199),
    ("Tczew", 54.097959, 18.789244),
    ("Kutno", 52.227818, 19.347300),
    ("Elbląg", 54.150875, 19.417410),
    ("Słupsk", 54.467102, 17.015377),
    ("Radom", 51.390394, 21.156035),
    ("Kielce", 50.873494, 20.617694),
    ("Częstochowa", 50.808467, 19.120782),
    ("Iława", 53.581652, 19.573589),
}

locomotive_models = {
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
}

carriage_models = {
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
}
#nr rejestracyjne wagonow i lokomotyw to liczby całkowite (mogą być od 1 do N)

#maszynisci

names = { "Adam", "Piotr", "Marek", "Grzegorz", "Anna", "Jan", "Filip", "Szymon",
          "Stanisław", "Wojciech", "Mikołaj", "Wiktor", "Joanna", "Elżbieta", "Henryk",
          "Andrzej", "Jarosław"
}

surnames = {"Nowak", "Wójcik", "Kowalczyk", "Pesta", "Woźniak", "Mazur",
            "Krawczyk", "Zając", "Wróbel", "Stępień", "Sikora", "Małysz", "Stoch", "Baran",
            "Duda", "Bąk", "Wilk"}


print(len(cities))