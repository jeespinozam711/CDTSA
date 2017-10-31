Create Table dbo.cbBanco ( IDBanco int identity(1,1) not null, Codigo nvarchar(10) not null, 
Descr nvarchar(250) ,Activo bit default 1 )
go

alter table dbo.cbBanco add constraint pkcbBanco primary key (IDBanco)
go

alter table dbo.cbBanco add constraint ukcbBanco unique (Codigo)
go

--drop table dbo.cbTipoCuenta
Create Table dbo.cbTipoCuenta( IDTipo int not null, Descr nvarchar(250), Activo bit default 0 )
go

alter table dbo.cbTipoCuenta add constraint pkTipoCta primary key ( IDTipo )
go

Insert dbo.cbTipoCuenta( IDTipo, Descr )
values (1, 'Cuenta Corriente' )
go
Insert dbo.cbTipoCuenta( IDTipo, Descr )
values (2, 'Cuenta Ahorro' )
go
Insert dbo.cbTipoCuenta( IDTipo, Descr )
values (3, 'Cuenta de Debito' )
go
Insert dbo.cbTipoCuenta( IDTipo, Descr )
values (4, 'Tarjeta de Credito' )
go

Create Table dbo.cbTipoDocumento ( IDTipo int not null, Tipo nvarchar(3) not null , Descr nvarchar(200), Activo bit default 1 )
go

alter table dbo.cbTipoDocumento add constraint pkcbTipoDocumento primary key (IDTipo)
go

alter table dbo.cbTipoDocumento add constraint pkcbTipoDoc unique (Tipo)
go


Create Table dbo.cbSubTipoDocumento ( IDTipo int not null, IDSubtipo int not null, 
SubTipo nvarchar(3) not null, Descr nvarchar(200), ReadOnlySys bit default 0, Activo bit default 1, Consecutivo int default 0 )

go
alter table dbo.cbSubTipoDocumento add constraint pkSubtipoDoc primary key (IDTipo, IDSubTipo)
go
alter table dbo.cbSubTipoDocumento add constraint usubtipodoc unique (SubTipo)
go

