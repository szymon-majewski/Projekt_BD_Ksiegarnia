CREATE TABLE Adresy (
[ID adresu] INT IDENTITY(1,1) PRIMARY KEY,
Miasto NVARCHAR(50) NOT NULL,
Ulica NVARCHAR(50) NOT NULL,
[Nr lokalu] INT NOT NULL,
[Kod pocztowy] NVARCHAR(10)
);

CREATE TABLE [Firmy Wysylkowe] (
[ID Firmy] INT IDENTITY(1, 1) PRIMARY KEY,
[Nazwa Firmy] NVARCHAR(50) NOT NULL,
[ID Adresu] INT,
Telefon INT,
Email NVARCHAR(50) UNIQUE NOT NULL,
[Dane przedstawiciela] NVARCHAR(100),
FOREIGN KEY ([ID Adresu]) REFERENCES Adresy([ID Adresu])
);


CREATE TABLE Autorzy (
[ID Autora] INT IDENTITY(1, 1) PRIMARY KEY,
Imie NVARCHAR(50),
Nazwisko NVARCHAR(50)
);


CREATE TABLE [Urlopy Kategorie] (
[ID Kategorii] INT IDENTITY(1, 1) PRIMARY KEY,
Nazwa NVARCHAR(50) NOT NULL,
[Czy Platny] INT,
[Dopuszczalna Ilosc Dni] INT,
Opis NVARCHAR(50)
);


CREATE TABLE Rabaty (
[ID Rabatu] INT IDENTITY(1, 1) PRIMARY KEY,
Nazwa NVARCHAR(50) NOT NULL,
[Wysokosc Rabatu] FLOAT NOT NULL
);


CREATE TABLE [Klienci Kategorie] (
[ID Kategorii] INT IDENTITY(1, 1) PRIMARY KEY,
Nazwa NVARCHAR(50) NOT NULL,
[Czy Wymagagane Konto] INT,
[Dopuszczalna Ilosc Dni] INT,
Opis NVARCHAR(50),
[ID Rabatu] INT,
FOREIGN KEY ([ID Rabatu]) REFERENCES Rabaty([ID Rabatu])
);


CREATE TABLE Serie (
[ID Serii] INT IDENTITY(1, 1) PRIMARY KEY,
Nazwa NVARCHAR(50),
[Ilosc Czesci Planowana] INT,
[Ilosc Czesci Wydanych] INT
);


CREATE TABLE [Punkty Odbioru] (
[ID Punktu] INT IDENTITY(1, 1) PRIMARY KEY,
Nazwa NVARCHAR(50) NOT NULL,
[ID Adresu] INT,
[Godziny Dzialania] TIME NOT NULL,
[ID Firmy] INT NOT NULL,
FOREIGN KEY ([ID Firmy]) REFERENCES [Firmy Wysylkowe]([ID Firmy]),
FOREIGN KEY ([ID Adresu]) REFERENCES Adresy([ID Adresu])
);


CREATE TABLE Klienci (
[ID Klienta] INT IDENTITY(1, 1) PRIMARY KEY,
[ID Kategorii] INT NOT NULL,
Imie NVARCHAR(50) NOT NULL,
Nazwisko NVARCHAR(50) NOT NULL,
[Nazwa Konta] NVARCHAR(50),
[Haslo Do Konta] NVARCHAR(50),
[ID Adresu] INT,
Telefon INT,
Email NVARCHAR(50) UNIQUE NOT NULL,
FOREIGN KEY ([ID Kategorii]) REFERENCES [Klienci Kategorie]([ID Kategorii]),
FOREIGN KEY ([ID Adresu]) REFERENCES Adresy([ID Adresu])
);


CREATE TABLE [Opcje Wysylki] (
[ID Firmy] INT NOT NULL,
Typ NVARCHAR(50) NOT NULL,
Cena MONEY NOT NULL,
FOREIGN KEY ([ID Firmy]) REFERENCES [Firmy Wysylkowe]([ID Firmy]),
PRIMARY KEY([ID Firmy], Typ)
);


CREATE TABLE Zmiany (
[ID Zmiany] INT IDENTITY(1, 1) PRIMARY KEY,
[Godzina Rozpoczecia] TIME NOT NULL,
[Godzina Zakonczenia] TIME NOT NULL,
Dzien NVARCHAR(10)
);

CREATE TABLE Stanowiska (
[ID stanowiska] INT IDENTITY(1,1) PRIMARY KEY,
Nazwa NVARCHAR(50) NOT NULL UNIQUE,
Obowiazki NVARCHAR(200),
Kwalifikacje NVARCHAR(200),
[Pensja podstawowa] MONEY,
)


CREATE TABLE Pracownicy (
[ID pracownika] INT PRIMARY KEY,
Imie NVARCHAR(50) NOT NULL,
Nazwisko NVARCHAR(50) NOT NULL,
[ID przelozonego] INT,
[ID stanowiska] INT NOT NULL,
Pensja MONEY NOT NULL

FOREIGN KEY ([ID stanowiska]) REFERENCES Stanowiska([ID Stanowiska])
);

CREATE TABLE Urlopy (
[ID pracownika] INT,
[Data od] DATE,
[Data do] DATE NOT NULL,

PRIMARY KEY ([ID pracownika], [Data od]),
FOREIGN KEY ([ID pracownika]) REFERENCES Pracownicy([ID pracownika])
);

CREATE TABLE [Historia pensji] (
[ID pracownika] INT,
[Data zatrudnienia] DATE,
[Data zmiany pensji] DATE NOT NULL,

PRIMARY KEY ([ID pracownika], [Data zatrudnienia]),
FOREIGN KEY ([ID pracownika]) REFERENCES Pracownicy([ID pracownika])
);

