CREATE TABLE Adresy (
[ID adresu] INT IDENTITY(1,1) PRIMARY KEY,
Miasto NVARCHAR(50) NOT NULL,
Ulica NVARCHAR(50) NOT NULL,
[Nr budynku] INT NOT NULL,
[Nr lokalu] INT,
[Kod pocztowy] NVARCHAR(10) NOT NULL
); 

--Stworzenie tabeli Firmy Wysylkowe
CREATE TABLE [Firmy Wysylkowe] (
[ID Firmy] INT IDENTITY(1, 1) PRIMARY KEY,
[Nazwa Firmy] NVARCHAR(100) UNIQUE NOT NULL,
[ID Adresu] INT, --on delete cascade
Telefon INT,
[E-mail] NVARCHAR(255) UNIQUE NOT NULL,
[Imie przedstawiciela] NVARCHAR(50) NOT NULL,
[Nazwisko przedstawiciela] NVARCHAR(50) NOT NULL,
[Telefon przedstawiciela] INT,
[E-mail przedstawiciela] NVARCHAR(255) NOT NULL,
  
FOREIGN KEY ([ID Adresu]) REFERENCES Adresy([ID Adresu])
);

--Stworzenie tabeli Autorzy
CREATE TABLE Autorzy (
[ID Autora] INT IDENTITY(1, 1) PRIMARY KEY,
Imie NVARCHAR(50) NOT NULL,
Nazwisko NVARCHAR(50) NOT NULL,
[Data urodzenia] DATE,
  
UNIQUE([ID Autora], Imie, Nazwisko)
);

--Stworzenie tabeli Statusy Zamowienia
CREATE TABLE [Statusy zamowienia](
[ID Statusu] INT IDENTITY(1, 1) PRIMARY KEY,
[Nazwa statusu] NVARCHAR(50) UNIQUE NOT NULL,
[Opis statusu] NVARCHAR(200) NOT NULL
);

--Stworzenie tabeli Urlopy Kategorie
CREATE TABLE [Urlopy Kategorie] (
[ID Kategorii] INT IDENTITY(1, 1) PRIMARY KEY,
Nazwa NVARCHAR(50) UNIQUE NOT NULL,
[Dopuszczalna Ilosc Dni] INT NOT NULL,
Opis NVARCHAR(150)
);

--Stworzenie tabeli Klienci Kategorie
CREATE TABLE [Klienci Kategorie] (
[ID Kategorii] INT IDENTITY(1, 1) PRIMARY KEY,
Nazwa NVARCHAR(50) UNIQUE NOT NULL,
[Minimalne Miesieczne Zakupy] SMALLMONEY,
[Maksymalne Miesieczne Zakupy] SMALLMONEY,
[Rabat] FLOAT NOT NULL,
);

--Stworzenie tabeli Serie
CREATE TABLE Serie (
[ID Serii] INT IDENTITY(1, 1) PRIMARY KEY, --on delete
Nazwa NVARCHAR(300) UNIQUE NOT NULL,
[ID Autora] INT NOT NULL,
[Ilosc Czesci Planowana] INT,
[Ilosc Czesci Wydanych] INT NOT NULL,

FOREIGN KEY ([ID Autora]) REFERENCES Autorzy([ID Autora])
);

--Stworzenie tabeli Punkty Odbioru
CREATE TABLE [Punkty Odbioru] (
[ID Punktu] INT IDENTITY(1, 1) PRIMARY KEY, --on delete
Nazwa NVARCHAR(50) UNIQUE NOT NULL,
[ID Adresu] INT NOT NULL, -- on delete
[Czynny od] TIME NOT NULL,
[Czynny do] TIME NOT NULL,
[ID Firmy] INT NOT NULL,
  
FOREIGN KEY ([ID Firmy]) REFERENCES [Firmy Wysylkowe]([ID Firmy]),
FOREIGN KEY ([ID Adresu]) REFERENCES Adresy([ID Adresu])
);

--Stworzenie tabeli Klienci
CREATE TABLE Klienci (
[ID Klienta] INT IDENTITY(1, 1) PRIMARY KEY,
[ID Kategorii] INT NOT NULL,
Imie NVARCHAR(50) NOT NULL,
Nazwisko NVARCHAR(50) NOT NULL,
[Nazwa Konta] NVARCHAR(50) UNIQUE NOT NULL,
[Haslo Do Konta] NVARCHAR(50) NOT NULL,
[ID Adresu] INT, --on delete cascade
Telefon INT NOT NULL,
[E-mail] NVARCHAR(255),
  
FOREIGN KEY ([ID Kategorii]) REFERENCES [Klienci Kategorie]([ID Kategorii]),
FOREIGN KEY ([ID Adresu]) REFERENCES Adresy([ID Adresu])
);

