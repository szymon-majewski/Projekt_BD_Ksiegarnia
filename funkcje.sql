IF OBJECT_ID('wyswietl_wszystkie_pozycje_kategorii') IS NOT NULL
DROP FUNCTION wyswietl_wszystkie_pozycje_kategorii

--funkcja wyswietlajaca informacje o pozycjach z kategorii danej argumentem
GO
CREATE FUNCTION wyswietl_wszystkie_pozycje_kategorii(@kategoria AS NVARCHAR(50)) 
RETURNS TABLE AS 
RETURN (

	SELECT P.Tytul, P.ISBN13, CONCAT( O.Imie, ' ', O.Nazwisko ) AS [Autor], P.[Czesc serii], P.Jezyk, P.[Jezyk oryginalu], W.Nazwa AS [Wydawca], P.[Data wydania],
			P.Oprawa, P.Wymiary, P.[Liczba stron], (P.Cena * (1 - P.Obnizka)) AS Cena, P.Opis
	FROM [Kategorie ksiazek] K 
	JOIN Produkty P ON K.[ID kategorii] = P.[ID kategorii]
	JOIN Autorzy A ON A.[ID Autora] = P.[ID autora]
	JOIN Osoby O ON O.[ID Osoby] = A.[ID Autora]
	JOIN Wydawcy W ON W.[ID wydawcy] = P.[ID wydawcy]
	WHERE K.[Nazwa] = @kategoria
)
GO

-- przykładowe wywołanie funkcji (wypisanie informacji o pozycjach z kategorii 'fantastyka' ):
SELECT * FROM wyswietl_wszystkie_pozycje_kategorii('fantastyka')

--------------------------------------------------------------------------------------------------------------------------------------------------

IF OBJECT_ID('wyswietl_wszystkie_pozycje_serii') IS NOT NULL
DROP FUNCTION wyswietl_wszystkie_pozycje_serii

--funkcja wyswietlajaca szczegoly ksiazek nalezacych do serii danej argumentem
GO
CREATE FUNCTION wyswietl_wszystkie_pozycje_serii(@seria AS NVARCHAR(300))
RETURNS TABLE AS 
RETURN (

	SELECT P.Tytul, P.ISBN13, CONCAT( O.Imie, ' ', O.Nazwisko ) AS [Autor], P.[Czesc serii], P.Jezyk, P.[Jezyk oryginalu], W.Nazwa AS [Wydawca], P.[Data wydania],
			P.Oprawa, P.Wymiary, P.[Liczba stron],(P.Cena * (1 - P.Obnizka)) AS Cena, P.Opis
	FROM [Serie] S
	JOIN Produkty P ON S.[ID Serii] = P.[ID serii]
	JOIN Autorzy A ON A.[ID Autora] = P.[ID autora]
	JOIN Osoby O ON O.[ID Osoby] = A.[ID Autora]
	JOIN Wydawcy W ON W.[ID wydawcy] = P.[ID wydawcy]
	WHERE S.[Nazwa] = @seria

)
GO

-- przykładowe wywołanie funkcji (wypisanie informacji o pozycjach z serii 'The Green Bone Saga' ):
SELECT * FROM wyswietl_wszystkie_pozycje_serii('The Green Bone Saga')

--------------------------------------------------------------------------------------------------------------------------------------------------
IF OBJECT_ID('wyswietl_ksiazki_autora') IS NOT NULL
DROP FUNCTION wyswietl_ksiazki_autora

-- funkcja wyswietlajaca dane ksiazek napisanych przez danego argumentem autora
GO
CREATE FUNCTION wyswietl_ksiazki_autora(@autor_nazwisko AS NVARCHAR(50), @autor_imie AS NVARCHAR(50)) 
RETURNS TABLE AS 
RETURN (

	SELECT P.Tytul, P.ISBN13, CONCAT( O.Imie, ' ', O.Nazwisko ) AS [Autor], S.Nazwa AS [Nazwa serii] ,P.[Czesc serii], P.Jezyk, P.[Jezyk oryginalu], W.Nazwa AS [Wydawca], P.[Data wydania],
			P.Oprawa, P.Wymiary, P.[Liczba stron], (P.Cena * (1 - P.Obnizka)) AS Cena , P.Opis
	FROM Osoby O
	JOIN Autorzy A ON O.[ID osoby] = A.[ID autora]
	JOIN Produkty P ON O.[ID osoby] = P.[ID autora] 
	JOIN Serie S ON O.[ID osoby] = S.[ID autora]
	JOIN Wydawcy W ON W.[ID wydawcy] = P.[ID wydawcy]
	WHERE O.Imie =  @autor_imie AND O.Nazwisko = @autor_nazwisko

)
GO

-- przykładowe wywołanie funkcji (wypisanie informacji o pozycjach autorstwa Fondy Lee):
SELECT * FROM wyswietl_ksiazki_autora('Lee', 'Fonda')

-----------------------------------------------------
IF OBJECT_ID('wyswietl_zamowienia_klienta') IS NOT NULL
DROP FUNCTION wyswietl_zamowienia_klienta

