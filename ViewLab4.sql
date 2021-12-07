USE DB_Pharmacy


		--a
CREATE VIEW Drugs AS  
SELECT  [NameDrug], [prise]
FROM [NamePharmacyDrugs]
UNION
SELECT [NameDrug], [prise]
FROM [NameFactoryDrugs]

Select* 
From Drugs


CREATE VIEW DrugsPrescription AS 
SELECT 
		PrescriptionDoctor.IdPrescription, NamePatient, SurnamePatient,
		NameDoctor, SurnameDoctor, Diagnosis, Name_Drug, DateOrder
FROM PrescriptionDoctor
INNER JOIN ListDrugs ON ListDrugs.IdPrescription = PrescriptionDoctor.IdPrescription
INNER JOIN ( SELECT [NamePharmacyDrug] AS Name_Drug, IdOrder, DateOrder
			From DirectoryOrder
			Union
			SELECT [NameFactoryDrug] AS Name_Drug, IdOrder, DateOrder
			From DirectoryOrder
			)AS DirectOrder 
ON DirectOrder.IdOrder = ListDrugs.IdOrder AND DirectOrder.Name_Drug IS NOT NULL

Select* 
From DrugsPrescription




	--b
CREATE VIEW PrescriptionDrugs AS
Select
		IdPrescription, NamePatient, SurnamePatient,
		NameDoctor, SurnameDoctor, Diagnosis, Name_Drug, DateOrder, Drugs.[Prise]
From DrugsPrescription
INNER JOIN (SELECT  [NameDrug], [prise]
			FROM [NamePharmacyDrugs]
			UNION
			SELECT [NameDrug], [prise]
			FROM [NameFactoryDrugs]) AS DRUGS
ON DrugsPrescription.Name_Drug = Drugs.NameDrug

Select* 
From PrescriptionDrugs


			--c
ALTER VIEW PrescriptionDrugs AS
Select
		IdPrescription, NamePatient, SurnamePatient,
		NameDoctor, SurnameDoctor, Diagnosis, Name_Drug, DateOrder, Drugs.[Prise]
From DrugsPrescription
INNER JOIN (SELECT  [NameDrug], [prise]
			FROM [NamePharmacyDrugs]
			UNION
			SELECT [NameDrug], [prise]
			FROM [NameFactoryDrugs]) AS DRUGS
ON DrugsPrescription.Name_Drug = Drugs.NameDrug
WHERE Prise > 100


ALTER VIEW Drugs AS
SELECT  [NameDrug], [prise]
FROM [NamePharmacyDrugs]
UNION
SELECT [NameDrug], [prise]
FROM [NameFactoryDrugs]
Where Prise > 100



		--d

EXEC sp_depends @objname = N'Drugs'
EXEC sp_depends @objname = N'PrescriptionDrugs'
EXEC sp_depends @objname = N'DrugsPrescription'

EXEC sp_help;
EXEC sp_help @objname = N'Drugs'
EXEC sp_help @objname = N'PrescriptionDrugs'
EXEC sp_help @objname = N'DrugsPrescription'


EXEC sp_helptext @objname = N'Drugs'
EXEC sp_helptext @objname = N'PrescriptionDrugs'
EXEC sp_helptext @objname = N'DrugsPrescription'