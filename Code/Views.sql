-- Views
-- USE Burgsburg;


CREATE OR ALTER VIEW Graveyard(Name, Surname, Profession, Date_of_birth, Date_of_death)
AS
(
	SELECT Persons.Name, Persons.Surname, Persons.Profession, Persons.Date_of_birth, Persons.Date_of_death
	FROM Persons
	WHERE Persons.Date_of_death IS NOT NULL
);
GO

CREATE OR ALTER VIEW Barrack(Name, Surname, Profession, Height, Weight)
AS
(
	SELECT Persons.Name, Persons.Surname, Persons.Profession, Persons.Height, Persons.Weight
	FROM Persons
	WHERE Persons.House in (SELECT Id FROM Houses WHERE type ='Barrack')
);
GO

CREATE OR ALTER VIEW Jail(Name, Surname, Profession, Height, Weight)
AS
(
	SELECT Persons.Name, Persons.Surname, Persons.Profession, Persons.Height, Persons.Weight
	FROM Persons
	WHERE Persons.House in (SELECT Id FROM Houses WHERE type='Jail')
	);
GO

CREATE OR ALTER VIEW Free_People(Name, Surname, Profession, Money, District, Type, Number)
AS
(
	SELECT Persons.Name, Persons.Surname, Persons.Profession, Persons.Money, Houses.District, Houses.Type, Houses.Id
	FROM Persons
		JOIN Houses on Persons.House = Houses.Id
	WHERE Houses.Type not in ('Jail', 'Barrack', 'Graveyard')
	);
GO

CREATE OR ALTER VIEW Occupation_of_houses(District, Type, Number, Housemates, Capacity)
AS
(
	SELECT District, Type, Houses.Id, COUNT(*), Capacity
	FROM Houses INNER JOIN Persons on Houses.Id = Persons.House
	GROUP BY Houses.Id, Type, District, Capacity
	);
GO

