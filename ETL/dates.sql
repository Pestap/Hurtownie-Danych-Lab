USE PRZEWOZY_POZAREGIONALNE_DW
GO

Declare @StartDate date;
Declare @EndDate date;

SELECT @StartDate = '2022-11-01', @EndDate = '2032-11-01';

Declare @CurrentDate date = @StartDate

WHILE @CurrentDate <= @EndDate
	BEGIN
		INSERT INTO dbo.DATA (data, rok, miesiac, dzien, dzien_wolny)
		VALUES (
			@CurrentDate, 
			CAST( Year(@CurrentDate) as int),
			CAST( Month(@CurrentDate) as int),
			CAST( Day(@CurrentDate) as int),
			CASE	
				WHEN DATEPART(dw, @CurrentDate) = 1 OR  DATEPART(dw, @CurrentDate) = 7 THEN 'dzieñ wolny'
				ELSE 'zwyk³y dzieñ'
			END
		);
		SET @CurrentDate = DATEADD(d,1, @CurrentDate);
	END