CREATE TABLE [Historia zatrudnien] (
[ID pracownika] INT,
[Data zatrudnienia] DATE,
Stanowisko INT NOT NULL, 
[Data zwolnienia] DATE,

PRIMARY KEY ([ID pracownika], [Data zatrudnienia])
);


CREATE TABLE Zamowienia (
[ID zamowienia] INT IDENTITY(1,1) PRIMARY KEY,
[ID klienta] INT NOT NULL,
[Data zamownienia] DATE NOT NULL,
[Data wysylki] DATE,
[ID adresu] INT,
[ID pracownika] INT NOT NULL,
[ID punktu odbioru] INT,

FOREIGN KEY ([ID adresu]) REFERENCES Adresy([ID adresu]),
FOREIGN KEY ([ID pracownika]) REFERENCES Pracownicy([ID pracownika]),
FOREIGN KEY ([ID klienta]) REFERENCES Klienci([ID klienta]),
FOREIGN KEY ([ID punktu odbioru]) REFERENCES [Punkty odbioru]([ID punktu]),
);

CREATE TABLE [Kategorie ksiazek] (
[ID kategorii] INT IDENTITY(1,1) PRIMARY KEY,
Nazwa NVARCHAR(50) NOT NULL,
);

CREATE TABLE Dostawcy (
[ID dostawcy] INT IDENTITY(1,1) PRIMARY KEY,
Nazwa NVARCHAR(50) NOT NULL,
[ID adresu] INT,
Telefon INT,
[E-mail] NVARCHAR(50) NOT NULL,
[Imie przedstawiciela] NVARCHAR(50) NOT NULL,
[Nazwisko przedstawiciela] NVARCHAR(50) NOT NULL,
[Telefon przedstawiciela] INT,
[E-mail przedstawiciela] NVARCHAR(50) NOT NULL,

FOREIGN KEY ([ID adresu]) REFERENCES Adresy([ID adresu])
);


CREATE TABLE Wydawcy (
[ID wydawcy] INT IDENTITY(1,1) PRIMARY KEY,
Nazwa NVARCHAR(50) NOT NULL,
[ID adresu] INT,

FOREIGN KEY ([ID adresu]) REFERENCES Adresy([ID adresu])
);

CREATE TABLE Produkty (
[ID produktu] INT PRIMARY KEY,
[ID kategorii] INT NOT NULL,
Tytul NVARCHAR(50) NOT NULL,
[ID autora] INT NOT NULL,
[ID serii] INT,
[Czesc serii] INT,
Jezyk NVARCHAR(50) NOT NULL,
[Jezyk oryginalu] NVARCHAR(50), 
[ID wydawcy] INT NOT NULL,
ISBN13 INT NOT NULL,
[Data wydania] DATE,
[Oprawa] NVARCHAR(50),
Wymiary NVARCHAR(50),
[Liczba stron] INT,
[Ilosc w magazynie] INT NOT NULL,
[Ilosc w salonie] INT NOT NULL,
[Cena hurtowa] MONEY NOT NULL,
[Cena detaliczna] MONEY NOT NULL,

FOREIGN KEY ([ID kategorii]) REFERENCES [Kategorie ksiazek]([ID kategorii]),
FOREIGN KEY ([ID autora]) REFERENCES Autorzy([ID autora]),
FOREIGN KEY ([ID serii]) REFERENCES Serie([ID serii]),
FOREIGN KEY ([ID wydawcy]) REFERENCES Wydawcy([ID wydawcy])
);

CREATE TABLE [Szczegoly zamowien] (
[ID zamowienia] INT,
[ID produktu] INT,
Cena MONEY NOT NULL,
Ilosc INT NOT NULL,
Obnizka REAL NOT NULL,	

PRIMARY KEY ([ID zamowienia], [ID produktu]),
FOREIGN KEY ([ID zamowienia]) REFERENCES Zamowienia([ID zamowienia]),
FOREIGN KEY ([ID produktu]) REFERENCES Produkty([ID produktu])
);


CREATE TABLE [Grafik Zmian] (
[ID Zmiany] INT NOT NULL,
[ID Pracownika] INT NOT NULL,
[Data Rozpoczecia] DATETIME,
[Data Zakonczenia] DATETIME
FOREIGN KEY ([ID Pracownika]) REFERENCES Pracownicy([ID Pracownika]),
PRIMARY KEY ([ID Zmiany], [ID Pracownika], [Data Rozpoczecia])
);


CREATE TABLE [Zapotrzebowanie Na Pracownikow] (
[ID Stanowiska] INT PRIMARY KEY,
[Ilosc Potrzebnych Pracownikow] INT,
FOREIGN KEY ([ID Stanowiska]) REFERENCES Stanowiska([ID Stanowiska]),
);


CREATE TABLE [Skargi Pracownicze] (
[ID Skladajacego] INT,
[ID Oskarzonego] INT,
Data DATETIME,
Tresc NVARCHAR(500),
[Komentarz Przelozonego] NVARCHAR(200),
FOREIGN KEY ([ID Skladajacego]) REFERENCES Pracownicy([ID Pracownika]),
FOREIGN KEY ([ID Oskarzonego]) REFERENCES Pracownicy([ID Pracownika]),
PRIMARY KEY([ID Skladajacego], [ID Oskarzonego], Data)
);


CREATE TABLE [Opinie Klientow] (
[ID Pracownika] INT NOT NULL,
[ID Klienta] INT NOT NULL,
Data DATETIME,
Tresc NVARCHAR(500),
Ocena INT,
FOREIGN KEY ([ID pracownika]) REFERENCES Pracownicy([ID pracownika]),
FOREIGN KEY ([ID Klienta]) REFERENCES Klienci([ID Klienta]),
PRIMARY KEY ([ID Pracownika], [ID Klienta], Data)
);