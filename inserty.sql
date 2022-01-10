INSERT INTO Rabaty (Nazwa, [Wysokosc Rabatu]) VALUES
('Uniwersalny', 0.1),
('Level1', 0.12),
('Level2', 0.15),
('Level3', 0.18),
('Level4S', 0.21),
('Okolinczno�ciowy', 0.2);

INSERT INTO [Klienci Kategorie] ( Nazwa, [Minimalne Miesieczne Zakupy], [Maksymalne Miesieczne Zakupy], [ID Rabatu]) VALUES
('Anonimowy', 0, 1500, 1),
('Pocz�tkuj�cy', 0, 100, 2),
('Zaawansowany', 100, 700, 3),
('Ksi��kocholik', 700, 1000, 4),
('Psychofan', 1000, 1500, 5);

INSERT INTO [Urlopy Kategorie] (Nazwa, [Dopuszczalna Ilosc Dni], Opis) VALUES
('Urlop wypoczynkowy',31,'celem urlopu jest wypoczynek pracownika i regeneracja utraconych przez niego si�'),
('Urlop okoliczno�ciowy',100,'celem urlopu jest za�atwienie spraw osobistych pracownika, odpowiadaj�cych okre�lonym okoliczno�ciom wskazanym w k.p.'),
('Urlop na dziecko',100,'macierzy�ski, tacierzy�ski, rodzicielski, ojcowski) (cele urlopu jest opieka nad dzieckiem'),
('Urlop szkoleniowy',31,'celem urlopu jest podnoszenie kwalifikacji zawodowych pracownika'),
('Urlop na ��danie',14,'Urlop na ��danie'),
('Urlop bezp�atny',47,'Urlop bezp�atny');

INSERT INTO [Kategorie ksiazek] (Nazwa) VALUES
('fanatstyka'),
('science fiction'),
('klasyka'),
('horror'),
('krymina�'),
('komedia');

INSERT INTO Adresy (Miasto, Ulica, [Nr budynku], [Nr lokalu], [Kod pocztowy]) VALUES
('Krak�w', 'L', '5', '5', '11-111'),
('Krak�w', 'L', '5', '51', '11-111'),
('Krak�w', 'La', '5', '5', '15-111'),
('Krak�w', 'La', '5', NULL, '11-151'),
('Krak�w', 'Lal', '5', '5', '11-511'),
('Krak�w', 'Lal', '15', NULL, '11-171'),
('Krak�w', 'Laa', '5', '5', '11-111'),
('Krak�w', 'L', '15', NULL, '11-171'),
('Krak�w', 'Laa', '3', '5', '11-117');


INSERT INTO  Autorzy (Imie, Nazwisko, [Data urodzenia]) VALUES
('Fonda ', 'Lee', '1979-03-10'),
('Pascal', 'Garnier', '1949-07-04'),
('Robert', 'Wegner', '1999-01-01');


INSERT INTO Serie (Nazwa, [ID Autora], [Ilosc Czesci Planowana], [Ilosc Czesci Wydanych]) VALUES
('The Green Bone Saga', 1, 3, 3),
('Opowie�ci z meekha�skiego pogranicza', 3, 5, 6);

INSERT INTO Wydawcy (Nazwa, [ID adresu]) VALUES
('claroscuro', 1),
('Orbit', 2),
('Powergraph', 3);

