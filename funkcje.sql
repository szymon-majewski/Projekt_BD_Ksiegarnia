IF OBJECT_ID('dbo.wyswietl_wszystkie_pozycje_kategorii') IS NOT NULL
DROP FUNCTION dbo.wyswietl_wszystkie_pozycje_kategorii

--funkcja wyswietlajaca informacje o pozycjach z kategorii danej argumentem
GO
CREATE FUNCTION dbo.wyswietl_wszystkie_pozycje_kategorii(@kategoria AS NVARCHAR(50)) 
RETURNS TABLE AS 
RETURN (

	SELECT P.Tytul, CONCAT( O.Imie, ' ', O.Nazwisko ) AS [Autor], P.[Czesc serii], P.Jezyk, P.[Jezyk oryginalu], W.Nazwa AS [Wydawca], P.[Data wydania],
			P.Oprawa, P.Wymiary, P.[Liczba stron], P.Cena, P.Opis
	FROM [Kategorie ksiazek] K 
	JOIN Produkty P ON K.[ID kategorii] = P.[ID kategorii]
	JOIN Autorzy A ON A.[ID Autora] = P.[ID autora]
	JOIN Osoby O ON O.[ID Osoby] = A.[ID Autora]
	JOIN Wydawcy W ON W.[ID wydawcy] = P.[ID wydawcy]
	WHERE K.[Nazwa] = @kategoria
)
GO

-- przykładowe wywołanie funkcji (wypisanie informacji o pozycjach z kategorii 'fantastyka' ):
SELECT * FROM dbo.wyswietl_wszystkie_pozycje_kategorii('fantastyka')

--------------------------------------------------------------------------------------------------------------------------------------------------

IF OBJECT_ID('dbo.wyswietl_wszystkie_pozycje_serii') IS NOT NULL
DROP FUNCTION dbo.wyswietl_wszystkie_pozycje_serii

--funkcja wyswietlajaca szczegoly ksiazek nalezacych do serii danej argumentem
GO
CREATE FUNCTION dbo.wyswietl_wszystkie_pozycje_serii(@seria AS NVARCHAR(300))
RETURNS TABLE AS 
RETURN (

	SELECT P.Tytul, CONCAT( O.Imie, ' ', O.Nazwisko ) AS [Autor], P.[Czesc serii], P.Jezyk, P.[Jezyk oryginalu], W.Nazwa AS [Wydawca], P.[Data wydania],
			P.Oprawa, P.Wymiary, P.[Liczba stron], P.Cena, P.Opis
	FROM [Serie] S
	JOIN Produkty P ON S.[ID Serii] = P.[ID serii]
	JOIN Autorzy A ON A.[ID Autora] = P.[ID autora]
	JOIN Osoby O ON O.[ID Osoby] = A.[ID Autora]
	JOIN Wydawcy W ON W.[ID wydawcy] = P.[ID wydawcy]
	WHERE S.[Nazwa] = @seria

)
GO

-- przykładowe wywołanie funkcji (wypisanie informacji o pozycjach z serii 'The Green Bone Saga' ):
SELECT * FROM dbo.wyswietl_wszystkie_pozycje_serii('The Green Bone Saga')

--------------------------------------------------------------------------------------------------------------------------------------------------

IF OBJECT_ID('dbo.wyswietl_zamowienia_klienta') IS NOT NULL
DROP FUNCTION dbo.wyswietl_zamowienia_klienta

--funkcja wyswietlajaca informacje o wszystkich zamowieniach klienta, ktorego ID jest dane argumentem 
GO
CREATE FUNCTION dbo.wyswietl_zamowienia_klienta(@ID AS INT)
RETURNS TABLE AS 
RETURN (

	SELECT  SZ.[ID zamowienia], Z.[Data i czas zamowienia], Z.[Status wysylki], Z.[Data wysylki], 
			CONCAT( Z.[Kod pocztowy], ' ', Z.[Miasto], ' ', Z.[Ulica], ' ',  Z.[Nr budynku], ' ', Z.[Nr lokalu]) AS Adres,
			OW.[Typ] AS [Metoda wysylki], ISNULL(PO.[Nazwa],'')  AS [Punkt odbioru], 
			CONCAT( PO.[Kod pocztowy], ' ', PO.[Miasto], ' ', PO.[Ulica], ' ',  PO.[Nr budynku]) AS [Adres Punktu Odbioru],
			CAST(SUM( ( SZ.Cena * (1 - Obnizka) ) + OW.Cena  ) AS MONEY ) AS Kwota
	FROM [Klienci] K
	JOIN Zamowienia Z ON K.[ID Klienta] = Z.[ID klienta]
	JOIN [Szczegoly Zamowien] SZ ON Z.[ID zamowienia] = SZ.[ID zamowienia]	
	LEFT JOIN [Punkty odbioru] PO ON PO.[ID punktu] = Z.[ID punktu odbioru]
	LEFT JOIN [Opcje wysylki] OW ON OW.[ID opcji] = Z.[Metoda wysylki]
	WHERE K.[ID Klienta] = @ID
	GROUP BY SZ.[ID zamowienia], Z.[Data i czas zamowienia], Z.[Status wysylki], Z.[Data wysylki],
			 Z.[Miasto], Z.[Ulica], Z.[Nr budynku], Z.[Nr lokalu], Z.[Kod pocztowy], OW.Typ, PO.[Nazwa], 
			 PO.[Miasto], PO.[Ulica], PO.[Nr budynku], PO.[Kod pocztowy], OW.Cena
)
GO

-- przykładowe wywołanie funkcji (wypisanie informacji o zamowieniach klienta o ID = 4):
SELECT * FROM dbo.wyswietl_zamowienia_klienta(4)

