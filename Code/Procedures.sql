CREATE OR ALTER PROCEDURE TheBestStrategyofInvestment
AS
	PRINT 'You have to pay bonus for city council!'
GO

CREATE OR ALTER PROCEDURE ProposedUpgrades
AS
	DECLARE @Max INT;
	DECLARE @Current INT;
	SET @Current =	(SELECT ISNULL(SUM(Housemates),0)
				FROM Occupation_of_houses
				WHERE Type ='Possession')
	SET @Max =	(SELECT ISNULL(SUM(Capacity),0)
			FROM Houses
			WHERE Type = 'Possession')
	IF (@Max-@Current) < 10
		BEGIN
			PRINT 'Build new Possesions!' 
			SET @Current =	(SELECT ISNULL(SUM(Housemates),0)
					FROM Occupation_of_houses
					WHERE Type in ('Hut'))
		END
	ELSE
		BEGIN
			SET @Max =	(SELECT ISNULL(SUM(Capacity),0) FROM Houses WHERE Type in ('Hut'))
			IF(@Max - @Current) < 10
				PRINT 'Build new Huts!'
			ELSE
				PRINT 'Everything is ok. You can investment!'
		END
		
GO

CREATE OR ALTER PROCEDURE ChangeHouse
	@Id_person BIGINT,
	@Id_new_house INT
AS
	IF ('Barrack' = (SELECT Type from Persons inner join Houses on Persons.house = Houses.Id WHERE Persons.Id = @Id_person))
		BEGIN
			RAISERROR('That person is in barrack! He cannot change house, he must return to home.',16,1)
			RETURN;
		END
	IF ('Jail' = (SELECT Type from Houses WHERE @Id_new_house = Houses.Id))
		BEGIN
			RAISERROR('Noone want to live in Jail. :(',16,1)
			RETURN;
		END;
	IF ('Barrack' = (SELECT Type from Houses WHERE @Id_new_house = Houses.Id))
			BEGIN
			RAISERROR('That person is not a soldier, he cannot live in barrack.',16,1)
		RETURN;
		END
	IF ('Graveyard' = (SELECT Type from Houses WHERE @Id_new_house = Houses.Id) AND ( (SELECT Date_of_death FROM Persons WHERE id=@Id_person) IS NULL ) )
		BEGIN
			RAISERROR('That person is alive!',16,1)
			RETURN;
		END
	IF (SELECT Date_of_death FROM Persons WHERE @Id_person = Id) IS NOT NULL
		BEGIN
			RAISERROR('That person is death!',16,1)
			RETURN;
		END
	IF ((SELECT Money FROM Persons WHERE id=@Id_person) < 20000) AND ('Possession' = (SELECT Type FROM Houses WHERE id=@Id_new_house) )
		BEGIN
			RAISERROR('That person is too poor for possesion.', 16, 1)
			RETURN
		END
	UPDATE Persons
	SET House = @Id_new_house
	WHERE Id = @Id_person
GO


CREATE OR ALTER PROCEDURE Killing
	@Id_person BIGINT,
	@Date_of_death DATE
AS
		IF (SELECT Date_of_death FROM Persons WHERE @Id_person = id) IS NOT NULL
			BEGIN
				RAISERROR('That person has died yet.',16,1)
				RETURN;
			END
		UPDATE Persons
		SET Date_of_death = @Date_of_death WHERE Id=@Id_person
		UPDATE Persons
		SET House = (SELECT Id FROM Houses WHERE Type='Graveyard') WHERE Id=@Id_person
		UPDATE Persons
		SET Money = 0 WHERE Id=@Id_person
		DELETE FROM Owners WHERE Owner = @Id_person
GO


CREATE OR ALTER PROCEDURE PutInJail
	@Id_person BIGINT
AS

	IF (SELECT Capacity FROM Houses WHERE Type='Jail') <= (SELECT COUNT(*) FROM Jail )
		BEGIN
			RAISERROR('For this knave there is already no place in jail. Banish him! ', 16, 1)
			RETURN
		END

	IF  (SELECT Date_of_death FROM Persons WHERE Id=@Id_person) IS NOT NULL
		BEGIN
			RAISERROR('He is already dead. There is no paragraph for him.',16,1)
			RETURN;
		END
	UPDATE Persons
		SET House = (SELECT Id FROM Houses WHERE Type='Jail') WHERE Id = @Id_person
