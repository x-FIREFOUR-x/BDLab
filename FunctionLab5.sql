USE DB_Pharmacy

		--a
CREATE FUNCTION Func_Amount_Drug
(
	@Name nvarchar(50)
)
RETURNS int
AS
BEGIN
	DECLARE @res INT
	SET @RES = (SELECT SUM(Table1.[COUNT])
	FROM (SELECT NameDrug, [Count] 
		  FROM FactoryDrugs
		  UNION
		  SELECT NameDrug, [Count] 
		  FROM PharmacyDrugs
		  ) AS Table1
	WHERE NameDrug = @Name)
	RETURN @RES
END

DROP FUNCTION Amount_Drug

SELECT dbo.Func_Amount_Drug('ŒÙÚ‡Ï≥Î50')





		--B / C
CREATE FUNCTION Func_Table_Drugs
(
)
RETURNS Table
AS 
	RETURN (SELECT NameDrug, [Count], [DateMade], [DateUsed]
		  FROM FactoryDrugs
		  UNION
		  SELECT NameDrug, [Count], [DateMade] , [DateUsed]
		  FROM PharmacyDrugs)


DROP FUNCTION Func_Table_Drugs 

SELECT * FROM Func_Table_Drugs()

