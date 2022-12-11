USE PRZEWOZY_POZAREGIONALNE_DW
GO

IF (OBJECT_ID('awaria_lokomotywy_etl_view') is not null) DROP View awaria_lokomotywy_etl_view;
GO

CREATE VIEW awaria_lokomotywy_etl_view
AS
SELECT DISTINCT
	LOKOMOTYWA.ID_lokomotywy as ID_lokomotywy,
	DATA_AWARII.ID_daty as ID_daty_zgloszenia,
	MASZYNISTA.ID_maszynista as ID_zglaszajacego_maszynisty,
	AWARIE_LOKOMOTYW_AUX.koszt as koszt_naprawy,
	JUNK_AWARII.ID_junk_awarii as ID_junk_awarii
FROM PRZEWOZY_POZAREGIONALNE_DW.dbo.AWARIE_LOKOMOTYW_AUX 
JOIN PRZEWOZY_POZAREGIONALNE_DW.dbo.LOKOMOTYWA ON AWARIE_LOKOMOTYW_AUX.nr_rejestracyjny = LOKOMOTYWA.nr_rejestracyjny
JOIN PRZEWOZY_POZAREGIONALNE_DW.dbo.MASZYNISTA ON AWARIE_LOKOMOTYW_AUX.id_firmowe_maszynisty = MASZYNISTA.ID_firmowe_maszynisty
JOIN PRZEWOZY_POZAREGIONALNE_DW.dbo.JUNK_AWARII ON AWARIE_LOKOMOTYW_AUX.typ_awarii = JUNK_AWARII.typ_awarii 
JOIN PRZEWOZY_POZAREGIONALNE_DW.dbo.DATA as DATA_AWARII ON
	DATEPART(YEAR, AWARIE_LOKOMOTYW_AUX.data_zgloszenia) = DATA_AWARII.rok
	AND DATEPART(MONTH, AWARIE_LOKOMOTYW_AUX.data_zgloszenia) = DATA_AWARII.miesiac
	AND DATEPART(DAY,AWARIE_LOKOMOTYW_AUX.data_zgloszenia) = DATA_AWARII.dzien
WHERE LOKOMOTYWA.aktywny = 'True'
GO

SELECT * FROM awaria_lokomotywy_etl_view

MERGE INTO PRZEWOZY_POZAREGIONALNE_DW.dbo.AWARIA_LOKOMOTYWY as AL USING awaria_lokomotywy_etl_view as ALV
ON (SELECT nr_rejestracyjny FROM LOKOMOTYWA WHERE ID_lokomotywy = AL.ID_lokomotywy) = (SELECT nr_rejestracyjny FROM LOKOMOTYWA WHERE ID_lokomotywy = ALV.ID_lokomotywy)
AND AL.ID_daty_zgloszenia = ALV.ID_daty_zgloszenia
AND AL.ID_zglaszajcego_maszynisty = ALV.ID_zglaszajacego_maszynisty
AND AL.koszt_naprawy = ALV.koszt_naprawy
AND AL.ID_junk_awarii = ALV.ID_junk_awarii
WHEN NOT MATCHED THEN
	INSERT VALUES(ID_lokomotywy, ID_daty_zgloszenia,ID_zglaszajacego_maszynisty, koszt_naprawy,ID_junk_awarii)
;



DROP VIEW awaria_lokomotywy_etl_view
DROP TABLE AWARIE_LOKOMOTYW_AUX