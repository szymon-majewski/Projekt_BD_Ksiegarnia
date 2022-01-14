IF OBJECT_ID('dbo.wyswietl_wszystkie_pozycje_kategorii') IS NOT NULL
DROP FUNCTION dbo.wyswietl_wszystkie_pozycje_kategorii

--funkcja wyswietlajaca informacje o pozycjach z kategorii danej argumentem
GO
CREATE FUNCTION dbo.wyswietl_wszystkie_pozycje_kategorii(@kategoria AS NVARCHAR(50)) 
RETURNS TABLE AS 
RETURN (

	SELECT P.Tytul, A.Imie AS [Imie Autora], A.Nazwisko AS [Nazwisko Autora], P.[Czesc serii], P.Jezyk, P.[Jezyk oryginalu], W.Nazwa AS [Wydawca], P.[Data wydania],
			P.Oprawa, P.Wymiary, P.[Liczba stron], P.Cena, P.Opis
	FROM [Kategorie ksiazek] K 
	JOIN Produkty P ON K.[ID kategorii] = P.[ID kategorii]
	JOIN Autorzy A ON A.[ID Autora] = P.[ID autora]
	JOIN Wydawcy W ON W.[ID wydawcy] = P.[ID wydawcy]
	WHERE K.[Nazwa] = @kategoria
)
GO

-- przykładowe wywołanie funkcji (wypisanie informacji o pozycjach z kategorii 'fantastyka' ):
SELECT * FROM dbo.wyswietl_wszystkie_pozycje_kategorii('fantastyka')


IF OBJECT_ID('dbo.wyswietl_wszystkie_pozycje_serii') IS NOT NULL
DROP FUNCTION dbo.wyswietl_wszystkie_pozycje_serii

--funkcja wyswietlajaca szczegoly ksiazek nalezacych do serii danej argumentem
GO
CREATE FUNCTION dbo.wyswietl_wszystkie_pozycje_serii(@seria AS NVARCHAR(300))
RETURNS TABLE AS 
RETURN (

	SELECT P.Tytul, A.Imie AS [Imie Autora], A.Nazwisko AS [Nazwisko Autora], P.[Czesc serii], P.Jezyk, P.[Jezyk oryginalu], W.Nazwa AS [Wydawca], P.[Data wydania],
			P.Oprawa, P.Wymiary, P.[Liczba stron], P.Cena, P.Opis
	FROM [Serie] S
	JOIN Produkty P ON S.[ID Serii] = P.[ID serii]
	JOIN Autorzy A ON A.[ID Autora] = P.[ID autora]
	JOIN Wydawcy W ON W.[ID wydawcy] = P.[ID wydawcy]
	WHERE S.[Nazwa] = @seria

)
GO

-- przykładowe wywołanie funkcji (wypisanie informacji o pozycjach z serii 'The Green Bone Saga' ):
SELECT * FROM dbo.wyswietl_wszystkie_pozycje_serii('The Green Bone Saga')


IF OBJECT_ID('dbo.wyswietl_zamowienia_klienta') IS NOT NULL
DROP FUNCTION dbo.wyswietl_zamowienia_klienta

--DODAC WYSWIETLENIE ADRESOW/PKT ODBIORU JAK JUZ TABELKI BEDA SKONCZONE

--funkcja wyswietlajaca informacje o wszystkich zamowieniach klienta, ktorego ID jest dane argumentem 
GO
CREATE FUNCTION dbo.wyswietl_zamowienia_klienta(@ID AS INT)
RETURNS TABLE AS 
RETURN (

	SELECT  Z.[ID zamowienia], Z.[Data i czas zamownienia], Z.[Status wysylki], Z.[Data wysylki], Z.[Metoda wysylki], CAST(SUM(Cena * (1 - Obnizka) ) AS MONEY ) AS Kwota
	FROM [Klienci] K
	JOIN Zamowienia Z ON K.[ID Klienta] = Z.[ID klienta]
	JOIN [Szczegoly Zamowien] SZ ON Z.[ID zamowienia] = SZ.[ID zamowienia]	
	WHERE K.[ID Klienta] = @ID
	GROUP BY SZ.[ID zamowienia], Z.[ID zamowienia], Z.[Data i czas zamownienia], Z.[Status wysylki], Z.[Data wysylki], Z.[Metoda wysylki]
)
GO

-- przykładowe wywołanie funkcji (wypisanie informacji o zamowienia klienta o ID = 1):
SELECT * FROM dbo.wyswietl_zamowienia_klienta(1)

