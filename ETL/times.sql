USE PRZEWOZY_POZAREGIONALNE_DW
GO

Declare @StartHour int;
Declare @EndHour int;

Declare @StartMinute int;
Declare @EndMinute int;

Declare @StartSecond int;
Declare @EndSecond int;

SELECT @StartHour = 0, @EndHour = 23;
SELECT @StartMinute = 0, @EndMinute = 59;
SELECT @StartSecond = 0, @EndSecond =59;


Declare @CurrentHour int = @StartHour
WHILE @CurrentHour <= @EndHour
	BEGIN
		Declare @CurrentMinute int = @StartMinute;
		WHILE @CurrentMinute <= @EndMinute
			BEGIN
				Declare @CurrentSecond int = @StartSecond;
				WHILE @CurrentSecond <= @EndSecond
					BEGIN
						INSERT INTO dbo.CZAS(godzina, minuta, sekunda, czas_dnia)
						VALUES (
							@CurrentHour,
							@CurrentMinute,
							@CurrentSecond,
							CASE
								WHEN @CurrentHour <= 6 THEN 'noc'
								WHEN @CurrentHour <= 12 THEN 'przedpo³udnie'
								WHEN @CurrentHour <=18 THEN 'popo³udnie'
								ELSE 'wieczór'
							END
						);

						SET @CurrentSecond = @CurrentSecond + 1
					END
				SET @CurrentMinute = @CurrentMinute + 1
			END
		SET @CurrentHour = @CurrentHour + 1
	END
