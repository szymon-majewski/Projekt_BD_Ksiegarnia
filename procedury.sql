IF OBJECT_ID ('dbo.zmien_pensje') IS NOT NULL
DROP PROCEDURE dbo.zmien_pensje;

--procedura zmienia pensję pracownikowi o ID danym argumentem na nową, ponadto przed zmianą dodaje obecną pensję do zarchiwizowanych (historii)
GO
CREATE PROCEDURE dbo.zmien_pensje ( @ID INT = NULL, @Nowa_pensja MONEY = NULL )
AS
 
DECLARE @blad AS NVARCHAR(500);
 
IF @ID IS NULL OR @Nowa_pensja IS NULL OR @ID NOT IN (SELECT [ID pracownika] FROM Pracownicy)
  BEGIN
    SET @blad = 'Nieprawidłowe dane, sprawdź podane argumenty.';
    RAISERROR(@blad, 16,1);
      RETURN;
  END

IF @ID NOT IN (SELECT [ID pracownika] FROM Pracownicy)
  BEGIN
    SET @blad = 'Nie ma takiego pracownika w bazie danych.';
    RAISERROR(@blad, 16,1);
      RETURN;
  END


DECLARE @Stara_pensja AS MONEY;
SET @Stara_pensja = (SELECT Pensja FROM Pracownicy	
					 WHERE [ID pracownika] = @ID)

INSERT INTO [Historia Pensji]([ID pracownika], [Data zmiany pensji], [Poprzednia pensja])
VALUES (@ID, GETDATE(), @Stara_pensja);

UPDATE Pracownicy
SET Pensja = @Nowa_pensja
WHERE [ID pracownika] = @ID;
GO

--przykładowe wywołanie procedury - zmiana pensji pracownikowi o ID = 1 na 15 000
EXEC dbo.zmien_pensje @ID = 1, @Nowa_pensja = 15000.00
GO

--------------------------------------------------------------------------------------------------------------------------------------------------

IF OBJECT_ID ('dbo.zmien_status_zamowienia') IS NOT NULL
DROP PROCEDURE dbo.zmien_status_zamowienia;

--procedura zmienia status zamowienia o ID danym argumentem na następny w kolejności, w momencie, gdy status zmieni się na 'wysłano' aktualizowana
--jest data wysyłki w tabeli Zamowienia
GO
CREATE PROCEDURE dbo.zmien_status_zamowienia ( @ID INT = NULL )
AS
 
DECLARE @blad AS NVARCHAR(500);
 
IF @ID IS NULL OR @ID NOT IN ( SELECT [ID zamowienia] FROM Zamowienia)
	BEGIN
    SET @blad = 'Nieprawidłowe dane, sprawdź podane argumenty.';
    RAISERROR(@blad, 16,1);
      RETURN;
	END

IF @ID NOT IN ( SELECT [ID zamowienia] FROM Zamowienia)
	BEGIN
    SET @blad = 'Nie ma takiego zamówienia w bazie danych.';
    RAISERROR(@blad, 16,1);
      RETURN;
	END

DECLARE @temp AS INT, @MAX AS INT;

SET @temp = (SELECT SZ.[ID Statusu] FROM Zamowienia Z
			 JOIN [Statusy zamowienia] SZ ON SZ.[ID Statusu] = Z.[Status wysylki]
			 WHERE [ID zamowienia] = @ID);
SET @max = (SELECT [ID Statusu] FROM [Statusy zamowienia] 
			WHERE [Nazwa statusu] = 'wyslano');

IF @temp IS NULL
	BEGIN
    UPDATE Zamowienia
	SET [Status wysylki] = 1
	WHERE [ID zamowienia] = @ID;
      RETURN;
	END

IF @temp = @max 
	BEGIN
    SET @blad = 'Nie można zmienić statusu, zamówienie zostało już wysłane.';
    RAISERROR(@blad, 16,1);
      RETURN;
	END

IF @temp + 1 = @max 
	UPDATE Zamowienia
	SET [Data wysylki] = GETDATE()
	WHERE [ID zamowienia] = @ID;

UPDATE Zamowienia
SET [Status wysylki] = @temp + 1
WHERE [ID zamowienia] = @ID;
GO

--przykładowe wywołanie procedury - czterokrotne zaktualizowanie statusu dla zamówienia o ID = 5
EXEC dbo.zmien_status_zamowienia @ID = 5
GO

--------------------------------------------------------------------------------------------------------------------------------------------------

IF OBJECT_ID ('dbo.dodaj_klienta') IS NOT NULL
DROP PROCEDURE dbo.dodaj_klienta;

--DOROBIC ADRES

--procedura dodająca nowego klienta (tworząca nowe konto) do bazy wraz ze wszytkimi danymi, hasłem i loginem
GO
CREATE PROC dbo.dodaj_klienta( @Imie VARCHAR(50) = NULL, @Nazwisko VARCHAR(50) = NULL, @Login VARCHAR(50), 
							   @Haslo VARCHAR(50), @Tel INT = NULL, @Mail NVARCHAR(255) = NULL )
AS
 
DECLARE @blad AS NVARCHAR(500);
 
IF @Imie IS NULL OR @Nazwisko IS NULL OR @Login IS NULL OR @Haslo IS NULL OR @Tel IS NULL
	BEGIN
		SET @blad = 'Błędne dane, sprawdź podane argumenty.';
		RAISERROR(@blad, 16,1);
		RETURN;
	END

IF LEN(@Haslo) < 8 
	BEGIN
	SET @blad = 'Hasło powinno zawierać minimum 8 znaków';
		RAISERROR(@blad, 16,1);
		RETURN;
	END

IF @Login IN (SELECT [Nazwa konta] FROM Klienci) 
	BEGIN
		SET @blad = 'Błędny login. Konto o podanej nazwie już istnieje.';
		RAISERROR(@blad, 16,1);
		RETURN;
	END

IF @Mail IN (SELECT [E-mail] FROM Klienci) 
	BEGIN
		SET @blad = 'Błędny e-mial. Konto na podany adres e-mail zostało już utworzone.';
		RAISERROR(@blad, 16,1);
		RETURN;
	END

/*INSERT INTO Osoby(Imie, Nazwisko) -- + adres --dodam jak sie pojawi ta tabelka
VALUES (@Imie, @Nazwisko);*/

INSERT INTO Klienci( Imie, Nazwisko, [ID kategorii], [Nazwa konta], [Haslo do konta], Telefon, [E-mail] )
VALUES(@Imie, @Nazwisko, 1, @Login, @Haslo, @Tel, @Mail );
GO

--przykładowe wywołanie procedury - dodanie klienta: Jan Kowalski wraz z danymi, loginem i hasłem
EXEC dbo.dodaj_klienta  @Imie = 'Jan', @Nazwisko = 'Kowalski', @Login = 'jkowal', 
							   @Haslo = '12asasdfgg', @Tel = 123123123, @Mail = NULL
GO


