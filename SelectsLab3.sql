USE DB_Pharmacy


		--a
SELECT * FROM [DB_Pharmacy].[dbo].[PrescriptionDoctor];

SELECT [NameDoctor],[SurnameDoctor],[NamePatient],[SurnamePatient],[DateBirth],[Diagnosis]
FROM [DB_Pharmacy].[dbo].[PrescriptionDoctor];


		--b
DECLARE @NameDrug nvarchar(50);  
SET @NameDrug = 'Офтаміл50';   
SELECT * 
  FROM [DB_Pharmacy].[dbo].[PharmacyDrugs]
  WHERE [NameDrug] = @NameDrug;

SELECT *
  FROM [DB_Pharmacy].[dbo].[FactoryDrugs]
  WHERE [DateUsed] > getdate();


		--c
SELECT *
  FROM [DB_Pharmacy].[dbo].[NameFactoryDrugs]
  WHERE [Prise] > '50.50' AND [Prise] < '220.00';

SELECT *
  FROM [DB_Pharmacy].[dbo].[Order]
  WHERE [PriseOrder] > '945.00'OR [Count] > '25';


	--d
SELECT *
  FROM [DB_Pharmacy].[dbo].[PrescriptionDoctor]
  WHERE ([NameDoctor] = 'Василь' AND [SurnameDoctor] = 'Жук') OR ([NameDoctor] = 'Сергій' AND [SurnameDoctor] = 'Коваль');

SELECT [NameDoctor],[SurnameDoctor],[NamePatient],[SurnamePatient],[DateBirth],[Diagnosis]
  FROM [DB_Pharmacy].[dbo].[PrescriptionDoctor]
  WHERE (Not[SurNameDoctor] = 'Жук' ) AND ([NamePatient] = 'Ігор' OR [NamePatient] = 'Артем');


		--e
  SELECT  MAX([Prise])  AS MaxPrise 
  FROM [DB_Pharmacy].[dbo].[NamePharmacyDrugs];



			--f
  SELECT *
  FROM [DB_Pharmacy].[dbo].[DirectoryOrder]
  WHERE [Bought] IN ('1');

  SELECT *
  FROM [DB_Pharmacy].[dbo].[FactoryDrugs]
  WHERE [Count] BETWEEN 20 AND 62;

  SELECT *
  FROM [DB_Pharmacy].[dbo].[Order]
  WHERE [Adress] LIKE '%Янгеля%'

  SELECT *
  FROM [DB_Pharmacy].[dbo].[NameFactoryDrugs]
  WHERE [NameCompany] LIKE '_ай__';

  SELECT *
  FROM [DB_Pharmacy].[dbo].[PrescriptionDoctor]
  WHERE [SurnamePatient] LIKE '[ГК]%'

  SELECT *
  FROM [DB_Pharmacy].[dbo].[DirectoryOrder]
  WHERE [NamePharmacyDrug] IS NULL;










			--a			--- in from select

SELECT *
  FROM [DB_Pharmacy].[dbo].[NameFactoryDrugs]
  WHERE [NameDrug] = ( SELECT [NameDrug]
					   FROM [DB_Pharmacy].[dbo].[FactoryDrugs]
					   WHERE [COUNT] = 15 );

Select NameDrug, [Count], DateMade, DateUsed, Ingredients, (Select Min(Prise) From NamePharmacyDrugs ) AS Min_Price
FROM  ( Select [NamePharmacyDrugs].[NameDrug], [Count], [DateMade],[DateUsed],[Ingredients],[Recipe],[ExpirationDate]
		FROM [DB_Pharmacy].[dbo].[NamePharmacyDrugs] 
		INNER JOIN [DB_Pharmacy].[dbo].[PharmacyDrugs] ON [NamePharmacyDrugs].NameDrug = [PharmacyDrugs].NameDrug
		INNER JOIN [DB_Pharmacy].[dbo].[TechnologyPreparation] ON [NamePharmacyDrugs].IdTechnology = [TechnologyPreparation].[IdTechnology]
		) AS table2


				--b
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
			WHERE [Adress] LIKE '%Янгеля%');
			


				--c
Select [NameFactoryDrugs].[NameDrug],
		[FactoryDrugs].[DateMade],
		[FactoryDrugs].[DateUsed]
FROM [DB_Pharmacy].[dbo].[NameFactoryDrugs] CROSS JOIN [DB_Pharmacy].[dbo].[FactoryDrugs]

Select [NameFactoryDrugs].[NameDrug],
		[FactoryDrugs].[Count]
FROM [DB_Pharmacy].[dbo].[FactoryDrugs] CROSS JOIN [DB_Pharmacy].[dbo].[NameFactoryDrugs]  ;


			--d
