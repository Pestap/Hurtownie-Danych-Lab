USE PRZEWOZY_POZAREGIONALNE_DW
GO


INSERT INTO JUNK_AWARII(typ_awarii)
VALUES	('Awaria silnika'),
		('Awaria komputera'),
		('Awaria hamulca'),
		('Awaria elektroniki'),
		('Awaria podwozia'),
		('Awaria drzwi'),
		('Awaria klimatyzacji')


SELECT * FROM JUNK_AWARII
GO