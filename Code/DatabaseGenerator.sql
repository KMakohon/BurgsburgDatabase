--DROP DATABASE Burgsburg;
--GO

--CREATE DATABASE Burgsburg;
--GO

--USE Burgsburg;
--GO

---- Drop Tabels ----

IF OBJECT_ID('Owners', 'U') IS NOT NULL 
	DROP TABLE Owners;

IF OBJECT_ID('Transactions', 'U') IS NOT NULL 
	DROP TABLE Transactions;

IF OBJECT_ID('Production', 'U') IS NOT NULL 
	DROP TABLE Production;

IF OBJECT_ID('Items', 'U') IS NOT NULL 
	DROP TABLE Items;

IF OBJECT_ID('Persons', 'U') IS NOT NULL 
	DROP TABLE Persons;

IF OBJECT_ID('Proffesions', 'U') IS NOT NULL 
	DROP TABLE Proffesions;

IF OBJECT_ID('Names', 'U') IS NOT NULL 
	DROP TABLE Names;

IF OBJECT_ID('Houses', 'U') IS NOT NULL 
	DROP TABLE Houses;







---- Create tables ----

CREATE TABLE Names
(
	Name VARCHAR(25) PRIMARY KEY,
	Gender VARCHAR(1) NOT NULL

	CONSTRAINT ck_gender CHECK (Gender in ('w', 'm'))
);


CREATE TABLE Houses
(
	Id INT PRIMARY KEY IDENTITY(1,1),
	District VARCHAR(30),
	Capacity SMALLINT NOT NULL,
	Type VARCHAR(30),

	CONSTRAINT ck_capacity CHECK (Capacity > 0),
	CONSTRAINT ck_district CHECK (District in ('Grossplatz', 'Osstor', 'Harzel', 'Rolandsbrucke', 'Verenenstadt', 'Beilheim', 'Helmsberg', 'Sudentor', 'Viehstadt')),
	CONSTRAINT ck_type CHECK (Type in ('Graveyard', 'Jail', 'Bridge', 'Barrack', 'Possession', 'Hut'))
);


CREATE TABLE Proffesions
(
	Name VARCHAR(30) PRIMARY KEY,
	Salary SMALLINT NOT NULL DEFAULT 0

);


CREATE TABLE Persons
(
   Id	BIGINT	 PRIMARY KEY IDENTITY(1,1),
   Name VARCHAR(25) FOREIGN KEY REFERENCES Names(Name) NOT NULL,
   Surname VARCHAR(50) NOT NULL,
   House INT FOREIGN KEY REFERENCES Houses(Id) NOT NULL,
   Proffesion VARCHAR(30) FOREIGN KEY REFERENCES Proffesions(Name) NOT NULL,
   Height TINYINT NOT NULL,
   Weight TINYINT NOT NULL,
   Date_of_birth DATE NOT NULL,
   Date_of_death DATE DEFAULT NULL,
   Money INT DEFAULT 0,

   CONSTRAINT ck_surname CHECK (surname LIKE '[A-Z]%'),
   --CONSTRAINT ck_age_min CHECK ( ( YEAR(dbo.ufn_GetDate()) - (YEAR(Date_of_birth) ) ) >= 14 )
);

CREATE TABLE Items
(
	Name VARCHAR(30) PRIMARY KEY,
	Value INT NOT NULL,
	Description VARCHAR(500),

	CONSTRAINT ck_value CHECK (Value>0)

);


CREATE TABLE Owners
(
	Id	BIGINT	 PRIMARY KEY IDENTITY(1,1),
	Name VARCHAR(30) FOREIGN KEY REFERENCES  Items(Name),
	Owner BIGINT FOREIGN KEY REFERENCES Persons(Id)  ON DELETE SET NULL
);


