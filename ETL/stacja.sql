USE PRZEWOZY_POZAREGIONALNE_DW
GO

IF (OBJECT_ID('stacja_etl_view') is not null) DROP View stacja_etl_view;
GO

CREATE VIEW stacja_etl_view
AS
SELECT DISTINCT 
	nazwa as nazwa,
	CASE
		WHEN liczba_peronow <= 2  THEN 'ma³a'
		WHEN liczba_peronow <= 4 THEN 'œrednia'
		ELSE 'du¿a'
	END AS liczba_peronow_kategoria,
	CASE
		WHEN pojemnosc <= 2  THEN 'ma³a'
		WHEN pojemnosc <= 4 THEN 'œrednia'
		ELSE 'du¿a'
	END AS pojemnosc_kategoria
FROM TRAINMASTER.dbo.STACJA;
GO

INSERT INTO STACJA
SELECT * FROM stacja_etl_view
GO


SELECT * FROM STACJA
DROP VIEW stacja_etl_view