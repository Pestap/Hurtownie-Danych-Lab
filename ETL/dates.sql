USE PRZEWOZY_POZAREGIONALNE_DW
GO

Declare @StartDate date;
Declare @EndDate date;

SELECT @StartDate = '2022-11-01', @EndDate = '2099-11-01';

Declare @CurrentDate date = @StartDate

CREATE TABLE HOLIDAYS(
	data date
);

BULK INSERT HOLIDAYS
FROM 'D:\Piotrek\Studia\Semestr 5\Hurtownie danych\Hurtownie-Danych-Lab\Generator\excel\holidays.csv'
WITH
(	
	FORMAT='CSV',
	FIRSTROW=2
)


WHILE @CurrentDate <= @EndDate
	BEGIN
		INSERT INTO dbo.DATA (data, rok, miesiac, dzien, dzien_wolny)
		VALUES (
			@CurrentDate, 
			CAST( Year(@CurrentDate) as int),
			CAST( Month(@CurrentDate) as int),
			CAST( Day(@CurrentDate) as int),
			CASE	
				WHEN DATEPART(dw, @CurrentDate) = 1 OR  DATEPART(dw, @CurrentDate) = 7 
				OR EXISTS (SELECT * FROM HOLIDAYS WHERE data = @CurrentDate)
				THEN 'dzieñ wolny'
				ELSE 'zwyk³y dzieñ'
			END
		);
		SET @CurrentDate = DATEADD(d,1, @CurrentDate);
	END

DROP TABLE HOLIDAYS