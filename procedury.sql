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

--przykładowe wywołanie procedury - zmiana pensji pracownikowi o ID = 9 na 15 000
EXEC dbo.zmien_pensje @ID = 9, @Nowa_pensja = 15000.00
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

--przykładowe wywołanie procedury - trzykrotne zaktualizowanie statusu dla zamówienia o ID = 3
EXEC dbo.zmien_status_zamowienia @ID = 3
GO
EXEC dbo.zmien_status_zamowienia @ID = 3
GO
EXEC dbo.zmien_status_zamowienia @ID = 3
GO

--------------------------------------------------------------------------------------------------------------------------------------------------

IF OBJECT_ID ('dbo.dodaj_klienta') IS NOT NULL
DROP PROCEDURE dbo.dodaj_klienta;

--procedura dodająca nowego klienta (tworząca nowe konto) do bazy wraz ze wszytkimi danymi, hasłem i loginem
GO
CREATE PROC dbo.dodaj_klienta( @Imie NVARCHAR(50) = NULL, @Nazwisko NVARCHAR(50) = NULL, @Miasto NVARCHAR(50) = NULL, @Ulica NVARCHAR(50) = NULL, @Budynek INT = NULL,
							   @Lokal INT = NULL, @Kod NVARCHAR(10) = NULL, @Login NVARCHAR(50), @Haslo VARCHAR(50), 
							   @Tel INT = NULL, @Mail NVARCHAR(255) = NULL )
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

INSERT INTO Osoby(Imie, Nazwisko, Miasto, Ulica, [Nr budynku], [Nr lokalu], [Kod pocztowy])
VALUES (@Imie, @Nazwisko, @Miasto, @Ulica, @Budynek, @Lokal, @Kod);

DECLARE @ID INT;
SET @ID= ( SELECT MAX([ID osoby]) FROM Osoby )

INSERT INTO Klienci([ID klienta], [ID kategorii], [Nazwa konta], [Haslo do konta], Telefon, [E-mail] )
VALUES(@ID, 1, @Login, @Haslo, @Tel, @Mail );
GO

--przykładowe wywołanie procedury - dodanie klienta: Jan Kowalski wraz z danymi, loginem i hasłem
EXEC dbo.dodaj_klienta  @Imie = 'Jan', @Nazwisko = 'Kowalski', @Login = 'jkowal', @Miasto = 'Kraków', @Ulica = 'Focha', @Budynek = '123', @Kod = '30-111', 
			@Haslo = '12asasdfgg', @Tel = 123123123, @Mail = NULL
GO

-----------------------------------------------------------------SZYMON---------------------------------------------------------------------------

IF OBJECT_ID('dbo.dodaj_pracownika','P') IS NOT NULL DROP PROCEDURE dbo.dodaj_pracownika

GO
CREATE PROCEDURE dbo.dodaj_pracownika( @Imie NVARCHAR(50) = NULL, @Nazwisko NVARCHAR(50) = NULL, @Miasto NVARCHAR(50) = NULL, @Ulica NVARCHAR(50) = NULL, @Budynek INT = NULL, @Lokal INT = NULL, @Kod_Pocztowy NVARCHAR(10) = NULL, @ID_Przelozonego INT = NULL, @ID_Stanowiska INT = NULL, @Pensja MONEY = NULL ) AS 
BEGIN
	DECLARE @blad AS NVARCHAR(100);

	IF @Imie IS NULL OR @Nazwisko IS NULL OR @ID_Stanowiska IS NULL OR @Pensja IS NULL
	BEGIN
		SET @blad = 'Pominieto kluczowe dane. Dodanie pracownika nie powiodlo sie';
		RAISERROR(@blad, 16, 1);
		RETURN;
	END
	
	IF @ID_Przelozonego NOT IN ( SELECT ID_Pracownika FROM Pracownicy ) AND @ID_Przelozonego IS NOT NULL
	BEGIN
		SET @blad = 'Podano bledne ID przelozonego. Dodanie pracownika nie powiodlo sie';
		RAISERROR(@blad, 16, 1);
		RETURN;
	END
	
	IF @ID_Stanowiska NOT IN ( SELECT ID_Stanowiska FROM Stanowiska )
	BEGIN
		SET @blad = 'Podano bledne ID stanowiska. Dodanie pracownika nie powiodlo sie';
		RAISERROR(@blad, 16, 1);
		RETURN;
	END
	
	IF ( SELECT [Ilosc Potrzebnych Pracownikow] FROM [Zapotrzebowanie Na Pracownikow] --trzeba przetestowac
		 WHERE [ID_Stanowiska] = @ID_Stanowiska ) = 0
	BEGIN
		SET @blad = 'Brak zapotrzebowania pracownikow na podane stanowisko. Dodanie pracownika nie powiodlo sie';
		RAISERROR(@blad, 16, 1);
		RETURN;
	END
	
	UPDATE [Zapotrzebowanie Na Pracownikow]
	SET [Ilosc Potrzebnych Pracownikow] = ( [Ilosc Potrzebnych Pracownikow] - 1 ),
	[Ilosc Zatrudnionych Pracownikow] = ( [Ilosc Zatrudnionych Pracownikow] + 1 )
	WHERE [ID_Stanowiska] = @ID_Stanowiska
	
	INSERT INTO Osoby(Imie, Nazwisko, Miasto, Ulica, [Nr budynku], [Nr lokalu], [Kod pocztowy])
	VALUES (@Imie, @Nazwisko, @Miasto, @Ulica, @Budynek, @Lokal, @Kod_Pocztowy);

	DECLARE @ID INT;
	SET @ID = ( SELECT MAX( [ID osoby] ) FROM Osoby )
	
	INSERT INTO Pracownicy( [ID Pracownika], [ID przelozonego], [ID stanowiska], Pensja )
	VALUES (@ID, @ID_Przelozonego, @ID_Stanowiska, @Pensja)
