use TRAINMASTER

BULK INSERT dbo.STACJA FROM  "D:\Piotrek\Studia\Semestr 5\Hurtownie danych\Hurtownie-Danych-Lab\Generator\bulks\station.bulk" WITH (FIELDTERMINATOR=',')
BULK INSERT dbo.LOKOMOTYWA FROM "D:\Piotrek\Studia\Semestr 5\Hurtownie danych\Hurtownie-Danych-Lab\Generator\bulks\locomotive.bulk" WITH (FIELDTERMINATOR=',')
BULK INSERT dbo.WAGON FROM "D:\Piotrek\Studia\Semestr 5\Hurtownie danych\Hurtownie-Danych-Lab\Generator\bulks\carriage.bulk" WITH (FIELDTERMINATOR=',')
BULK INSERT dbo.MASZYNISTA FROM "D:\Piotrek\Studia\Semestr 5\Hurtownie danych\Hurtownie-Danych-Lab\Generator\bulks\driver.bulk" WITH (FIELDTERMINATOR=',')
BULK INSERT dbo.KURS FROM "D:\Piotrek\Studia\Semestr 5\Hurtownie danych\Hurtownie-Danych-Lab\Generator\bulks\course.bulk" WITH (FIELDTERMINATOR=',')
BULK INSERT dbo.KURS_WAGON FROM "D:\Piotrek\Studia\Semestr 5\Hurtownie danych\Hurtownie-Danych-Lab\Generator\bulks\courseCarriage.bulk" WITH (FIELDTERMINATOR=',')


UPDATE LOKOMOTYWA
SET predkosc_maksymalna = 140
WHERE model = 'EU07';

UPDATE LOKOMOTYWA
SET model = 'EP09A'
WHERE model = 'EP09';

BULK INSERT dbo.KURS FROM "D:\Piotrek\Studia\Semestr 5\Hurtownie danych\Hurtownie-Danych-Lab\Generator\bulks\course2.bulk" WITH (FIELDTERMINATOR=',')
BULK INSERT dbo.KURS_WAGON FROM "D:\Piotrek\Studia\Semestr 5\Hurtownie danych\Hurtownie-Danych-Lab\Generator\bulks\courseCarriage2.bulk" WITH (FIELDTERMINATOR=',')
