	
INSERT INTO Rabaty (Nazwa, [Wysokosc Rabatu]) VALUES
('Uniwersalny', 0.1),
('Level1', 0.12),
('Level2', 0.15),
('Level3', 0.18),
('Level4S', 0.21),
('Okolicznosciowy', 0.2);

INSERT INTO [Klienci Kategorie] ( Nazwa, [Minimalne Miesieczne Zakupy], [Maksymalne Miesieczne Zakupy], [ID Rabatu]) VALUES
('Anonimowy', 0, 1500, 1),
('Poczatkujacy', 0, 100, 2),
('Zaawansowany', 100, 700, 3),
('Ksiazkoholik', 700, 1000, 4),
('Psychofan', 1000, 1500, 5);

INSERT INTO [Urlopy Kategorie] (Nazwa, [Dopuszczalna Ilosc Dni], Opis) VALUES
('Urlop wypoczynkowy',31,'celem urlopu jest wypoczynek pracownika i regeneracja utraconych przez niego sil'),
('Urlop okolicznosciowy',100,'celem urlopu jest zalatwienie spraw osobistych pracownika, odpowiadajacych okreslonym okolicznosciom wskazanym w k.p.'),
('Urlop na dziecko',100,'macierzynski, tacierzynski, rodzicielski, ojcowski) (cele urlopu jest opieka nad dzieckiem'),
('Urlop szkoleniowy',31,'celem urlopu jest podnoszenie kwalifikacji zawodowych pracownika'),
('Urlop na zadanie',14,'Urlop na zadanie'),
('Urlop bezplatny',47,'Urlop bezplatny');

INSERT INTO [Kategorie ksiazek] (Nazwa) VALUES
('fantastyka'),
('science fiction'),
('klasyka'),
('horror'),
('kryminal'),
('komedia');

--bullshit dane
INSERT INTO Adresy (Miasto, Ulica, [Nr budynku], [Nr lokalu], [Kod pocztowy]) VALUES
('Kraków', 'L', '5', '5', '11-111'),
('Kraków', 'L', '5', '51', '11-111'),
('Kraków', 'La', '5', '5', '15-111'),
('Kraków', 'La', '5', NULL, '11-151'),
('Kraków', 'Lal', '5', '5', '11-511'),
('Kraków', 'Lal', '15', NULL, '11-171'),
('Kraków', 'Laa', '5', '5', '11-111'),
('Kraków', 'L', '15', NULL, '11-171'),
('Kraków', 'Laa', '3', '5', '11-117');

INSERT INTO Autorzy (Imie, Nazwisko, [Data urodzenia]) VALUES
('Fonda ', 'Lee', '1979-03-10'),
('Pascal', 'Garnier', '1949-07-04'),
('Robert', 'Wegner', NULL);

INSERT INTO Serie (Nazwa, [ID Autora], [Ilosc Czesci Planowana], [Ilosc Czesci Wydanych]) VALUES
('The Green Bone Saga', 1, 3, 3),
('Opowieści z meekhańskiego pogranicza', 3, 5, 6);

INSERT INTO Wydawcy (Nazwa, [ID adresu]) VALUES
('claroscuro', 1),
('Orbit', 2),
('Powergraph', 3);