CREATE TABLE Transactions
(
	Id BIGINT PRIMARY KEY IDENTITY(1,1),
	Customer BIGINT DEFAULT -1 FOREIGN KEY REFERENCES Persons(Id),
	Provider BIGINT DEFAULT -1 FOREIGN KEY REFERENCES Persons(Id),
	Date DATE,
	Amount INT NOT NULL
	CONSTRAINT ck_amount CHECK (Amount>0)
);


CREATE TABLE Production
(
	Id	BIGINT	 PRIMARY KEY IDENTITY(1,1),
	Proffesion VARCHAR(30) FOREIGN KEY REFERENCES Proffesions(Name),
	Item VARCHAR(30) FOREIGN KEY REFERENCES Items(Name),

);

---- Set example values ----

INSERT INTO Proffesions VALUES
('Agitator', 20),
('Bailiff', 60),
('Barber-Surgeon', 0),
('Bodyguard', 0),
('Carpenter', 0),
('Charcoal-burner', 15),
('Engineer', 40),
('Entertainer', 15),
('Fisherman', 0),
('Innkeeper', 0),
('Jailer', 30),
('Mercenrary', 0),
('Merchant', 0),
('Messanger', 25),
('Miner', 30),
('Minstrel', 0),
('Peasant', 0),
('Priest', 100),
('Rat-catcher', 15),
('Scribe', 30),
('Servant', 0),
('Soldier', 30),
('Student', 0),
('Toll-keeper', 25),
('Smith', 0),
('Watchman', 30),
('Weaver', 0),
('Witch Hunter', 200)





