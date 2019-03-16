CREATE OR ALTER TRIGGER t_DeleteTransactions
ON Transactions
AFTER UPDATE
AS
	IF (SELECT COUNT(*) FROM Transactions WHERE Customer is NULL AND Provider is NULL) > 0
		BEGIN
			DELETE FROM Transactions WHERE Customer is NULL AND Provider is NULL
		END
GO


CREATE OR ALTER TRIGGER t_ControlCapacity
ON Persons
AFTER UPDATE
AS
	IF EXISTS (SELECT * FROM deleted inner join inserted on inserted.id=deleted.id WHERE inserted.House != deleted.House) 
		BEGIN

			IF (SELECT COUNT(House) FROM Persons INNER JOIN Houses on Persons.House = Houses.id WHERE Houses.Type='Bridge') >= (SELECT SUM(Capacity) FROM Houses WHERE Type = 'Bridge')
				BEGIN
					UPDATE Houses SET Capacity = Capacity + 1 WHERE Type='Bridge'
					RETURN
				END
			
			IF (SELECT COUNT(House) FROM Persons INNER JOIN Houses on Persons.House = Houses.id WHERE Houses.Type='Graveyard' GROUP BY House, Houses.Capacity HAVING COUNT(*) = Houses.Capacity) IS NOT NULL
				BEGIN
					DECLARE @i BIGINT
					SET @i = (SELECT TOP 1 ID FROM Persons WHERE Date_of_death IS NOT NULL ORDER BY Date_of_death) 
					exec Banish @i, -1
				END

			IF (SELECT COUNT(*) FROM Persons INNER JOIN Houses on Persons.House = Houses.id GROUP BY House, Houses.Capacity HAVING COUNT(*) > Houses.Capacity) > 0
				BEGIN
					RAISERROR('Coœ posz³o nie tak! Przepe³nienie Houseów!', 16, 1)
					ROLLBACK;
				END
		END
GO


CREATE OR ALTER TRIGGER t_firing
ON Professions
INSTEAD OF DELETE
AS
	PRINT('You tried to delete Profession!')
	PRINT('We should not delete Professions - we never know if there would be new person with that Profession. Anyway, we can set salary for this Profession on 0; it will be costless for city! It is like delete, is not it?')
	UPDATE Professions SET Salary = 0 WHERE Name in (SELECT Name FROM deleted)
GO

