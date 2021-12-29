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
	SELECT @RES =  SUM(Table1.[COUNT])
	FROM (SELECT NameDrug, [Count] 
		  FROM FactoryDrugs
		  UNION
		  SELECT NameDrug, [Count] 
		  FROM PharmacyDrugs
		  ) AS Table1
	WHERE NameDrug = @Name;

	RETURN @RES;
END

DROP FUNCTION Func_Amount_Drug

SELECT dbo.Func_Amount_Drug('Îôòàì³ë50')





		--B 
CREATE FUNCTION Func_Table_Drugs()
RETURNS Table
AS RETURN 
(
	SELECT NameDrug, [Count], [DateMade], [DateUsed]
	FROM FactoryDrugs
	UNION
	SELECT NameDrug, [Count], [DateMade] , [DateUsed]
	FROM PharmacyDrugs
)


DROP FUNCTION Func_Table_Drugs 

SELECT * FROM Func_Table_Drugs()



		--C

CREATE FUNCTION Func_Table_Drugs2
(
	@minCount int
)
RETURNS @tableName Table (NameDrug nvarchar(50) Not Null, CountD int)
AS 
BEGIN
	INSERT INTO @tableName SELECT NameDrug, [Count]
	FROM (
			SELECT NameDrug, [Count], [DateMade], [DateUsed]
			FROM FactoryDrugs
			UNION
			SELECT NameDrug, [Count], [DateMade] , [DateUsed]
			FROM PharmacyDrugs
		  ) AS tabl
	WHERE [Count] >= @minCount
	RETURN 
END

DROP FUNCTION Func_Table_Drugs2

Select* from Func_Table_Drugs2('30')