--funkcja wyswietlajaca informacje o wszystkich zamowieniach klienta, ktorego ID jest dane argumentem 
GO
CREATE FUNCTION wyswietl_zamowienia_klienta(@ID AS INT)
RETURNS TABLE AS 
RETURN (

	SELECT  SZ.[ID zamowienia], Z.[Data i czas zamowienia], Z.[Status wysylki], Z.[Data wysylki], 
			CONCAT( Z.[Kod pocztowy], ' ', Z.[Miasto], ' ', Z.[Ulica], ' ',  Z.[Nr budynku], ' ', Z.[Nr lokalu]) AS Adres,
			OW.[Typ] AS [Metoda wysylki], ISNULL(PO.[Nazwa],'')  AS [Punkt odbioru], 
			CONCAT( PO.[Kod pocztowy], ' ', PO.[Miasto], ' ', PO.[Ulica], ' ',  PO.[Nr budynku]) AS [Adres Punktu Odbioru],
			CAST( ( SUM( ( SZ.Cena * (1 - Obnizka) ) + OW.Cena) * ( 1- Z.[Rabat kliencki] ) ) AS MONEY ) AS Kwota
	FROM [Klienci] K
	JOIN Zamowienia Z ON K.[ID Klienta] = Z.[ID klienta]
	JOIN [Szczegoly Zamowien] SZ ON Z.[ID zamowienia] = SZ.[ID zamowienia]	
	LEFT JOIN [Punkty odbioru] PO ON PO.[ID punktu] = Z.[ID punktu odbioru]
	LEFT JOIN [Opcje wysylki] OW ON OW.[ID opcji] = Z.[Metoda wysylki]
	WHERE K.[ID Klienta] = @ID
	GROUP BY SZ.[ID zamowienia], Z.[Data i czas zamowienia], Z.[Status wysylki], Z.[Data wysylki],
			 Z.[Miasto], Z.[Ulica], Z.[Nr budynku], Z.[Nr lokalu], Z.[Kod pocztowy], OW.Typ, PO.[Nazwa], 
			 PO.[Miasto], PO.[Ulica], PO.[Nr budynku], PO.[Kod pocztowy], OW.Cena, Z.[Rabat kliencki]
)
GO

-- przykładowe wywołanie funkcji (wypisanie informacji o zamowieniach klienta o ID = 4):
SELECT * FROM wyswietl_zamowienia_klienta(4)

---------------------------------------------SZYMON-----------------------------------------------

IF OBJECT_ID('pracownicy_na_zmianie', 'FN') IS NOT NULL DROP FUNCTION pracownicy_na_zmianie

GO
CREATE FUNCTION pracownicy_na_zmianie( @ID_Zmiany INT, @Data DATE ) RETURNS TABLE AS RETURN (
	SELECT P.[ID Pracownika], P.Imie, P.Nazwisko FROM [Grafik Zmian] AS G
	JOIN Pracownicy AS P ON P.[ID Pracownika] = G.[ID Pracownika]
	WHERE @ID_Zmiany = G.[ID Zmiany] AND @Data = G.Data
)

GO
SELECT * FROM pracownicy_na_zmianie(1, '2022-01-13')

--------------------------------------------------------------------------------------------------

IF OBJECT_ID('miesieczne_wydatki_klienta', 'FN') IS NOT NULL DROP FUNCTION miesieczne_wydatki_klienta

GO
CREATE FUNCTION miesieczne_wydatki_klienta( @ID_Klienta INT ) RETURNS MONEY AS
BEGIN
	DECLARE @Wydatki MONEY
	
	-- przy wyliczaniu wydatkow uwzgledniac rabat nadany w ramach kategorii klienta? (kategoria mogla sie zmienic w trakcie miesiaca) Jesli tak to jak? Moze po prostu tu sumowac cene bazowa ksiazek w zamowieniu i na tej podstawie potem wyznaczac kategorie klienta, bo im wyzsza kategoria, tym mniej sprawiedliwe jest wbijanie kolejnej
	SET @Wydatki = ( SELECT SUM(ROUND(SZ.Ilosc * CAST((SZ.Cena * SZ.obnizka) AS MONEY ), 2)) FROM Zamowienia AS Z
					 JOIN [Szczegoly Zamowien] AS SZ ON Z.[ID zamowienia] = SZ.[ID zamowienia]
					 WHERE @ID_Klienta = Z.[ID klienta] AND DATEDIFF( month, GETDATE(), Z.[Data i czas zamowienia]) <= 1
					 GROUP BY Z.[ID klienta] )
	RETURN @Wydatki
END

SELECT dbo.miesieczne_wydatki_klienta( 4 )

--------------------------------------------------------------------------------------------------

IF OBJECT_ID('historia_zatrudnien_na_stanowisku', 'FN') IS NOT NULL DROP FUNCTION historia_zatrudnien_na_stanowisku

GO
CREATE FUNCTION historia_zatrudnien_na_stanowisku( @ID_Stanowiska INT ) RETURNS TABLE AS RETURN (
	SELECT P.[ID Pracownika], P.Imie, P.Nazwisko,
	HZ.[Data zatrudnienia na stanowisku] AS [Data zatrudnienia], HZ.[Data zwolnienia] FROM [Historia Zatrudnien] AS HZ
	JOIN Pracownicy AS P ON P.[ID Pracownika] = HZ.[ID Pracownika]
	WHERE @ID_Stanowiska = HZ.[Stanowisko] -- dlaczego w create tu nie ma foreign key do tabeli stanowiska?
)

GO
SELECT * FROM historia_zatrudnien_na_stanowisku( 1 )

