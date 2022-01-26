IF OBJECT_ID ( 'produkty_przecenione') IS NOT NULL
	DROP VIEW produkty_przecenione;

--widok wyświetlający wszystkie produkty przecenione
GO
CREATE VIEW produkty_przecenione AS
SELECT * FROM Produkty
WHERE Obnizka > 0;

----------------------------------------------------

IF OBJECT_ID ( 'zamownienia_realizowane') IS NOT NULL
	DROP VIEW zamownienia_realizowane;

--widok wyświetlający wszystkie zamowienia ktore sa obencie w realizacji

GO
CREATE VIEW zamownienia_realizowane AS --realizowane to przyjete, oplacone i niewyslane imo
SELECT * FROM Zamowienia Z
	LEFT JOIN [Statusy zamowienia] S ON S.[ID Statusu] = Z.[Status wysylki]
WHERE [Nazwa statusu] = N'oplacono' OR [Nazwa statusu] = N'do wyslania';

-------------------

IF OBJECT_ID ( 'pracownicy_obslugii_klienta') IS NOT NULL
	DROP VIEW pracownicy_obslugii_klienta;

--widok wyświetlający wszytkich pracownikow obslugii klienta
GO
CREATE VIEW pracownicy_obslugii_klienta AS
SELECT * FROM Pracownicy P
	LEFT JOIN Osoby O ON O.[ID osoby] = P.[ID pracownika]
WHERE [ID stanowiska] IN 
(SELECT [ID stanowiska] FROM Stanowiska
WHERE Nazwa = 'Pracownik Obslugi Klienta');

-------------------

IF OBJECT_ID ( 'zapotrzebowanie_pracownikow') IS NOT NULL
	DROP VIEW zapotrzebowanie_pracownikow;

--widok wyświetlający obecne zapotrzebowanie na pracownikow
--cos bez sensu troche ten widok
GO
CREATE VIEW zapotrzebowanie_pracownikow AS
SELECT * FROM [Zapotrzebowanie Na Pracownikow] Z
WHERE [Ilosc Potrzebnych Pracownikow] > [Ilosc Zatrudnionych Pracownikow];
 
 -------------------
 
 IF OBJECT_ID ( 'hierarchia_pracownikow') IS NOT NULL
	DROP VIEW hierarchia_pracownikow;

-- widok wyświetlający hierarchie pracownikow
GO
CREATE VIEW hierarchia_pracownikow AS
SELECT O2.Imie AS  [Imie pracowinka], O2.Nazwisko AS  [Nazwisko pracowinka], S2.Nazwa AS [Stanowisko pracowinka], S2.Obowiazki  AS [Obowiazki pracowinka],
O1.Imie AS [Imie przelozonego], O1.Nazwisko AS  [Nazwisko przelozonego], S1.Nazwa AS [Stanowisko przelozonego],
P2.[ID pracownika] AS [ID pracownika], P1.[ID pracownika] AS [ID przelozonego]
FROM Pracownicy AS P1
 JOIN Pracownicy AS P2 ON P2.[ID przelozonego] = P1.[ID pracownika]
 JOIN Osoby AS O1 ON O1.[ID osoby] = P1.[ID pracownika]
 JOIN Osoby AS O2 ON O2.[ID osoby] = P2.[ID pracownika]
 JOIN Stanowiska AS S2 ON S2.[ID stanowiska] = P2.[ID stanowiska]
 JOIN Stanowiska AS S1 ON S1.[ID stanowiska] = P1.[ID stanowiska]
GO

/*
--testowanie dzialania
SELECT * FROM hierarchia_pracownikow;
SELECT * FROM Pracownicy;
SELECT * FROM Osoby;
SELECT * FROM Stanowiska;
*/

-------------------