alter table dbo.cbSubTipoDocumento add constraint fksubtipodoc foreign key (IDTipo) references dbo.cbTipoDocumento (IDTipo)
go
insert dbo.cbTipoDocumento (IDTipo, Tipo, Descr, Activo )
values (0,'A/C', 'APERTURA DE SALDO DE CUENTA', 1)
GO
insert dbo.cbTipoDocumento (IDTipo, Tipo , Descr, Activo )
values (1,'CHQ', 'CHEQUE', 1)
GO
insert dbo.cbTipoDocumento (IDTipo, Tipo , Descr, Activo )
values (2,'DEP', 'DEPOSITO', 1)
GO
insert dbo.cbTipoDocumento (IDTipo, Tipo , Descr, Activo )
values (3,'N/C', 'NOTA DE CREDITO', 1)
GO
insert dbo.cbTipoDocumento (IDTipo, Tipo , Descr, Activo )
values (4,'N/D', 'NOTA DE DEBITO', 1)
GO
insert dbo.cbTipoDocumento (IDTipo, Tipo , Descr, Activo )
values (5,'T/D', 'TRANSFERENCIA TIPO DEBITO', 1)
GO
insert dbo.cbTipoDocumento (IDTipo, Tipo , Descr, Activo )
values (6,'T/C', 'TRANSFERENCIA TIPO CREDITO', 1)
GO
insert dbo.cbTipoDocumento (IDTipo, Tipo , Descr, Activo )
values (7,'O/C', 'OTROS CREDITO', 1)
GO
insert dbo.cbTipoDocumento (IDTipo, Tipo , Descr, Activo )
values (8,'O/D', 'OTROS DEBITO', 1)
GO
-- SUBTIPOS DE DOCUMENTOS delete from dbo.cbSubTipoDocumento
insert dbo.cbSubTipoDocumento (IDTipo, IDSubtipo , SUBTipo, Descr, Activo , ReadOnlySys )
values (0,0,'A/C', 'APERTURA DE SALDO DE CUENTA', 1,1)
GO
insert dbo.cbSubTipoDocumento (IDTipo, IDSubtipo, SUBTipo , Descr, Activo , ReadOnlySys )
values (1,1, 'CHQ', 'CHEQUE', 1,1)
GO
insert dbo.cbSubTipoDocumento (IDTipo, IDSubtipo, SUBTipo , Descr, Activo , ReadOnlySys)
values (2,1,'DEP', 'DEPOSITO', 1,1)
GO
insert dbo.cbSubTipoDocumento (IDTipo, IDSubtipo, SUBTipo , Descr, Activo , ReadOnlySys )
values (3,1,'N/C', 'NOTA DE CREDITO', 1,1)
GO
insert dbo.cbSubTipoDocumento (IDTipo, IDSubtipo, SUBTipo , Descr, Activo , ReadOnlySys )
values (4,1,'N/D', 'NOTA DE DEBITO', 1,1)
GO
insert dbo.cbSubTipoDocumento (IDTipo, IDSubtipo, SUBTipo , Descr, Activo , ReadOnlySys )
values (5,1,'T/D', 'TRANSFERENCIA TIPO DEBITO', 1,1)
GO
insert dbo.cbSubTipoDocumento (IDTipo, IDSubtipo, SUBTipo , Descr, Activo , ReadOnlySys )
values (6,1,'T/C', 'TRANSFERENCIA TIPO CREDITO', 1,1)
GO
insert dbo.cbSubTipoDocumento (IDTipo, IDSubtipo, SUBTipo , Descr, Activo, ReadOnlySys )
values (7,1,'O/C', 'OTROS CREDITO', 1,1 )
GO
insert dbo.cbSubTipoDocumento (IDTipo, IDSubtipo, SUBTipo , Descr, Activo , ReadOnlySys )
values (8,1,'O/D', 'OTROS DEBITO', 1, 1)
GO


-- SELECT * FROM dbo.cbSubTipoDocumento


--drop table dbo.globalMoneda
Create Table dbo.globalMoneda ( IDMoneda int not null, Moneda nvarchar(20) not null, Simbolo nvarchar(10), Descr nvarchar(100), Activo bit default 1 )
go

Alter Table dbo.globalMoneda add constraint pkglobalMoneda primary key (IDMoneda)
go

Alter Table dbo.globalMoneda add constraint ukglobalMoneda unique (Moneda)
go

INSERT dbo.globalMoneda (IDMoneda, Moneda , Descr, Simbolo )
VALUES (1, 'LOCAL', 'C�rdobas', 'C$' )
GO
INSERT dbo.globalMoneda (IDMoneda, Moneda , Descr, Simbolo )
VALUES (2, 'DOLAR', 'DOLAR', '$' )
GO
Create Table dbo.cbCuentaBancaria ( IDCuentaBanco int not null, Codigo nvarchar(25), Descr nvarchar(250),
IDBanco int not null, IDMoneda int not null, SaldoInicial decimal(28,4 ) default 0, FechaCreacion date,
IDTipo int not null, 
SaldoLibro decimal(28,4 ) default 0, SaldoBanco decimal(28,4 ) default 0, UltDeposito int default 0, UltCheque int default 0,
UltTransferencia int default 0, Limite decimal(28,4 ) default 0, 
Sobregiro bit default 0, IDCuenta int not null, Activa bit default 1 )
go

alter table dbo.cbCuentaBancaria add constraint pkcbCuentaBancaria primary key (IDCuentaBanco)
go

alter table dbo.cbCuentaBancaria add constraint fkMoneda foreign key (IDMoneda) references dbo.globalMoneda (IDMoneda)
go

alter table dbo.cbCuentaBancaria add constraint fkCuentaContable foreign key (IDCuenta) references dbo.cntCuenta (IDCuenta)
go


alter table dbo.cbCuentaBancaria add constraint fkcuentaTipo foreign key (IDTipo) references dbo.cbTipoCuenta (IDTipo)
go

