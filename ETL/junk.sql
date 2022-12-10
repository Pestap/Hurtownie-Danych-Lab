USE PRZEWOZY_POZAREGIONALNE_DW
GO

IF (OBJECT_ID('junk_etl_view') is not null) DROP View junk_etl_view;
GO


CREATE VIEW junk_etl_view
AS
SELECT DISTINCT 
	KURS.nazwa_pociagu as nazwa_pociagu
FROM TRAINMASTER.dbo.KURS;
GO


MERGE INTO PRZEWOZY_POZAREGIONALNE_DW.dbo.JUNK as J USING junk_etl_view as JV
ON J.nazwa_pociagu = JV.nazwa_pociagu
WHEN NOT MATCHED THEN 
	INSERT VALUES(nazwa_pociagu)
;

DROP VIEW junk_etl_view