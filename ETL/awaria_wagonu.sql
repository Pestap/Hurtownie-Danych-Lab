IF (OBJECT_ID('awaria_wagonu_etl_view') is not null) DROP View awaria_wagonu_etl_view;
GO

CREATE VIEW awaria_wagonu_etl_view
AS
SELECT DISTINCT
	WAGON.ID_wagon as ID_wagonu,
	DATA_AWARII.ID_daty as ID_daty_zgloszenia,
	MASZYNISTA.ID_maszynista as ID_zglaszajacego_maszynisty,
	AWARIE_WAGONOW_AUX.koszt as koszt_naprawy,
	JUNK_AWARII.ID_junk_awarii as ID_junk_awarii
FROM PRZEWOZY_POZAREGIONALNE_DW.dbo.AWARIE_WAGONOW_AUX 
JOIN PRZEWOZY_POZAREGIONALNE_DW.dbo.WAGON ON AWARIE_WAGONOW_AUX.nr_rejestracyjny = WAGON.nr_rejestracyjny
JOIN PRZEWOZY_POZAREGIONALNE_DW.dbo.MASZYNISTA ON AWARIE_WAGONOW_AUX.id_firmowe_maszynisty = MASZYNISTA.ID_firmowe_maszynisty
JOIN PRZEWOZY_POZAREGIONALNE_DW.dbo.JUNK_AWARII ON AWARIE_WAGONOW_AUX.typ_awarii = JUNK_AWARII.typ_awarii 
JOIN PRZEWOZY_POZAREGIONALNE_DW.dbo.DATA as DATA_AWARII ON
	DATEPART(YEAR, AWARIE_WAGONOW_AUX.data_zgloszenia) = DATA_AWARII.rok
	AND DATEPART(MONTH, AWARIE_WAGONOW_AUX.data_zgloszenia) = DATA_AWARII.miesiac
	AND DATEPART(DAY,AWARIE_WAGONOW_AUX.data_zgloszenia) = DATA_AWARII.dzien;
GO

INSERT INTO AWARIA_WAGONU
SELECT * FROM awaria_wagonu_etl_view
GO

DROP VIEW awaria_wagonu_etl_view
DROP TABLE AWARIE_WAGONOW_AUX