
/*
Views:

SELECT * FROM Jail
SELECT * FROM Barrack
SELECT * FROM Graveyard
SELECT * FROM Free_People
SELECT * FROM Occupation_of_houses

*/

/*
Procedures:

exec TheBestStrategyofInvestment



exec ProposedUpgrades
exec ModifyHouse 5, 10


SELECT * FROM Persons
exec ChangeHouse 1,8
SELECT * FROM Persons


SELECT * FROM Graveyard
SELECT * FROM Persons
exec Killing 1, '1158-06-23'
SELECT * FROM Graveyard
SELECT * FROM Persons


SELECT * FROM Jail
exec PutInJail 6
SELECT * FROM Jail

SELECT * FROM Persons
exec Earn 12
SELECT * FROM Persons

SELECT * FROM Persons
exec ModifySurname 12, 'Kircher'
SELECT * FROM Persons

SELECT * FROM Persons
exec ModifyProfession 12,'Soldier'
SELECT * FROM Persons

SELECT * FROM Persons
exec ModifyWeight 2, 88
SELECT * FROM Persons

SELECT * FROM Persons
exec ModifyHeight 2,163
SELECT * FROM Persons

SELECT * FROM Houses
exec ModifyHouse 3, 60
SELECT * FROM Houses

Select * FROM Names
exec AddName 'Abraham', 'm'
SELECT * FROM Names

SELECT * FROM Items
exec AddItem 'Axe', 300, 'Standard axe.'
SELECT * FROM Items

SELECT * FROM Items
exec ModifyItem @name = 'Axe', @Value = 100, @Description = 'The best medicine!'
SELECT * FROM Items

SELECT * FROM Items
exec DeleteItem 'Axe'
SELECT * FROM Items

SELECT * FROM Professions
exec AddProfession 'Cultist', 0
SELECT * FROM Professions

SELECT * FROM Professions
exec ModifySalary 'Cultist', 20
SELECT * FROM Professions

SELECT * FROM Production
exec AddItem 'Axe', 300, 'Standard axe.'
exec AddProduction 'Smith', 'Axe'
SELECT * FROM Production


SELECT * FROM Houses
exec BuildHouse 'Harzel', 1, 'Hut'
SELECT * FROM Houses

SELECT * FROM Persons
exec CreatePerson 'Hans', 'Regerlon', 9, 'Peasant', 190, 88, '1140-11-01', 20
SELECT * FROM Persons


DECLARE @I BIGINT = 12
DECLARE @J BIGINT = 7
SELECT * FROM Transactions
SELECT * FROM Persons WHERE ID in (@I, @J)
exec MakeTransaction @I, @J, '1158-02-14', 150
SELECT * FROM Transactions
SELECT * FROM Persons WHERE ID in (@I, @J)


DECLARE @I INT = 6
SELECT * FROM Owners WHERE Owner=@I
SELECT * FROM Persons WHERE ID=@I
exec CreateThing 'Ale', @I
SELECT * FROM Owners WHERE Owner=@I

DECLARE @I INT = 6
SELECT * FROM Owners WHERE Owner=@I
SELECT * FROM Persons WHERE ID=@I
exec SellItem 'Ale', @I
SELECT * FROM Persons WHERE ID=@I
SELECT * FROM Owners WHERE Owner=@I


DECLARE @I INT = 6
SELECT * FROM Owners WHERE Owner=@I
SELECT * FROM Persons WHERE ID=@I
exec BuyItem 'Onion', @I
SELECT * FROM Persons WHERE ID=@I
SELECT * FROM Owners WHERE Owner=@I


SELECT * FROM Persons
exec CollectTaxes
SELECT * FROM Persons

SELECT * FROM Barrack
exec Conscription
SELECT * FROM Barrack


SELECT * FROM Barrack
exec Homecoming 4
SELECT * FROM Barrack

SELECT * FROM Persons
SELECT * FROM Owners
exec Banish 12, 4
SELECT * FROM Persons
SELECT * FROM Owners 



Functions:

SELECT * FROM BirthYear(1101)

SELECT * FROM DeathYear(1145)

SELECT * FROM FindExperts('Soldier')

SELECT dbo.MediumHeight()

SELECT dbo.CapacityOfCity()

SELECT dbo.HowManyCanBurgsburgEarn()

SELECT dbo.WealthOfPerson(4)

SELECT dbo.ufn_PobierzDate()



*/

