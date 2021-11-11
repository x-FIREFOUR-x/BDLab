USE DB_Pharmacy
SELECT TOP (1000) [IdPrescription]
      ,[NameDoctor]
      ,[SurnameDoctor]
      ,[SealDoctor]
      ,[SignatureDoctor]
      ,[NamePatient]
      ,[SurnamePatient]
      ,[DateBirth]
      ,[Diagnosis]
  FROM [DB_Pharmacy].[dbo].[PrescriptionDoctor];

  SELECT TOP (1000) [IdTechnology]
      ,[Ingredients]
      ,[Recipe]
      ,[ExpirationDate]
  FROM [DB_Pharmacy].[dbo].[TechnologyPreparation];

  SELECT TOP (1000) [NameDrug]
      ,[Prise]
      ,[CriticalNorm]
      ,[IdTechnology]
  FROM [DB_Pharmacy].[dbo].[NamePharmacyDrugs];

  SELECT TOP (1000) [NameDrug]
      ,[Count]
      ,[DateMade]
      ,[DateUsed]
  FROM [DB_Pharmacy].[dbo].[PharmacyDrugs];

  SELECT TOP (1000) [NameDrug]
      ,[NameCompany]
      ,[Prise]
      ,[CriticalNorm]
  FROM [DB_Pharmacy].[dbo].[NameFactoryDrugs];

  SELECT TOP (1000) [NameDrug]
      ,[Count]
      ,[DateMade]
      ,[DateUsed]
	  ,[IdOrder]
  FROM [DB_Pharmacy].[dbo].[FactoryDrugs];

  SELECT TOP (1000) [IdOrder]
      ,[TypeDrug]
      ,[NamePharmacyDrug]
      ,[NameFactoryDrug]
      ,[DateOrder]
      ,[Bought]
  FROM [DB_Pharmacy].[dbo].[DirectoryOrder];

  SELECT TOP (1000) [IdPrescription]
      ,[IdOrder]
  FROM [DB_Pharmacy].[dbo].[ListDrugs];

  SELECT TOP (1000) [IdOrder]
      ,[Count]
      ,[Adress]
      ,[DateOrder]
      ,[PriseOrder]
  FROM [DB_Pharmacy].[dbo].[Order];