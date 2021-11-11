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
      ,[Count]
      ,[Prise]
      ,[CriticalNorm]
      ,[IdTechnology]
  FROM [DB_Pharmacy].[dbo].[PharmacyDrug];

  SELECT TOP (1000) [NameDrug]
      ,[NameCompany]
      ,[Count]
      ,[Prise]
      ,[CriticalNorm]
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
      ,[NameDrug]
      ,[Adress]
      ,[DateOrder]
      ,[PriseOrder]
  FROM [DB_Pharmacy].[dbo].[Order];