INSERT INTO Names VALUES
('Abelhard','m'),
('Abelhelm','m'),
('Admund','m'),
('Adred','m'),
('Adric','m'),
('Agis','m'),
('Alaric','m'),
('Alberic','m'),
('Albrecht','m'),
('Aldebrand','m'),
('Aldred','m'),
('Aldric','m'),
('Alfreid','m'),
('Altmar','m'),
('Alric','m'),
('Andre','m'),
('Andred','m'),
('Andric','m'),
('Anshelm','m'),
('Anton','m'),
('Arne','m'),
('Anrulf','m'),
('Axel','m'),
('Axelbrand','m'),
('Baldred','m'),
('Baldric','m'),
('Baldwin','m'),
('Balthasar','m'),
('Barnabas','m'),
('Bart','m'),
('Bartolf','m'),
('Batomar','m'),
('Bernolt','m'),
('Bertold','m'),
('Bertolf','m'),
('Bob', 'm'),
('Boris','m'),
('Bruno','m'),
('Burgolf','m'),
('Calvin','m'),
('Casimir','m'),
('Caspar','m'),
('Cedred','m'),
('Conrad','m'),
('Corvin','m'),
('Dagmar','m'),
('Dankmar','m'),
('Dankred','m'),
('Dekmar','m'),
('Detlef','m'),
('Diebold','m'),
('Diel','m'),
('Dietfried','m'),
('Dieter','m'),
('Dietmund','m'),
('Dietrich','m'),
('Dirk','m'),
('Donat','m'),
('Durnhelm','m'),
('Eber','m'),
('Eckel','m'),
('Eckhart','m'),
('Edgar','m'),
('Edmund','m'),
('Edwin','m'),
('Ehrhart','m'),
('Ehrl','m'),
('Ehrwig','m'),
('Eldred','m'),
('Elmeric','m'),
('Emil','m'),
('Engel','m'),
('Engelbert','m'),
('Engelbrecht','m'),
('Engelhart','m'),
('Eodred','m'),
('Eomund','m'),
('Erdman','m'),
('Edred','m'),
('Erkenbrand','m'),
('Erasmus','m'),
('Erich','m'),
('Erman','m'),
('Ernst','m'),
('Erwin','m'),
('Eugen','m'),
('Eustasius','m'),
('Ewald','m'),
('Fabian','m'),
('Faustus','m'),
('Felix','m'),
('Ferdinant','m'),
('Fleugweinter','m'),
('Fosten','m'),
('Franz','m'),
('Frediger','m'),
('Fredric','m'),
('Friebald','m'),
('Friedrich','m'),
('Fulko','m'),
('Gawin','m'),
('Gerber','m'),
('Gerhart','m'),
('Gerlach','m'),
('Gernar','m'),
('Gerolf','m'),
('Gilbrecht','m'),
('Gisbert','m'),
('Giselbrecht','m'),
('Gismar','m'),
('Goran','m'),
('Gosbert','m'),
('Goswin','m'),
('Gotfried','m'),
('Gothard','m'),
('Gottolf','m'),
('Gotwin','m'),
('Gregor','m'),
('Greimold','m'),
('Grimwold','m'),
('Griswold','m'),
('Guido','m'),
('Gundolf','m'),
('Gundred','m'),
('Gunnar','m'),
('Gunter','m'),
('Gustaf','m'),
('Hadred','m'),
('Hadwin','m'),
('Hagar','m'),
('Hagen','m'),
('Haldred','m'),
('Halman','m'),
('Hamlyn','m'),
('Hans','m'),
('Harbrand','m'),
('Harman','m'),
('Hartmann','m'),
('Haug','m'),
('Heidric','m'),
('Heimar','m'),
('Heinfried','m'),
('Heinman','m'),
('Heinrich','m'),
('Heinz','m'),
('Helmut','m'),
('Henlyn','m'),
('Hermann','m'),
('Herwin','m'),
('Hieronymus','m'),
('Hildebart','m'),
('Hildebrand','m'),
('Hildemar','m'),
('Hildemund','m'),
('Hildred','m'),
('Hildric','m'),
('Horst','m'),
('Hugo','m'),
('Igor','m'),
('Ingwald','m'),
('Jander','m'),
('Jekil','m'),
('Jodokus','m'),
('Johann','m'),
('Jonas','m'),
('Jorg','m'),
('Jorn','m'),
('Josef','m'),
('Jost','m'),
('Jurgen','m'),
('Karl','m'),
('Kaspar','m'),
('Klaus','m'),
('Kleber','m'),
('Konrad','m'),
('Konradin','m'),
('Kurt','m'),
('Lamprecht','m'),
('Lanfried','m'),
('Lanric','m'),
('Lanwin','m'),
('Leo','m'),
('Leopold','m'),
('Levin','m'),
('Liebert','m'),
('Liebrecht','m'),
('Liebwin','m'),
('Lienhart','m'),
('Linus','m'),
('Lodwig','m'),
('Lothar','m'),
('Lucius','m'),
('Ludwig','m'),
('Luitpold','m'),
('Lukas','m'),
('Lupold','m'),
('Lupus','m'),
('Luther','m'),
('Lutolf','m'),
('Madred','m'),
('Magnus','m'),
('Mandred','m'),
('Manfred','m'),
('Mathias','m'),
('Max','m'),
('Maximillian','m'),
('Meiner','m'),
('Meinhart','m'),
('Meinolf','m'),
('Mekel','m'),
('Merkel','m'),
('Nat','m'),
('Nathandar','m'),
('Nicodemus','m'),
('Odamar','m'),
('Odric','m'),
('Odwin','m'),
('Olbrecht','m'),
('Oldred','m'),
('Oldric','m'),
('Ortlieb','m'),
('Ortolf','m'),
('Orwin','m'),
('Oswald','m'),
('Osric','m'),
('Oswin','m'),
('Ostfried','m'),
('Otto','m'),
('Otwin','m'),
('Paulus','m'),
('Prospero','m'),
('Ragen','m'),
('Ralf','m'),
('Rambrecht','m'),
('Randulf','m'),
('Ranuld','m'),
('Ranald','m'),
('Reikhard','m'),
('Rein','m'),
('Reiner','m'),
('Reinhard','m'),
('Reinolt','m'),
('Reuban','m'),
('Rigo','m'),
('Roderic','m'),
('Rolf','m'),
('Ruben','m'),
('Rudel','m'),
('Rudgar','m'),
('Rudolf','m'),
('Rufus','m'),
('Ruprecht','m'),
('Sebastian','m'),
('Semund','m'),
('Sepp','m'),
('Sieger','m'),
('Siegfried','m'),
('Siegmund','m'),
('Sigismund','m'),
('Sigric','m'),
('Steffan','m'),
('Tankred','m'),
('Theoderic','m'),
('Tilmann','m'),
('Tomas','m'),
('Trubald','m'),
('Trubert','m'),
('Udo','m'),
('Ulli','m'),
('Ulfred','m'),
('Ulfman','m'),
('Ulman','m'),
('Uto','m'),
('Valdred','m'),
('Valdric','m'),
('Varl','m'),
('Viggo','m'),
('Viktor','m'),
('Vilmar','m'),
('Volker','m'),
('Volkhard','m'),
('Volkrad','m'),
('Volkin','m'),
('Voltz','m'),
('Walbrecht','m'),
('Waldor','m'),
('Waldred','m'),
('Walther','m'),
('Warmund','m'),
('Werner','m'),
('Wilbert','m'),
('Wilfried','m'),
('Wilhelm','m'),
('Woldred','m'),
('Wolfram','m'),
('Wolfhart','m'),
('Wolfgang','m'),
('Wulf','m'),
('Xavier','m'),

