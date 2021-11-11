USE DB_Pharmacy

DELETE FROM TechnologyPreparation Where IdTechnology = '1';

DELETE FROM [Order] Where IdOrder = '1';

UPDATE PharmacyDrug
SET Prise='130.00'
WHERE NameDrug='Коваміл';

UPDATE PrescriptionDoctor
SET SignatureDoctor='1111', SealDoctor = '1111'
WHERE SurnameDoctor='Жук';

UPDATE DirectoryOrder
SET Bought = '0';

ALTER TABLE PrescriptionDoctor
ALTER COLUMN SignatureDoctor [image] NULL;

ALTER TABLE [Order]
ALTER COLUMN [Count] [bigint];

ALTER TABLE PrescriptionDoctor
ADD FatherName [nvarchar](50) NULL;

ALTER TABLE PrescriptionDoctor
Drop COLUMN FatherName;

ALTER TABLE PrescriptionDoctor
Drop COLUMN SealDoctor;