INSERT INTO Produkty ([ID kategorii], ISBN13, Tytul, [ID autora], [ID serii], [Czesc serii],
Jezyk, [Jezyk oryginalu],  [ID wydawcy], [Data wydania], [Oprawa], Wymiary, [Liczba stron],
[Ilosc w magazynie], [Ilosc w salonie], Cena, Opis) VALUES
(1, 9780356510514,'Jade City',1,1,1,'angielski', 'angielski',2,'2018-06-28', 'miekka',' 126 x 198 x 36mm', 560, 100, 65, 70,
'The Kaul family is one of two crime syndicates that control the island of Kekon. It is the only place in the world that produces rare magical jade, 
which grants those with the right training and heritage superhuman abilities. The Green Bone clans of honorable jade-wearing warriors once protected the island from foreign invasion
--but nowadays, in a bustling post-war metropolis full of fast cars and foreign money, Green Bone families like the Kauls are primarily involved in commerce, construction, and the everyday 
upkeep of the districts under their protection. When the simmering tension between the Kauls and their greatest rivals erupts into open violence in the streets, the outcome of this clan war 
will determine the fate of all Green Bones and the future of Kekon itself.'),
(1,9780356510538,'Jade War',1,1,2,'angielski', 'angielski',2,'2019-07-23', 'miekka',' 126 x 198 x 36mm', 624, 100, 47, 70, 
'On the island of Kekon, the Kaul family is locked in a violent feud for control of the capital city and the supply of magical jade that endows trained Green Bone warriors with supernatural powers 
they alone have possessed for hundreds of years. Beyond Kekons borders, war is brewing. Powerful foreign governments and mercenary criminal kingpins alike turn their eyes on the island nation. 
Jade, Kekons most prized resource, could make them rich - or give them the edge they would need to topple their rivals. Faced with threats on all sides, the Kaul family is forced to form new and dangerous alliances, 
confront enemies in the darkest streets and the tallest office towers, and put honor aside in order to do whatever it takes to ensure their own survival - and that of all the Green Bones of Kekon.'),
(1, 9780356510590,'Jade Legacy',1,1,3,'angielski', 'angielski',2,'2021-12-02', 'miekka',' 126 x 198 x 36mm', 752, 100, 81, 70,
'The Kauls have been battered by war and tragedy. They are plagued by resentments and old wounds as their adversaries are on the ascent and their country is riven by dangerous factions and foreign interference that
could destroy the Green Bone way of life altogether. As a new generation arises, the clans growing empire is in danger of coming apart. The clan must discern allies from enemies, set aside aside bloody rivalries,
 and make terrible sacrifices... but even the unbreakable bonds of blood and loyalty may not be enough to ensure the survival of the Green Bone clans and the nation they are sworn to protect.'),
(1, 9788361187448,'Polnoc - Poludnie',3,2,1,'polski', 'polski',3, '2012-03-07', 'twarda', '145 x 210 mm', 568, 100, 34, 47,
'Topor i skala -- oto skarby Polnocy. Wiedza o tym nieustraszeni zolnierze Szostej Kompanii, gorskiego oddzialu, strzegacego polnocnych granic Imperium Meekhanskiego. A jesli istnieja starcia nie do wygrania? 
Jedyne, na co moze wtedy liczyc Gorska Straz, to honor gorali. Miecz i zar -- tylko tyle pozostalo zamaskowanemu wojownikowi z pustynnego Poludnia. Kiedys, zgodnie ze zwyczajem, zaslanial twarz, by nikt nie wykradl mu duszy. 
Dzis nie ma juz duszy, ktora moglby chronic. Czy z bogami mozna walczyc za pomoca mieczy? Tak, jesli jestes Issarem i nie masz nic do stracenia.'),
(1, 9788361187455,'Wschod - Zachod',3,2,2,'polski', 'polski',3, '2012-03-07', 'twarda', '145 x 210 mm', 680, 100, 34, 47,
'Honor i wiernosc, wytrwalosc i zelazna wola. W ksiazkach Roberta Wegnera odzywaja dawne wartosci, a pomiedzy barwnymi pojedynkami, intrygami, bitwami wielkich armii i krwawymi starciami jest miejsce na emocje, 
ktore potrafia skruszyc serce najwiekszego twardziela. Opowiadania z Polnocy, Poludnia, Wschodu i Zachodu skladaja sie na epicka opowiesc o egzotycznych swiatach roznych nacji, jezykow, wierzen i magii.'),
(1, 9788361187417,'Niebo ze stali',3,2,3,'polski', 'polski',3, '2012-03-07', 'twarda', '145 x 210 mm', 624, 100, 34, 47,
'Wozy wygnanych niegdys koczownikow stanely u stop gor, ktore oddzielaja ich od upragnionej wolnosci. Losy Szostej Kompanii Gorskiej Strazy, dziewczyn z wolnego czaardanu i malej dziewczynki z rodu Verdanno zaczynaja sie splatac...
 Zanim na niebie o barwie stali wzejdzie slonce, wyzyna splynie krwia.'),
(1, 9788364384240,'Pamiec wszystkich slow',3,2,4,'polski', 'polski',3, '2015-05-06', 'twarda', '145 x 210 mm', 702, 100, 34, 47,
'Opowiesci z meekhanskiego pogranicza - historie z Polnocy, Poludnia, Wschodu i Zachodu skladaja sie na egzotyczna opowiesc o swiatach roznych nacji, jezykow, wierzen i magii. 
Napisana z rozmachem "Pamiec wszystkich slow" zabiera bohaterow na niegoscinna pustynie, w niebezpieczne uliczki pelnych przepychu wschodnich miast czy w samo serce wyspy opanowanej przez zwasnione rody, siedziby miejscowego boga. 
Pomiedzy zemsta rodowa a buntem niewolnikow, wrzuceni miedzy potegi rozgrywajace swoja partie z Losem, bohaterowie Wegnera musza wybierac, gdy wydaje sie, ze nie pozostal juz zaden wybor. I nawet niesmiertelni sie ugna, gdy w gre wchodzi honor, 
lojalnosc i przysiegi zlozone cieniom tych, ktorzy odeszli.'),
(1, 9788364384868,'Kazde martwe marzenie',3,2,5,'polski', 'polski',3, '2018-11-28', 'twarda', '145 x 210 mm', 744, 100, 34, 47,
'Deana dKllean, niegdys Piesniarka Pamieci i mistrzyni miecza, a dzis rzadzaca pustynnym ksiestwem wybranka Boga Ognia, stoi na progu wojny. Powstanie niewolnikow, ktore wybuchlo u poludniowych granic panstwa, zatacza coraz szersze kregi. 
Genno Laskolnyk wraz ze swoim czaardanem wolnych jezdzcow wpada w sam srodek wojny. Czego szuka wsrod niewolnikow, ktorzy postanowili zrzucic jarzmo krwawych panow? Tymczasem tysiace mil na polnoc Czerwone Szostki trafiaja na tajemnice, ktora pochlonela juz niejedna ofiare. 
Czy odwaga gorali ocali im zycie? Meekhan splywa krwia i wydaje sie, ze nic juz nie powstrzyma plomienia, ktory ogarnia Imperium.'),
(3,9788362498291,'Teoria pandy',2, NULL,NULL,'polski', 'francuski',1,'2018-10-01', 'miekka', '125 x 190 mm', 196, 100, 14, 33, 
'Dzieki swojemu talentowi kulinarnemu i niewymuszonemu luzowi, Gabriel, pojawiwszy sie nie wiadomo skad, buduje silne wiezi z mieszkancami malego miasteczka w Bretanii: 
z recepcjonistka hotelowa, z dwoma cpunami bez grosza, a przede wszystkim z Jose, wlascicielem baru Faro. Niczym pluszowa panda wylegujaca sie na kontuarze Faro, Gabriel poswieca swoj czas tym, 
ktorzy do niego przychodza, wiedzeni ciekawoscia, bardziej zauroczeni niz nieufni. A jednak, gdyby tylko wiedzieli... Kolejny raz Pascal Garnier roztacza przed nami swoj wyjatkowy czar.'),
(3,9788362498383,'Daleko, dalej',2, NULL,NULL,'polski', 'francuski',1,'2021-03-01', 'miekka', '125 x 190 mm', 132, 100, 25, 29, 
'Szescdziesieciolatek Marc ma, jak sie wydaje, wszystko, co potrzebne do szczescia. Dusi go jednak poczucie mialkosci jego zycia - byc moze ta mialkosc odpowiada za to, co nieudane, niezbyt chwalebne, toksyczne. 
Magia wielkiej dali ciazy w jego umysle podskorna obietnica nowego poczatku dla niego i dla jego corki Anne, przebywajacej w zakladzie psychiatrycznym. Marc, nie informujac nikogo, zabiera wiec corke w podroz nad morze...'),
(3,9788362498154,'Jak sie ma twoj bol?',2, NULL,NULL,'polski', 'francuski',1,'2017-03-01', 'miekka', '125 x 190 mm',176, 100, 51, 33 , 
'Smierc jest zajeciem Simona. Starzejacy sie tepiciel szkodnikow przygotowuje sie do wykonania ostatniego zlecenia. Po drodze zatrzymuje sie w Vals-les-Bains, gdzie spotyka Bernarda, 
serdecznego, nieco naiwnego chlopaka o lagodnym spojrzeniu i dobrym sercu. Bernard nigdy nie byl nad morzem, a Simon potrzebuje kierowcy. Moze przez kaprys, moze przez rzeczywista sympatie do czlowieka,
 ktory tak rozni sie od niego, Simon proponuje Bernardowi prace.');

 --bullshit dane
INSERT INTO [Firmy Wysylkowe] ([Nazwa Firmy], [ID Adresu], Telefon, [E-mail], [Imie przedstawiciela], [Nazwisko przedstawiciela], [Telefon przedstawiciela], [E-mail przedstawiciela]) VALUES
('Paczuchy', 1, 123456789, 'paczuch@paczuchy.pl', 'Anna', 'Kgsysjd', 123456123, 'skjch@cs.pl' ),
('xx', 2, 123456789, 'paczxch@paczuchy.pl', 'Anna', 'Kgsysjd', 123456123, 'skjch@cs.pl' ),
('Paczuchyx', 3, 123456789, 'paczuch@paczuchy.pl', 'Anna', 'Kgsysjd', 123456123, 'skjch@cs.pl' );

--bullshit dane
INSERT INTO [Punkty Odbioru] (Nazwa, [ID Adresu], [Czynny od], [Czynny do], [ID Firmy]) VALUES
('A', 1, '08:00:00', '17:00:00', 1),
('AA', 2, '10:00:00', '20:00:00', 1),
('AAA', 3, '10:00:00', '20:00:00', 1),
('AA', 2, '10:00:00', '20:00:00', 2),
('AAA', 3, '10:00:00', '20:00:00', 3);

--bullshit dane
INSERT INTO [Opcje Wysylki] ([ID Firmy], Typ, Cena) VALUES
(1, 'punkt odbioru', 7),
(2, 'punkt odbioru', 9),
(3, 'punkt odbioru', 8),
(3, 'kurier', 15);

--bullshit dane
INSERT INTO Klienci ([ID Kategorii], Imie, Nazwisko, [Nazwa Konta], [Haslo Do Konta], [ID Adresu], Telefon, [E-mail]) VALUES
(1, 'A', 'B', NULL, NULL, 1, 123123123, 'sada@ssa.pl'),
(2, 'Adx', 'Bxdfr', 'ad', 'sef', 2, 123123123, 'sada@ssa.pl'),
(3, 'Ae', 'Brh', 'fsd', 'dg', 3, 123123123, 'sada@ssa.pl'),
(4, 'Arhj', 'Brth', 'tfhj', 'hfghv', 3, 123123123, 'sada@ssa.pl'),
(5, 'Aft', 'Brty', 'tddgf', 'dhfchgb', 2, 123123123, 'sada@ssa.pl');

INSERT INTO Zmiany ([Godzina Rozpoczecia], [Godzina Zakonczenia], Dzien) VALUES
('00:00:00','07:30:00', 'pn - czw'),
('07:00:00','13:30:00', 'pn - czw'),
('13:00:00','17:30:00', 'pn - czw'),
('17:00:00','24:00:00', 'pn - czw'),
('00:00:00','07:30:00', 'pt, sb'),
('07:00:00','13:30:00', 'pt, sb'),
('13:00:00','17:30:00', 'pt, sb'),
('17:00:00','24:00:00', 'pt, sb'),
('00:00:00','07:30:00', 'nie, swieta'),
('07:00:00','13:30:00', 'nie, swieta'),
('13:00:00','17:30:00', 'nie, swieta'),
('17:00:00','24:00:00', 'nie, swieta');

INSERT INTO Zamowienia ([ID klienta], [Data zamownienia], [Data wysylki], [ID adresu], [ID pracownika]) VALUES
;

INSERT INTO [Szczegoly zamowien] (
[ID zamowienia], [ID produktu], Cena, Ilosc, Obnizka) VALUES
;

--wymyslic z sensem
INSERT INTO Stanowiska (Nazwa, Obowiazki, Kwalifikacje) VALUES
('Specjalista Do Spraw Obslugii Klienta', '', 'doswiadczenie w zarządzaniu ludźmi'),
(),
(),
()

--wymyslic WHATEVER
INSERT INTO Pracownicy ([ID pracownika], Imie, Nazwisko, [ID przelozonego], [ID stanowiska], Pensja) VALUES
(1, )

--wymyslic WHATEVER
INSERT INTO Urlopy ([ID pracownika], [ID kategorii], [Data od], [Data do]) VALUES
;

--wymyslic WHATEVER 
INSERT INTO [Historia pensji] ([ID pracownika], [Data zatrudnienia], [Data zmiany pensji]) VALUES
;

--wymyslic WHATEVER
INSERT INTO[Historia zatrudnien] ([ID pracownika], [Data zatrudnienia], Stanowisko, [Data zwolnienia]) VALUES
;

--wymyslic WHATEVER 
INSERT INTO [Grafik Zmian] ([ID Zmiany], [ID Pracownika],[Data Rozpoczecia],[Data Zakonczenia]) VALUES
;

--wymyslic WHATEVER 
INSERT INTO [Skargi Pracownicze] ([ID Skladajacego], [ID Oskarzonego], Data, Tresc, [Komentarz Przelozonego])VALUES
;

--wymyslic WHATEVER 
INSERT INTO [Opinie Klientow] ([ID Pracownika], [ID Klienta], Data, Tresc, Ocena) VALUES
;

--wymyslic WHATEVER (komentarz w create !!!)
INSERT INTO [Zapotrzebowanie Na Pracownikow] ([ID Stanowiska], [Ilosc Potrzebnych Pracownikow]) VALUES
;

--wymyslic WHATEVER -- jaki to ma sesns wgl??
INSERT INTO Dostawcy (Nazwa, [ID adresu], Telefon, [E-mail], [Imie przedstawiciela], [Nazwisko przedstawiciela], [Telefon przedstawiciela], [E-mail przedstawiciela]) VALUES
;
