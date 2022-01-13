CREATE TABLE Adresy (
[ID adresu] INT IDENTITY(1,1) PRIMARY KEY,
Miasto NVARCHAR(50) NOT NULL,
Ulica NVARCHAR(50) NOT NULL,
[Nr budynku] INT NOT NULL,
[Nr lokalu] INT,
[Kod pocztowy] NVARCHAR(10) NOT NULL
); -- mam tu lekkie watpliwosci, co do wrzucania tak bulkowo wszytskich adresow (klientow, wydawcow, punktow odbioru)
--jednak moze byc wielu przedstawicili tabelka prezdstawicile by sie przydala, (wtedy do kazdego wyslanego zmowienia dodamy przedstawiciela odpowiedzilanego za paczke aby ja zwrocic w przypadku anulowania zaowienia)
CREATE TABLE [Firmy Wysylkowe] (
[ID Firmy] INT IDENTITY(1, 1) PRIMARY KEY,
[Nazwa Firmy] NVARCHAR(100) UNIQUE NOT NULL,
[ID Adresu] INT,
Telefon INT,
[E-mail] NVARCHAR(255) UNIQUE NOT NULL,
[Imie przedstawiciela] NVARCHAR(50) NOT NULL,
[Nazwisko przedstawiciela] NVARCHAR(50) NOT NULL,
[Telefon przedstawiciela] INT,
[E-mail przedstawiciela] NVARCHAR(255) NOT NULL,
  
FOREIGN KEY ([ID Adresu]) REFERENCES Adresy([ID Adresu])
);


CREATE TABLE Autorzy (
[ID Autora] INT IDENTITY(1, 1) PRIMARY KEY,
Imie NVARCHAR(50) NOT NULL,
Nazwisko NVARCHAR(50) NOT NULL,
[Data urodzenia] DATE
);

