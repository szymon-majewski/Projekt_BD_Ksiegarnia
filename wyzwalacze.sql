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
