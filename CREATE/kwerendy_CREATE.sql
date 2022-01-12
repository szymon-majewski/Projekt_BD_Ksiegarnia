CREATE TABLE Adresy (
[ID adresu] INT IDENTITY(1,1) PRIMARY KEY,
Miasto NVARCHAR(50) NOT NULL,
Ulica NVARCHAR(50) NOT NULL,
[Nr budynku] INT NOT NULL,
[Nr lokalu] INT,
[Kod pocztowy] NVARCHAR(10) NOT NULL
);

CREATE TABLE [Firmy Wysylkowe] (
[ID Firmy] INT IDENTITY(1, 1) PRIMARY KEY,
[Nazwa Firmy] NVARCHAR(100) UNIQUE NOT NULL,
[ID Adresu] INT,
Telefon INT,
[E-mail] NVARCHAR(255) UNIQUE NOT NULL,
[Imie przedstawiciela] NVARCHAR(50) NOT NULL,
[Nazwisko przedstawiciela] NVARCHAR(50) NOT NULL,
[Telefon przedstawiciela] INT,
[E-mail przedstawiciela] NVARCHAR(255) UNIQUE NOT NULL,
  
FOREIGN KEY ([ID Adresu]) REFERENCES Adresy([ID Adresu])
);


CREATE TABLE Autorzy (
[ID Autora] INT IDENTITY(1, 1) PRIMARY KEY,
Imie NVARCHAR(50) NOT NULL,
Nazwisko NVARCHAR(50) NOT NULL,
[Data urodzenia] DATE
);


CREATE TABLE [Urlopy Kategorie] (
[ID Kategorii] INT IDENTITY(1, 1) PRIMARY KEY,
Nazwa NVARCHAR(50) UNIQUE NOT NULL,
[Dopuszczalna Ilosc Dni] INT NOT NULL,
Opis NVARCHAR(150)
);


CREATE TABLE Rabaty (
[ID Rabatu] INT IDENTITY(1, 1) PRIMARY KEY,
Nazwa NVARCHAR(50) UNIQUE NOT NULL,
[Wysokosc Rabatu] FLOAT NOT NULL
);


CREATE TABLE [Klienci Kategorie] (
[ID Kategorii] INT IDENTITY(1, 1) PRIMARY KEY,
Nazwa NVARCHAR(50) UNIQUE NOT NULL,
[Minimalne Miesieczne Zakupy] MONEY,
[Maksymalne Miesieczne Zakupy] MONEY,
[ID Rabatu] INT,
  
FOREIGN KEY ([ID Rabatu]) REFERENCES Rabaty([ID Rabatu])
);


CREATE TABLE Serie (
[ID Serii] INT IDENTITY(1, 1) PRIMARY KEY,
Nazwa NVARCHAR(300) UNIQUE NOT NULL,
[ID Autora] INT NOT NULL,
[Ilosc Czesci Planowana] INT,
[Ilosc Czesci Wydanych] INT NOT NULL,

FOREIGN KEY ([ID Autora]) REFERENCES Autorzy([ID Autora])
);


CREATE TABLE [Punkty Odbioru] (
[ID Punktu] INT IDENTITY(1, 1) PRIMARY KEY,
Nazwa NVARCHAR(50) UNIQUE NOT NULL,
[ID Adresu] INT NOT NULL,
[Czynny od] TIME NOT NULL,
[Czynny do] TIME NOT NULL,
[ID Firmy] INT NOT NULL,
  
FOREIGN KEY ([ID Firmy]) REFERENCES [Firmy Wysylkowe]([ID Firmy]),
FOREIGN KEY ([ID Adresu]) REFERENCES Adresy([ID Adresu])
);


CREATE TABLE Klienci (
[ID Klienta] INT IDENTITY(1, 1) PRIMARY KEY,
[ID Kategorii] INT NOT NULL,
Imie NVARCHAR(50) NOT NULL,
Nazwisko NVARCHAR(50) NOT NULL,
[Nazwa Konta] NVARCHAR(50) UNIQUE,
[Haslo Do Konta] NVARCHAR(50),
[ID Adresu] INT,
Telefon INT,
[E-mail] NVARCHAR(255),
  
FOREIGN KEY ([ID Kategorii]) REFERENCES [Klienci Kategorie]([ID Kategorii]),
FOREIGN KEY ([ID Adresu]) REFERENCES Adresy([ID Adresu])
);

ALTER TABLE Klienci               --nie mozna zalozyc konta bez hasla i e-mailu
ADD CONSTRAINT CK1_Klienci 
CHECK ( ([E-mail] IS NOT NULL AND [Nazwa konta] IS NOT NULL AND [Haslo Do Konta] IS NOT NULL ) OR [Nazwa konta] IS NULL )

ALTER TABLE Klienci               --haslo co najmniej 8 znakow
ADD CONSTRAINT CK2_Klienci CHECK ( [Haslo do konta] >= 8 )