Select [NameFactoryDrugs].[NameDrug] [NameCompany] ,[Count], [DateMade],[DateUsed]
FROM [DB_Pharmacy].[dbo].[NameFactoryDrugs], [DB_Pharmacy].[dbo].[FactoryDrugs]
WHERE [NameFactoryDrugs].NameDrug = [FactoryDrugs].NameDrug;

Select [NamePharmacyDrugs].[NameDrug] [NameCompany] ,[Count], [DateMade],[DateUsed],[Ingredients],[Recipe],[ExpirationDate]
FROM [DB_Pharmacy].[dbo].[NamePharmacyDrugs] , [DB_Pharmacy].[dbo].[PharmacyDrugs], [DB_Pharmacy].[dbo].[TechnologyPreparation]
WHERE [NamePharmacyDrugs].NameDrug = [PharmacyDrugs].NameDrug AND [NamePharmacyDrugs].IdTechnology = [TechnologyPreparation].[IdTechnology];

			--e
Select [NameFactoryDrugs].[NameDrug] [NameCompany] ,[Count], [DateMade],[DateUsed]
FROM [DB_Pharmacy].[dbo].[NameFactoryDrugs] , [DB_Pharmacy].[dbo].[FactoryDrugs]
WHERE [NameFactoryDrugs].NameDrug = [FactoryDrugs].NameDrug AND [Count] > 20;
 

Select [NamePharmacyDrugs].[NameDrug] ,[Count], [DateMade],[DateUsed],[Ingredients],[Recipe],[ExpirationDate]
FROM [DB_Pharmacy].[dbo].[NamePharmacyDrugs], [DB_Pharmacy].[dbo].[PharmacyDrugs], [DB_Pharmacy].[dbo].[TechnologyPreparation] 
WHERE [NamePharmacyDrugs].NameDrug = [PharmacyDrugs].NameDrug AND
[NamePharmacyDrugs].IdTechnology = [TechnologyPreparation].[IdTechnology] AND
[Count] > 10 AND [ExpirationDate] Like '%day%';

		--f
Select [NameFactoryDrugs].[NameDrug] [NameCompany] ,[Count], [DateMade],[DateUsed]
FROM [DB_Pharmacy].[dbo].[NameFactoryDrugs] 
INNER JOIN [DB_Pharmacy].[dbo].[FactoryDrugs] ON [NameFactoryDrugs].NameDrug = [FactoryDrugs].NameDrug;

Select [NamePharmacyDrugs].[NameDrug] ,[Count], [DateMade],[DateUsed],[Ingredients],[Recipe],[ExpirationDate]
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


			--g
Select *
FROM [DB_Pharmacy].[dbo].[NamePharmacyDrugs]
LEFT JOIN [DB_Pharmacy].[dbo].[PharmacyDrugs] ON
	[NamePharmacyDrugs].[NameDrug] = PharmacyDrugs.[NameDrug]
Left JOIN [DB_Pharmacy].[dbo].[TechnologyPreparation] ON
	[NamePharmacyDrugs].[IdTechnology] = [TechnologyPreparation].[IdTechnology]; 


			--h
Select *
FROM [DB_Pharmacy].[dbo].[NamePharmacyDrugs]
RIGHT JOIN [DB_Pharmacy].[dbo].[PharmacyDrugs] ON
	[NamePharmacyDrugs].[NameDrug] = PharmacyDrugs.[NameDrug]
Right JOIN [DB_Pharmacy].[dbo].[TechnologyPreparation] ON
[NamePharmacyDrugs].[IdTechnology] = [TechnologyPreparation].[IdTechnology]; 



Select *
FROM [DB_Pharmacy].[dbo].[NamePharmacyDrugs]
FULL JOIN [DB_Pharmacy].[dbo].[PharmacyDrugs] ON
	[NamePharmacyDrugs].[NameDrug] = PharmacyDrugs.[NameDrug];

SELECT [Count], [DateMade],[DateUsed], [NamePharmacyDrugs].[NameDrug]
FROM [DB_Pharmacy].[dbo].[NamePharmacyDrugs]
FULL JOIN [DB_Pharmacy].[dbo].[PharmacyDrugs] ON
	[NamePharmacyDrugs].[NameDrug] = PharmacyDrugs.[NameDrug];


			--i
SELECT [NameDrug], [prise], [CriticalNorm]
FROM [DB_Pharmacy].[dbo].[NamePharmacyDrugs]
UNION
SELECT [NameDrug], [prise], [CriticalNorm]
FROM [DB_Pharmacy].[dbo].[NameFactoryDrugs]

SELECT [NameDrug], [prise], [CriticalNorm]
FROM [DB_Pharmacy].[dbo].[NamePharmacyDrugs]
UNION
SELECT [NameDrug], [prise], [CriticalNorm]
FROM [DB_Pharmacy].[dbo].[NameFactoryDrugs]
UNION
SELECT [NameDrug], [Count], [IdOrder]
FROM [DB_Pharmacy].[dbo].[FactoryDrugs]
