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

