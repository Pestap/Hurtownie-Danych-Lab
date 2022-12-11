USE PRZEWOZY_POZAREGIONALNE_DW
GO

IF (OBJECT_ID('AWARIE_WAGONOW_AUX') is not null) DROP TABLE PRZEWOZY_POZAREGIONALNE_DW.dbo.AWARIE_WAGONOW_AUX
GO

IF (OBJECT_ID('AWARIE_LOKOMOTYW_AUX') is not null) DROP TABLE PRZEWOZY_POZAREGIONALNE_DW.dbo.AWARIE_LOKOMOTYW_AUX
GO


CREATE TABLE PRZEWOZY_POZAREGIONALNE_DW.dbo.AWARIE_LOKOMOTYW_AUX (
	nr_rejestracyjny varchar(10),
	id_firmowe_maszynisty int,
	data_zgloszenia date,
	typ_awarii varchar(50),
	koszt float
);

GO
CREATE TABLE PRZEWOZY_POZAREGIONALNE_DW.dbo.AWARIE_WAGONOW_AUX (
	nr_rejestracyjny varchar(10),
	id_firmowe_maszynisty int,
	data_zgloszenia date,
	typ_awarii varchar(50),
	koszt float
);

USE [master]
GO
EXEC master.dbo.sp_MSset_oledb_prop N'Microsoft.ACE.OLEDB.12.0', N'AllowInProcess', 1
GO
EXEC master.dbo.sp_MSset_oledb_prop N'Microsoft.ACE.OLEDB.12.0', N'DynamicParameters', 1
GO

sp_configure 'show advanced options', 1;
RECONFIGURE;
GO
sp_configure 'Ad Hoc Distributed Queries', 1;
RECONFIGURE;
GO

USE PRZEWOZY_POZAREGIONALNE_DW;
GO
INSERT INTO PRZEWOZY_POZAREGIONALNE_DW.dbo.AWARIE_WAGONOW_AUX
SELECT *
FROM OPENDATASOURCE('Microsoft.ACE.OLEDB.12.0',
    'Data Source=D:\Piotrek\Studia\Semestr 5\Hurtownie danych\Hurtownie-Danych-Lab\Generator\excel\awarie.xlsx;Extended Properties=Excel 8.0')...[Wagony$];
GO
USE PRZEWOZY_POZAREGIONALNE_DW
INSERT INTO PRZEWOZY_POZAREGIONALNE_DW.dbo.AWARIE_LOKOMOTYW_AUX
SELECT *
FROM OPENDATASOURCE('Microsoft.ACE.OLEDB.12.0',
    'Data Source=D:\Piotrek\Studia\Semestr 5\Hurtownie danych\Hurtownie-Danych-Lab\Generator\excel\awarie.xlsx;Extended Properties=Excel 8.0')...[Lokomotywy$];
GO