INSERT INTO Produkty ([ID kategorii], ISBN13, Tytul, [ID autora], [ID serii], [Czesc serii],
Jezyk, [Jezyk oryginalu],  [ID wydawcy], [Data wydania], [Oprawa], Wymiary, [Liczba stron],
[Ilosc w magazynie], [Ilosc w salonie], Cena, Opis) VALUES
(1,9780356510514,'Jade City',1,1,1,'angielski', 'angielski',2,'2018-06-28', 'mi�kka',' 126 x 198 x 36mm', 560, 100, 65, 70,
'The Kaul family is one of two crime syndicates that control the island of Kekon. It is the only place in the world that produces rare magical jade, 
which grants those with the right training and heritage superhuman abilities. The Green Bone clans of honorable jade-wearing warriors once protected the island from foreign invasion
--but nowadays, in a bustling post-war metropolis full of fast cars and foreign money, Green Bone families like the Kauls are primarily involved in commerce, construction, and the everyday 
upkeep of the districts under their protection. When the simmering tension between the Kauls and their greatest rivals erupts into open violence in the streets, the outcome of this clan war 
will determine the fate of all Green Bones and the future of Kekon itself.'),

(1,9780356510538,'Jade War',1,1,2,'angielski', 'angielski',2,'2019-07-23', 'mi�kka',' 126 x 198 x 36mm', 624, 100, 47, 70, 
'On the island of Kekon, the Kaul family is locked in a violent feud for control of the capital city and the supply of magical jade that endows trained Green Bone warriors with supernatural powers 
they alone have possessed for hundreds of years. Beyond Kekons borders, war is brewing. Powerful foreign governments and mercenary criminal kingpins alike turn their eyes on the island nation. 
Jade, Kekons most prized resource, could make them rich - or give them the edge they would need to topple their rivals. Faced with threats on all sides, the Kaul family is forced to form new and dangerous alliances, 
confront enemies in the darkest streets and the tallest office towers, and put honor aside in order to do whatever it takes to ensure their own survival - and that of all the Green Bones of Kekon.'),

(1, 9780356510590,'Jade Legacy',1,1,3,'angielski', 'angielski',2,'2021-12-02', 'mi�kka',' 126 x 198 x 36mm', 752, 100, 81, 70,
'The Kauls have been battered by war and tragedy. They are plagued by resentments and old wounds as their adversaries are on the ascent and their country is riven by dangerous factions and foreign interference that
could destroy the Green Bone way of life altogether. As a new generation arises, the clan�s growing empire is in danger of coming apart. The clan must discern allies from enemies, set aside aside bloody rivalries,
 and make terrible sacrifices� but even the unbreakable bonds of blood and loyalty may not be enough to ensure the survival of the Green Bone clans and the nation they are sworn to protect.'),

--(1,13,'tytul',3,2,czesc serii,'polski', 'polski',3, data wydania, 'twarda'), --tbd

(3,9788362498291,'Teoria pandy',2, NULL,NULL,'polski', 'francuski',1,'2018-10-01', 'mi�kka', '125 x 190 mm', 196, 100, 14, 33, 
'Dzi�ki swojemu talentowi kulinarnemu i niewymuszonemu luzowi, Gabriel, pojawiwszy si� nie wiadomo sk�d, buduje silne wi�zi z mieszka�cami ma�ego miasteczka w Bretanii: 
z recepcjonistk� hotelow�, z dwoma �punami bez grosza, a przede wszystkim z Jos�, w�a�cicielem baru Faro. Niczym pluszowa panda wyleguj�ca si� na kontuarze Faro, Gabriel po�wi�ca sw�j czas tym, 
kt�rzy do niego przychodz�, wiedzeni ciekawo�ci�, bardziej zauroczeni ni� nieufni. A jednak, gdyby tylko wiedzieli... Kolejny raz Pascal Garnier roztacza przed nami sw�j wyj�tkowy czar.'),

(3,9788362498383,'Daleko, dalej',2, NULL,NULL,'polski', 'francuski',1,'2021-03-01', 'mi�kka', '125 x 190 mm', 132, 100, 25, 29, 
'Sze��dziesi�ciolatek Marc ma, jak si� wydaje, wszystko, co potrzebne do szcz�cia. Dusi go jednak poczucie mia�ko�ci jego �ycia � by� mo�e ta mia�ko�� odpowiada za to, co nieudane, niezbyt chwalebne, toksyczne. 
Magia wielkiej dali ci��y w jego umy�le podsk�rn� obietnic� nowego pocz�tku dla niego i dla jego c�rki Anne, przebywaj�cej w zak�adzie psychiatrycznym. Marc, nie informuj�c nikogo, zabiera wi�c c�rk� w podr� nad morze...'),

(3,9788362498154,'Jak si� ma tw�j b�l?',2, NULL,NULL,'polski', 'francuski',1,'2017-03-01', 'mi�kka', '125 x 190 mm',176, 100, 51, 33 , 
'�mier� jest zaj�ciem Simona. Starzej�cy si� t�piciel szkodnik�w przygotowuje si� do wykonania ostatniego zlecenia. Po drodze zatrzymuje si� w Vals-les-Bains, gdzie spotyka Bernarda, 
serdecznego, nieco naiwnego ch�opaka o �agodnym spojrzeniu i dobrym sercu. Bernard nigdy nie by� nad morzem, a Simon potrzebuje kierowcy. Mo�e przez kaprys, mo�e przez rzeczywist� sympati� do cz�owieka,
 kt�ry tak r�ni si� od niego, Simon proponuje Bernardowi prac�.');

