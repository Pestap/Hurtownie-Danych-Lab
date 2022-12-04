sp_configure 'show advanced options', 1;
RECONFIGURE;
GO
sp_configure 'Ad Hoc Distributed Queries', 1;
RECONFIGURE;
GO


SELECT * INTO Data_dq
FROM OPENDATASOURCE('Microsoft.ACE.OLEDB.12.0',
    'Data Source=D:\Piotrek\Studia\Semestr 5\Hurtownie danych\Hurtownie-Danych-Lab\Generator\excel\awarie_t1.xls;Extended Properties=Excel 12.0')...[Sheet1$];
GO