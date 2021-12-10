USE DB_Pharmacy


		--a
CREATE TRIGGER Pharmacy_Drugs_del
ON PharmacyDrugs
FOR DELETE
AS
BEGIN
	PRINT 'ТРИГЕР відкатив видалення даних таблиці PharmacyDrugs'
	ROLLBACK TRAN
END

DROP TRIGGER Pharmacy_Drugs_del

SELECT* FROM PharmacyDrugs

DELETE PharmacyDrugs  where NameDrug = 'Коваміл'




		--b
CREATE TRIGGER Pharmacy_Drugs_upd
ON PharmacyDrugs
FOR UPDATE
AS
BEGIN
	PRINT 'ТРИГЕР відкатив зміни ьаблиці PharmacyDrugs'
	ROLLBACK TRAN
END

DROP TRIGGER Pharmacy_Drugs_upd

SELECT* FROM PharmacyDrugs

update PharmacyDrugs set [Count] = 1000 where NameDrug = 'Коваміл'



		--с
CREATE TRIGGER Pharmacy_Drugs_ins
ON PharmacyDrugs
FOR INSERT
AS
BEGIN
	PRINT 'ТРИГЕР відкатив добавлення даних таблиці PharmacyDrugs'
	ROLLBACK TRAN
END

DROP TRIGGER Pharmacy_Drugs_ins

SELECT* FROM PharmacyDrugs

INSERT INTO 
PharmacyDrugs([NameDrug], [Count], [DateMade], [DateUsed])
VALUES
('Киротіл','1000','20211112','20211128')

