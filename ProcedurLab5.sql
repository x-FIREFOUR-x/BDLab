USE DB_Pharmacy





	--a
CREATE TYPE tempTable1 AS TABLE(NameD nvarchar(50), CountD int, DateM date, DateU date);
GO


CREATE PROCEDURE MakeTempTable 
	@table tempTable1 readonly 
AS
BEGIN
  SELECT * INTO ##temp_table FROM @table
END


DECLARE @table AS tempTable1
INSERT INTO @table(NameD, CountD, DateM, DateU)
SELECT *
FROM PharmacyDrugs

EXEC MakeTempTable @table

SELECT * FROM ##temp_table



	--b
CREATE PROC GoodsPrice
	@reasonablePrice int,
	@TypeDrug nvarchar(50),
	@Name nvarchar(50)
AS
BEGIN
	IF @TypeDrug = 'Factory'
		IF @reasonablePrice > (Select Prise FROM NameFactoryDrugs WHERE NameDrug = @Name)
			SELECT [NameDrug],[NameCompany],[Prise],[CriticalNorm], 'Price is less than this' FROM NameFactoryDrugs WHERE NameDrug = @Name
		ELSE
			SELECT [NameDrug],[NameCompany],[Prise],[CriticalNorm], 'Price not is less than this' FROM NameFactoryDrugs WHERE NameDrug = @Name
	ELSE
		IF @TypeDrug = 'Pharmacy'
			IF @reasonablePrice > (Select Prise FROM NamePharmacyDrugs WHERE NameDrug = @Name)
				SELECT [NameDrug],[Prise],[CriticalNorm], 'Price is less than this' FROM NamePharmacyDrugs WHERE NameDrug = @Name
			ELSE
				SELECT [NameDrug],[Prise],[CriticalNorm], 'Price not is less than this' FROM NamePharmacyDrugs WHERE NameDrug = @Name

END 
DROP PROCEDURE GoodsPrice;

EXEC GoodsPrice 400, 'Pharmacy' ,'Киротіл'
EXEC GoodsPrice 14, 'Factory' ,'Аспірін'




		--c
CREATE PROC OddPrescription
AS
BEGIN
	DECLARE @i int
	DECLARE @size int
	SET @i = 1
	SET @size = (SELECT count(IdPrescription) FROM PrescriptionDoctor)
	WHILE @i <= @size
	BEGIN
		if @i % 2 = 0
		SELECT * FROM PrescriptionDoctor WHERE @i =IdPrescription
		SET @i = @i + 1
	END
END

DROP PROC OddPrescription

EXEC OddPrescription





		--d
CREATE PROC FitDay
AS
BEGIN
SELECT 
	FactoryDrugs.NameDrug, FactoryDrugs.[Count], 
	FactoryDrugs.DateMade, FactoryDrugs.DateUsed,
	DATEDIFF(day, DateMade, DateUsed) AS FitDay
FROM FactoryDrugs
LEFT JOIN NameFactoryDrugs ON NameFactoryDrugs.NameDrug = FactoryDrugs.NameDrug
UNION
SELECT 
	PharmacyDrugs.NameDrug, PharmacyDrugs.[Count], 
	PharmacyDrugs.DateMade, PharmacyDrugs.DateUsed,
	DATEDIFF(day, DateMade, DateUsed) AS FitDay
FROM PharmacyDrugs
LEFT JOIN NamePharmacyDrugs ON NamePharmacyDrugs.NameDrug = PharmacyDrugs.NameDrug
END

EXEC FitDay





		--e
CREATE PROC TotalPrisePreparation
	@MinPrise int
AS
BEGIN
SELECT 
		[PrescriptionDoctor].[IdPrescription], [PrescriptionDoctor].[NamePatient], 
		[PrescriptionDoctor].[SurnamePatient],  DirectOrder.DateOrder, 
		Sum(Drugs.Prise) As TotalPrise
FROM [PrescriptionDoctor]
FULL JOIN [ListDrugs] ON ListDrugs.IdPrescription = PrescriptionDoctor.IdPrescription
INNER JOIN ( SELECT [NamePharmacyDrug] AS Name_Drug, IdOrder, DateOrder
			From DirectoryOrder
			Union
			SELECT [NameFactoryDrug] AS Name_Drug, IdOrder, DateOrder
			From DirectoryOrder
			)AS DirectOrder 
ON DirectOrder.IdOrder = ListDrugs.IdOrder AND DirectOrder.Name_Drug IS NOT NULL
INNER JOIN (SELECT [NameDrug], [prise]
			FROM [NamePharmacyDrugs]
			UNION
			SELECT [NameDrug], [prise]
			FROM [NameFactoryDrugs])  AS Drugs
ON DirectOrder.Name_Drug = Drugs.NameDrug
GROUP BY [PrescriptionDoctor].[IdPrescription], [PrescriptionDoctor].[NamePatient], [PrescriptionDoctor].[SurnamePatient],  DirectOrder.DateOrder
HAVING Sum(Drugs.Prise) > @MinPrise 
END

EXEC TotalPrisePreparation 51;








	--f
Create PROC SearchDiagnosis
	@Name nvarchar(50)
AS
BEGIN
		DECLARE @Count int
		SET @Count =(SELECT TOP(1) [Count]
		FROM FactoryDrugs
		WHERE NameDrug = @Name) 

		RETURN @Count
END

DROP PROC SearchDiagnosis

DECLARE @Return_count int
EXEC @Return_count = SearchDiagnosis 'Атоксіл';
SELECT 'Count' = @Return_count;






		--g
CREATE PROC Update_PharmacyDrugs
	@Name nvarchar(50),
	@NewCount int

AS
BEGIN
	UPDATE PharmacyDrugs set [Count] = @NewCount WHERE NameDrug = @Name
END

EXEC Update_PharmacyDrugs 'Коваміл', 20






		--h
CREATE PROC AmountKindDrugsInPrescription
AS
BEGIN
	SELECT [PrescriptionDoctor].[IdPrescription], [PrescriptionDoctor].[NamePatient], [PrescriptionDoctor].[SurnamePatient],  DirectoryOrder.DateOrder, Count(ListDrugs.IdPrescription) As AmountKindDrugs
	FROM [PrescriptionDoctor]
	INNER JOIN [ListDrugs] ON ListDrugs.IdPrescription = PrescriptionDoctor.IdPrescription
	INNER JOIN [DirectoryOrder] ON DirectoryOrder.IdOrder = ListDrugs.IdOrder
	Group By ListDrugs.IdPrescription, [PrescriptionDoctor].[IdPrescription], [PrescriptionDoctor].[NamePatient], [PrescriptionDoctor].[SurnamePatient] ,  DirectoryOrder.DateOrder
END

EXEC AmountKindDrugsInPrescription
