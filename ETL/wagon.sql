USE PRZEWOZY_POZAREGIONALNE_DW
GO

IF (OBJECT_ID('wagon_etl_view') is not null) DROP View wagon_etl_view;
GO


CREATE VIEW wagon_etl_view
AS
SELECT DISTINCT 
	nr_rejestracyjny as nr_rejestracyjny,
	model as model,
	CASE
		WHEN DATEDIFF(year, data_produkcji, GETDATE()) < 10 THEN 'nowy'
		WHEN DATEDIFF(year, data_produkcji, GETDATE()) < 25 THEN 'œredni'
		ELSE 'stary'
	END AS wiek_kategoria,
	CASE
		WHEN predkosc_maksymalna < 65 THEN 'niska'
		WHEN predkosc_maksymalna < 100 THEN 'œrednia'
		ELSE 'wysoka'
	END AS max_liczba_pasazerow_kategoria,
	CASE
		WHEN predkosc_maksymalna < 140 THEN 'niska'
		WHEN predkosc_maksymalna < 180 THEN 'œrednia'
		ELSE 'wysoka'
	END AS predkosc_max_kategoria,
	CASE 
		WHEN waga < 40 THEN 'niska'
		WHEN waga < 50 THEN 'œrednia'
		ELSE 'wysoka'
	END AS waga_kategoria,
	ID_stacji as ID_stacji_bazowej
FROM TRAINMASTER.dbo.WAGON JOIN PRZEWOZY_POZAREGIONALNE_DW.dbo.STACJA ON  stacja_bazowa = nazwa;
GO

INSERT INTO WAGON
SELECT * FROM wagon_etl_view
GO
SELECT * FROM wagon_etl_view 

DROP VIEW wagon_etl_view