ALTER TABLE Klienci 
DROP CONSTRAINT CK1_Klienci

ALTER TABLE Klienci 
DROP CONSTRAINT CK2_Klienci

IF OBJECT_ID('Statusy zamowienia') IS NOT NULL 
	DROP TABLE [Statusy zamowienia];

IF OBJECT_ID('Urlopy') IS NOT NULL 
	DROP TABLE Urlopy;

IF OBJECT_ID('Urlopy kategorie') IS NOT NULL 
	DROP TABLE [Urlopy kategorie];

IF OBJECT_ID('Historia pensji') IS NOT NULL 
	DROP TABLE [Historia pensji];

IF OBJECT_ID('Grafik zmian') IS NOT NULL 
	DROP TABLE [Grafik zmian];

IF OBJECT_ID('Zmiany') IS NOT NULL 
	DROP TABLE Zmiany;

IF OBJECT_ID('Historia zatrudnien') IS NOT NULL 
	DROP TABLE [Historia zatrudnien];

IF OBJECT_ID('Zapotrzebowanie Na Pracownikow') IS NOT NULL 
	DROP TABLE [Zapotrzebowanie Na Pracownikow];

IF OBJECT_ID('Opinie klientow') IS NOT NULL 
	DROP TABLE [Opinie klientow];

IF OBJECT_ID('Szczegoly zamowien') IS NOT NULL 
	DROP TABLE [Szczegoly zamowien];

IF OBJECT_ID('Zamowienia') IS NOT NULL 
	DROP TABLE Zamowienia;

IF OBJECT_ID('Statusy Zamowienia') IS NOT NULL 
	DROP TABLE [Statusy Zamowienia];

IF OBJECT_ID('Punkty odbioru') IS NOT NULL 
	DROP TABLE [Punkty odbioru];

IF OBJECT_ID('Produkty') IS NOT NULL 
	DROP TABLE Produkty;

IF OBJECT_ID('Serie') IS NOT NULL 
	DROP TABLE Serie;

IF OBJECT_ID('Autorzy') IS NOT NULL 
	DROP TABLE Autorzy;

IF OBJECT_ID('Kategorie ksiazek') IS NOT NULL 
	DROP TABLE [Kategorie ksiazek];

IF OBJECT_ID('Wydawcy') IS NOT NULL 
	DROP TABLE Wydawcy;

IF OBJECT_ID('Opcje wysylki') IS NOT NULL 
	DROP TABLE [Opcje wysylki];

IF OBJECT_ID('Firmy wysylkowe') IS NOT NULL 
	DROP TABLE [Firmy wysylkowe];

IF OBJECT_ID('Klienci') IS NOT NULL 
	DROP TABLE Klienci;

IF OBJECT_ID('Klienci Kategorie') IS NOT NULL 
	DROP TABLE [Klienci Kategorie];

IF OBJECT_ID('Rabaty') IS NOT NULL 
	DROP TABLE Rabaty;

IF OBJECT_ID('Pracownicy') IS NOT NULL 
	DROP TABLE Pracownicy;

IF OBJECT_ID('Stanowiska') IS NOT NULL 
	DROP TABLE Stanowiska;

IF OBJECT_ID('Adresy') IS NOT NULL 
	DROP TABLE Adresy;