CREATE TABLE [Opcje Wysylki] (
[ID Opcji] INT IDENTITY(1, 1), --dodalam aby stworzyc tu jakis sens, dodac do zmowien
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
Dzien NVARCHAR(10) NOT NULL
);

CREATE TABLE Stanowiska (
[ID stanowiska] INT IDENTITY(1,1) PRIMARY KEY,
Nazwa NVARCHAR(50) NOT NULL UNIQUE,
Obowiazki NVARCHAR(200),
Kwalifikacje NVARCHAR(200)
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
[ID kategorii] INT,
[Data od] DATE,
[Data do] DATE NOT NULL,

PRIMARY KEY ([ID pracownika], [Data od]),
FOREIGN KEY ([ID pracownika]) REFERENCES Pracownicy([ID pracownika]),
FOREIGN KEY ([ID kategorii]) REFERENCES [Urlopy Kategorie]([ID Kategorii])
);

CREATE TABLE [Historia pensji] (
[ID pracownika] INT,
[Data zatrudnienia] DATE NOT NULL,
[Data zmiany pensji] DATE NOT NULL,

PRIMARY KEY ([ID pracownika], [Data zatrudnienia]),
FOREIGN KEY ([ID pracownika]) REFERENCES Pracownicy([ID pracownika])
);

CREATE TABLE [Historia zatrudnien] (
[ID pracownika] INT,
[Data zatrudnienia] DATE NOT NULL,
Stanowisko INT NOT NULL, 
[Data zwolnienia] DATE,

PRIMARY KEY ([ID pracownika], [Data zatrudnienia]),
FOREIGN KEY ([ID pracownika]) REFERENCES Pracownicy([ID pracownika])
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
Nazwa NVARCHAR(50) UNIQUE NOT NULL,
);

CREATE TABLE Dostawcy (
[ID dostawcy] INT IDENTITY(1,1) PRIMARY KEY,
Nazwa NVARCHAR(50) UNIQUE NOT NULL,
[ID adresu] INT,
Telefon INT,
[E-mail] NVARCHAR(255) UNIQUE NOT NULL,
[Imie przedstawiciela] NVARCHAR(50) NOT NULL,
[Nazwisko przedstawiciela] NVARCHAR(50) NOT NULL,
[Telefon przedstawiciela] INT,
[E-mail przedstawiciela]  NVARCHAR(255) UNIQUE NOT NULL,

FOREIGN KEY ([ID adresu]) REFERENCES Adresy([ID adresu])
);


CREATE TABLE Wydawcy (
[ID wydawcy] INT IDENTITY(1,1) PRIMARY KEY,
Nazwa NVARCHAR(50) UNIQUE NOT NULL,
[ID adresu] INT,

FOREIGN KEY ([ID adresu]) REFERENCES Adresy([ID adresu])
);

CREATE TABLE Produkty (
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
[Ilosc w salonie] INT NOT NULL,
Cena MONEY NOT NULL,
Opis NVARCHAR(1000),

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
[ID Zmiany] INT,
[ID Pracownika] INT,
[Data Rozpoczecia] DATETIME,
[Data Zakonczenia] DATETIME NOT NULL,
  
FOREIGN KEY ([ID Pracownika]) REFERENCES Pracownicy([ID Pracownika]),
FOREIGN KEY ([ID Zmiany]) REFERENCES Zmiany([ID Zmiany]),
PRIMARY KEY ([ID Zmiany], [ID Pracownika], [Data Rozpoczecia])
);


CREATE TABLE [Zapotrzebowanie Na Pracownikow] ( 
--powinno być zapotrzebowanie na pracowników na danej zmianie inaczej nie ma sensu,
--ale idk jak to ogranąc z pk wtedy
[ID Stanowiska] INT PRIMARY KEY,
[Ilosc Potrzebnych Pracownikow] INT NOT NULL,
  
FOREIGN KEY ([ID Stanowiska]) REFERENCES Stanowiska([ID Stanowiska]),
);


CREATE TABLE [Skargi Pracownicze] (
[ID Skladajacego] INT,
[ID Oskarzonego] INT,
Data DATETIME,
Tresc NVARCHAR(500) NOT NULL,
[Komentarz Przelozonego] NVARCHAR(200),
  
FOREIGN KEY ([ID Skladajacego]) REFERENCES Pracownicy([ID Pracownika]),
FOREIGN KEY ([ID Oskarzonego]) REFERENCES Pracownicy([ID Pracownika]),
PRIMARY KEY([ID Skladajacego], [ID Oskarzonego], Data)
);


CREATE TABLE [Opinie Klientow] (
[ID Pracownika] INT,
[ID Klienta] INT,
Data DATETIME,
Tresc NVARCHAR(500),
Ocena INT NOT NULL,
  
FOREIGN KEY ([ID pracownika]) REFERENCES Pracownicy([ID pracownika]),
FOREIGN KEY ([ID Klienta]) REFERENCES Klienci([ID Klienta]),
PRIMARY KEY ([ID Pracownika], [ID Klienta], Data)
);
