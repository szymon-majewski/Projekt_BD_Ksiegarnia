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


