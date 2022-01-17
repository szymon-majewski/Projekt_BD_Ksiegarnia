IF OBJECT_ID ( 'produkty_przecenione') IS NOT NULL
	DROP VIEW produkty_przecenione;

--widok wyświetlający wszystkie produkty przecenione
GO
CREATE VIEW produkty_przecenione AS
SELECT * FROM Produkty
WHERE Obnizka > 0;

----------------------------------------------------