END

GO

EXECUTE dodaj_pracownika @Imie = 'Szymon', @Nazwisko = 'Majewski', @Miasto = 'Kraków', @Ulica = 'Focha', @Budynek = '123', @Kod = '30-111', @ID_Przelozonego = NULL, @ID_Stanowiska = 1, @Pensja = 20000.00
		
-------------------------------------------------------------------------------------------------------------

IF OBJECT_ID('dbo.przypisz_klientowi_kategorie','P') IS NOT NULL DROP PROCEDURE dbo.przypisz_klientowi_kategorie

GO
CREATE PROCEDURE dbo.przypisz_klientowi_kategorie ( @ID_Klienta INT ) AS
BEGIN
	DECLARE @wydatki_w_ostatnim_miesiacu INT
	SET @wydatki_w_ostatnim_miesiacu = ( SELECT * FROM miesieczne_wydatki_klienta( @ID_Klienta ) )
	
	DECLARE @Ilosc_Kategorii INT
	SET @Ilosc_Kategorii = ( SELECT COUNT( [ID kategorii] ) FROM [Klienci Kategorie] )
	
	DECLARE @i INT
	SET @i = 1
	
	WHILE (@i <= @Ilosc_Kategorii)
	BEGIN
		IF @wydatki_w_ostatnim_miesiacu < ( SELECT [Maksymalne Miesieczne Zakupy ] FROM [Klienci Kategorie]
											WHERE [ID Kategorii] = @i )
		BEGIN
			UPDATE Klienci
			SET [ID Kategorii] = @i
			WHERE [ID Klienta] = @ID_Klienta
			
			RETURN
		END
		
		SET @i = @i + 1
	END
	
	UPDATE Klienci
	SET [ID Kategorii] = ( @i - 1 )
	WHERE [ID Klienta] = @ID_Klienta
	
	RETURN
END
	
GO
EXECUTE dbo.przypisz_klientowi_kategorie @ID_Klienta = 4

-------------------------------------------------------------------------------------------------------------

CREATE TYPE Pozycje_Zamowienia_TYP AS TABLE (
	ID_Produktu INT,
	Ilosc INT
)

IF OBJECT_ID('dbo.zloz_zamowienie','P') IS NOT NULL DROP PROCEDURE dbo.zloz_zamowienie

