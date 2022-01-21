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

IF OBJECT_ID ( 'zapotrzebowanie_pracownikow') IS NOT NULL
	DROP VIEW zapotrzebowanie_pracownikow;

--widok wyświetlający obecne zapotrzebowanie na pracownikow
--cos bez sensu troche ten widok
GO
CREATE VIEW zapotrzebowanie_pracownikow AS
SELECT * FROM [Zapotrzebowanie Na Pracownikow] Z
WHERE [Ilosc Potrzebnych Pracownikow] > [Ilosc Zatrudnionych Pracownikow];
 

