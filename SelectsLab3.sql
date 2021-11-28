USE DB_Pharmacy

SELECT * FROM [DB_Pharmacy].[dbo].[PrescriptionDoctor];

SELECT [NameDoctor],[SurnameDoctor],[NamePatient],[SurnamePatient],[DateBirth],[Diagnosis]
FROM [DB_Pharmacy].[dbo].[PrescriptionDoctor];



DECLARE @NameDrug nvarchar(50);  
SET @NameDrug = '������50';   
SELECT * 
  FROM [DB_Pharmacy].[dbo].[PharmacyDrugs]
  WHERE [NameDrug] = @NameDrug;

SELECT *
  FROM [DB_Pharmacy].[dbo].[FactoryDrugs]
  WHERE [DateUsed] > getdate();



SELECT *
  FROM [DB_Pharmacy].[dbo].[NameFactoryDrugs]
  WHERE [Prise] > '50.50' AND [Prise] < '220.00';

SELECT *
  FROM [DB_Pharmacy].[dbo].[Order]
  WHERE [PriseOrder] > '945.00'OR [Count] > '25';



SELECT *
  FROM [DB_Pharmacy].[dbo].[PrescriptionDoctor]
  WHERE ([NameDoctor] = '������' AND [SurnameDoctor] = '���') OR ([NameDoctor] = '�����' AND [SurnameDoctor] = '������');

SELECT [NameDoctor],[SurnameDoctor],[NamePatient],[SurnamePatient],[DateBirth],[Diagnosis]
  FROM [DB_Pharmacy].[dbo].[PrescriptionDoctor]
  WHERE (Not[SurNameDoctor] = '���' ) AND ([NamePatient] = '����' OR [NamePatient] = '�����');


  
  SELECT  MAX([Prise])  AS MaxPrise 
  FROM [DB_Pharmacy].[dbo].[NamePharmacyDrugs];


  SELECT *
  FROM [DB_Pharmacy].[dbo].[DirectoryOrder]
  WHERE [Bought] IN ('1');

  SELECT *
  FROM [DB_Pharmacy].[dbo].[FactoryDrugs]
  WHERE [Count] BETWEEN 20 AND 62;

  SELECT *
  FROM [DB_Pharmacy].[dbo].[Order]
  WHERE [Adress] LIKE '%������%'

  SELECT *
  FROM [DB_Pharmacy].[dbo].[NameFactoryDrugs]
  WHERE [NameCompany] LIKE '_��__';

  SELECT *
  FROM [DB_Pharmacy].[dbo].[PrescriptionDoctor]
  WHERE [SurnamePatient] LIKE '[��]%'

  SELECT *
  FROM [DB_Pharmacy].[dbo].[DirectoryOrder]
  WHERE [NamePharmacyDrug] IS NULL;












SELECT *
  FROM [DB_Pharmacy].[dbo].[NameFactoryDrugs]
  WHERE [NameDrug] = ( SELECT [NameDrug]
					   FROM [DB_Pharmacy].[dbo].[FactoryDrugs]
					   WHERE [COUNT] = 15 );



SELECT *
  FROM [DB_Pharmacy].[dbo].[NameFactoryDrugs]
  WHERE EXISTS
		( SELECT *
			FROM [DB_Pharmacy].[dbo].[FactoryDrugs]
			WHERE  FactoryDrugs.NameDrug = NameFactoryDrugs.NameDrug
			AND FactoryDrugs.DateUsed > getdate());

SELECT *
  FROM [DB_Pharmacy].[dbo].[FactoryDrugs]
  WHERE [IdOrder] IN
		( SELECT [IdOrder]
			FROM [DB_Pharmacy].[dbo].[Order]
			WHERE [Adress] LIKE '%������%');
			


Select [NameFactoryDrugs].[NameDrug],
		[NameFactoryDrugs].[NameCompany] ,
		[FactoryDrugs].[Count],
		[FactoryDrugs].[DateMade],
		[FactoryDrugs].[DateUsed]
FROM [DB_Pharmacy].[dbo].[NameFactoryDrugs] CROSS JOIN [DB_Pharmacy].[dbo].[FactoryDrugs]
WHERE [NameFactoryDrugs].NameDrug = [FactoryDrugs].NameDrug;

Select [NameFactoryDrugs].[NameDrug],
		[FactoryDrugs].[Count]
FROM [DB_Pharmacy].[dbo].[FactoryDrugs] CROSS JOIN [DB_Pharmacy].[dbo].[NameFactoryDrugs]  ;