GO


CREATE OR ALTER PROCEDURE Earn
	@Id_person BIGINT
AS
	IF @Id_person not in (SELECT Id FROM Persons WHERE Persons.house not in (SELECT Id from Houses WHERE Type in ('Graveyard', 'Jail'))) and @Id_person in (SELECT Id FROM Persons)
		BEGIN
			RAISERROR('He cannot gain money!',16,1)
			RETURN
		END
	DECLARE @Salary INT
	SET @Salary = (SELECT Salary FROM Professions WHERE Professions.Name = (SELECT Profession FROM Persons WHERE Id = @Id_person))
	IF (@Salary = 0)
		BEGIN
			PRINT('City have not pay that person!')
			RETURN
		END
	UPDATE Persons
		SET Persons.Money = Persons.Money + @Salary WHERE id=@Id_person
GO

CREATE OR ALTER PROCEDURE ModifySurname
	@Id_person BIGINT,
	@Surname VARCHAR(50)
AS
	IF (SELECT Date_of_death FROM Persons WHERE Id = @Id_person) IS NOT NULL
		BEGIN
			RAISERROR('He is death!',16,1)
			RETURN
		END
	UPDATE Persons
		SET Persons.Surname = @Surname WHERE id = @Id_person
GO

CREATE OR ALTER PROCEDURE ModifyProfession
	@Id_person BIGINT,
	@Profession VARCHAR(30)
AS
	IF (SELECT Date_of_death FROM Persons WHERE Id = @Id_person) IS NOT NULL
		BEGIN
			RAISERROR('He is death!',16,1)
			RETURN
		END
	IF @Profession not in (SELECT Name FROM Professions)
		BEGIN
			RAISERROR('That Profession does not exist.', 16,1)
			RETURN
		END
	UPDATE Persons
		SET Persons.Profession = @Profession WHERE Id = @Id_person
GO

CREATE OR ALTER PROCEDURE ModifyWeight
	@Id_person BIGINT,
	@Weight TINYINT
AS
	IF (SELECT Date_of_death FROM Persons WHERE Id = @Id_person) IS NOT NULL
		BEGIN
			RAISERROR('He is death!',16,1)
			RETURN
		END
	UPDATE Persons
		SET Persons.Weight = @Weight WHERE Id = @Id_person
GO

CREATE OR ALTER PROCEDURE ModifyHeight
	@Id_person BIGINT,
	@Height TINYINT
AS
	IF (SELECT Date_of_death FROM Persons WHERE Id = @Id_person) IS NOT NULL
		BEGIN
			RAISERROR('He is death!',16,1)
			RETURN
		END
	UPDATE Persons
		SET Persons.Height = @Height WHERE Id = @Id_person
GO


CREATE OR ALTER PROCEDURE ModifyHouse
	@Id_House INT,
	@Capacity SMALLINT = 0 ,
	@Type VARCHAR(30) = 'No changes'
AS


	IF (@Capacity >= (SELECT Capacity FROM Houses WHERE Id = @Id_House) )
		BEGIN
			UPDATE Houses SET Capacity=@Capacity WHERE Id = @Id_House
		END
	IF (@Type != 'No changes')
		BEGIN
			IF (SELECT TYPE FROM Houses WHERE id = @Id_House) in ('Graveyard', 'Jail', 'Barrack', 'most') OR  (@Type) in ('Graveyard', 'Jail', 'Barrack', 'most')
				BEGIN
					RAISERROR('Type House error!', 16, 1)
					RETURN
				END
			UPDATE Houses SET Type = @Type WHERE id = @Id_House
		END
GO




CREATE OR ALTER PROCEDURE AddName
	@Name VARCHAR(25),
	@Gender VARCHAR(1)
AS
	INSERT INTO Names VALUES
	(@Name, @Gender)
GO


CREATE OR ALTER PROCEDURE AddItem
	@Name VARCHAR(30),
	@Value INT,
	@Description VARCHAR(500)
AS
	INSERT INTO Items VALUES
	(@Name, @Value, @Description)
GO

CREATE OR ALTER PROCEDURE ModifyItem
	@Name VARCHAR(30),
	@Value INT = -1,
	@Description VARCHAR(500) = ''
