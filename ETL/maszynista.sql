USE PRZEWOZY_POZAREGIONALNE_DW
GO

IF (OBJECT_ID('maszynista_etl_view') is not null) DROP View maszynista_etl_view;
GO


CREATE VIEW maszynista_etl_view
AS
SELECT DISTINCT 
	id as ID_firmowe_maszynisty,
	imie +' '+nazwisko as imie_nazwisko,
	CASE
		WHEN DATEDIFF(year, data_urodzenia, GETDATE()) < 35 THEN 'm³ody'
		WHEN DATEDIFF(year, data_urodzenia, GETDATE()) < 55 THEN 'œredni'
		ELSE 'stary'
	END AS wiek_kategoria,
	plec as plec

FROM TRAINMASTER.dbo.MASZYNISTA;
GO

INSERT INTO MASZYNISTA 
SELECT * FROM maszynista_etl_view

GO