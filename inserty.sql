INSERT INTO [Statusy zamowienia]([Nazwa statusu], [Opis statusu]) VALUES
('przyjete', 'oczekawinie na platnosc'),
('oplacone', 'trafilo do realizjcji'),
('do wyslania', 'oczekuje na wyslke'),
('wyslano', 'zostalo wyslane');

INSERT INTO [Klienci Kategorie] ( Nazwa, [Minimalne Miesieczne Zakupy], [Maksymalne Miesieczne Zakupy], Rabat) VALUES
('Poczatkujacy', 0, 100, 0.05),
('Zaawansowany', 100, 700, 0.1),
('Ksiazkoholik', 700, 1000, 0.2),
('Psychofan', 1000, 1500, 0.35);


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

INSERT INTO Osoby (Imie, Nazwisko, Miasto, Ulica, [Nr budynku], [Nr lokalu], [Kod pocztowy]) VALUES
('Fonda', 'Lee', NULL, NULL, NULL, NULL, NULL),
('Pascal', 'Garnier', NULL, NULL, NULL, NULL, NULL),
('Robert', 'Wegner', NULL, NULL, NULL, NULL, NULL),
('klient1', 'Lee', NULL, NULL, NULL, NULL, NULL),
('klient2', 'Lee', NULL, NULL, NULL, NULL, NULL),
('klient3', 'Lee', NULL, NULL, NULL, NULL, NULL),
('klient4', 'Lee', NULL, NULL, NULL, NULL, NULL),
('klient5', 'Lee', NULL, NULL, NULL, NULL, NULL),
('pracownik1', 'Lee', NULL, NULL, NULL, NULL, NULL),
('pracownik2', 'Lee', NULL, NULL, NULL, NULL, NULL),
('pracownik3', 'Lee', NULL, NULL, NULL, NULL, NULL),
('pracownik4', 'Lee', NULL, NULL, NULL, NULL, NULL),
('pracownik5', 'Lee', NULL, NULL, NULL, NULL, NULL);

INSERT INTO Autorzy ([ID Autora], [Data urodzenia]) VALUES
(1, '1979-03-10'),
(2, '1949-07-04'),
(3, NULL);

INSERT INTO Serie (Nazwa, [ID Autora], [Ilosc Czesci Planowana], [Ilosc Czesci Wydanych]) VALUES
('The Green Bone Saga', 1, 3, 3),
('Opowieści z meekhańskiego pogranicza', 3, 5, 6);

INSERT INTO Wydawcy (Nazwa, Miasto, Ulica, [Nr budynku], [Nr lokalu], [Kod pocztowy]) VALUES
('claroscuro', 'Kraków', 'Lal', '15', NULL, '11-171'),
('Orbit', 'Kraków', 'Lal', '15', NULL, '11-171'),
('Powergraph', 'Kraków', 'Lal', '15', NULL, '11-171');

