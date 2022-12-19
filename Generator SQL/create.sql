USE TRAINMASTER

CREATE TABLE STACJA (
	nazwa varchar(50) PRIMARY KEY,
	liczba_peronow integer,
	pojemnosc integer
);

CREATE TABLE MASZYNISTA (
	id integer PRIMARY KEY,
	imie varchar(20),
	nazwisko varchar(30),
	data_urodzenia datetime,
	plec varchar(10)
);

CREATE TABLE WAGON (
	nr_rejestracyjny varchar(10) PRIMARY KEY,
	model varchar(20),
	data_produkcji date,
	max_liczba_pasazerow integer,
	predkosc_maksymalna integer,
	waga float,
	stacja_bazowa varchar(50) FOREIGN KEY REFERENCES STACJA
);

ALTER TABLE WAGON ALTER COLUMN data_produkcji datetime;
ALTER TABLE WAGON ALTER COLUMN waga float;

CREATE TABLE LOKOMOTYWA(
	nr_rejestracyjny varchar(10) PRIMARY KEY,
	model varchar(20),
	data_produkcji date,
	moc integer,
	typ varchar(30),
	predkosc_maksymalna integer,
	waga float,
	stacja_bazowa_nazwa varchar(50) FOREIGN KEY REFERENCES STACJA
);

ALTER TABLE LOKOMOTYWA ALTER COLUMN data_produkcji datetime;
ALTER TABLE LOKOMOTYWA ALTER COLUMN waga float;

CREATE TABLE KURS(
	id integer PRIMARY KEY,
	nazwa_pociagu varchar(50),
	data_rozpoczecia datetime,
	data_zakonczenia datetime,
	dlugosc float,
	czas_trwania float,
	liczba_pasazerow integer,
	lokomotywa_nr_rejestracyjny varchar(10) FOREIGN KEY REFERENCES LOKOMOTYWA,
	stacja_poczatkowa_nazwa varchar(50) FOREIGN KEY REFERENCES STACJA,
	stacja_koncowa_nazwa varchar(50) FOREIGN KEY REFERENCES STACJA,
	maszynista_id integer FOREIGN KEY REFERENCES MASZYNISTA
);

CREATE TABLE KURS_WAGON(
	wagon_nr_rejestracyjny varchar(10) FOREIGN KEY REFERENCES WAGON,
	kurs_id integer FOREIGN KEY REFERENCES KURS
	CONSTRAINT PK_KURS_WAGON PRIMARY KEY (wagon_nr_rejestracyjny, kurs_id)
);