AS
	if (@Value > 0)
		BEGIN
			UPDATE Items
				SET Value = @Value WHERE Name=@Name
		END
	if (@Description != '')
		BEGIN
			UPDATE Items
				SET Description = @Description WHERE Name=@Name
		END
GO


CREATE OR ALTER PROCEDURE DeleteItem
	@Name VARCHAR(30)
AS
	DELETE FROM Items
		WHERE Name = @Name;
GO


CREATE OR ALTER PROCEDURE AddProfession
	@Name VARCHAR(30),
	@Salary SMALLINT = 0
AS
	INSERT INTO Professions VALUES
	(@Name, @Salary)
GO


CREATE OR ALTER PROCEDURE AddProduction
	@Profession VARCHAR(30),
	@Item VARCHAR(30)
AS
	INSERT INTO Production VALUES
	(@Profession, @Item)
GO


CREATE OR ALTER PROCEDURE BuildHouse
	@District VARCHAR(30),
	@Capacity SMALLINT,
	@Type VARCHAR(30)
AS
	IF (@Type in ('Graveyard', 'Jail', 'Barrack') )
		BEGIN
			RAISERROR('You can not build that!', 16, 1)
			RETURN
		END
	INSERT INTO Houses(District, Capacity, Type) VALUES
	(@District, @Capacity, @Type)
GO

CREATE OR ALTER PROCEDURE CreatePerson
	@Name VARCHAR(25),
	@Surname VARCHAR(50),
	@house INT,
	@Profession VARCHAR(30),
	@Height TINYINT,
	@Weight TINYINT,
	@Date_of_birth DATE,
	@Money INT = 0
AS
	IF(SELECT COUNT(*) FROM Persons WHERE house = @house) >= (SELECT Capacity FROM Houses WHERE id=@house)
		BEGIN
			RAISERROR('There is no room in this house for that person.', 16, 1)
			RETURN
		END
	INSERT INTO Persons(Name, Surname, House, Profession, Height, Weight, Date_of_birth,Money)
	VALUES (@Name, @Surname, @house, @Profession, @Height, @Weight, @Date_of_birth, @Money)
GO


CREATE OR ALTER PROCEDURE MakeTransaction
	@Provider BIGINT,
	@Customer BIGINT,
	@Date DATE,
	@Amount INT
AS
	IF (@Amount < 0 )
		BEGIN
			RAISERROR('No loans!',16,1)
			RETURN
		END
	IF (SELECT Money FROM Persons WHERE Id=@Provider) < @Amount
		BEGIN
			RAISERROR('That person have not enough money!', 16, 1)
			RETURN
		END
	IF ((@Provider in (SELECT Id FROM Persons WHERE Persons.house not in (SELECT Id from Houses WHERE Type in ('Graveyard', 'Jail'))) )  AND (@Customer in (SELECT Id FROM Persons WHERE Persons.house not in (SELECT Id from Houses WHERE Type in ('Graveyard', 'Jail'))) ) )
		BEGIN
			INSERT INTO Transactions VALUES
				(@Provider, @Customer, @Date, @Amount)
			UPDATE Persons
				SET Money = Money + @Amount WHERE Id = @Customer
			UPDATE Persons
				SET Money = Money - @Amount WHERE Id = @Provider
		END
	ELSE
		RAISERROR('That person can not transact with someone other!', 16, 1)			
GO


CREATE OR ALTER PROCEDURE ModifySalary
	@Name VARCHAR(30),
	@NewSalary SMALLINT
AS
	UPDATE Professions
		SET Salary = @NewSalary WHERE Name=@Name
GO



CREATE OR ALTER PROCEDURE CreateThing
	@Item_Name VARCHAR(30),
	@Id_person BIGINT
AS
	IF ( @Item_Name in (SELECT Item FROM Production WHERE Profession = (SELECT Profession FROM Persons WHERE Id = @Id_person)) )
		BEGIN
			INSERT INTO Owners VALUES
				(@Item_Name, @Id_person)
		END
	ELSE
		RAISERROR('That person can not create that!', 16, 1)
		RETURN
GO

CREATE OR ALTER PROCEDURE SellItem
	@Name_Item VARCHAR(30),
	@id_Person BIGINT