Select [NameFactoryDrugs].[NameDrug] [NameCompany] ,[Count], [DateMade],[DateUsed]
FROM [DB_Pharmacy].[dbo].[NameFactoryDrugs], [DB_Pharmacy].[dbo].[FactoryDrugs]
WHERE [NameFactoryDrugs].NameDrug = [FactoryDrugs].NameDrug;

Select [NamePharmacyDrugs].[NameDrug] [NameCompany] ,[Count], [DateMade],[DateUsed],[Ingredients],[Recipe],[ExpirationDate]
FROM [DB_Pharmacy].[dbo].[NamePharmacyDrugs] , [DB_Pharmacy].[dbo].[PharmacyDrugs], [DB_Pharmacy].[dbo].[TechnologyPreparation]
WHERE [NamePharmacyDrugs].NameDrug = [PharmacyDrugs].NameDrug AND [NamePharmacyDrugs].IdTechnology = [TechnologyPreparation].[IdTechnology];



Select [NameFactoryDrugs].[NameDrug] [NameCompany] ,[Count], [DateMade],[DateUsed]
FROM [DB_Pharmacy].[dbo].[NameFactoryDrugs] 
INNER JOIN [DB_Pharmacy].[dbo].[FactoryDrugs] ON [NameFactoryDrugs].NameDrug = [FactoryDrugs].NameDrug;

Select [NamePharmacyDrugs].[NameDrug] [NameCompany] ,[Count], [DateMade],[DateUsed],[Ingredients],[Recipe],[ExpirationDate]
FROM [DB_Pharmacy].[dbo].[NamePharmacyDrugs] 
INNER JOIN [DB_Pharmacy].[dbo].[PharmacyDrugs] ON [NamePharmacyDrugs].NameDrug = [PharmacyDrugs].NameDrug
INNER JOIN [DB_Pharmacy].[dbo].[TechnologyPreparation] ON [NamePharmacyDrugs].IdTechnology = [TechnologyPreparation].[IdTechnology];

Select [NameFactoryDrugs].[NameDrug] [NameCompany] ,[Count], [DateMade],[DateUsed]
FROM [DB_Pharmacy].[dbo].[NameFactoryDrugs] 
INNER JOIN [DB_Pharmacy].[dbo].[FactoryDrugs] ON [NameFactoryDrugs].NameDrug = [FactoryDrugs].NameDrug 
WHERE [Count] > 20;

Select [NamePharmacyDrugs].[NameDrug] [NameCompany] ,[Count], [DateMade],[DateUsed],[Ingredients],[Recipe],[ExpirationDate]
FROM [DB_Pharmacy].[dbo].[NamePharmacyDrugs] 
INNER JOIN [DB_Pharmacy].[dbo].[PharmacyDrugs] ON [NamePharmacyDrugs].NameDrug = [PharmacyDrugs].NameDrug
INNER JOIN [DB_Pharmacy].[dbo].[TechnologyPreparation] ON [NamePharmacyDrugs].IdTechnology = [TechnologyPreparation].[IdTechnology]
WHERE [Count] > 10 AND [ExpirationDate] Like '%day%';



Select *
FROM [DB_Pharmacy].[dbo].[NamePharmacyDrugs]
LEFT JOIN [DB_Pharmacy].[dbo].[PharmacyDrugs] ON
	[NamePharmacyDrugs].[NameDrug] = PharmacyDrugs.[NameDrug]; 



Select *
FROM [DB_Pharmacy].[dbo].[NamePharmacyDrugs]
RIGHT JOIN [DB_Pharmacy].[dbo].[PharmacyDrugs] ON
	[NamePharmacyDrugs].[NameDrug] = PharmacyDrugs.[NameDrug];



Select *
FROM [DB_Pharmacy].[dbo].[NamePharmacyDrugs]
FULL JOIN [DB_Pharmacy].[dbo].[PharmacyDrugs] ON
	[NamePharmacyDrugs].[NameDrug] = PharmacyDrugs.[NameDrug];

SELECT [Count], [DateMade],[DateUsed], [NamePharmacyDrugs].[NameDrug]
FROM [DB_Pharmacy].[dbo].[NamePharmacyDrugs]
FULL JOIN [DB_Pharmacy].[dbo].[PharmacyDrugs] ON
	[NamePharmacyDrugs].[NameDrug] = PharmacyDrugs.[NameDrug];