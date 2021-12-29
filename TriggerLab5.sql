USE DB_Pharmacy


		--a
CREATE TRIGGER Pharmacy_Drugs_del
ON PharmacyDrugs
FOR DELETE
AS
BEGIN
	PRINT '������ ������� ��������� ����� ������� PharmacyDrugs'
	ROLLBACK TRAN
END

DROP TRIGGER Pharmacy_Drugs_del

SELECT* FROM PharmacyDrugs

DELETE PharmacyDrugs  where NameDrug = '������'


				--������ ������ �� ��������� ���� � DirectoryOrder �� ��������� �������� �������� ���� � ListDrugs � DirectoryOrder

CREATE TRIGGER DeleteDirectoryOrder
ON DirectoryOrder
INSTEAD OF DELETE AS
BEGIN
	DECLARE @id int 
	SET @id = (SELECT IdOrder FROM deleted)


	DELETE ListDrugs
	WHERE IdOrder = @id
	DELETE DirectoryOrder
	WHERE IdOrder = @id
END

DROP TRIGGER DeleteNamePharmacyDrugs

Select* FROM DirectoryOrder
SELECT* FROM ListDrugs
SELECT* FROM PrescriptionDoctor

DELETE DirectoryOrder where IdOrder = 1;







		--b
CREATE TRIGGER Pharmacy_Drugs_upd
ON PharmacyDrugs
FOR UPDATE
AS
BEGIN
	PRINT '������ ������� ���� ������� PharmacyDrugs'
	ROLLBACK TRAN
END

DROP TRIGGER Pharmacy_Drugs_upd

SELECT* FROM PharmacyDrugs

update PharmacyDrugs set [Count] = 1000 where NameDrug = '������'


				--������ ������ ������ DirectoryOrder ���� � DirectoryOrder ������� ���������� ������������ ������� Bought ������ �������� 1
				-- ������ �� ������� ����� ��������� 1 � FactoryDrugs �� PharmacyDrugs

CREATE TRIGGER UpdateDirectoryOrder
ON DirectoryOrder
INSTEAD OF UPDATE AS
BEGIN
	DECLARE @idOrder int 
	SET @idOrder = (SELECT IdOrder FROM deleted)
	DECLARE @namePhDrug nvarchar(50) 
	SET @namePhDrug = (SELECT NamePharmacyDrug FROM deleted)
	DECLARE @nameFDrug nvarchar(50) 
	SET @nameFDrug = (SELECT NameFactoryDrug FROM deleted)
	DECLARE @bought int
	SET @bought = (Select Bought FROM deleted)

	Select* FROM deleted

	IF  @bought = 0
	BEGIN
		DECLARE @count int

		IF @namePhDrug IS NOT NULL
		BEGIN
			SET @count = (SELECT TOP(1) [Count] FROM PharmacyDrugs WHERE NameDrug = @namePhDrug ORDER BY [Count] DESC)
			SET @count = @count - 1

			UPDATE DirectoryOrder 
			SET Bought = 1
			WHERE IdOrder = @idOrder

			UPDATE PharmacyDrugs 
			SET [Count] = @count
			WHERE NameDrug = @namePhDrug
		END
		
		IF @nameFDrug IS NOT NULL
		BEGIN
			SET @count = (SELECT TOP(1) [Count] FROM FactoryDrugs WHERE NameDrug = @nameFDrug ORDER BY [Count] DESC)
			SET @count = @count - 1
		

			UPDATE DirectoryOrder 
			SET Bought = 1
			WHERE IdOrder = @idOrder

			UPDATE FactoryDrugs 
			SET [Count] = @count
			WHERE NameDrug = @nameFDrug
		END
		
	END

END

DROP TRIGGER UpdateDirectoryOrder

UPDATE DirectoryOrder
SET Bought = 1
WHERE IdOrder = 1

SELECT * FROM DirectoryOrder
SELECT * FROM FactoryDrugs
Select * FROM PharmacyDrugs


		--�
CREATE TRIGGER Pharmacy_Drugs_ins
ON PharmacyDrugs
FOR INSERT
AS
BEGIN
	PRINT '������ ������� ���������� ����� ������� PharmacyDrugs'
	ROLLBACK TRAN
END

DROP TRIGGER Pharmacy_Drugs_ins

SELECT* FROM PharmacyDrugs

INSERT INTO 
PharmacyDrugs([NameDrug], [Count], [DateMade], [DateUsed])
VALUES
('������','1000','20211112','20211128')


						--����� ��� �������� ���� ���������� ��� �������� ������ � ������� PrescriptionDoctor
CREATE TRIGGER Chech_BirthDate_PrescriptionDoctor
ON PrescriptionDoctor
INSTEAD OF INSERT AS
BEGIN
	DECLARE @date date
	SET @date = (SELECT [DateBirth] FROM inserted)

	IF (@date > '1900-01-01')
	BEGIN
		INSERT INTO PrescriptionDoctor 
		SELECT [NameDoctor],[SurnameDoctor], [NamePatient],[SurnamePatient],[DateBirth],[Diagnosis] 
		FROM inserted
	END
	ELSE
	BEGIN
		PRINT('������� �� �������� ���� ����������')
	END
END

SELECT * FROM PrescriptionDoctor

INSERT INTO 
[dbo].[PrescriptionDoctor]([NameDoctor],[SurnameDoctor], [NamePatient],[SurnamePatient],[DateBirth],[Diagnosis])
VALUES
('������','���','����','г���','20020206','�������������')

INSERT INTO 
[dbo].[PrescriptionDoctor]([NameDoctor],[SurnameDoctor], [NamePatient],[SurnamePatient],[DateBirth],[Diagnosis])
VALUES
('������','���','����','г���','18990206','�������������')

DROP TRIGGER Chech_BirthDate_PrescriptionDoctor