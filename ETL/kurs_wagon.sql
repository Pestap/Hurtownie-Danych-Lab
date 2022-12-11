USE PRZEWOZY_POZAREGIONALNE_DW
GO

IF (OBJECT_ID('kurs_wagon_etl_view') is not null) DROP View kurs_wagon_etl_view;
GO

CREATE VIEW kurs_wagon_etl_view
AS
SELECT DISTINCT 
	W.ID_wagon as ID_wagonu,
	KURS_DW.ID_kurs as ID_kursu
FROM TRAINMASTER.dbo.KURS_WAGON as KW
JOIN PRZEWOZY_POZAREGIONALNE_DW.dbo.WAGON as W ON KW.wagon_nr_rejestracyjny = W.nr_rejestracyjny
JOIN TRAINMASTER.dbo.KURS as K_T ON kurs_id = K_T.id
JOIN PRZEWOZY_POZAREGIONALNE_DW.dbo.LOKOMOTYWA as L_DW ON K_T.lokomotywa_nr_rejestracyjny = L_DW.nr_rejestracyjny
JOIN PRZEWOZY_POZAREGIONALNE_DW.dbo.MASZYNISTA as M_DW ON K_T.maszynista_id = M_DW.ID_firmowe_maszynisty
JOIN PRZEWOZY_POZAREGIONALNE_DW.dbo.DATA as D_DW ON
	DATEPART(YEAR, K_T.data_rozpoczecia) = D_DW.rok
	AND DATEPART(MONTH, K_T.data_rozpoczecia) = D_DW.miesiac
	AND DATEPART(DAY, K_T.data_rozpoczecia) = D_DW.dzien
JOIN PRZEWOZY_POZAREGIONALNE_DW.dbo.CZAS as T_DW ON
	DATEPART(HOUR, K_T.data_rozpoczecia) = T_DW.godzina
	AND DATEPART(MINUTE, K_T.data_rozpoczecia) = T_DW.minuta
	AND DATEPART(SECOND, K_T.data_rozpoczecia) = T_DW.sekunda
JOIN PRZEWOZY_POZAREGIONALNE_DW.dbo.KURS AS KURS_DW ON
	L_DW.ID_lokomotywy = KURS_DW.ID_lokomotywy
	AND M_DW.ID_maszynista = KURS_DW.ID_maszynisty
	AND D_DW.ID_daty = KURS_DW.ID_daty_rozpoczecia
	AND T_DW.ID_czasu = KURS_DW.ID_czasu_rozpoczecia
GO

MERGE INTO PRZEWOZY_POZAREGIONALNE_DW.dbo.KURS_WAGON as KW USING kurs_wagon_etl_view as KWV
ON KW.ID_wagonu = KWV.ID_wagonu
AND KW.ID_kursu = KWV.ID_kursu
WHEN NOT MATCHED THEN 
	INSERT VALUES(ID_wagonu, ID_kursu)
;

DROP VIEW kurs_wagon_etl_view