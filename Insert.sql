USE[DB_Pharmacy]

INSERT INTO 
[dbo].[PrescriptionDoctor]([NameDoctor],[SurnameDoctor], [SealDoctor],[SignatureDoctor],[NamePatient],[SurnamePatient],[DateBirth],[Diagnosis])
VALUES
('������','���','0','0','�����','������','20020206','�������������'),
('�����','��������','0','0','�����','������','20020206','����� ������� ����� ����'),
('������','������������','0','0','����','������','20000907','����'),
('������','���','0','0','�������','������','19990110','�������� ������������'),
('�����','������','0','0','����','������','19990110','������'),
('�����','������','0','0','����','��������','19920110','�������');

INSERT INTO 
TechnologyPreparation([Ingredients],[Recipe],[ExpirationDate])
VALUES
('��','��','5 day'),
('��','��','10 day'),
('��','��','10 day'),
('��','��','1 mounth'),
('��','��','1 year');


INSERT INTO 
NamePharmacyDrugs([NameDrug],[Prise],[CriticalNorm], [IdTechnology])
VALUES
('������50','220.00','5','1'),
('��������','17.75','10','2'),
('�������','50.50','5','3'),
('������','120.00','10','4'),
('������','500.00','1','5');

INSERT INTO 
PharmacyDrugs([NameDrug], [Count], [DateMade], [DateUsed])
VALUES
('������50','220','20211112','20211128');

INSERT INTO 
NameFactoryDrugs([NameDrug],[NameCompany],[Prise],[CriticalNorm])
VALUES
('������','�����','210.00','5'),
('�����','���������','15.75','5'),
('������','�����','12.00','5'),
('�������','������','57.50','5'),
('������','�����������������','63.00','5');

INSERT INTO 
[Order]([Count],[Adress],[DateOrder],[PriseOrder])
VALUES
('10','�. ��� ���. ����������� ���. 23','20211110','2100.00'),
('100','�. ��� ���. ����������� ���. 23','20210711','1575.00'),
('50','�. ��� ���. ������ ���. 5','20211102','600.00'),
('62','�. ��� ���. ������ ���. 5','20211102','3565.00'),
('15','�. ��� ���. ������ ���. 10','20211102','945');

INSERT INTO 
FactoryDrugs([NameDrug],[Count],[DateMade],[DateUsed],[IdOrder])
VALUES
('������','10','20211011','20211111','1'),
('�����','100','20211015','20211115','2'),
('������','50','20211020','20211120','3'),
('�������','62','20211030','20211130','4'),
('������','15','20211030','20211230','5');

INSERT INTO 
DirectoryOrder([TypeDrug],[NamePharmacyDrug],[NameFactoryDrug],[Bought])
VALUES
('Factory',NULL,'������','0'),
('Pharmacy','������50',NULL,'1'),
('Factory',NULL,'�����','1'),
('Factory',NULL,'������','0'),
('Pharmacy','��������',NULL,'0'),
('Pharmacy','�������',NULL,'0'),
('Factory',NULL,'�������','1'),
('Pharmacy','�������',NULL,'1'),
('Factory',NULL,'������','1');

INSERT INTO 
ListDrugs([IdPrescription],[IdOrder])
VALUES
('1','1'),
('2','2'),
('2','3'),
('3','4'),
('3','5'),
('3','6'),
('4','7'),
('5','8'),
('6','9');