ALTER TABLE Klienci               --haslo co najmniej 8 znakow
ADD CONSTRAINT CK2_Klienci CHECK ( LEN([Haslo do konta]) >= 8 ) 

--Stworzenie tabeli Opcje Wysylki
CREATE TABLE [Opcje Wysylki] (
[ID Opcji] INT IDENTITY(1, 1),
[ID Firmy] INT NOT NULL, --on delete
Typ NVARCHAR(50) NOT NULL,
Cena SMALLMONEY NOT NULL,
  
FOREIGN KEY ([ID Firmy]) REFERENCES [Firmy Wysylkowe]([ID Firmy]),
PRIMARY KEY([ID Firmy], Typ)
);

--Stworzenie tabeli Zmiany
CREATE TABLE Zmiany (
[ID Zmiany] INT IDENTITY(1, 1) PRIMARY KEY,
[Godzina Rozpoczecia] TIME NOT NULL,
[Godzina Zakonczenia] TIME NOT NULL,
Dzien NVARCHAR(20) NOT NULL
);

--Stworzenie tabeli Stanowiska
CREATE TABLE Stanowiska (
[ID stanowiska] INT IDENTITY(1,1) PRIMARY KEY,
Nazwa NVARCHAR(50) NOT NULL UNIQUE,
Obowiazki NVARCHAR(200),
Kwalifikacje NVARCHAR(200)
)

--Stworzenie tabeli Pracownicy
CREATE TABLE Pracownicy (
[ID pracownika] INT PRIMARY KEY,
Imie NVARCHAR(50) NOT NULL,
Nazwisko NVARCHAR(50) NOT NULL,
[ID przelozonego] INT,
[ID stanowiska] INT NOT NULL, --on delete
Pensja MONEY NOT NULL

FOREIGN KEY ([ID stanowiska]) REFERENCES Stanowiska([ID Stanowiska])
);

--Stworzenie tabeli Urlopy
CREATE TABLE Urlopy (
[ID pracownika] INT, --on delete
[ID kategorii] INT, --on delete
[Data od] DATE,
[Data do] DATE NOT NULL,

PRIMARY KEY ([ID pracownika], [Data od]),
FOREIGN KEY ([ID pracownika]) REFERENCES Pracownicy([ID pracownika]),
FOREIGN KEY ([ID kategorii]) REFERENCES [Urlopy Kategorie]([ID Kategorii])
);

--Stworzenie tabeli Historia Pensji
CREATE TABLE [Historia Pensji] (
[ID pracownika] INT, --on derlete
[Data zmiany pensji] DATE,
[Poprzednia pensja] MONEY NOT NULL,

PRIMARY KEY ([ID pracownika], [Data zmiany pensji]),
FOREIGN KEY ([ID pracownika]) REFERENCES Pracownicy([ID pracownika])
);

--Stworzenie tabeli Historia Zatrudnien
CREATE TABLE [Historia Zatrudnien] (
[ID pracownika] INT, --on delete
[Data zatrudnienia na stanowisku] DATE NOT NULL,
Stanowisko INT NOT NULL, 
[Data zwolnienia] DATE,

PRIMARY KEY ([ID pracownika], [Data zatrudnienia]),
FOREIGN KEY ([ID pracownika]) REFERENCES Pracownicy([ID pracownika])
);

--Stworzenie tabeli Zamowienia
CREATE TABLE Zamowienia ( --on delety
[ID zamowienia] INT IDENTITY(1,1) PRIMARY KEY,
[ID klienta] INT NOT NULL,
[Data i czas zamowienia] DATETIME NOT NULL,
[Status wysylki] INT NOT NULL,
[Data wysylki] DATE,
[ID adresu] INT,
[Metoda wysylki] INT,
[ID punktu odbioru] INT,

FOREIGN KEY ([ID adresu]) REFERENCES Adresy([ID adresu]),
FOREIGN KEY ([Metoda wysylki]) REFERENCES [Opcje wysylki]([ID Opcji]),
FOREIGN KEY ([Status wysylki]) REFERENCES [Statusy zamowienia]([ID Statusu]),
FOREIGN KEY ([ID klienta]) REFERENCES Klienci([ID klienta]),
FOREIGN KEY ([ID punktu odbioru]) REFERENCES [Punkty odbioru]([ID punktu]),
);

