USE [DB_Pharmacy]
GO

CREATE TABLE [dbo].[PrescriptionDoctor](
	[IdPrescription] [int] IDENTITY(1,1) PRIMARY KEY,
	[NameDoctor] [nvarchar](50) NOT NULL,
	[SurnameDoctor] [nvarchar](50) NOT NULL,
	[SealDoctor] [image] NOT NULL,
	[SignatureDoctor] [image] NOT NULL,
	[NamePatient] [nvarchar](50) NOT NULL,
	[SurnamePatient] [nvarchar](50) NOT NULL,
	[DateBirth] [date] NOT NULL,
	[Diagnosis] [text] NOT NULL
) 
GO

CREATE TABLE [dbo].[FactoryDrugs](
	[NameDrug] [nvarchar](50) NOT NULL PRIMARY KEY,
	[NameCompany] [nvarchar](50) NOT NULL,
	[Count] [int] NOT NULL,
	[Prise][money] NOT NULL,
	[CriticalNorm][int] NOT NULL
) 
GO



CREATE TABLE [dbo].[TechnologyPreparation](
	[IdTechnology] [int] IDENTITY(1,1) PRIMARY KEY,
	[Ingredients][text] NOT NULL,
	[Recipe] [text] NOT NULL,
	[ExpirationDate][nvarchar](50) NOT NULL
) 
GO

CREATE TABLE [dbo].[PharmacyDrug](
	[NameDrug] [nvarchar](50) NOT NULL PRIMARY KEY,
	[Count] [int] NOT NULL,
	[Prise][money] NOT NULL,
	[CriticalNorm][int] NOT NULL,
	[IdTechnology] [int] NOT NULL UNIQUE FOREIGN KEY REFERENCES TechnologyPreparation(IdTechnology)
) 
GO

CREATE TABLE [dbo].[DirectoryOrder](
	[IdOrder] [int] IDENTITY(1,1) PRIMARY KEY,
	[TypeDrug][nvarchar](10) NOT NULL,
	[NamePharmacyDrug] [nvarchar](50) NULL FOREIGN KEY REFERENCES PharmacyDrug(NameDrug),
	[NameFactoryDrug] [nvarchar](50) NULL FOREIGN KEY REFERENCES FactoryDrugs(NameDrug),
	[DateOrder] [Date] DEFAULT(getdate()),
	[Bought][bit] NOT NULL
) 
GO


CREATE TABLE [dbo].[ListDrugs](
	[IdPrescription] [int] NOT NULL FOREIGN KEY REFERENCES PrescriptionDoctor(IdPrescription),
	[IdOrder] [int] NOT NULL UNIQUE FOREIGN KEY REFERENCES DirectoryOrder(IdOrder)
) 
GO

CREATE TABLE [dbo].[Order](
	[IdOrder] [int] IDENTITY(1,1)PRIMARY KEY,
	[Count] [int],
	[NameDrug] [nvarchar](50) NOT NULL FOREIGN KEY REFERENCES FactoryDrugs(NameDrug),
	[Adress][nvarchar](50) NOT NULL,
	[DateOrder][date] NOT NULL,
	[PriseOrder][money] NOT NULL
) 
GO