GO
CREATE PROCEDURE dbo.zloz_zamowienie ( @pozycje_zamowienia Pozycje_Zamowienia_TYP READONLY, @ID_Klienta INT,
@Miasto NVARCHAR(50) = NULL, @Ulica NVARCHAR(50) = NULL, @Nr_Budynku = NULL, @Nr_Lokalu = NULL, @Kod_Pocztowy = NULL, @Metoda_Wysylki = NULL, @ID_Punktu_Odbioru = NULL ) AS
BEGIN
	DECLARE @blad AS NVARCHAR(100);
	
	-- zamowienie puste
	IF ( SELECT COUNT(ID_Produktu) FROM @pozycje_zamowienia ) = 0
	BEGIN
		SET @blad = 'Koszyk pusty. Zamowienie nie zostalo zlozone';
		RAISERROR(@blad, 16, 1);
		RETURN;
	END

	-- brak danych do wysylki (albo punktu odbioru, albo adresu)
	IF @ID_Punktu_Odbioru IS NULL AND ( @Miasto IS NULL OR @Ulica IS NULL OR @Nr_Budynku IS NULL OR @Kod_Pocztowy IS NULL )
	BEGIN
		SET @blad = 'Niepelne dane do wysylki. Zamowienie nie zostalo zlozone';
		RAISERROR(@blad, 16, 1);
		RETURN;
	END
	
	DECLARE @ID_Prod INT
	DECLARE @Liczba INT
	
	DECLARE wiersz_zamowienia CURSOR FOR
	SELECT ID_Produktu, Ilosc FROM @pozycje_zamowienia
	
	OPEN wiersz_zamowienia
	
	FETCH NEXT FROM wiersz_zamowienia INTO @ID_Prod, @Liczba
	
	--brak towaru na stanie
	WHILE ( @@FETCH_STATUS = 0 )
	BEGIN
		IF @Liczba > ( SELECT [Ilosc w magazynie] FROM Produkty WHERE @ID_Prod = [ID Produktu] )
		BEGIN
			SET @blad = 'Brak towaru na stanie. Zamowienie nie zostalo zlozone';
			RAISERROR(@blad, 16, 1);
			CLOSE wiersz_zamowienia
			DEALLOCATE wiersz_zamowienia
			RETURN;
		END
		
		FETCH NEXT FROM wiersz_zamowienia INTO @ID_Prod, @Liczba
	END
	
	CLOSE wiersz_zamowienia
	DEALLOCATE wiersz_zamowienia
	
	--odjecie towaru ze stanu
	DECLARE wiersz_zamowienia2 CURSOR FOR
	SELECT ID_Produktu, Ilosc FROM @pozycje_zamowienia
	
	OPEN wiersz_zamowienia2
	
	FETCH NEXT FROM wiersz_zamowienia2 INTO @ID_Prod, @Liczba
	
	WHILE ( @@FETCH_STATUS = 0 )
	BEGIN
		UPDATE Produkty
		SET [Ilosc w magazynie] = [Ilosc w magazynie] - @Liczba
		WHERE @ID_Prod = [ID Produktu]
		
		FETCH NEXT FROM wiersz_zamowienia2 INTO @ID_Prod, @Liczba
	END
	
	CLOSE wiersz_zamowienia2
	DEALLOCATE wiersz_zamowienia2
	
	--nadanie klientowi kategorii
	EXECUTE dbo.przypisz_klientowi_kategorie @ID_Klienta = @ID_Klienta --to przejdzie?
	DECLARE @ID_Kategorii_Klienta INT
	SET @ID_Kategorii_Klienta = ( SELECT [ID Kategorii] FROM Klienci WHERE @ID_Klienta = [ID Klienta] )
	
	--dodanie zamowienia
	INSERT INTO Zamowienia ( [ID klienta], [Data i czas zamowienia], [Status wysylki], [Data wysylki], Miasto,Ulica, [Nr budynku], [Nr lokalu], [Kod pocztowy], [Metoda Wysylki], [ID Punktu Odbioru] )
	VALUES ( @ID_Klienta, GETDATE(), 1, NULL, @Miasto, @Ulica, @Nr_Budynku, @Nr_Lokalu, @Kod_Pocztowy, @Metoda_Wysylki, @ID_Punktu_Odbioru )
	
	DECLARE @ID INT;
	SET @ID = ( SELECT MAX( [ID Zamowienia] ) FROM Zamowienia )
	
	--dodanie szczegolow zamowienia
	DECLARE wiersz_zamowienia3 CURSOR FOR
	SELECT ID_Produktu, Ilosc FROM @pozycje_zamowienia
	
	OPEN wiersz_zamowienia3
	
	FETCH NEXT FROM wiersz_zamowienia3 INTO @ID_Prod, @Liczba
	
	WHILE ( @@FETCH_STATUS = 0 )
	BEGIN
		INSERT INTO [Szczegoly Zamowien] ( [ID Zamowienia], [ID produktu], Cena, Ilosc, Obnizka ) --co wstawic w cena? cena jest w tabeli Produkty. Chyba ze tu jest cena produktu, która obowiazywala w czasie skladania zamowienia i mogla ulec potem zmianie.
		--nie wiem czy dobrze rozumiem obnizke jako rabat wynikajacy z kategorii klienta. Jesli nie, to gdzie bedzie trzymany ten rabat z kategorii wyznaczony w trakcie skladania zamowienia?
		VALUES ( @ID, @ID_Prod, ( SELECT Cena FROM Produkty WHERE [ID Produktu] = @ID_Prod ), @Liczba,
		( SELECT Rabat FROM [Klienci Kategorie] WHERE @ID_Kategorii_Klienta = [ID Kategorii] ) )
		
		FETCH NEXT FROM wiersz_zamowienia3 INTO @ID_Prod, @Liczba
	END
	
	CLOSE wiersz_zamowienia3
	DEALLOCATE wiersz_zamowienia3
	
END

--przykladzior
