--ogarnac czy da sie cos zrobic z ta kwota

IF OBJECT_ID('zlozono_zamowienie', 'TR') IS NOT NULL
	DROP TRIGGER zlozono_zamowienie
GO

CREATE TRIGGER zlozono_zamowienie ON Zamowienia
AFTER INSERT
AS 
	DECLARE @Text VARCHAR(256)
	SET @Text = FORMATMESSAGE('ZAMOWIENIE ZOSTALO ZLOZONE')
	PRINT @Text
GO

-- zatrudniono pracownika na danym stanowisku
IF OBJECT_ID('zatrudniono_pracownika', 'TR') IS NOT NULL
	DROP TRIGGER zatrudniono_pracownika
GO

CREATE TRIGGER zatrudniono_pracownika ON Pracownicy
AFTER INSERT
AS 
	DECLARE @Text VARCHAR(256)
	SET @Text = FORMATMESSAGE('Pracownik zostal dodany do bazy pracownikow')
	PRINT @Text
GO

 --wyzwalacz dodanie_klienta
IF OBJECT_ID('dodano_klienta', 'TR') IS NOT NULL
	DROP TRIGGER dodano_klienta
GO

CREATE TRIGGER dodano_klienta ON Klienci
AFTER INSERT
AS 
	DECLARE @Text VARCHAR(256)
	SET @Text = FORMATMESSAGE('konto zostalo zalozone pomyslnie')
	PRINT @Text
GO

 --wyzwalacz usuwanie_konta
IF OBJECT_ID('usuniento_konto', 'TR') IS NOT NULL
	DROP TRIGGER usuniento_konto
GO

CREATE TRIGGER usuniento_konto ON Klienci
AFTER DELETE
AS 
	DECLARE @Text VARCHAR(256)
	SET @Text = FORMATMESSAGE('Konto zostalo usuniete pomyslnie')
	PRINT @Text
GO

------------------------------------------------------------------------------------------

IF OBJECT_ID('zmieniono_status_zamowienia', 'TR') IS NOT NULL
	DROP TRIGGER zmieniono_status_zamowienia
GO

CREATE TRIGGER zmieniono_status_zamowienia ON Zamowienia
AFTER UPDATE
AS 
	DECLARE @Text VARCHAR(256)
	
	IF UPDATE( [Status wysylki] )
	BEGIN
		IF ( SELECT [Status wysylki] FROM Inserted ) = 1
		BEGIN
			SET @Text = FORMATMESSAGE('Zamowienie przyjete do realizacji')
		END
		IF ( SELECT [Status wysylki] FROM Inserted ) = 2
		BEGIN
			SET @Text = FORMATMESSAGE('Zamowienie zostalo oplacone')
		END
		IF ( SELECT [Status wysylki] FROM Inserted ) = 3
		BEGIN
			SET @Text = FORMATMESSAGE('Zamowienie oczekuje na wysylke')
		END
		IF ( SELECT [Status wysylki] FROM Inserted ) = 4
		BEGIN
			SET @Text = FORMATMESSAGE('Zamowienie zostalo wyslane')
		END
	END
	
	PRINT @Text
GO

SELECT * FROM Zamowienia

UPDATE Zamowienia
SET [Status wysylki] = [Status wysylki] + 1
WHERE [ID Zamowienia] = 5