alter table dbo.cbCuentaBancaria add constraint fkBanco foreign key (IDBanco) references dbo.cbBanco (IDBanco)
go


Create Table dbo.cbCuentaFormatoCheque (IDFormato int not null, IDCuentaBanco int not null, FormatoCheque nvarchar(250), UltNoCheque int , Activo bit default 1)
go

alter table dbo.cbCuentaFormatoCheque add constraint pkCuentaFormatCheque primary key (IDFormato, IDCuentaBanco)
go
alter table dbo.cbCuentaFormatoCheque add constraint fkCuentaFormatCheque foreign key (IDCuentaBanco) references dbo.cbCuentaBancaria (IDCuentaBanco)
go

--drop table dbo.cbMovimientos
Create Table dbo.cbMovimientos (IDCuentaBanco int not null, Fecha date not null, IDTipo int not null, IDSubTipo int not null, 
Numero int not null, Pagadero_a nvarchar(250), Monto decimal(28,4) default 0, Asiento nvarchar(20), Anulado bit default 0, AsientoAnulacion nvarchar(20),
Usuario nvarchar(20), UsuarioAnulacion nvarchar(20), FechaAnulacion date,
Referencia nvarchar(100) Default ' ' not null, ConceptoContable nvarchar(255) )
go

alter table dbo.cbMovimientos add constraint pkcbMovimientos primary key (IDCuentaBanco, Fecha, IDTipo, IDSubtipo, Numero)
go

alter table dbo.cbMovimientos add constraint fkcbMovimientos foreign key (IDCuentaBanco) references dbo.cbCuentaBancaria (IDCuentaBanco)
go
alter table dbo.cbMovimientos add constraint fkcbTipo foreign key (IDTipo, IDSubTipo) references dbo.cbSubTipoDocumento (IDTipo, IDSubTipo)
GO


alter table dbo.cbMovimientos 
ADD CONSTRAINT uReferenciaUnica UNIQUE NONCLUSTERED
(
 IDCuentaBanco, Fecha, IDTipo, Numero, Referencia
)
GO


--Valida si el deposito es unico segun la referncia antes de ingresarlo a la base de datos.
CREATE FUNCTION [dbo].[cbReferenciaValida] (@IDCuentaBanco int, @IDTipo int, @IDSubTipo int, @Fecha date, @Numero int, @Referencia nvarchar(100))
RETURNS bit
AS
BEGIN
declare @Resultado bit, @TipoDeposito int
Set @TipoDeposito = (SELECT Distinct IDTipo FROM dbo.cbSubTipoDocumento where SubTipo = 'DEP')

IF @IDTipo = @TipoDeposito
Begin

IF exists (SELECT Distinct IDTipo 
FROM dbo.cbMovimientos 
WHERE IDCuentaBanco = @IDCuentaBanco and IDTipo = @IDTipo and Fecha = @Fecha 
and Numero = @Numero and Referencia = @Referencia )
set @Resultado = 0
ELSE
set @Resultado = 1
end
ELSE
Begin
set @Resultado = 1
End

RETURN @Resultado
END

GO

CREATE Procedure [dbo].[cbUpdateBanco] @Operacion nvarchar(1), @IDBanco int, @Codigo nvarchar(10), @Descr nvarchar(250),@Activo BIT
as
set nocount on 

if upper(@Operacion) = 'I'
begin
	INSERT INTO dbo.cbBanco ( Codigo, Descr, Activo )
	VALUES (@Codigo,@Descr,@Activo)
end

if upper(@Operacion) = 'D'
begin

	if Exists ( Select IDBanco  from  dbo.cbCuentaBancaria    Where IDBanco  = @IDBanco)	
	begin 
		RAISERROR ( 'El Banco esta asociado a una cuenta bancaria, no puede eliminarla', 16, 1) ;
		return				
	end
	
	DELETE  FROM dbo.cbBanco WHERE IDBanco = @IDBanco 
end

