USE DB_Pharmacy



DECLARE cur CURSOR FOR
SELECT IdPrescription, NameDoctor, SurnameDoctor,
	   NamePatient, SurnamePatient, DateBirth  
FROM PrescriptionDoctor

OPEN cur

DECLARE @IdPrescription int
DECLARE	@NameDoctor nvarchar(50)
DECLARE	@SurnameDoctor nvarchar(50)
DECLARE	@NamePatient nvarchar(50)
DECLARE	@SurnamePatient nvarchar(50) 
DECLARE	@DateBirth date 

Select @IdPrescription, @NameDoctor, 
@SurnameDoctor,	@NamePatient, @SurnamePatient, 
@DateBirth
FETCH NEXT FROM cur INTO  @IdPrescription, @NameDoctor, 
@SurnameDoctor,	@NamePatient, @SurnamePatient, 
@DateBirth

WHILE @@FETCH_STATUS = 0
BEGIN
	Select @IdPrescription, @NameDoctor, 
@SurnameDoctor,	@NamePatient, @SurnamePatient, 
@DateBirth
FETCH NEXT FROM cur INTO  @IdPrescription, @NameDoctor, 
@SurnameDoctor,	@NamePatient, @SurnamePatient, 
@DateBirth
END


Close cur

DEALLOCATE cur