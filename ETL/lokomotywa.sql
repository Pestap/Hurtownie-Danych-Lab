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
	ID_stacji as ID_stacji_bazowej,
	NULL as ID_daty_wprowadzenia,
	NULL as ID_daty_dezaktywacji,
	'True' as aktywny
FROM TRAINMASTER.dbo.LOKOMOTYWA JOIN PRZEWOZY_POZAREGIONALNE_DW.dbo.STACJA ON  stacja_bazowa_nazwa = nazwa;
GO

/*INSERT INTO LOKOMOTYWA
SELECT * FROM lokomotywa_etl_view
GO*/
/*SELECT * FROM lokomotywa_etl_view */



MERGE INTO PRZEWOZY_POZAREGIONALNE_DW.dbo.LOKOMOTYWA as L USING lokomotywa_etl_view as LV
ON L.nr_rejestracyjny = LV.nr_rejestracyjny
WHEN NOT MATCHED THEN 
	INSERT VALUES(nr_rejestracyjny, model, wiek_kategoria, moc_kategoria, typ, predkosc_max_kategoria,
	waga_kategoria, ID_stacji_bazowej, ID_daty_wprowadzenia, ID_daty_dezaktywacji, aktywny)
WHEN MATCHED AND L.aktywny = 'True'
AND (L.model <> LV.model OR
	L.wiek_kategoria <> LV.wiek_kategoria OR
	L.moc_kategoria <> LV.moc_kategoria OR
	L.typ <> LV.typ OR
	L.predkosc_max_kategoria <> LV.predkosc_max_kategoria OR
	L.waga_kategoria <> LV.waga_kategoria OR
	L.ID_stacji_bazowej <> LV.ID_stacji_bazowej)
THEN 
	UPDATE SET L.aktywny = 'False'
;

SELECT * FROM LOKOMOTYWA

/*DROP VIEW lokomotywa_etl_view*/