if upper(@Operacion) = 'U' 
BEGIN
	UPDATE dbo.cbBanco SET  Descr = @Descr,Activo=@Activo WHERE IDBanco=@IDBanco

end

GO

CREATE Procedure [dbo].[cbUpdateCuentaBancaria] @Operacion nvarchar(1), @IDCuentaBanco int, @Codigo nvarchar(10), @Descr nvarchar(250),
			@IDBanco INT,@IDMoneda INT ,@SaldoInicial DECIMAL(28,4), @FechaCreacion DATE,@IDTipo INT, @Limite DECIMAL(28,4),@IDCuenta int ,@Activa BIT
as
set nocount on 

if upper(@Operacion) = 'I'
begin
	INSERT INTO dbo.cbCuentaBancaria  ( IDCuentaBanco ,Codigo ,Descr ,IDBanco ,IDMoneda ,SaldoInicial ,FechaCreacion ,IDTipo ,SaldoLibro ,SaldoBanco ,
	          UltDeposito ,UltCheque ,UltTransferencia ,Limite ,Sobregiro ,IDCuenta ,Activa)
	VALUES (@IDCuentaBanco,@Codigo,@Descr,@IDBanco,@IDMoneda,@SaldoInicial,@FechaCreacion,@IDTipo,0,0,0,0,0,@Limite,0,@IDCuenta,@Activa)
END 

if upper(@Operacion) = 'D'
begin

	if Exists ( Select IDCuentaBanco  from  dbo.cbMovimientos    Where IDCuentaBanco  = @IDCuentaBanco)	
	begin 
		RAISERROR ( 'La Cuenta bancanria tiene movimientos, no puede ser eliminada. ', 16, 1) ;
		return				
	end
	
	DELETE  FROM dbo.cbCuentaBancaria WHERE IDCuentaBanco = @IDCuentaBanco 
end

if upper(@Operacion) = 'U' 
BEGIN
	UPDATE dbo.cbCuentaBancaria SET Codigo=@Codigo,  Descr = @Descr, IDBanco=@IDBanco,IDMoneda=@IDMoneda,
											IDTipo=@IDTipo,Limite=@Limite,IDCuenta=@IDCuenta,Activa=@Activa
	WHERE IDCuentaBanco=@IDCuentaBanco

end

GO


CREATE Procedure [dbo].[cbUpdateSubTipoDocumento] @Operacion nvarchar(1), @IDTipo int, @IDSubTipo INT ,@SubTipo NVARCHAR(3),@Descripcion NVARCHAR(200),@Activo bit,@Consecutivo INT
as
set nocount on 

if upper(@Operacion) = 'I'
begin
	INSERT INTO dbo.cbSubTipoDocumento( IDTipo ,IDSubtipo ,SubTipo ,Descr ,ReadOnlySys ,Activo ,Consecutivo)
	VALUES  ( @IDTipo,@IDSubTipo,@SubTipo,@Descripcion,0,@Activo,@Consecutivo)
end

if upper(@Operacion) = 'D'
begin

	if  (( Select ReadOnlySys  from  dbo.cbSubTipoDocumento    Where IDSubTipo  = @IDSubTipo)	=1)
	begin 
		RAISERROR ( 'No puede eliminar el SubTipo, es un documento del sistema', 16, 1) ;
		return				
	END
	
	if Exists ( Select IDSubTipo  from  dbo.cbMovimientos    Where IDSubTipo  = @IDSubTipo)	
	begin 
		RAISERROR ( 'El SubTipo tiene movimientos, no puede eliminarla', 16, 1) ;
		return				
	end
	
	DELETE  FROM dbo.cbSubTipoDocumento WHERE IDSubtipo = IDSubtipo AND IDTipo =@IDTipo
end

if upper(@Operacion) = 'U' 
BEGIN
	UPDATE dbo.cbSubTipoDocumento SET  Descr = @Descripcion,Activo=@Activo WHERE IDTipo=@IDTipo AND IDSubtipo=@IDSubTipo

end
