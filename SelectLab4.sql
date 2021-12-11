USE DB_Pharmacy


	--a
SELECT [PrescriptionDoctor].[IdPrescription], [PrescriptionDoctor].[NamePatient], [PrescriptionDoctor].[SurnamePatient],  DirectoryOrder.DateOrder, Count(ListDrugs.IdPrescription) As AmountKindDrugs
FROM [PrescriptionDoctor]
INNER JOIN [ListDrugs] ON ListDrugs.IdPrescription = PrescriptionDoctor.IdPrescription
INNER JOIN [DirectoryOrder] ON DirectoryOrder.IdOrder = ListDrugs.IdOrder
Group By ListDrugs.IdPrescription, [PrescriptionDoctor].[IdPrescription], [PrescriptionDoctor].[NamePatient], [PrescriptionDoctor].[SurnamePatient] ,  DirectoryOrder.DateOrder



	--b
SELECT 
		[PrescriptionDoctor].[IdPrescription], [PrescriptionDoctor].[NamePatient], 
		[PrescriptionDoctor].[SurnamePatient],  DirectOrder.DateOrder, 
		--DirectOrder.IdOrder, Drugs.NameDrug, Drugs.Prise
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



	--c
Select TechnologyPreparation.IdTechnology, UPPER(NameDrug), Prise, ExpirationDate, Ingredients 
FROM [TechnologyPreparation]
INNER JOIN NamePharmacyDrugs ON NamePharmacyDrugs.IdTechnology = TechnologyPreparation.IdTechnology 




	-- d
SELECT 
	FactoryDrugs.NameDrug, NameFactoryDrugs.NameCompany, FactoryDrugs.[Count], 
	FactoryDrugs.DateMade, FactoryDrugs.DateUsed,
	DATEDIFF(day, DateMade, DateUsed) AS FitDay
FROM FactoryDrugs
RIGHT JOIN NameFactoryDrugs ON NameFactoryDrugs.NameDrug = FactoryDrugs.NameDrug


	--e
SELECT Drugs.NameDrug, Sum(Drugs.[Count]) As AllCount
FROM (SELECT NameDrug, [Count]
	   FROM FactoryDrugs
	   UNION
	   SELECT NameDrug, [Count]
	   FROM PharmacyDrugs) AS Drugs
GROUP BY Drugs.NameDrug


	--f
SELECT Presc.NamePatient, Presc.SurnamePatient, Count(Presc.IdPrescription) AS CountPrescription
FROM(
		SELECT NamePatient, SurnamePatient, PrescriptionDoctor.IdPrescription
		FROM PrescriptionDoctor
		INNER JOIN ListDrugs ON ListDrugs.IdPrescription = PrescriptionDoctor.IdPrescription
		GROUP BY NamePatient, SurnamePatient, PrescriptionDoctor.IdPrescription
	  ) AS Presc
GROUP BY Presc.NamePatient, Presc.SurnamePatient



	--g
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
HAVING Sum(Drugs.Prise) > 100


	-- h
Select 'True' As IsDrugsExpensive
FROM NamePharmacyDrugs
having Max(Prise) > 100

	--i
SELECT NamePatient, SurnamePatient, Name_Drug, Prise, DateOrder
FROM PrescriptionDoctor
INNER JOIN ListDrugs ON ListDrugs.IdPrescription = PrescriptionDoctor.IdPrescription
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
			FROM [NameFactoryDrugs]
			)  AS Drugs
ON DirectOrder.Name_Drug = Drugs.NameDrug
ORDER BY Prise DESC