('Abbie','w'),
('Abighild','w'),
('Abigund','w'),
('Abigunda','w'),
('Ada','w'),
('Adel','w'),
('Adelind','w'),
('Adeline','w'),
('Adelyn','w'),
('Adelle','w'),
('Agathe','w'),
('Agnete','w'),
('Aldreda','w'),
('Alfreda','w'),
('Alicia','w'),
('Allane','w'),
('Althea','w'),
('Amalie','w'),
('Amalinde','w'),
('Amalyn','w'),
('Anhilda','w'),
('Annabella','w'),
('Anna','w'),
('Anthea','w'),
('Arabella','w'),
('Aver','w'),
('Bechilda','w'),
('Bella','w'),
('Bellane','w'),
('Benedicta','w'),
('Berlinda','w'),
('Berlyn','w'),
('Bertha','w'),
('Berthilda','w'),
('Bess','w'),
('Beth','w'),
('Broncea','w'),
('Brunhilda','w'),
('Camilia','w'),
('Carla','w'),
('Carlinda','w'),
('Carlotta','w'),
('Cilicia','w'),
('Cilie','w'),
('Clora','w'),
('Clothilda','w'),
('Connie','w'),
('Constance','w'),
('Constanza','w'),
('Cordelia','w'),
('Dema','w'),
('Demona','w'),
('Desdemona','w'),
('Dorthilda','w'),
('Drachena','w'),
('Drachilda','w'),
('Edhilda','w'),
('Edith','w'),
('Edyth','w'),
('Edythe','w'),
('Eleanor','w'),
('Elinor','w'),
('Elisinda','w'),
('Elsina','w'),
('Ella','w'),
('Ellene','w'),
('Ellinde','w'),
('Eloise','w'),
('Elsa','w'),
('Elsbeth','w'),
('Elspeth','w'),
('Elyn','w'),
('Emagunda','w'),
('Emelia','w'),
('Emme','w'),
('Emmalyn','w'),
('Emmanuel','w'),
('Emerlinde','w'),
('Emerlyn','w'),
('Erica','w'),
('Ermina','w'),
('Erminlind','w'),
('Ermintrude','w'),
('Esmaralda','w'),
('Estelle','w'),
('Etheldreda','w'),
('Ethelind','w'),
('Ethelreda','w'),
('Fay','w'),
('Frieda','w'),
('Friedhilda','w'),
('Friedrun','w'),
('Friedrica','w'),
('Gabby','w'),
('Gabriele','w'),
('Galina','w'),
('Gena','w'),
('Genevieve','w'),
('Genoveva','w'),
('Gerberga','w'),
('Gerda','w'),
('Gerlinde','w'),
('Gertie','w'),
('Getrud','w'),
('Greta','w'),
('Gretchen','w'),
('Grizelda','w'),
('Grunhilda','w'),
('Gudrun','w'),
('Gudryn','w'),
('Hanna','w'),
('Hedwig','w'),
('Heidi','w'),
('Heidrun','w'),
('Helga','w'),
('Herlinde','w'),
('Herwig','w'),
('Hilda','w'),
('Hildegart','w'),
('Hildegund','w'),
('Honoria','w'),
('Ida','w'),
('Ingrid','w'),
('Ingrun','w'),
('Ingrund','w'),
('Irmella','w'),
('Irmine','w'),
('Isabella','w'),
('Isadora','w'),
('Isolde','w'),
('Jocelin','w'),
('Johanna','w'),
('Josie','w'),
('Karin','w'),
('Katherine','w'),
('Katheryn','w'),
('Katharina','w'),
('Katerine','w'),
('Keterlind','w'),
('Keterlyn','w'),
('Kitty','w'),
('Kristen','w'),
('Kristyn','w'),
('Kirsten','w'),
('Kirstyn','w'),
('Lavina','w'),
('Lavinia','w'),
('Leanor','w'),
('Leanora','w'),
('Leticia','w'),
('Letty','w'),
('Lena','w'),
('Lenora','w'),
('Lisa','w'),
('Lisbeth','w'),
('Lizzie','w'),
('Lorinda','w'),
('Lorna','w'),
('Lucinda','w'),
('Lucretia','w'),
('Lucie','w'),
('Ludmilla','w'),
('Mabel','w'),
('Madge','w'),
('Magdalyn','w'),
('Maggie','w'),
('Maghilda','w'),
('Maglind','w'),
('Maglyn','w'),
('Magunda','w'),
('Magreta','w'),
('Maida','w'),
('Marien','w'),
('Marietta','w'),
('Margaret','w'),
('Margreta','w'),
('Marline','w'),
('Marlyn','w'),
('Mathilda','w'),
('Maude','w'),
('May','w'),
('Meg','w'),
('Melicent','w'),
('Miranda','w'),
('Moll','w'),
('Nathilda','w'),
('Nellie','w'),
('Nora','w'),
('Olga','w'),
('Ophelia','w'),
('Osterhild','w'),
('Ostelle','w'),
('Ostia','w'),
('Ottagunda','w'),
('Ottaline','w'),
('Ottilda','w'),
('Ottilyn','w'),
('Perdita','w'),
('Pergale','w'),
('Pergunda','w'),
('Petronella','w'),
('Philomelia','w'),
('Reikgilda','w'),
('Renata','w'),
('Rosabel','w'),
('Rosabella','w'),
('Rosalie','w'),
('Rosalia','w'),
('Rosalin','w'),
('Rosalinde','w'),
('Rosamunde','w'),
('Rosanne','w'),
('Rose','w'),
('Roz','w'),
('Rozhilda','w'),
('Salina','w'),
('Saltza','w'),
('Sigismunda','w'),
('Sigrid','w'),
('Sigunda','w'),
('Solla','w'),
('Styrine','w'),
('Talima','w'),
('Theodora','w'),
('Therese','w'),
('Tilea','w'),
('Ursula','w'),
('Ulrica','w'),
('Valeria','w'),
('Verena','w'),
('Wilfrieda','w'),
('Wilhelmina','w'),
('Winifred','w'),
('Wolfhilde','w'),
('Zemelda','w'),
('Zena','w');


