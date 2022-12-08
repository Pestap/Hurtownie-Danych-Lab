IF (OBJECT_ID('awaria_lokomotywy_etl_view') is not null) DROP View awaria_lokomotywy_etl_view;
GO

CREATE VIEW awaria_lokomotywy_etl_view
AS
SELECT DISTINCT
	LOKOMOTYWA.ID_lokomotywy as ID_lokomotywy,
	DATA_AWARII.ID_daty as ID_daty_zgloszenia,
	MASZYNISTA.ID_maszynista as ID_zglaszajacego_maszynisty,
	AWARIE_L_AUX.koszt as koszt_naprawy,
	JUNK_AWARII.ID_junk_awarii as ID_junk_awarii
FROM PRZEWOZY_POZAREGIONALNE_DW.dbo.AWARIE_L_AUX 
JOIN PRZEWOZY_POZAREGIONALNE_DW.dbo.LOKOMOTYWA ON AWARIE_L_AUX.nr_rejestracyjny = LOKOMOTYWA.nr_rejestracyjny
JOIN PRZEWOZY_POZAREGIONALNE_DW.dbo.MASZYNISTA ON AWARIE_L_AUX.id_firmowe_maszynisty = MASZYNISTA.ID_firmowe_maszynisty
JOIN PRZEWOZY_POZAREGIONALNE_DW.dbo.JUNK_AWARII ON AWARIE_L_AUX.typ_awarii = JUNK_AWARII.typ_awarii 
JOIN PRZEWOZY_POZAREGIONALNE_DW.dbo.DATA as DATA_AWARII ON
	DATEPART(YEAR, AWARIE_L_AUX.data_zgloszenia) = DATA_AWARII.rok
	AND DATEPART(MONTH, AWARIE_L_AUX.data_zgloszenia) = DATA_AWARII.miesiac
	AND DATEPART(DAY,AWARIE_L_AUX.data_zgloszenia) = DATA_AWARII.dzien;
GO

INSERT INTO AWARIA_LOKOMOTYWY
SELECT * FROM awaria_lokomotywy_etl_view
GO

DROP VIEW awaria_lokomotywy_etl_view
DROP TABLE AWARIE_L_AUX