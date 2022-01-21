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
IF OBJECT_ID('zatrudniono pracownika', 'TR') IS NOT NULL
	DROP TRIGGER zatrudniono pracownika
GO

CREATE TRIGGER zatrudniono pracownika ON Pracownicy
AFTER INSERT
AS 
	DECLARE @Text VARCHAR(256)
	SET @Text = FORMATMESSAGE('Pracownik zostal dodany do bazy pracownikow')
	PRINT @Text
GO

 --wyzwalacz dodanie klienta
IF OBJECT_ID('dodano klienta', 'TR') IS NOT NULL
	DROP TRIGGER dodano klienta
GO

CREATE TRIGGER dodano klienta ON Klienci
AFTER INSERT
AS 
	DECLARE @Text VARCHAR(256)
	SET @Text = FORMATMESSAGE('konto zostalo zalozone pomyslnie')
	PRINT @Text
GO

 --wyzwalacz usuwanie konta
IF OBJECT_ID('usuniento konto', 'TR') IS NOT NULL
	DROP TRIGGER usuniento konto
GO

CREATE TRIGGER usuniento konto ON Klienci
AFTER DELETE
AS 
	DECLARE @Text VARCHAR(256)
	SET @Text = FORMATMESSAGE('Konto zostalo usuniete pomyslnie')
	PRINT @Text
GO