INSERT INTO Houses VALUES
('Sudentor', 10, 'Graveyard'),
('Harzel', 2, 'Jail'),
('Osstor', 5, 'Barrack'),
('Harzel', 20, 'Bridge'),
('Grossplatz', 4, 'Possession'),
('Beilheim', 6, 'Hut'),
('Harzel', 6, 'Hut'),
('Sudentor', 6, 'Hut'),
('Osstor', 6, 'Hut'),
('Osstor', 6, 'Possession')


INSERT INTO Items VALUES
('Ale', 5, 'Brewed from wheat, barley, yeast and other mysterious ingredients,
ale is one of the staple drinks of the Burgsburg.'),
('Beer', 10, 'Similar to ale, yet brewed with hops for added flavour and
longevity, beer is the travellers friend.'),
('Bread', 5, 'The staple fare of the Burgsburgs diet.'),
('Poor Clothing', 40, 'A slight step above rags.'),
('Common Male Clothing', 100, 'Includes breeches with few patches, stained, and slightly frayer shirt, light cloak, and shoes or old boots.'),
('Common Female Clothing', 300, 'Includes plain dresses cinched at the waist with a thin belt of cloth or leather, with shoes, and a light cloak.'),
('Sword', 500, 'Bladed weapon intended for slashing or thrusting that is longer than a knife or dagger.'),
('Onion', 1, 'Vegetable that protect from diseases.')


INSERT INTO Production VALUES
('Peasant', 'Bread'),
('Peasant', 'Onion'),
('Smith', 'Sword'),
('Innkeeper', 'Ale'),
('Innkeeper', 'Beer'),
('Weaver', 'Poor Clothing'),
('Weaver', 'Common Male Clothing'),
('Weaver', 'Common Female Clothing')





INSERT INTO Persons VALUES
('Karin', 'Schmidt', 2, 'Peasant', 165, 93, '1111-06-06', NULL, 0),
('Heinrich', 'Schmidt', 2, 'Peasant', 164, 101, '1109-05-05', NULL, 0),
('Hans', 'Schuhmacher', 1, 'Soldier', 188, 40, '1101-02-21', '1145-12-01', 0),
('Wolfgang', 'Andrejewicz', 3, 'Soldier', 190, 80, '1105-09-18', NULL, 100),
('Otto', 'Hemme', 5, 'Soldier', 188, 70, '1128-09-01', NULL, 20),
('Eckel', 'Staib', 6, 'Innkeeper', 170, 63, '1131-11-24', NULL, 40),
('Hans', 'Moretz', 8, 'Weaver', 200, 125, '1100-02-12', NULL, 39),
('Kaspar', 'Semrau', 9, 'Barber-Surgeon', 154, 50, '1141-11-11', NULL, 0),
('Abigunda', 'Kolle', 4, 'Smith', 160, 54, '1132-12-29', NULL, 0),
('Arne', 'Buecker', 1, 'Barber-Surgeon', 170, 66, '1111-11-11', '1157-02-02', 0),
('Helga', 'Schodernborn', 7, 'Witch Hunter', 190, 240, '1102-01-31', NULL, 0),
('Bob', 'Schwarzberger', 5, 'Priest', 177, 82, '1133-06-06', NULL, 40000),
('Johann', 'Neumann', 8, 'Peasant', 165, 55, '1140-05-02', NULL, 0)



INSERT INTO Transactions VALUES
(1, 2, '1145-06-01', 200),
(2, 1, '1145-11-05', 200)

INSERT INTO Owners VALUES
('Common Male Clothing', 7),
('Beer', 12),
('Onion', 13),
('Ale', 4)



---- WYŚWIETLANIE TABELI ----

SELECT * FROM Names
SELECT * FROM Houses
SELECT * FROM Items
SELECT * FROM Production
SELECT * FROM Transactions
SELECT * FROM Proffesions
SELECT * FROM Owners
SELECT * FROM Persons
GO

SELECT * FROM Jail
SELECT * FROM Barrack
SELECT * FROM Graveyard
SELECT * FROM Free_People
SELECT * FROM Occupation_of_houses