--potrzebujemy jeszce czegos co bedzie okreslac hierarchie statusów zamówień (ze np. po anulowania zamownienia nastepuje zwrot pieniedzy itd.)
--ostatecznie moze to byc tabelka dodatkowa ale to dosc slabe (chcodzi tutaj o wzorzec triggerow jakby, w momencie w ktory zamowinie zostaje anulowe, sprawdzamy czy zostalo oplacone,
jesli tak zwracamy pieniadze, czy zostalo nadane wyslane itp. pracownik kontaktuje sie z forma wylkowa - pracownik powinien dosatc alert, o jakby zrobic tabele 'wiadomosci systemowych',
ktora wysyla konkretne uwagi komendy itp do pracownikow, byloby tu fajnie widoczne dzialnie bazy. !! bardzo mocno proponuje to zrobic
CREATE TABLE [Statusy zamowienia](
[ID Statusu] INT IDENTITY(1, 1) PRIMARY KEY,
[Nazwa statusu] NVARCHAR(50) UNIQUE NOT NULL,
[Opis statusu] NVARCHAR(200) NOT NULL
);


CREATE TABLE [Urlopy Kategorie] (
[ID Kategorii] INT IDENTITY(1, 1) PRIMARY KEY,
Nazwa NVARCHAR(50) UNIQUE NOT NULL,
[Dopuszczalna Ilosc Dni] INT NOT NULL,
Opis NVARCHAR(150)
);

-- proponuje polaczenie rabatow z klienci kategorie (kazdej kategorii i tak przysluguje jedne rabat, tak wlasciwnie bullshito tabelka, chyba, zeby udalo sie nam zaklepac ze na wszytkie zamownia np. w okresie 
swiatecznym jest rabat swiateczny itp. + moznaby porobic jakie sindywidualne rabty z okazji urodzin klientow zarejestrowanych - wtedy pytamy ich o date urodzenia, rabat automatucznie wskauje w tygodiu urodzin czy cos)
CREATE TABLE Rabaty (
[ID Rabatu] INT IDENTITY(1, 1) PRIMARY KEY,
Nazwa NVARCHAR(50) UNIQUE NOT NULL,
[Wysokosc Rabatu] FLOAT NOT NULL
);
CREATE TABLE [Klienci Kategorie] (
[ID Kategorii] INT IDENTITY(1, 1) PRIMARY KEY,
Nazwa NVARCHAR(50) UNIQUE NOT NULL,
[Minimalne Miesieczne Zakupy] SMALLMONEY,
[Maksymalne Miesieczne Zakupy] SMALLMONEY,
[ID Rabatu] INT,
  
FOREIGN KEY ([ID Rabatu]) REFERENCES Rabaty([ID Rabatu])
);


--update gdy nowa ksiazka w serii wychodzi do liczby liczby ksiazek wydanych
--uodate tez do liczby ksiazek planowanych
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

--nie wiem do konca w jaki sposob mozemy rozwiazac sprawe klientow anonimowych, chyba ze sa anonimowi tylko z nazwy i z tego ze nie zakldaja konta, dalej 
potrzebne ich imie nazwisko telefon mail
CREATE TABLE Klienci (
[ID Klienta] INT IDENTITY(1, 1) PRIMARY KEY,
[ID Kategorii] INT NOT NULL,
Imie NVARCHAR(50),
Nazwisko NVARCHAR(50),
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
ADD CONSTRAINT CK2_Klienci CHECK ( LEN([Haslo do konta]) >= 8 ) --wywala prownanie do inta


CREATE TABLE [Opcje Wysylki] (
[ID Opcji] INT IDENTITY(1, 1), --dodalam aby stworzyc tu jakis sens, dodac do zmowien
[ID Firmy] INT NOT NULL,
Typ NVARCHAR(50) NOT NULL,
Cena SMALLMONEY NOT NULL,
  
FOREIGN KEY ([ID Firmy]) REFERENCES [Firmy Wysylkowe]([ID Firmy]),
PRIMARY KEY([ID Firmy], Typ)
);

--automatyczne ukladanie harmonogramu jakos?
CREATE TABLE Zmiany (
[ID Zmiany] INT IDENTITY(1, 1) PRIMARY KEY,
[Godzina Rozpoczecia] TIME NOT NULL,
[Godzina Zakonczenia] TIME NOT NULL,
Dzien NVARCHAR(20) NOT NULL
);


CREATE TABLE Stanowiska (
[ID stanowiska] INT IDENTITY(1,1) PRIMARY KEY,
Nazwa NVARCHAR(50) NOT NULL UNIQUE,
Obowiazki NVARCHAR(200),
Kwalifikacje NVARCHAR(200)
)

--tutaj dziedziczenie jakos??
--chciaz ono pownno isc od stanowiska a nie konretnych pracownikow
--trzeba wymyslic jak rozwiazac problem przelozonych 
CREATE TABLE Pracownicy (
[ID pracownika] INT PRIMARY KEY,
Imie NVARCHAR(50) NOT NULL,
Nazwisko NVARCHAR(50) NOT NULL,
[ID przelozonego] INT,
[ID stanowiska] INT NOT NULL,
Pensja MONEY NOT NULL

FOREIGN KEY ([ID stanowiska]) REFERENCES Stanowiska([ID Stanowiska])
);

--potrzebne ograniczenie pracownik na urlopie, nie moze miec zmiany, nie moze byc pracownikiem przypisanym do zamowienia, nalezy kontrolowac dopuszczalna ilosc dni konkretnego urlopu
CREATE TABLE Urlopy (
[ID pracownika] INT,
[ID kategorii] INT,
[Data od] DATE,
[Data do] DATE NOT NULL,

PRIMARY KEY ([ID pracownika], [Data od]),
FOREIGN KEY ([ID pracownika]) REFERENCES Pracownicy([ID pracownika]),
FOREIGN KEY ([ID kategorii]) REFERENCES [Urlopy Kategorie]([ID Kategorii])
);

--troszke redundancji tu jest chyba, jak wczesniejsza pensja rowna sie poprzedniej obecnej pensji idk?
CREATE TABLE [Historia pensji] (
[ID pracownika] INT,
[Data zmiany pensji] DATE,
[Wczesniejsza pensja] MONEY NOT NULL,
[Obecna pensja] MONEY NOT NULL,

PRIMARY KEY ([ID pracownika], [Data zmiany pensji]),
FOREIGN KEY ([ID pracownika]) REFERENCES Pracownicy([ID pracownika])
);

--historia zatrudnien na danym stanowisku
CREATE TABLE [Historia zatrudnien] (
[ID pracownika] INT,
[Data zatrudnienia] DATE NOT NULL,
Stanowisko INT NOT NULL, 
[Data zwolnienia] DATE,

PRIMARY KEY ([ID pracownika], [Data zatrudnienia]),
FOREIGN KEY ([ID pracownika]) REFERENCES Pracownicy([ID pracownika])
);

--potrzebujemy ograniczenia jakiegos, ze jesli jest data wysylki statusem musi byc wyslane, anulowane itd., a jak null to nie moglo byc wyslane, sama zmiana statusu
--powinna automatycznie updatowac date na obecna date
--nr konta musimy dodac (niestety nie moze byc do w danych klienta - chyba ze bedziemy go updatowac jakos) bo potrzebne nam konto na ktore ew zwracamy pieniadze w przypadku anulowania zamowienia
--przenioslabym tutaj obnizke na zamownie i dodala cena zaplacona za zamowinie 
CREATE TABLE Zamowienia (
[ID zamowienia] INT IDENTITY(1,1) PRIMARY KEY,
[ID klienta] INT NOT NULL,
[Data zamownienia] DATE NOT NULL,
[Status wysylki] INT,
[Data wysylki] DATE,
[ID adresu] INT,
[ID pracownika] INT NOT NULL,
[ID punktu odbioru] INT,

FOREIGN KEY ([ID adresu]) REFERENCES Adresy([ID adresu]),
FOREIGN KEY ([Status wysylki]) REFERENCES [Statusy zamowienia]([ID Statusu]),
FOREIGN KEY ([ID pracownika]) REFERENCES Pracownicy([ID pracownika]),
FOREIGN KEY ([ID klienta]) REFERENCES Klienci([ID klienta]),
FOREIGN KEY ([ID punktu odbioru]) REFERENCES [Punkty odbioru]([ID punktu]),
);

CREATE TABLE [Kategorie ksiazek] (
[ID kategorii] INT IDENTITY(1,1) PRIMARY KEY,
Nazwa NVARCHAR(50) UNIQUE NOT NULL,
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
Cena SMALLMONEY NOT NULL,
Opis NVARCHAR(1000),

FOREIGN KEY ([ID kategorii]) REFERENCES [Kategorie ksiazek]([ID kategorii]),
FOREIGN KEY ([ID autora]) REFERENCES Autorzy([ID autora]),
FOREIGN KEY ([ID serii]) REFERENCES Serie([ID serii]),
FOREIGN KEY ([ID wydawcy]) REFERENCES Wydawcy([ID wydawcy])
);

CREATE TABLE [Szczegoly zamowien] (
[ID zamowienia] INT,
[ID produktu] INT,
Cena SMALLMONEY NOT NULL,
Ilosc INT NOT NULL,
Obnizka REAL NOT NULL,	

PRIMARY KEY ([ID zamowienia], [ID produktu]),
FOREIGN KEY ([ID zamowienia]) REFERENCES Zamowienia([ID zamowienia]),
FOREIGN KEY ([ID produktu]) REFERENCES Produkty([ID produktu])
);

-- historyczny i obecny, na kazdy tydzien powinien sam moze powstawac (tylko nie mamy do tego nigdzie zapotrzebowania na pracownikow na danej zmianie)
CREATE TABLE [Grafik Zmian] (
[ID Zmiany] INT,
[ID Pracownika] INT,
[Data Rozpoczecia] DATE NOT NULL,
  
FOREIGN KEY ([ID Pracownika]) REFERENCES Pracownicy([ID Pracownika]),
FOREIGN KEY ([ID Zmiany]) REFERENCES Zmiany([ID Zmiany]),
PRIMARY KEY ([ID Zmiany], [ID Pracownika], [Data Rozpoczecia])
);

--automatyczne info do szefa ds zatrudnienia ze trzeb kogos zatrudnic
CREATE TABLE [Zapotrzebowanie Na Pracownikow] ( 
[ID Stanowiska] INT PRIMARY KEY,
[Ilosc Potrzebnych Pracownikow] INT NOT NULL,
[Ilosc Zatrudnionych Pracownikow] INT NOT NULL,
  
FOREIGN KEY ([ID Stanowiska]) REFERENCES Stanowiska([ID Stanowiska]),
);


--wsm nie jestem pewna czy to wywalac zostawiam obecnie, może jednak się przyda 
/*
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
*/