INSERT INTO Produkty ([Nazwa kategorii], ISBN13, Tytul, [ID autora], [ID serii], [Czesc serii],
Jezyk, [Jezyk oryginalu],  [ID wydawcy], [Data wydania], [Oprawa], Wymiary, [Liczba stron],
[Ilosc w magazynie], Cena, Opis) VALUES
('fantastyka', 9780356510514,'Jade City',1,1,1,'angielski', 'angielski',2,'2018-06-28', 'miekka',' 126 x 198 x 36mm', 560, 65, 70,
'The Kaul family is one of two crime syndicates that control the island of Kekon. It is the only place in the world that produces rare magical jade, 
which grants those with the right training and heritage superhuman abilities. The Green Bone clans of honorable jade-wearing warriors once protected the island from foreign invasion
--but nowadays, in a bustling post-war metropolis full of fast cars and foreign money, Green Bone families like the Kauls are primarily involved in commerce, construction, and the everyday 
upkeep of the districts under their protection. When the simmering tension between the Kauls and their greatest rivals erupts into open violence in the streets, the outcome of this clan war 
will determine the fate of all Green Bones and the future of Kekon itself.'),
('fantastyka',9780356510538,'Jade War',1,1,2,'angielski', 'angielski',2,'2019-07-23', 'miekka',' 126 x 198 x 36mm', 624, 47, 70, 
'On the island of Kekon, the Kaul family is locked in a violent feud for control of the capital city and the supply of magical jade that endows trained Green Bone warriors with supernatural powers 
they alone have possessed for hundreds of years. Beyond Kekons borders, war is brewing. Powerful foreign governments and mercenary criminal kingpins alike turn their eyes on the island nation. 
Jade, Kekons most prized resource, could make them rich - or give them the edge they would need to topple their rivals. Faced with threats on all sides, the Kaul family is forced to form new and dangerous alliances, 
confront enemies in the darkest streets and the tallest office towers, and put honor aside in order to do whatever it takes to ensure their own survival - and that of all the Green Bones of Kekon.'),
('fantastyka', 9780356510590,'Jade Legacy',1,1,3,'angielski', 'angielski',2,'2021-12-02', 'miekka',' 126 x 198 x 36mm', 752, 81, 70,
'The Kauls have been battered by war and tragedy. They are plagued by resentments and old wounds as their adversaries are on the ascent and their country is riven by dangerous factions and foreign interference that
could destroy the Green Bone way of life altogether. As a new generation arises, the clans growing empire is in danger of coming apart. The clan must discern allies from enemies, set aside aside bloody rivalries,
 and make terrible sacrifices... but even the unbreakable bonds of blood and loyalty may not be enough to ensure the survival of the Green Bone clans and the nation they are sworn to protect.'),
('fantastyka', 9788361187448,'Polnoc - Poludnie',3,2,1,'polski', 'polski',3, '2012-03-07', 'twarda', '145 x 210 mm', 568, 34, 47,
'Topor i skala -- oto skarby Polnocy. Wiedza o tym nieustraszeni zolnierze Szostej Kompanii, gorskiego oddzialu, strzegacego polnocnych granic Imperium Meekhanskiego. A jesli istnieja starcia nie do wygrania? 
Jedyne, na co moze wtedy liczyc Gorska Straz, to honor gorali. Miecz i zar -- tylko tyle pozostalo zamaskowanemu wojownikowi z pustynnego Poludnia. Kiedys, zgodnie ze zwyczajem, zaslanial twarz, by nikt nie wykradl mu duszy. 
Dzis nie ma juz duszy, ktora moglby chronic. Czy z bogami mozna walczyc za pomoca mieczy? Tak, jesli jestes Issarem i nie masz nic do stracenia.'),
('fantastyka', 9788361187455,'Wschod - Zachod',3,2,2,'polski', 'polski',3, '2012-03-07', 'twarda', '145 x 210 mm', 680, 34, 47,
'Honor i wiernosc, wytrwalosc i zelazna wola. W ksiazkach Roberta Wegnera odzywaja dawne wartosci, a pomiedzy barwnymi pojedynkami, intrygami, bitwami wielkich armii i krwawymi starciami jest miejsce na emocje, 
ktore potrafia skruszyc serce najwiekszego twardziela. Opowiadania z Polnocy, Poludnia, Wschodu i Zachodu skladaja sie na epicka opowiesc o egzotycznych swiatach roznych nacji, jezykow, wierzen i magii.'),
('fantastyka', 9788361187417,'Niebo ze stali',3,2,3,'polski', 'polski',3, '2012-03-07', 'twarda', '145 x 210 mm', 624, 34, 47,
'Wozy wygnanych niegdys koczownikow stanely u stop gor, ktore oddzielaja ich od upragnionej wolnosci. Losy Szostej Kompanii Gorskiej Strazy, dziewczyn z wolnego czaardanu i malej dziewczynki z rodu Verdanno zaczynaja sie splatac...
 Zanim na niebie o barwie stali wzejdzie slonce, wyzyna splynie krwia.'),
('fantastyka', 9788364384240,'Pamiec wszystkich slow',3,2,4,'polski', 'polski',3, '2015-05-06', 'twarda', '145 x 210 mm', 702, 34, 47,
'Opowiesci z meekhanskiego pogranicza - historie z Polnocy, Poludnia, Wschodu i Zachodu skladaja sie na egzotyczna opowiesc o swiatach roznych nacji, jezykow, wierzen i magii. 
Napisana z rozmachem "Pamiec wszystkich slow" zabiera bohaterow na niegoscinna pustynie, w niebezpieczne uliczki pelnych przepychu wschodnich miast czy w samo serce wyspy opanowanej przez zwasnione rody, siedziby miejscowego boga. 
Pomiedzy zemsta rodowa a buntem niewolnikow, wrzuceni miedzy potegi rozgrywajace swoja partie z Losem, bohaterowie Wegnera musza wybierac, gdy wydaje sie, ze nie pozostal juz zaden wybor. I nawet niesmiertelni sie ugna, gdy w gre wchodzi honor, 
lojalnosc i przysiegi zlozone cieniom tych, ktorzy odeszli.'),
('fantastyka', 9788364384868,'Kazde martwe marzenie',3,2,5,'polski', 'polski',3, '2018-11-28', 'twarda', '145 x 210 mm', 744, 34, 47,
'Deana dKllean, niegdys Piesniarka Pamieci i mistrzyni miecza, a dzis rzadzaca pustynnym ksiestwem wybranka Boga Ognia, stoi na progu wojny. Powstanie niewolnikow, ktore wybuchlo u poludniowych granic panstwa, zatacza coraz szersze kregi. 
Genno Laskolnyk wraz ze swoim czaardanem wolnych jezdzcow wpada w sam srodek wojny. Czego szuka wsrod niewolnikow, ktorzy postanowili zrzucic jarzmo krwawych panow? Tymczasem tysiace mil na polnoc Czerwone Szostki trafiaja na tajemnice, ktora pochlonela juz niejedna ofiare. 
Czy odwaga gorali ocali im zycie? Meekhan splywa krwia i wydaje sie, ze nic juz nie powstrzyma plomienia, ktory ogarnia Imperium.'),
('klasyka',9788362498291,'Teoria pandy',2, NULL,NULL,'polski', 'francuski',1,'2018-10-01', 'miekka', '125 x 190 mm', 196, 14, 33, 
'Dzieki swojemu talentowi kulinarnemu i niewymuszonemu luzowi, Gabriel, pojawiwszy sie nie wiadomo skad, buduje silne wiezi z mieszkancami malego miasteczka w Bretanii: 
z recepcjonistka hotelowa, z dwoma cpunami bez grosza, a przede wszystkim z Jose, wlascicielem baru Faro. Niczym pluszowa panda wylegujaca sie na kontuarze Faro, Gabriel poswieca swoj czas tym, 
ktorzy do niego przychodza, wiedzeni ciekawoscia, bardziej zauroczeni niz nieufni. A jednak, gdyby tylko wiedzieli... Kolejny raz Pascal Garnier roztacza przed nami swoj wyjatkowy czar.'),
('klasyka',9788362498383,'Daleko, dalej',2, NULL,NULL,'polski', 'francuski',1,'2021-03-01', 'miekka', '125 x 190 mm', 132, 25, 29, 
'Szescdziesieciolatek Marc ma, jak sie wydaje, wszystko, co potrzebne do szczescia. Dusi go jednak poczucie mialkosci jego zycia - byc moze ta mialkosc odpowiada za to, co nieudane, niezbyt chwalebne, toksyczne. 
Magia wielkiej dali ciazy w jego umysle podskorna obietnica nowego poczatku dla niego i dla jego corki Anne, przebywajacej w zakladzie psychiatrycznym. Marc, nie informujac nikogo, zabiera wiec corke w podroz nad morze...'),
('klasyka',9788362498154,'Jak sie ma twoj bol?',2, NULL,NULL,'polski', 'francuski',1,'2017-03-01', 'miekka', '125 x 190 mm',176, 51, 33 , 
'Smierc jest zajeciem Simona. Starzejacy sie tepiciel szkodnikow przygotowuje sie do wykonania ostatniego zlecenia. Po drodze zatrzymuje sie w Vals-les-Bains, gdzie spotyka Bernarda, 
serdecznego, nieco naiwnego chlopaka o lagodnym spojrzeniu i dobrym sercu. Bernard nigdy nie byl nad morzem, a Simon potrzebuje kierowcy. Moze przez kaprys, moze przez rzeczywista sympatie do czlowieka,
 ktory tak rozni sie od niego, Simon proponuje Bernardowi prace.');

 --bullshit dane
INSERT INTO [Firmy Wysylkowe] ([Nazwa Firmy], Miasto, Ulica, [Nr budynku], [Nr lokalu], [Kod pocztowy], Telefon, [E-mail], [Imie przedstawiciela], [Nazwisko przedstawiciela], [Telefon przedstawiciela], [E-mail przedstawiciela]) VALUES
('Paczuchy', 'Kraków', 'Lal', '15', NULL, '11-171', 123456789, 'paczuch@paczuchy.pl', 'Anna', 'Kgsysjd', 123456123, 'skjch@cs.pl' ),
('xx', 'Kraków', 'Lal', '15', NULL, '11-171', 123456789, 'paczxch@paczuchy.pl', 'Anna', 'Kgsysjd', 123456123, 'skjch@cs.pl' ),
('Paczuchyx', 'Kraków', 'Lal', '15', NULL, '11-171', 123456789, 'paczuwqch@paczuchy.pl', 'Anna', 'Kgsysjd', 123456123, 'skjch@cs.pl' );

--bullshit dane
INSERT INTO [Punkty Odbioru] (Nazwa, Miasto, Ulica, [Nr budynku], [Kod pocztowy], [Czynny od], [Czynny do], [ID Firmy]) VALUES
('A', 'Kraków', 'Lal', '15', '11-171', '08:00:00', '17:00:00', 1),
('AA', 'Kraków', 'Lal', '15', '11-171', '10:00:00', '20:00:00', 1),
('AAA', 'Kraków', 'Lal', '15', '11-171', '10:00:00', '20:00:00', 1),
('AB', 'Kraków', 'Lal', '15', '11-171', '10:00:00', '20:00:00', 2),
('AAB', 'Kraków', 'Lal', '15', '11-171', '10:00:00', '20:00:00', 3);

--bullshit dane
INSERT INTO [Opcje Wysylki] ([ID Firmy], Typ, Cena) VALUES
(1, 'punkt odbioru', 7),
(2, 'punkt odbioru', 9),
(3, 'punkt odbioru', 8),
(3, 'kurier', 15);

--bullshit dane
INSERT INTO Klienci ([ID Klienta], [ID Kategorii], [Nazwa Konta], [Haslo Do Konta], Telefon, [E-mail]) VALUES
(4, 1, 'wa', 'weodhdowdih', 123123123, 'sada@ssa.pl'),
(5, 2, 'ad', 'sefzaqqa', 123123123, 'sada@ssa.pl'),
(6, 3, 'fsd', 'dgzaq2nj', 123123123, 'sada@ssa.pl'),
(7, 4, 'tfhj', 'hfash&7ghv', 123123123, 'sada@ssa.pl'),
(8, 1, 'tddgf', 'dhfcjk^hgb', 123123123, 'sada@ssa.pl');

--DECLARE @MyTime time(0) 

INSERT INTO Zmiany ([Godzina Rozpoczecia], [Godzina Zakonczenia], Dzien) VALUES
('12:00AM','07:30AM', 'pn - czw'),
('07:00AM','01:30PM', 'pn - czw'),
('01:00PM','05:30PM', 'pn - czw'),
('05:00PM','12:00AM', 'pn - czw'),
('12:00AM','07:30AM', 'pt, sb'),
('07:00AM','01:30PM', 'pt, sb'),
('01:00PM','05:30PM', 'pt, sb'),
('05:00PM','12:00AM', 'pt, sb'),
('12:00AM','07:30AM', 'nie, swieta'),
('07:00AM','01:30PM', 'nie, swieta'),
('01:00PM','05:30PM', 'nie, swieta'),
('05:00PM','12:00AM', 'nie, swieta');

--poprawic z sensem (dopisac brakujace dane)
INSERT INTO Stanowiska (Nazwa, Obowiazki, Kwalifikacje) VALUES
('Specjalista Do Spraw Obslugi Klienta', 'nadwzorowanie pracownikow do spraw obslogi klienta', 'doswiadczenie w zarządzaniu ludźmi'),
('Pracownik Obslugi Klienta', 'kontakt z klientami, pomoc w rozwiazaniu problemow', NULL),
('Prezes', 'zarzadznie firma' ,'doswiadczenie w zarzadzaniu'),
('Ekspert IT', 'zarzadznie baza danych, systemem, bla bla bla...', 'dswiadczenie w ...'),
('Dyrektor do spraw komunikacji','',''),
('Asystent ds technicznych', '', '');

--bullshit dane
INSERT INTO Pracownicy ([ID pracownika], [ID przelozonego], [ID stanowiska], Pensja) VALUES
(9, NULL, 1, 90000),
(10, 1, 2, 50000),
(11, 1, 2, 50000),
(12, 1, 2, 60000),
(13, 1, 2, 50000);

--bullshit dane
INSERT INTO Zamowienia ([ID klienta], [Data i czas zamowienia], [Status Wysylki], [Data wysylki], Miasto, Ulica, [Nr budynku], [Nr lokalu], [Kod pocztowy]) VALUES
(4, '2022-01-12', 4, '2022-01-14', 'Kraków', 'Lal', '15', NULL, '11-171'),
(5, '2022-01-10', 4, '2022-01-12', 'Kraków', 'Lal', '15', NULL, '11-171'),
(6, '2022-01-16', 1, NULL, 'Kraków', 'Lal', '15', NULL, '11-171');

--bullshit dane
INSERT INTO [Szczegoly zamowien] ([ID zamowienia], [ID produktu], Cena, Ilosc, Obnizka) VALUES
(1, 1, 68, 1, 0.15),
(1, 2, 63, 1, 0.34);

INSERT INTO Urlopy ([ID pracownika], [ID kategorii], [Data od], [Data do]) VALUES
(9, 2, '2022-01-01', '2022-01-18'),
(10, 4, '2022-01-12', '2022-01-15');

INSERT INTO [Historia pensji] ([ID pracownika], [Data zmiany pensji], [Poprzednia pensja]) VALUES
(9, '2021-05-13', 50000),
(10, '2021-09-13', 60000),
(11, '2022-01-13', 90000);


INSERT INTO[Historia zatrudnien] ([ID pracownika], [Data zatrudnienia na stanowisku], Stanowisko, [Data zwolnienia]) VALUES
(9, '2021-05-13', 2, '2022-01-13'),
(10, '2022-01-13', 1, NULL);

--wymyslic WHATEVER 
INSERT INTO [Grafik Zmian] ([ID Zmiany], [ID Pracownika], [Data]) VALUES
(1, 9, '2022-01-13'),
(1, 10, '2022-01-13'),
(2, 11, '2022-01-13'),
(3, 12, '2022-01-13'),
(4, 13, '2022-01-13'),
(1, 9, '2022-01-14'),
(1, 10, '2022-01-14'),
(2, 11, '2022-01-14'),
(3, 12, '2022-01-14'),
(4, 13, '2022-01-14');

--dane wyciagane bezposrednio z tabeli pracownicy pomijajc ilosc potrzenych pracownkow 
INSERT INTO [Zapotrzebowanie Na Pracownikow] ([ID Stanowiska], [Ilosc Potrzebnych Pracownikow], [Ilosc Zatrudnionych Pracownikow]) VALUES
(2, 10, 4),
(1, 1, 1);

--INSERT INTO [Opinie Klientow] ([ID Produktu], [ID Klienta], Data, Tresc, Ocena) VALUES