--Stworzenie tabeli Kategorie Ksiazek
CREATE TABLE [Kategorie ksiazek] (
[ID kategorii] INT IDENTITY(1,1) PRIMARY KEY,
Nazwa NVARCHAR(50) UNIQUE NOT NULL,
);

--Stworzenie tabeli Wydawcy
CREATE TABLE Wydawcy (
[ID wydawcy] INT IDENTITY(1,1) PRIMARY KEY,
Nazwa NVARCHAR(50) UNIQUE NOT NULL,
[ID adresu] INT,

FOREIGN KEY ([ID adresu]) REFERENCES Adresy([ID adresu])
);

--Stworzenie tabeli Produkty
CREATE TABLE Produkty ( --on delte cascade dodac
[ID produktu] INT IDENTITY (1,1) PRIMARY KEY,
ISBN13 BIGINT UNIQUE NOT NULL,
[ID kategorii] INT NOT NULL,
Tytul NVARCHAR(50) NOT NULL,
[ID autora] INT NOT NULL,
[ID serii] INT,
[Czesc serii] INT,
Jezyk NVARCHAR(50) NOT NULL,
[Jezyk oryginalu] NVARCHAR(50), 
[ID wydawcy] INT NOT NULL,
[Data wydania] DATE,
[Oprawa] NVARCHAR(50),
Wymiary NVARCHAR(50),
[Liczba stron] INT,
[Ilosc w magazynie] INT NOT NULL,
Cena SMALLMONEY NOT NULL,
Opis NVARCHAR(1000),

FOREIGN KEY ([ID kategorii]) REFERENCES [Kategorie ksiazek]([ID kategorii]),
FOREIGN KEY ([ID autora]) REFERENCES Autorzy([ID autora]),
FOREIGN KEY ([ID serii]) REFERENCES Serie([ID serii]),
FOREIGN KEY ([ID wydawcy]) REFERENCES Wydawcy([ID wydawcy])
);

--Stworzenie tabeli Szczegoly Zamowien
CREATE TABLE [Szczegoly Zamowien] ( --on delete
[ID zamowienia] INT,
[ID produktu] INT,
Cena SMALLMONEY NOT NULL,
Ilosc INT NOT NULL,
Obnizka REAL NOT NULL,	

PRIMARY KEY ([ID zamowienia], [ID produktu]),
FOREIGN KEY ([ID zamowienia]) REFERENCES Zamowienia([ID zamowienia]),
FOREIGN KEY ([ID produktu]) REFERENCES Produkty([ID produktu])
);

--Stworzenie tabeli Grafik Zmian
CREATE TABLE [Grafik Zmian] (-on delete
[ID Zmiany] INT,
[ID Pracownika] INT,
[Data] DATE NOT NULL,
  
FOREIGN KEY ([ID Pracownika]) REFERENCES Pracownicy([ID Pracownika]),
FOREIGN KEY ([ID Zmiany]) REFERENCES Zmiany([ID Zmiany]),
PRIMARY KEY ([ID Zmiany], [ID Pracownika], [Data Rozpoczecia])
);

--Stworzenie tabeli Zapotrzebowanie Na Pracownikow
CREATE TABLE [Zapotrzebowanie Na Pracownikow] ( 
[ID Stanowiska] INT PRIMARY KEY, --on delete
[Ilosc Potrzebnych Pracownikow] INT NOT NULL,
[Ilosc Zatrudnionych Pracownikow] INT NOT NULL,
  
FOREIGN KEY ([ID Stanowiska]) REFERENCES Stanowiska([ID Stanowiska]),
);

--Stworzenie tabeli Opinie Klientow
CREATE TABLE [Opinie Klientow] (--on delete
[ID Produktu] INT,
[ID Klienta] INT,
Data DATETIME,
Tresc NVARCHAR(500),
Ocena INT NOT NULL,
  
FOREIGN KEY ([ID produktu]) REFERENCES Produkty([ID produktu]),
FOREIGN KEY ([ID Klienta]) REFERENCES Klienci([ID Klienta]),
PRIMARY KEY ([ID Pracownika], [ID Klienta], Data)
);