AS
	IF ((SELECT COUNT(*) FROM Owners WHERE Name = @Name_Item AND Owner = @id_Person) > 0)
		BEGIN
			DELETE TOP (1) FROM Owners WHERE Name = @Name_Item
			UPDATE Persons SET Money = Money + (SELECT Value FROM Items WHERE Name = @Name_Item) WHERE Id = @id_Person
		END
	ELSE
		BEGIN
			RAISERROR('That person have not that item.', 16, 1)
		END
GO



CREATE OR ALTER PROCEDURE BuyItem
	@Name_Item VARCHAR(30),
	@id_Person BIGINT
AS
	DECLARE @Price INT
	SET @Price = FLOOR((SELECT Value FROM Items WHERE Name=@Name_Item)*1.5)
	IF (SELECT Money FROM Persons WHERE Id=@id_Person) < @Price
		BEGIN
			RAISERROR('That person have not enough money', 16, 1)
			RETURN
		END
	INSERT INTO Owners VALUES
	(@Name_Item, @id_Person)
	UPDATE Persons SET Money = Money - @Price WHERE Id=@id_Person
GO


CREATE OR ALTER PROCEDURE CollectTaxes
AS
	DECLARE @Taxed TABLE
	(
		Number BIGINT IDENTITY(1,1),
		Id BIGINT
	)

	DECLARE @DATE DATE
	SET @DATE = (SELECT dbo.ufn_GetDate())

	INSERT INTO @Taxed SELECT Id FROM Persons WHERE house in (SELECT Id FROM Houses WHERE Type not in ('Graveyard', 'Jail', 'Barrack') )

	DECLARE @i BIGINT
	SET @i = 0

	WHILE (@i <= (SELECT MAX(Number) FROM @Taxed) )
		BEGIN
			DECLARE @Id_Taxed BIGINT
			SET @Id_Taxed = (SELECT TOP 1 Id FROM @Taxed)
			UPDATE Persons SET Money = Money - FLOOR(1.4 * Weight) WHERE Id = @Id_Taxed
			IF (SELECT Money FROM Persons WHERE Id = @Id_Taxed) < 0
				BEGIN
					UPDATE Persons SET Money = 0 WHERE Id = @Id_Taxed
					EXEC Killing @Id_Taxed,  @DATE
				END
			DELETE FROM @Taxed WHERE Id = @Id_Taxed
			SET @i = @i + 1
		END
GO


CREATE OR ALTER PROCEDURE Conscription
AS
	UPDATE Persons SET House = (SELECT Id FROM Houses WHERE Type = 'Barrack') WHERE Height>170 AND (SELECT Gender FROM Names WHERE Name=Persons.Name) = 'm' AND (SELECT Type FROM Houses WHERE Id = Persons.house) not in ('Jail', 'Graveyard', 'Barrack')
GO

CREATE OR ALTER PROCEDURE HomeComing
	@Id_person BIGINT
AS
	IF (SELECT house FROM Persons WHERE id=@Id_person) in (SELECT Id FROM Houses WHERE Type='Barrack')
		BEGIN 
			UPDATE Persons SET Money=Money + 20000 WHERE Id = @Id_person
			UPDATE Persons SET house = (SELECT TOP 1 Id from Houses WHERE Type='Possession' AND (SELECT COUNT(*) FROM Persons WHERE house = Houses.Id) < (Houses.Capacity) )  WHERE Id = @Id_person
		END
	ELSE
		RAISERROR('That person is not in Barrack!', 16, 1)
GO

CREATE OR ALTER PROCEDURE Banish
	@Id_person BIGINT,
	@Id_Laird BIGINT
AS
	IF (SELECT Date_of_death FROM Persons WHERE id=@Id_Laird) IS NOT NULL
		BEGIN
			RAISERROR('Laird can not be death!', 16, 1)
			RETURN
		END
	IF(@Id_Laird<0)
		BEGIN
			DELETE FROM Owners WHERE Owner=@Id_person
		END
		ELSE
			BEGIN
			UPDATE Owners

				SET Owner = @Id_Laird WHERE Owner = @Id_person
			END
			UPDATE Transactions
				SET Customer = NULL WHERE Customer = @Id_person
			UPDATE Transactions
				SET Provider = NULL WHERE Provider = @Id_person
			DELETE FROM Persons WHERE Id = @Id_person
GO





