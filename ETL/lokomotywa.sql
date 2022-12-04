USE PRZEWOZY_POZAREGIONALNE_DW
GO

IF (OBJECT_ID('lokomotywa_etl_view') is not null) DROP View lokomotywa_etl_view;
GO


CREATE VIEW lokomotywa_etl_view
AS
SELECT DISTINCT 
	nr_rejestracyjny as nr_rejestracyjny,
	model as model,
	CASE
		WHEN DATEDIFF(year, data_produkcji, GETDATE()) < 10 THEN 'nowa'
		WHEN DATEDIFF(year, data_produkcji, GETDATE()) < 25 THEN 'œrednia'
		ELSE 'stara'
	END AS wiek_kategoria,
	CASE
		WHEN moc < 1500 THEN 'niska'
		WHEN moc < 4000 THEN 'œrednia'
		ELSE 'wysoka'
	END AS moc_kategoria,
	typ as typ,
	CASE
		WHEN predkosc_maksymalna < 120 THEN 'niska'
		WHEN predkosc_maksymalna < 180 THEN 'œrednia'
		ELSE 'wysoka'
	END AS predkosc_max_kategoria,
	CASE 
		WHEN waga < 80 THEN 'niska'
		WHEN waga < 100 THEN 'œrednia'
		ELSE 'wysoka'
	END AS waga_kategoria,
	ID_stacji as ID_stacji_bazowej
FROM TRAINMASTER.dbo.LOKOMOTYWA JOIN PRZEWOZY_POZAREGIONALNE_DW.dbo.STACJA ON  stacja_bazowa_nazwa = nazwa;
GO

INSERT INTO LOKOMOTYWA
SELECT * FROM lokomotywa_etl_view
GO
/*SELECT * FROM lokomotywa_etl_view */

DROP VIEW lokomotywa_etl_view