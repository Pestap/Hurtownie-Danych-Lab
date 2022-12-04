USE PRZEWOZY_POZAREGIONALNE_DW
GO

IF (OBJECT_ID('kurs_etl_view') is not null) DROP View kurs_etl_view;
GO



CREATE VIEW kurs_etl_view
AS
SELECT DISTINCT
	id as ID,
	dlugosc as dlugosc,
	czas_trwania as czas_trwania,
	liczba_pasazerow as liczba_pasazerow,
	(SELECT SUM(W.max_liczba_pasazerow)
	FROM TRAINMASTER.dbo.WAGON as W
	JOIN TRAINMASTER.dbo.KURS_WAGON as KW ON KW.wagon_nr_rejestracyjny = W.nr_rejestracyjny
	WHERE KW.kurs_id = id)
	as max_liczba_pasazerow,

	(SELECT MIN(vmax)
	FROM(	SELECT L.predkosc_maksymalna as vmax
			FROM  TRAINMASTER.dbo.KURS as K JOIN  TRAINMASTER.dbo.LOKOMOTYWA AS L ON K.lokomotywa_nr_rejestracyjny = L.nr_rejestracyjny
			WHERE K.id = TRAINMASTER.dbo.KURS.id
			UNION
			SELECT MIN(W.predkosc_maksymalna) as vmax
			FROM TRAINMASTER.dbo.WAGON as W
			JOIN TRAINMASTER.dbo.KURS_WAGON as KW ON KW.wagon_nr_rejestracyjny = W.nr_rejestracyjny
			WHERE KW.kurs_id = TRAINMASTER.dbo.KURS.id
		) as vmax_table
	) as predkosc_max, 

	ROUND(dlugosc/czas_trwania, 2) as predkosc_avg,
	LOKOMOTYWA.ID_lokomotywy as ID_lokomotywy,
	STACJA_POCZATKOWA.ID_stacji as ID_stacji_pocz¹tkowej,
	STACJA_KONCOWA.ID_stacji as ID_stacji_koncowej,
	ID_maszynista as ID_maszynisty,
	CZAS_ROZPOCZECIA.ID_czasu as ID_czasu_rozpoczecia,
	DATA_ROZPOCZECIA.ID_daty as ID_daty_rozpoczecia,
	CZAS_ZAKONCZENIA.ID_czasu as ID_czasu_zakonczenia,
	DATA_ZAKOCZENIA.ID_daty as ID_daty_zakonczenia,
	JUNK.ID_junk as ID_junk
FROM TRAINMASTER.dbo.KURS
JOIN PRZEWOZY_POZAREGIONALNE_DW.dbo.LOKOMOTYWA as LOKOMOTYWA ON lokomotywa_nr_rejestracyjny = nr_rejestracyjny
JOIN PRZEWOZY_POZAREGIONALNE_DW.dbo.STACJA as STACJA_POCZATKOWA on stacja_poczatkowa_nazwa = STACJA_POCZATKOWA.nazwa
JOIN PRZEWOZY_POZAREGIONALNE_DW.dbo.STACJA as STACJA_KONCOWA on stacja_koncowa_nazwa = STACJA_KONCOWA.nazwa 
JOIN PRZEWOZY_POZAREGIONALNE_DW.dbo.MASZYNISTA ON maszynista_id = ID_firmowe_maszynisty

JOIN PRZEWOZY_POZAREGIONALNE_DW.dbo.CZAS as CZAS_ROZPOCZECIA ON 
	DATEPART(HOUR, data_rozpoczecia) = CZAS_ROZPOCZECIA.godzina
	AND DATEPART(MINUTE, data_rozpoczecia) = CZAS_ROZPOCZECIA.minuta
	AND DATEPART(SECOND, data_rozpoczecia) = CZAS_ROZPOCZECIA.sekunda

JOIN PRZEWOZY_POZAREGIONALNE_DW.dbo.DATA as DATA_ROZPOCZECIA ON
	DATEPART(YEAR, data_rozpoczecia) = DATA_ROZPOCZECIA.rok
	AND DATEPART(MONTH, data_rozpoczecia) = DATA_ROZPOCZECIA.miesiac
	AND DATEPART(DAY, data_rozpoczecia) = DATA_ROZPOCZECIA.dzien

JOIN PRZEWOZY_POZAREGIONALNE_DW.dbo.CZAS as CZAS_ZAKONCZENIA ON 
	DATEPART(HOUR, data_zakonczenia) = CZAS_ZAKONCZENIA.godzina
	AND DATEPART(MINUTE, data_zakonczenia) = CZAS_ZAKONCZENIA.minuta
	AND DATEPART(SECOND, data_zakonczenia) = CZAS_ZAKONCZENIA.sekunda

JOIN PRZEWOZY_POZAREGIONALNE_DW.dbo.DATA as DATA_ZAKOCZENIA ON
	DATEPART(YEAR, data_zakonczenia) = DATA_ZAKOCZENIA.rok
	AND DATEPART(MONTH, data_zakonczenia) = DATA_ZAKOCZENIA.miesiac
	AND DATEPART(DAY, data_zakonczenia) = DATA_ZAKOCZENIA.dzien

JOIN PRZEWOZY_POZAREGIONALNE_DW.dbo.JUNK as JUNK ON TRAINMASTER.dbo.KURS.nazwa_pociagu = JUNK.nazwa_pociagu
GO




INSERT INTO KURS
SELECT dlugosc, czas_trwania, liczba_pasazerow, max_liczba_pasazerow, predkosc_max, predkosc_avg, ID_lokomotywy, ID_stacji_pocz¹tkowej,
		ID_stacji_koncowej, ID_maszynisty, ID_czasu_rozpoczecia, ID_daty_rozpoczecia, ID_czasu_zakonczenia, ID_daty_zakonczenia, ID_junk
FROM kurs_etl_view
GO


DROP VIEW kurs_etl_view

/*DELETE FROM KURS*/