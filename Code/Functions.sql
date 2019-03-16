CREATE OR ALTER FUNCTION BirthYear
(	
	@Year SMALLINT
)
RETURNS TABLE
AS

	RETURN SELECT Name, Surname, Profession, Height, Weight, Date_of_birth, Date_of_death 
	FROM Persons 
	WHERE YEAR(Date_of_birth) = @Year
GO


CREATE OR ALTER FUNCTION DeathYear
(
	@Year SMALLINT
)
RETURNS TABLE
AS
	RETURN SELECT Name, Surname, Profession, Height, Weight, Date_of_birth, Date_of_death
	FROM Persons
	WHERE YEAR(Date_of_death) = @Year
GO

CREATE OR ALTER FUNCTION FindExperts
(
	@Profession VARCHAR(30)
)
RETURNS TABLE
AS
	RETURN SELECT Name, Surname, District, Type, Number
	FROM Free_People
	WHERE Profession = @Profession
GO

CREATE OR ALTER FUNCTION MediumHeight
()
RETURNS TINYINT
AS
BEGIN
	DECLARE @Height TINYINT
	SET @Height = (SELECT AVG(Height) FROM Persons WHERE House not in (SELECT id FROM Houses WHERE Type='Graveyard') )
	RETURN @Height
END
GO

CREATE OR ALTER FUNCTION CapacityOfCity
()
RETURNS INT
AS
BEGIN
	DECLARE @Output INT
	SET @Output = ( SELECT SUM(Capacity) FROM Houses WHERE Type not in ('Jail', 'Bridge', 'Barrack', 'Graveyard') )
	RETURN @Output
END
GO

CREATE OR ALTER FUNCTION HowManyCanBurgsburgEarn
()
RETURNS INT
AS
BEGIN
	DECLARE @Value BIGINT
	DECLARE @Money BIGINT
	SET @Money = ISNULL((SELECT SUM(Money) FROM Persons), 0)
	SET @Value = ISNULL((SELECT SUM(Value) FROM Owners JOIN Items ON Owners.Name = Items.Name), 0)
	RETURN @Money+@Value
END
GO


CREATE OR ALTER FUNCTION ufn_getDate()
RETURNS DATE
AS
BEGIN
	DECLARE @Data DATE
	SET @Data = DATEFROMPARTS(YEAR(GETDATE())-860, MONTH(GETDATE()), DAY(GETDATE()))
	RETURN @Data;
END
GO


CREATE OR ALTER FUNCTION WealthOfPerson
(
@Person BIGINT
)
RETURNS INT
AS
BEGIN
	DECLARE @Output BIGINT
	DECLARE @Value BIGINT
	DECLARE @Money BIGINT
	SET @Money = ISNULL((SELECT SUM(Money) FROM Persons WHERE id = @Person), 0)
	SET @Value = ISNULL((SELECT SUM(Value) FROM Owners JOIN Items ON Owners.Name = Items.Name WHERE Owner = @Person), 0)
	RETURN @Money+@Value
END


