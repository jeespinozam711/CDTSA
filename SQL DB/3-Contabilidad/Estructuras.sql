

Create table dbo.cntTipoCuenta ( IDTipo int not null, Descr nvarchar(255), Tipo nvarchar(1), Activo bit default 1 )
go

alter table dbo.cntTipoCuenta add constraint pkTipoCuenta primary key (IDtipo)
go

Create table dbo.cntSubTipoCuenta ( IDTipo int not null, IDSubTipo int not null,  Descr nvarchar(255), 
SubTipo nvarchar(1), Activo bit default 1, Naturaleza nvarchar(1) )
go

alter table dbo.cntSubTipoCuenta add constraint pkcntSubTipoCuenta primary key (IDtipo, IDSubTipo)
go

alter table dbo.cntSubTipoCuenta add constraint fkcntSubTipoCuenta foreign key (IDtipo) references dbo.cntTipoCuenta ( IDtipo )
go

alter table dbo.cntSubTipoCuenta add constraint chkSubTipoCta CHECK ( Naturaleza in ('D', 'A'))
go
--*********** LOS TIPOS DE CUENTA SON VALORES POR DEFECTO DEL SISTEMA, SE TIENEN QUE INGRESAR AL CREAR LA BASE DE DATOS
insert dbo.cntTipoCuenta ( IDTipo, Descr, Tipo, Activo )
values (1, 'Balance de Situación', 'B', 1)
go

insert dbo.cntTipoCuenta ( IDTipo, Descr, Tipo, Activo )
values (2, 'Estado de Resultado', 'R', 1)
go

insert dbo.cntTipoCuenta ( IDTipo, Descr, Tipo, Activo )
values (3, 'Cuenta de Orden', 'O', 1)
go

insert dbo.cntSubTipoCuenta ( IDTipo, IDSubTipo , Descr, SubTipo, Activo, Naturaleza  )
values (1,1,  'Activo', 'A', 1, 'D')
go

insert dbo.cntSubTipoCuenta ( IDTipo, IDSubTipo , Descr, SubTipo, Activo, Naturaleza  )
values (1,2,  'Pasivo', 'P', 1, 'A')
go
 
insert dbo.cntSubTipoCuenta ( IDTipo, IDSubTipo , Descr, SubTipo, Activo, Naturaleza  )
values (1,3,  'Patrimonio', 'T', 1, 'A')
go

insert dbo.cntSubTipoCuenta ( IDTipo, IDSubTipo , Descr, SubTipo, Activo, Naturaleza  )
values (2,1,  'Ingreso', 'I', 1, 'A')
go

insert dbo.cntSubTipoCuenta ( IDTipo, IDSubTipo , Descr, SubTipo, Activo, Naturaleza  )
values (2,2,  'Costos', 'C', 1, 'D')

insert dbo.cntSubTipoCuenta ( IDTipo, IDSubTipo , Descr, SubTipo, Activo, Naturaleza  )
values (2,3,  'Gasto', 'G', 1, 'D')
go

Insert dbo.cntSubTipoCuenta ( IDTipo, IDSubTipo , Descr, SubTipo, Activo, Naturaleza  )
values (3,1,  'Cuenta de Orden Deudora', 'O', 1, 'D')
go

Insert dbo.cntSubTipoCuenta ( IDTipo, IDSubTipo , Descr, SubTipo, Activo, Naturaleza  )
values (3,2,  'Cuenta de Orden Acreedora', 'O', 1, 'A')
go

 
Create Table dbo.cntGrupoCuenta ( 
IDGrupo int not null, 
Nivel1 nvarchar(10) not null, 
Descr nvarchar(255) not null, 
UsaComplementaria bit default 0, 
IDTipo int not null,
IDSubTipo int not null, 
Activo bit default 1)
go

alter table dbo.cntGrupoCuenta add constraint pkGrupo primary key (IDGrupo)
go

alter table dbo.cntGrupoCuenta add constraint fkTipo foreign key (IDTipo) references dbo.cntTipoCuenta (IDTipo)
go

alter table dbo.cntGrupoCuenta add constraint fksubGrupo foreign key (IDTipo, IDSubTipo) references dbo.cntSubTipoCuenta (IDTipo, IDSubTipo)
go

insert  dbo.cntGrupoCuenta  (IDGrupo, Nivel1, Descr,   UsaComplementaria, IDTipo , IDSubTipo )
values (1, '1', 'ACTIVOS',   0, 1,1)
GO

insert  dbo.cntGrupoCuenta  (IDGrupo, Nivel1, Descr,   UsaComplementaria, IDTipo , IDSubTipo)
values (2, '2', 'PASIVOS',   0,1,2)
GO

insert  dbo.cntGrupoCuenta  (IDGrupo, Nivel1, Descr,   UsaComplementaria, IDTipo , IDSubTipo)
values (3, '3', 'PATRIMONIO',   0,1,3)
GO

insert  dbo.cntGrupoCuenta  (IDGrupo, Nivel1, Descr,   UsaComplementaria, IDTipo , IDSubTipo)
values (4, '4', 'INGRESOS',   0,2,1)
GO

insert  dbo.cntGrupoCuenta  (IDGrupo, Nivel1, Descr,   UsaComplementaria, IDTipo , IDSubTipo)
values (5, '5', 'COSTOS',   0,2,2)
GO

insert  dbo.cntGrupoCuenta  (IDGrupo, Nivel1, Descr,   UsaComplementaria, IDTipo , IDSubTipo)
values (6, '6', 'GASTOS',   0,2,3)
GO


insert  dbo.cntGrupoCuenta  (IDGrupo, Nivel1, Descr,   UsaComplementaria, IDTipo , IDSubTipo)
values (8, '8', 'CUENTAS DE ORDEN DEUDORA',   0,3,1)
GO

insert  dbo.cntGrupoCuenta  (IDGrupo, Nivel1, Descr,   UsaComplementaria, IDTipo , IDSubTipo)
values (9, '9', 'CUENTAS DE ORDEN ACREEDORA',   0,3,2)
GO

Create Table dbo.cntCuenta ( 
IDCuenta bigint not null identity (1,1), 
IDGrupo int not null, 
IDTipo int not null,
IDSubTipo int not null, 
Tipo nvarchar(1) not null,
SubTipo nvarchar(1) not null, 
Nivel1 nvarchar(50)  default '', 
Nivel2 nvarchar(50)  default '', 
Nivel3 nvarchar(50)  default '', 
Nivel4 nvarchar(50)  default '' , 
Nivel5 nvarchar(50)  default '',
Nivel6 nvarchar(50)  default '',
Cuenta nvarchar(50) not null default '', 
Descr nvarchar(255),
Complementaria bit default 0,
EsMayor bit default 0, 
AceptaDatos bit default 0,
Activa bit default 1, 
IDCuentaAnterior BIGINT not null,
IDCuentaMayor BIGINT not null,
UsaCentroCosto bit default 0
)
go


alter table dbo.cntCuenta add constraint chkMayorCentro CHECK ((cast(isnull(EsMayor,0) as int)+ cast(isnull(UsaCentroCosto,0) as int) )<=1)
go

alter table dbo.cntCuenta add constraint chkMayor CHECK ((cast(isnull(EsMayor,0) as int)+ cast(isnull(AceptaDatos,0) as int) )=1)
go
Alter Table dbo.cntCuenta add constraint pkcntCuenta primary key (IDCuenta)
go

Alter Table dbo.cntCuenta add constraint fkcntCuentaGrupo 
foreign key  (IDGrupo) references dbo.cntGrupoCuenta (IDGrupo)
go

Alter Table dbo.cntCuenta add constraint fkcntCuentaAnterior 
foreign key  (IDCuenta) references dbo.cntCuenta (IDCuenta)
go

Alter Table dbo.cntCuenta add constraint fkcntCuentaMayor 
foreign key  (IDCuenta) references dbo.cntCuenta (IDCuenta)
go

Alter Table dbo.cntCuenta add constraint ukcntCuenta UNIQUE (Cuenta)

go

--Insercion de las cuentas principales
INSERT INTO dbo.cntCuenta( IDGrupo ,IDTipo ,IDSubTipo ,Tipo ,SubTipo ,Nivel1 ,Nivel2 ,Nivel3 ,Nivel4 ,Nivel5 ,Nivel6 ,Cuenta ,Descr ,Complementaria ,EsMayor ,AceptaDatos ,Activa ,IDCuentaAnterior ,IDCuentaMayor ,UsaCentroCosto)
VALUES  (1,1,1,'B','A',1,0,0,0,0,0,'1.0.0.0.0.0','ACTIVOS',0,1,0,1,0,0,0)
GO
INSERT INTO dbo.cntCuenta( IDGrupo ,IDTipo ,IDSubTipo ,Tipo ,SubTipo ,Nivel1 ,Nivel2 ,Nivel3 ,Nivel4 ,Nivel5 ,Nivel6 ,Cuenta ,Descr ,Complementaria ,EsMayor ,AceptaDatos ,Activa ,IDCuentaAnterior ,IDCuentaMayor ,UsaCentroCosto)
VALUES  (2,1,2,'B','P',2,0,0,0,0,0,'2.0.0.0.0.0','PASIVOS',0,1,0,1,1,0,0)
GO
INSERT INTO dbo.cntCuenta( IDGrupo ,IDTipo ,IDSubTipo ,Tipo ,SubTipo ,Nivel1 ,Nivel2 ,Nivel3 ,Nivel4 ,Nivel5 ,Nivel6 ,Cuenta ,Descr ,Complementaria ,EsMayor ,AceptaDatos ,Activa ,IDCuentaAnterior ,IDCuentaMayor ,UsaCentroCosto)
VALUES  (3,1,3,'B','T',3,0,0,0,0,0,'3.0.0.0.0.0','PATRIMONIO',0,1,0,1,2,0,0)
GO
INSERT INTO dbo.cntCuenta( IDGrupo ,IDTipo ,IDSubTipo ,Tipo ,SubTipo ,Nivel1 ,Nivel2 ,Nivel3 ,Nivel4 ,Nivel5 ,Nivel6 ,Cuenta ,Descr ,Complementaria ,EsMayor ,AceptaDatos ,Activa ,IDCuentaAnterior ,IDCuentaMayor ,UsaCentroCosto)
VALUES  (4,2,1,'R','I',4,0,0,0,0,0,'4.0.0.0.0.0','INGRESOS',0,1,0,1,3,0,0)
GO
INSERT INTO dbo.cntCuenta( IDGrupo ,IDTipo ,IDSubTipo ,Tipo ,SubTipo ,Nivel1 ,Nivel2 ,Nivel3 ,Nivel4 ,Nivel5 ,Nivel6 ,Cuenta ,Descr ,Complementaria ,EsMayor ,AceptaDatos ,Activa ,IDCuentaAnterior ,IDCuentaMayor ,UsaCentroCosto)
VALUES  (5,2,2,'R','C',5,0,0,0,0,0,'5.0.0.0.0.0','COSTOS',0,1,0,1,4,0,0)
GO
INSERT INTO dbo.cntCuenta( IDGrupo ,IDTipo ,IDSubTipo ,Tipo ,SubTipo ,Nivel1 ,Nivel2 ,Nivel3 ,Nivel4 ,Nivel5 ,Nivel6 ,Cuenta ,Descr ,Complementaria ,EsMayor ,AceptaDatos ,Activa ,IDCuentaAnterior ,IDCuentaMayor ,UsaCentroCosto)
VALUES  (6,2,3,'R','G',6,0,0,0,0,0,'6.0.0.0.0.0','GASTOS',0,1,0,1,5,0,0)
GO
INSERT INTO dbo.cntCuenta( IDGrupo ,IDTipo ,IDSubTipo ,Tipo ,SubTipo ,Nivel1 ,Nivel2 ,Nivel3 ,Nivel4 ,Nivel5 ,Nivel6 ,Cuenta ,Descr ,Complementaria ,EsMayor ,AceptaDatos ,Activa ,IDCuentaAnterior ,IDCuentaMayor ,UsaCentroCosto)
VALUES  (8,3,1,'O','O',8,0,0,0,0,0,'8.0.0.0.0.0','CUENTAS DE ORDEN DEUDORA',0,1,0,1,6,0,0)
GO
INSERT INTO dbo.cntCuenta( IDGrupo ,IDTipo ,IDSubTipo ,Tipo ,SubTipo ,Nivel1 ,Nivel2 ,Nivel3 ,Nivel4 ,Nivel5 ,Nivel6 ,Cuenta ,Descr ,Complementaria ,EsMayor ,AceptaDatos ,Activa ,IDCuentaAnterior ,IDCuentaMayor ,UsaCentroCosto)
VALUES  (9,3,2,'O','O',9,0,0,0,0,0,'9.0.0.0.0.0','CUENTAS DE ORDEN ACREEDORA',0,1,0,1,7,0,0)

GO


Create trigger trgCuenta on dbo.cntCuenta for Insert, Update
as
Declare @UsaSeparadorCta bit, @SeparadorCta nvarchar(1), @iCantidad int , @UsaPredecesor bit, @charPredecesor nvarchar(1), 
@cantCharNivel1 int,  @cantCharNivel2 int, @cantCharNivel3 int, @cantCharNivel4 int, @cantCharNivel5 int , @cantCharNivel6 int

Select top 1 @UsaSeparadorCta = UsaSeparadorCta, @SeparadorCta = SeparadorCta, @UsaPredecesor = UsaPredecesor,
@charPredecesor = charPredecesor, @cantCharNivel1 = cantCharNivel1, @cantCharNivel2 = cantCharNivel2,
@cantCharNivel3 = cantCharNivel3, @cantCharNivel4 = cantCharNivel4, @cantCharNivel5 = cantCharNivel5, @cantCharNivel6 = cantCharNivel6
from  dbo.cntParametros

Update c set Cuenta = right(replicate ( @charPredecesor, @cantCharNivel1) +  ISNULL(i.Nivel1,'')  , @cantCharNivel1 ) + 
case when @UsaSeparadorCta= 1 and i.Nivel2<> '' then @SeparadorCta else '' end 
+ case when ISNULL(i.Nivel2,'')<> '' then right (replicate (CASE WHEN @UsaPredecesor=1 then @charPredecesor ELSE '' end, @cantCharNivel2)+ i.Nivel2, @cantCharNivel2)  else '' end 
+ case when @UsaSeparadorCta= 1 and i.Nivel3<> '' then @SeparadorCta else '' end
+ case when ISNULL(i.Nivel3,'')<> '' then right (replicate ( CASE WHEN @UsaPredecesor=1 then @charPredecesor ELSE '' end, @cantCharNivel3)+ i.Nivel3, @cantCharNivel3)  else '' end
+ case when @UsaSeparadorCta= 1 and i.Nivel4<> '' then @SeparadorCta else '' end
+ case when ISNULL(i.Nivel4,'')<> '' then right (replicate ( CASE WHEN @UsaPredecesor=1 then @charPredecesor ELSE '' end, @cantCharNivel4)+ i.Nivel4, @cantCharNivel4)  else '' end
+ case when @UsaSeparadorCta= 1 and i.Nivel5<> '' then @SeparadorCta else '' end
+ case when ISNULL(i.Nivel5,'')<> '' then right (replicate ( CASE WHEN @UsaPredecesor=1 then @charPredecesor ELSE '' end, @cantCharNivel5)+ i.Nivel5, @cantCharNivel5)  else '' end
+ case when @UsaSeparadorCta= 1 and i.Nivel6<> '' then @SeparadorCta else '' end
+ case when ISNULL(i.Nivel6,'')<> '' then right (replicate ( CASE WHEN @UsaPredecesor=1 then @charPredecesor ELSE '' end, @cantCharNivel6)+ i.Nivel6, @cantCharNivel6)  else '' end
From inserted i inner join dbo.cntCuenta c
on i.IDGrupo = c.IDGrupo and i.IDCuenta = c.IDCuenta 

go

CREATE  TABLE [dbo].[cntParametros](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[UsaSeparadorCta] [bit] NULL,
	[SeparadorCta] [nvarchar](1) NULL,
	[UsaPredecesor] [bit] NULL,
	[charPredecesor] [nvarchar](1) NULL,
	[CantCharNivel1] [int] NULL,
	[CantCharNivel2] [int] NULL,
	[CantCharNivel3] [int] NULL,
	[CantCharNivel4] [int] NULL,
	[CantCharNivel5] [int] NULL,
	[CantCharNivel6] [int] NULL,	
	[IDCtaUtilidadPeriodoIngresos] [bigint] NULL,
	[IDCtaUtilidadPeriodoCostos] BIGINT NULL,
	[IDCtaUtilidadPeriodoGastos] BIGINT NULL,
 	[IDCtaUtilidadAcumulada] [bigint] NULL,
	[MesInicioPeriodoFiscal] [int] NULL,
	[MesFinalPeriodoFiscal] [int] NULL,
	[UsaSeparadorCentro] [bit] NULL,
	[SeparadorCentro] [nvarchar](1) NULL,
	[UsaPredecesorCentro] [bit] NULL,
	[charPredecesorCentro] [nvarchar](1) NULL,
	[LongAsiento] [int] NULL,
	[TipoCambio] [nvarchar](20)
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[cntParametros]  WITH CHECK ADD  CONSTRAINT [fkctautilAcumPeriodo] FOREIGN KEY([IDCtaUtilidadAcumulada])
REFERENCES [dbo].[cntCuenta] ([IDCuenta])
GO

ALTER TABLE [dbo].[cntParametros] CHECK CONSTRAINT [fkctautilAcumPeriodo]
GO

ALTER TABLE [dbo].[cntParametros]  WITH CHECK ADD  CONSTRAINT [fkctautilperiodoIngresos] FOREIGN KEY([IDCtaUtilidadPeriodoIngresos])
REFERENCES [dbo].[cntCuenta] ([IDCuenta])
GO

ALTER TABLE [dbo].[cntParametros] CHECK CONSTRAINT [fkctautilperiodoIngresos]
GO

ALTER TABLE [dbo].[cntParametros]  WITH CHECK ADD  CONSTRAINT [fkctautilperiodoCostos] FOREIGN KEY([IDCtaUtilidadPeriodoCostos])
REFERENCES [dbo].[cntCuenta] ([IDCuenta])
GO

ALTER TABLE [dbo].[cntParametros] CHECK CONSTRAINT [fkctautilperiodoCostos]
GO


ALTER TABLE [dbo].[cntParametros]  WITH CHECK ADD  CONSTRAINT [fkctautilperiodoGastos] FOREIGN KEY([IDCtaUtilidadPeriodoGastos])
REFERENCES [dbo].[cntCuenta] ([IDCuenta])
GO

ALTER TABLE [dbo].[cntParametros] CHECK CONSTRAINT [fkctautilperiodoGastos]
GO

ALTER TABLE [dbo].[cntParametros]  WITH CHECK ADD  CONSTRAINT [fkctParametro_TipoCambio] FOREIGN KEY([TipoCambio])
REFERENCES [dbo].[globalTipoCambio] (IDTipoCambio)
GO

ALTER TABLE [dbo].[cntParametros] CHECK CONSTRAINT [fkctParametro_TipoCambio]

ALTER TABLE [dbo].[cntParametros] ADD  CONSTRAINT [DF__cntParame__UsaSe__1ED998B2]  DEFAULT ((0)) FOR [UsaSeparadorCta]
GO

ALTER TABLE [dbo].[cntParametros] ADD  CONSTRAINT [DF__cntParame__UsaPr__1FCDBCEB]  DEFAULT ((0)) FOR [UsaPredecesor]
GO

ALTER TABLE [dbo].[cntParametros] ADD  CONSTRAINT [DF__cntParame__CantC__20C1E124]  DEFAULT ((0)) FOR [CantCharNivel1]
GO

ALTER TABLE [dbo].[cntParametros] ADD  CONSTRAINT [DF__cntParame__CantC__21B6055D]  DEFAULT ((0)) FOR [CantCharNivel2]
GO

ALTER TABLE [dbo].[cntParametros] ADD  CONSTRAINT [DF__cntParame__CantC__22AA2996]  DEFAULT ((0)) FOR [CantCharNivel3]
GO

ALTER TABLE [dbo].[cntParametros] ADD  CONSTRAINT [DF__cntParame__CantC__239E4DCF]  DEFAULT ((0)) FOR [CantCharNivel4]
GO

ALTER TABLE [dbo].[cntParametros] ADD  CONSTRAINT [DF__cntParame__CantC__24927208]  DEFAULT ((0)) FOR [CantCharNivel5]
GO

ALTER TABLE [dbo].[cntParametros] ADD  CONSTRAINT [DF__cntParame__CantC__24927208X]  DEFAULT ((0)) FOR [CantCharNivel6]
GO

ALTER TABLE [dbo].[cntParametros] ADD  CONSTRAINT [DF__cntParame__MesIn__25869641]  DEFAULT ((0)) FOR [MesInicioPeriodoFiscal]
GO

ALTER TABLE [dbo].[cntParametros] ADD  CONSTRAINT [DF__cntParame__MesFi__267ABA7A]  DEFAULT ((0)) FOR [MesFinalPeriodoFiscal]
GO

ALTER TABLE [dbo].[cntParametros] ADD  CONSTRAINT [DF__cntParame__UsaPr__276EDEB3]  DEFAULT ((0)) FOR [UsaPredecesorCentro]
GO

ALTER TABLE [dbo].[cntParametros] ADD  CONSTRAINT [DF__cntParame__LongA__286302EC]  DEFAULT ((10)) FOR [LongAsiento]
GO



insert dbo.cntParametros  ( UsaSeparadorCta, SeparadorCta, UsaPredecesor, charPredecesor, CantCharNivel1, CantCharNivel2,
CantCharNivel3, CantCharNivel4, CantCharNivel5,CantCharNivel6, MesInicioPeriodoFiscal, MesFinalPeriodoFiscal,UsaSeparadorCentro, SeparadorCentro , UsaPredecesorCentro , charPredecesorCentro , LongAsiento ,TipoCambio   )
values ( 1, '.', 0,  '0',  1, 2,3,4, 5,6, 1, 12,1, '.', 0, '0', 10 ,'TVEN')

go

Create  View  dbo.vcntCatalogo 
as 
SELECT C.IDGrupo, G.Descr DescrGrupo, C.IDCuenta, C.Nivel1, C.Nivel2, C.Nivel3, C.Nivel4, C.Nivel5,C.Nivel6,
C.Cuenta, C.Descr DescrCuenta, S.Naturaleza ,S.Naturaleza NaturalezaSaldo ,
--case when c.Complementaria = 0 then S.Naturaleza 
--else case when  s.naturaleza = 'D' then 'A' 
--	 else 'D' 
--	 end
--end NaturalezaSaldo, 
 C.EsMayor, C.AceptaDatos , 
c.IDTipo, T.Descr DescrTipo,C.Tipo, C.IDSubTipo, S.Descr DescrSubTipo, S.SubTipo, 
C.Complementaria, C.UsaCentroCosto, C.IDCuentaMayor
FROM dbo.cntCuenta C INNER JOIN dbo.cntGrupoCuenta G on C.IDGrupo = G.IDGrupo 
inner join dbo.cntSubTipoCuenta S on C.IDTipo = s.IDTipo and C.IDSubTipo = S.IDSubTipo
inner join dbo.cntTipoCuenta T on C.IDTipo = T.IDTipo

go

Create Table dbo.cntEjercicio ( IDEjercicio int not null, Descr nvarchar(50), FechaInicio date, FechaFin date,
 Activo bit default 1, InicioOperaciones bit default 0, MesInicioOperaciones int, Cerrado bit default 0 ) 
go

alter table dbo.cntEjercicio add constraint pkcntEjercicio primary key (IDEjercicio)
go


alter table dbo.cntEjercicio add constraint chkperiodocierre check  ((Cerrado = 1 and activo = 1 ) or (Cerrado = 0 and Activo = 1) or (Cerrado = 0 and Activo = 0))
go


CREATE FUNCTION [dbo].[cntInicioOperaciones] ()
RETURNS bit
AS
BEGIN
Declare @Resultado int, @Iniciado bit 
set @Resultado = (
	Select COUNT(*)
	From dbo.cntEjercicio
	where InicioOperaciones = 1 --AND Activo = 1
	)
if @Resultado is null
	set @Resultado = 0
if @Resultado >= 1
	set @Iniciado = 1
else
	set @Iniciado = 0

RETURN @Iniciado
END
go


CREATE FUNCTION [dbo].[cntCantInicioOperaciones] ()
RETURNS int
AS
BEGIN
Declare @Resultado int, @Iniciado int 
set @Resultado = (
	Select COUNT(*)
	From dbo.cntEjercicio
	where InicioOperaciones = 1 AND Activo = 1
	)
if @Resultado is null
	set @Resultado = 0

	set @Iniciado = @Resultado

RETURN @Iniciado
END
go

CREATE FUNCTION [dbo].[cntCantEjerciciosAbiertos] ()
RETURNS int
AS
BEGIN
Declare @Resultado int, @Iniciado int 
set @Resultado = (
	Select COUNT(*)
	From dbo.cntEjercicio
	where Cerrado = 0 AND Activo = 1
	)
if @Resultado is null
	set @Resultado = 0

	set @Iniciado = @Resultado

RETURN @Iniciado
END
go


Alter Table dbo.cntEjercicio add constraint chkEjercicioInicioOperaciones 
check ( (not [dbo].[cntCantInicioOperaciones] ()>1 ) )				
go

Alter Table dbo.cntEjercicio add constraint chkEjercicioInicOperMesInicio 
check ( (InicioOperaciones = 1 and MesInicioOperaciones > 0) or (InicioOperaciones = 0 and MesInicioOperaciones = 0) )				
go


Alter Table dbo.cntEjercicio add constraint chkRangoAnio 
check ( DateDiff( day, FechaInicio, FechaFin) between 364 and 365 )				 
go
Create Table dbo.cntPeriodoContable ( IDEjercicio int not null, Periodo nvarchar(10) not null, FechaFinal date not null, Descr nvarchar(255) ,
FinPeriodoFiscal bit default 0, Cerrado bit default 0, AjustesCierreFiscal bit default 0, Activo bit default 1, PeriodoTrabajo bit default 0 )
go 

alter table dbo.cntPeriodoContable add constraint pkPeriodoContable primary key (IDEjercicio, Periodo)
go

alter table dbo.cntPeriodoContable add constraint fkPeriodoContable foreign key (IDEjercicio) references dbo.cntEjercicio ( IDEjercicio )
go


alter table dbo.cntPeriodoContable add constraint chkPeriodoContablecierre check  ((Cerrado = 1 and activo = 1 ) or (Cerrado = 0 and Activo = 1) or (Cerrado = 0 and Activo = 0))
go

alter table dbo.cntPeriodoContable add constraint 
chkPeriodoContablePerTrabajo 
check  (
(Cerrado = 1 and activo = 1 and PeriodoTrabajo = 0) or 
(Cerrado = 0 and Activo = 1 and PeriodoTrabajo = 1) or 
(Cerrado = 0 and Activo = 1 and PeriodoTrabajo = 0) or 
(Cerrado = 0 and Activo = 0 and PeriodoTrabajo = 0)
)

GO


Create Function dbo.cntEjercicioPeriodoDeTrabajo (@IDEjercicio int)
RETURNS int
BEGIN
Declare @Resultado int 
	set @Resultado =  ( Select count(*) 
				From dbo.cntPeriodoContable 
				Where IDEjercicio = @IDEjercicio and PeriodoTrabajo = 1 )	
		if @Resultado is null
			set @Resultado = 0

return @Resultado
END
go



Create Function dbo.cntEjercicioPeriodoAjusteCierreFiscal (@IDEjercicio int)
RETURNS int
BEGIN
Declare @Resultado int 
	set @Resultado =  ( Select count(*) 
				From dbo.cntPeriodoContable 
				Where IDEjercicio = @IDEjercicio and AjustesCierreFiscal = 1 )	
		if @Resultado is null
			set @Resultado = 0

return @Resultado
END
go

Create Function dbo.cntEjercicioPeriodoFinPeriodoFiscal (@IDEjercicio int)
RETURNS int
BEGIN
Declare @Resultado int 
	set @Resultado =  ( Select count(*) 
				From dbo.cntPeriodoContable 
				Where IDEjercicio = @IDEjercicio and FinPeriodoFiscal = 1 )	
		if @Resultado is null
			set @Resultado = 0

return @Resultado
END
go

Create Function dbo.cntEjercicioCntFinPeriodoFiscal (@IDEjercicio int)
RETURNS int
BEGIN
Declare @Resultado int 
	set @Resultado =  ( Select count(*) 
				From dbo.cntPeriodoContable 
				Where IDEjercicio = @IDEjercicio and FinPeriodoFiscal = 1 )	
		if @Resultado is null
			set @Resultado = 0

return @Resultado
END
go

--drop trigger trPeriodoContable
Create Trigger trPeriodoContable on dbo.cntPeriodoContable after Insert, Update
as
Declare @IDPeriodo int, @IDEjercicio int, @AjustesCierreFiscal bit, @FinPeriodoFiscal bit , @PeriodoTrabajo bit, @Activo bit
SElect @IDEjercicio = i.IDEjercicio, @AjustesCierreFiscal = i.AjustesCierreFiscal, @FinPeriodoFiscal = i.FinPeriodoFiscal,
@PeriodoTrabajo = PeriodoTrabajo, @Activo = Activo 
from inserted i
if @AjustesCierreFiscal = 1 and  dbo.cntEjercicioPeriodoAjusteCierreFiscal( @IDEjercicio)>1
begin
		RAISERROR ( 'Se intenta crear un Periodo Contable indicando que inicia Ajuste de Cierre Fiscal, pero ya Existe uno en ese Ejercicio...', 16, 1) ;
		rollback tran 
end

if @FinPeriodoFiscal = 1 and  dbo.cntEjercicioPeriodoFinPeriodoFiscal( @IDEjercicio)>1
begin
		RAISERROR ( 'Se intenta crear un Periodo Contable indicando que es Fin de Ciclo, pero ya Existe uno en ese Ejercicio...', 16, 1) ;
		rollback tran 
end

if @Activo = 0 and @PeriodoTrabajo = 1
begin
		RAISERROR ( 'Se intenta crear un Periodo Contable indicando que es Periodo de Trabajo, pero esta inactivo...', 16, 1) ;
		rollback tran 
end




go

Create Procedure dbo.cntCreaPeriodos @IDEjercicio int,  @AnioInicialPeriodo int
as
set nocount on
--set @AnioInicialPeriodo = 2017
Declare @MesInicioPeriodoFiscal int, @MesFinalPeriodoFiscal int, @MesPivote int, 
@Fecha date, @Periodo13 nvarchar(10), @Fecha13 date, @Periodo nvarchar(10), @FinPeriodo BIT,@PeriodoTrabajo BIT	
Declare @InicioOperaciones bit, @MesInicioOperaciones int, @Activo bit 
 Select @InicioOperaciones= InicioOperaciones, @MesInicioOperaciones =MesInicioOperaciones
 from dbo.cntejercicio
 where IDEjercicio = @IDEjercicio
-- validar si no existe movimientos en cualquier periodos del anio
if @InicioOperaciones = 0
	set @Activo = 1
SElect Top 1 @MesInicioPeriodoFiscal = MesInicioPeriodoFiscal, @MesFinalPeriodoFiscal = MesFinalPeriodoFiscal   
from dbo.cntParametros

SET @PeriodoTrabajo=0

Delete from dbo.cntPeriodoContable where FechaFinal >=  cast (cast(@AnioInicialPeriodo as nvarchar(4) ) + right ('00'+ cast ( @MesInicioPeriodoFiscal as nvarchar(2) ),2) + '01' as datetime )
and  FechaFinal <= dateadd ( month, 12, cast (cast(@AnioInicialPeriodo as nvarchar(4) ) + right ('00'+ cast ( @MesInicioPeriodoFiscal as nvarchar(2) ),2) + '01' as datetime ) )

set @MesPivote = 1

	set @Fecha = cast (cast(@AnioInicialPeriodo as nvarchar(4) ) + right ('00'+ cast ( @MesInicioPeriodoFiscal as nvarchar(2) ),2) + '01' as datetime )
	--set @Fecha = (select  [dbo].[globalDiaDelMes] (DATEADD (month,11, @Fecha ), 'U'))
	set @Fecha =  (select  [dbo].[globalDiaDelMes](@Fecha, 'U'))
While @MesPivote <= 13
begin
	set @Periodo = cast(year(@Fecha) as nvarchar(4) ) + right ('00' + cast(month(@Fecha) as nvarchar(4) ),2) 
	set @FinPeriodo = 0
	if @MesPivote <= 12
	begin	
		if @InicioOperaciones = 1 and   @MesPivote< @MesInicioOperaciones
			set @Activo = 0
		else
			set @Activo = 1
		if @MesPivote = 12
			set @FinPeriodo = 1
		IF (@MesPivote=@MesInicioOperaciones)
			SET @PeriodoTrabajo =1
		ELSE 
			SET @PeriodoTrabajo =0
		Insert dbo.cntPeriodoContable ( IDEjercicio, Periodo , FechaFinal, Descr, FinPeriodoFiscal, Activo,PeriodoTrabajo)
		Values (@IDEjercicio, @Periodo, @Fecha, 'Periodo ' + @Periodo , @FinPeriodo, @Activo,@PeriodoTrabajo )
	end

	
	if @MesPivote = 13
	begin
		set @Periodo13  =(cast(year(@Fecha) as nvarchar(4) ) + '13' )
		-- esto estaba antes con fecha 1 del mes siguiente al ultimo mes del periodo
		--set @Fecha13 = DATEADD ( month, 1,  cast (cast(year(@Fecha) as nvarchar(4) )+ right('00'+ cast(month(@Fecha) as nvarchar(4) ),2)+ '01' as datetime ) )
		set @Fecha13 = @Fecha 

			Insert dbo.cntPeriodoContable ( IDEjercicio, Periodo , FechaFinal, Descr, FinPeriodoFiscal, AjustesCierreFiscal )
			Values (@IDEjercicio, @Periodo13, @Fecha13, 'Ajustes al Cierre Fiscal  ' + cast (@IDEjercicio as nvarchar(20)) , 0,1)		
		
	end 

	set @MesPivote = @MesPivote + 1
	if @MesPivote <= 12
		set @Fecha = dateadd(month,1,@Fecha)
		set @Fecha =  (select  [dbo].[globalDiaDelMes](@Fecha, 'U'))
		
	
end

go

--******* para crear un EJERCICIO

Create Function dbo.cntExisteEjercicioConInicioOperaciones ()
Returns bit
begin
Declare @Existe bit
	set @Existe = (select  [dbo].[cntInicioOperaciones] ())
	Return @Existe
end
go
-- drop procedure dbo.cntCreaEjercicio exec dbo.cntCreaEjercicio  '20170101', 1,5 select * from cntperiodocontable select * from cntEjercicio
Create Procedure dbo.cntCreaEjercicio @FechaInicio date, @InicioOperaciones bit, @MesInicioOperaciones int
--Parametros del proceso de crear ejercicio 
-- @FechaInicio Es la Fecha en donde se inicia el Ejercicio de doce meses
-- @InicioOperaciones Indica si el ejercicio a crearse inicia o no las operaciones por primera vez
-- @MesInicioOperaciones Si es inicio de operaciones se indica el mes en que se inician las operaciones
as
Declare @FechaFin date,  @IDEjercicio int, @Anio int
set nocount on 
if dbo.cntExisteEjercicioConInicioOperaciones () = 1 and @InicioOperaciones = 1
begin
	RAISERROR ( 'Se intenta crear un Ejercicio Contable indicando que inicia operaciones, pero ya Existe uno...', 16, 1) ;
	return
end
 
if @InicioOperaciones = 0
	set  @MesInicioOperaciones = 0
Set  @FechaInicio = (select  [dbo].[globalDiaDelMes] ( @FechaInicio, 'P')) 
set @FechaFin = (select  [dbo].[globalDiaDelMes] (DATEADD (month,11, @FechaInicio ), 'U'))

set @Anio = (YEAR ( @FechaInicio ))

if exists (Select IDEjercicio from dbo.cntEjercicio where IDEjercicio = @Anio )
begin
	RAISERROR ( 'Ejercicio Contable Existente ...', 16, 1) ;
	return	
end
insert dbo.cntEjercicio ( IDEjercicio, Descr, FechaInicio, FechaFin , Activo, InicioOperaciones, MesInicioOperaciones)
values ( @Anio , 'Ejercicio ' + CAST( @Anio as nvarchar(4) ), @FechaInicio, @FechaFin,1, @InicioOperaciones,@MesInicioOperaciones)
EXEC dbo.cntCreaPeriodos   @Anio, @Anio

go


Create Table dbo.cntCentroCosto ( IDCentro int identity(0,1) not null, Nivel1 nvarchar(2),  
Nivel2 nvarchar(2), Nivel3 nvarchar(2), Nivel4 nvarchar(2),  Centro nvarchar(20), Descr nvarchar(255),
IDCentroAnterior int, Acumulador bit default 0,IDCentroAcumulador int,  ReadOnlySys bit default 0, Activo bit default 1)
go
Alter table dbo.cntCentroCosto add constraint pkCentro primary key (IDCentro)
go

alter table  dbo.cntCentroCosto add constraint fkCentroAcumulador foreign key (IDCentroAcumulador) references dbo.cntCentroCosto(IDCentro)
go

alter table  dbo.cntCentroCosto add constraint fkCentroAnterior foreign key (IDCentroAnterior) references dbo.cntCentroCosto(IDCentro)
go

alter table  dbo.cntCentroCosto add constraint ukcentroCentro unique (Centro)
go

Create trigger trgCentro on dbo.cntCentroCosto for Insert, Update
as
Declare @UsaSeparadorCentro bit, @SeparadorCentro nvarchar(1),  @UsaPredecesorCentro bit, @charPredecesorCentro nvarchar(1)

Select top 1 @UsaSeparadorCentro = UsaSeparadorCentro, @SeparadorCentro = SeparadorCentro, 
@UsaPredecesorCentro = UsaPredecesorCentro, @charPredecesorCentro = charPredecesorCentro
from  dbo.cntParametros


Update c set Centro = right(replicate ( @charPredecesorCentro, 2) +  ISNULL(i.Nivel1,'')  , 2 ) + 
case when @UsaSeparadorCentro= 1 and i.Nivel2<> '' then @SeparadorCentro else '' end 
+ case when ISNULL(i.Nivel2,'')<> '' then right (replicate ( @charPredecesorCentro, 2)+ isnull(i.Nivel2,''), 2)  else '' end 
+ case when @UsaSeparadorCentro= 1 and i.Nivel3<> '' then @SeparadorCentro else '' end
+ case when ISNULL(i.Nivel3,'')<> '' then right (replicate ( @charPredecesorCentro, 2)+ isnull(i.Nivel3,''), 2)  else '' END
+ case when @UsaSeparadorCentro= 1 and i.Nivel4<> '' then @SeparadorCentro else '' end
+ case when ISNULL(i.Nivel4,'')<> '' then right (replicate ( @charPredecesorCentro, 2)+ isnull(i.Nivel4,''), 2)  else '' end
From inserted i inner join dbo.cntCentroCosto c
on i.IDCentro = c.IDCentro

go


Insert dbo.cntCentroCosto ( Nivel1, Nivel2, Nivel3, Nivel4 , Descr ,  IDCentroAnterior, IDCentroAcumulador, Acumulador, ReadOnlySys )
values ( '0','0','0','0','No Definido', 0,0,0,1)
go


Create View dbo.vcntCentro
as
Select IDCentro, Centro, Descr, IDCentroAnterior, IDCentroAcumulador , Acumulador , ReadOnlySys , Activo
From dbo.cntCentroCosto 
go


Create Table dbo.cntCuentaCentro ( IDCuenta BIGINT not null, IDCentro int not null )
go

alter table dbo.cntCuentaCentro add constraint pkCentroCuenta primary key (IDCuenta, IDCentro)
go

alter table dbo.cntCuentaCentro add constraint fkCentroctacta foreign key (IDCuenta) references dbo.cntCuenta (IDCuenta)
go

alter table dbo.cntCuentaCentro add constraint fkCentroctaCentro foreign key (IDCentro) references dbo.cntCentroCosto (IDCentro)
go
-- drop table dbo.cntTipoAsiento
Create Table dbo.cntTipoAsiento( Tipo nvarchar(2) not null, Descr nvarchar(255), Consecutivo int default 0, UltimoAsiento nvarchar(20), Activo bit default 1, ReadOnlySys bit default 0)
go
alter table dbo.cntTipoAsiento add constraint pkTipoAsiento primary key (Tipo)
go

Insert dbo.cntTipoAsiento (Tipo, Descr, Consecutivo, UltimoAsiento, Activo, ReadOnlySys)
values ('FA', 'FACTURACION', 0, 'FA00000000', 1, 1)
GO

Insert dbo.cntTipoAsiento (Tipo, Descr, Consecutivo, UltimoAsiento, Activo, ReadOnlySys)
values ('CC', 'CUENTAS POR COBRAR', 0, 'CC00000000', 1, 1)
GO

Insert dbo.cntTipoAsiento (Tipo, Descr, Consecutivo, UltimoAsiento, Activo, ReadOnlySys)
values ('CP', 'CUENTAS POR PAGAR', 0, 'CP00000000', 1, 1)
GO

Insert dbo.cntTipoAsiento (Tipo, Descr, Consecutivo, UltimoAsiento, Activo, ReadOnlySys)
values ('NM', 'NOMINA', 0, 'NM00000000', 1, 1)
GO

Insert dbo.cntTipoAsiento (Tipo, Descr, Consecutivo, UltimoAsiento, Activo, ReadOnlySys)
values ('CG', 'CONTABILIDAD GENERAL', 0, 'CG00000000', 1, 1)
GO

Insert dbo.cntTipoAsiento (Tipo, Descr, Consecutivo, UltimoAsiento, Activo, ReadOnlySys)
values ('IN', 'INVENTARIO', 0, 'IN00000000', 1, 1)
GO

Insert dbo.cntTipoAsiento (Tipo, Descr, Consecutivo, UltimoAsiento, Activo, ReadOnlySys)
values ('CO', 'COMPRAS', 0, 'CO00000000', 1, 1)
GO

Insert dbo.cntTipoAsiento (Tipo, Descr, Consecutivo, UltimoAsiento, Activo, ReadOnlySys)
values ('AF', 'ACTIVOS FIJOS', 0, 'AF00000000', 1, 1)
GO

Insert dbo.cntTipoAsiento (Tipo, Descr, Consecutivo, UltimoAsiento, Activo, ReadOnlySys)
values ('BA', 'BANCOS', 0, 'BA00000000', 1, 1)
GO

Insert dbo.cntTipoAsiento (Tipo, Descr, Consecutivo, UltimoAsiento, Activo, ReadOnlySys)
values ('CF', 'CIERRE FISCAL ( EJERCICIO )', 0, 'CF00000000', 1, 1)
GO


CREATE TABLE dbo.TipoAsientoUsuario ( Usuario nvarchar(20) not null, Tipo nvarchar(2) not null )
go
alter table dbo.TipoAsientoUsuario add constraint pkTipoAsientoUsuario primary key (Usuario, Tipo)
go

alter table dbo.TipoAsientoUsuario add constraint fkTipoAsientoUsuarioU foreign key (Usuario) references dbo.secUsuario (Usuario)
go

alter table dbo.TipoAsientoUsuario add constraint fkTipoAsientoUsuarioTipo foreign key (Tipo) references dbo.cntTipoAsiento (Tipo)
go

--//TODO: Hacer mantenimiento de este catalogo
INSERT INTO dbo.TipoAsientoUsuario(Usuario,Tipo)
SELECT 'admin',Tipo  FROM dbo.cntTipoAsiento

GO


Create Table dbo.cntAsiento ( IDEjercicio int not null, Periodo nvarchar(10) not null, Asiento nvarchar(20) not null, Tipo nvarchar(2) not null, Fecha date, FechaHora datetime,
Createdby nvarchar(20), CreateDate datetime, Mayorizadoby nvarchar(20), MayorizadoDate datetime,  Anuladoby nvarchar(20), AnuladoDate datetime,
Concepto nvarchar(255), Mayorizado bit default 0, Anulado bit default 0, TipoCambio decimal (28,4) default 0, ModuloFuente nvarchar(2), CuadreTemporal bit default 0 )
go

alter table  dbo.cntAsiento add constraint pkcntAsiento primary key (Asiento)
go

alter table  dbo.cntAsiento add constraint fkcntAsiento foreign key (Tipo) references dbo.cntTipoAsiento (Tipo)
go

alter table  dbo.cntAsiento add constraint fkcntAsientoEjercicio foreign key (IDEJercicio) references dbo.cntEjercicio (IDEjercicio)
go

alter table  dbo.cntAsiento add constraint fkcntAsientoPeriodo foreign key (IDEJercicio, Periodo) references dbo.cntPeriodoContable (IDEjercicio, Periodo)
go
alter table dbo.cntAsiento add constraint chkCuadretMayor CHECK ((cast(isnull(Mayorizado,0) as int)+ cast(isnull(CuadreTemporal,0) as int) ) IN (0,1))
go

-- Crear el codigo del asiento

Create Table dbo.cntAsientoDetalle (IDDetalle BIGINT NOT NULL IDENTITY(1,1), Asiento nvarchar(20) not null, Linea int NOT NULL,
IDCentro int not null, IDCuenta BIGINT not null, 
--Centro nvarchar(10) not null, 
--Cuenta nvarchar(50) not null,
Referencia nvarchar(255), Debito decimal (28,4) default 0,  Credito decimal (28,4) default 0,
Documento nvarchar(255), daterecord datetime default getdate()  )
go

alter table dbo.cntAsientoDetalle add constraint pkAsientoDetalle primary key (IDDetalle,Asiento, IDCuenta, IDCentro)
go

alter table  dbo.cntAsientoDetalle add constraint fkcntAsientoCuenta foreign key (IDCuenta) references dbo.cntCuenta (IDCuenta)
go

alter table  dbo.cntAsientoDetalle add constraint fkcntAsientoCentro foreign key (IDCentro) references dbo.cntCentroCosto (IDCentro)
go

alter table  dbo.cntAsientoDetalle add constraint fkcntAsientodetasiento foreign key (Asiento) references dbo.cntAsiento(Asiento)
go

-- drop Trigger trgAsientoDetalle 
Create Trigger trgAsientoDetalle on dbo.cntAsientoDetalle for insert
as
Declare @Count int, @Asiento nvarchar(20) , @IDCentro int, @IDCuenta BIGINT, @Centro nvarchar(10), @Cuenta nvarchar(50)

SELECT @Asiento = i.Asiento, @IDCentro = IDCentro, @IDCuenta = IDCuenta
from inserted i 

--Select @Centro = Centro from dbo.cntCentroCosto  where IDCentro = @IDCentro
--Select @Cuenta = Cuenta from dbo.cntCuenta  where IDCuenta = @IDCuenta

set @Count = isnull((select  count(*) from dbo.cntAsientoDetalle where asiento =  @Asiento ) ,0)


update D set Linea = H.Linea
From  dbo.cntAsientoDetalle D inner join (SElect IDCuenta, IDCentro, ASiento, ROW_NUMBER() OVER(partition by Asiento ORDER BY IDCuenta, IDCentro, Asiento ASC) Linea
 From  dbo.cntAsientoDetalle D
WHERE D.Asiento = @Asiento 

) H
on D.IDCuenta = H.IDCuenta and D.IDCentro = H.IDCentro and D.Asiento = H.Asiento
--order by D.daterecord asc
go

-- drop table dbo.cntSaldo
Create Table dbo.cntSaldo( IDSaldo int not null Identity(1,1), IDEjercicio int not null, 
Periodo nvarchar(10) not null, IDCuenta BIGINT not null, IDCentro int not null, Fecha date, 
Saldo decimal(28,4) default 0, Debito DECIMAL(28,4) DEFAULT 0 ,Credito DECIMAL(28,4) DEFAULT 0, SaldoAnterior decimal(28,4) default 0 )
go

alter table dbo.cntSaldo add constraint pkcntSaldo primary key (IDSaldo)
go

alter table dbo.cntSaldo add constraint ukcntSaldo UNIQUE (IDEjercicio, Periodo, IDCuenta, IDCentro, Fecha)
go

alter table dbo.cntSaldo add constraint fkcntSaldoEjerc foreign key (IDEjercicio) references dbo.cntEjercicio (IDEjercicio)
go

alter table dbo.cntSaldo add constraint fkcntSaldoPeriodo foreign key (IDEjercicio, Periodo) references dbo.cntPeriodoContable (IDEjercicio, Periodo)
go

alter table dbo.cntSaldo add constraint fkcntSaldoCta foreign key (IDCuenta) references dbo.cntCuenta (IDCuenta)
go

alter table dbo.cntSaldo add constraint fkcntSaldoCentro foreign key (IDCentro) references dbo.cntCentroCosto (IDCentro)
go

Create Procedure cntUpdateEjercicio @Operacion nvarchar(1), @IDEjercicio int = 0,  @FechaInicio datetime, @InicioOperaciones bit, @MesInicioOperaciones int, @Descr nvarchar(50) = null
as
set nocount on 

if upper(@Operacion) = 'U'
begin
	Update dbo.cntEjercicio set Descr = @Descr 
	where IDEjercicio = @IDEjercicio 
end


if upper(@Operacion) = 'I'
begin
	exec dbo.cntCreaEjercicio  @FechaInicio, @InicioOperaciones,@MesInicioOperaciones
end
if upper(@Operacion) = 'D'
begin
	if exists (Select IDEjercicio  from dbo.cntAsiento where IDEjercicio = @IDEjercicio)
	begin
			RAISERROR ( 'No se puede eliminar un ejercicio con movimientos contables...', 16, 1) ;
			return	
	end
	-- borrarlo
	BEGIN TRANSACTION 
	BEGIN TRY
		Delete from dbo.cntPeriodoContable  where IDEjercicio = @IDEjercicio
		Delete from dbo.cntEjercicio where IDEjercicio = @IDEjercicio
	END TRY
	BEGIN CATCH
		IF @@TRANCOUNT > 0  
			ROLLBACK TRANSACTION;
	END CATCH
		IF @@TRANCOUNT > 0  
			COMMIT TRANSACTION; 	
end

go

Create Procedure dbo.cntUpdateTipoAsiento @Operacion nvarchar(1), @Tipo nvarchar(2), @Descr nvarchar(25), @Consecutivo int,  @Activo bit, @ReadOnlySys bit 
-- El ultimo asiento no se pasa como parametro
as
set nocount on 
declare @LongAsiento int, @tmpAsiento nvarchar (20)
	Select top 1  @LongAsiento = LongAsiento from dbo.cntParametros 	
	set @tmpAsiento = left(@Tipo + replicate ( '0', (@LongAsiento-2)),@LongAsiento)

if upper(@Operacion) = 'I'
begin
	if not exists (Select Tipo From dbo.cntTipoAsiento Where Tipo = @Tipo )
	begin
		insert dbo.cntTipoAsiento ( Tipo, Descr , Consecutivo ,Activo , ReadOnlySys, UltimoAsiento  )
		values ( @Tipo, @Descr, @Consecutivo, @Activo, @ReadOnlySys, @tmpAsiento )
	end
	else
	begin
			RAISERROR ( 'Ese Tipo de Asiento ya Existe', 16, 1) ;
			return			
	end
end	

if upper(@Operacion) in ('U', 'D') and Exists ( Select 	Tipo from  dbo.cntTipoAsiento  Where Tipo = @Tipo and ReadOnlySys = 1 )
begin
		RAISERROR ( 'Ese Tipo de Asiento est· protegido por el Sistema, Ud no puede alterarlo', 16, 1) ;
		return		
end

if upper(@Operacion) = 'U'
begin

	

	Update dbo.cntTipoAsiento set Descr = @Descr , Consecutivo = @Consecutivo, Activo = @Activo, ReadOnlySys = 0,
	UltimoAsiento = @tmpAsiento
	where Tipo = @Tipo and ReadOnlySys = 0
end	

if upper(@Operacion) = 'D'
begin

	if Exists ( Select 	Tipo from  dbo.cntAsiento  Where Tipo = @Tipo )	
	begin 
		RAISERROR ( 'Ese Tipo de Asiento no puede eliminarse porque tiene dependencias en asientos contables', 16, 1) ;
		return				
	end

	if Exists ( Select 	Tipo from  dbo.cntTipoAsiento  Where Tipo = @Tipo and ReadOnlySys = 0 )	
	begin 
		Delete from dbo.cntTipoAsiento where Tipo = @Tipo 
	end
end
go

CREATE FUNCTION [dbo].[cntGetCountCentroByNivel] (@Nivel1 AS NVARCHAR(50),@Nivel2 AS NVARCHAR(50),@Nivel3 AS NVARCHAR(50),@Nivel4 AS NVARCHAR(50))
RETURNS int
AS
BEGIN
Declare @Resultado BIGINT
/*
DECLARE @Nivel1 NVARCHAR(50),@Nivel2 NVARCHAR(50),@Nivel3 NVARCHAR(50),@Nivel4 NVARCHAR(50),@Nivel5 NVARCHAR(50)


SET @Nivel1='1'
SET @Nivel2='1'
SET @Nivel3='1'
SET @Nivel4='*'
SET @Nivel5='*'
*/

IF (@Nivel1='0') SET @Nivel1='*'
IF (@Nivel2='0') SET @Nivel2='*'
IF (@Nivel3='0') SET @Nivel3='*'
IF (@Nivel4='0') SET @Nivel4='*'

SET @Resultado = (
SELECT COUNT(Centro)FROM dbo.cntCentroCosto
WHERE (Nivel1=@Nivel1 OR @Nivel1='*') AND
			  (Nivel2=@Nivel2 OR @Nivel2='*') AND
			  (Nivel3=@Nivel3 OR @Nivel3='*')  AND
			  (Nivel4=@Nivel4 OR @Nivel4='*') 
			  
 )




IF (@Resultado IS NULL)
	SET @Resultado =0
RETURN @Resultado

END



GO

Create Procedure  dbo.cntUpdateCentroCosto @Operacion nvarchar(1), @IDCentro int, @Nivel1 nvarchar(2), @Nivel2 nvarchar(2),
@Nivel3 nvarchar(2),@Nivel4 nvarchar(2), @Descr nvarchar(255), @IDCentroAnterior int, @Acumulador bit, @IDCentroAcumulador INT,@Activo BIT
as
set nocount on 

if upper(@Operacion) = 'I'
begin
	INSERT  dbo.cntCentroCosto ( Nivel1, Nivel2 , Nivel3, Nivel4 , Descr , IDCentroAnterior, Acumulador, IDCentroAcumulador,Activo )
	VALUES ( @Nivel1 , @Nivel2 , @Nivel3,@Nivel4,  @Descr , @IDCentroAnterior , @Acumulador , @IDCentroAcumulador,@Activo )
end

if upper(@Operacion) = 'D'
begin

	if Exists ( Select IDCentro  from  dbo.cntCuentaCentro    Where IDCentro  = @IDCentro)	
	begin 
		RAISERROR ( 'Ese Centro de Costo no puede eliminarse porque tiene dependencias en la Relacion Cuentas - Centros', 16, 1) ;
		return				
	end
	if Exists ( Select IDCentro  from  dbo.cntAsientoDetalle   Where IDCentro  = @IDCentro)	
	begin 
		RAISERROR ( 'Ese Centro de Costo no puede eliminarse porque tiene dependencias en asientos contables', 16, 1) ;
		return				
	end
	DELETE  FROM dbo.cntCentroCosto WHERE IDCentro = @IDCentro and  ReadOnlySys <> 1
end

if upper(@Operacion) = 'U' 
BEGIN

	DECLARE @tmpAcumulador AS BIT
	SELECT @tmpAcumulador=Acumulador  FROM dbo.cntCentroCosto WHERE IDCentro=@IDCentro
	IF (@tmpAcumulador<>@Acumulador)
	BEGIN
		 IF ((SELECT [dbo].[cntGetCountCentroByNivel] (@Nivel1 ,@Nivel2 ,@Nivel3,@Nivel4 ))>0)
		 begin 
			RAISERROR ( 'El centro de costo no puede actualizar el campo acumulador, por que tiene centros que dependen de él', 16, 1) ;
			return		
		END
		
		IF EXISTS(SELECT TOP 1 *  FROM dbo.cntSaldo WHERE IDCentro=@IDCentro AND Saldo>0)
		BEGIN
			RAISERROR ( 'El centro de costo no puede actualizar el campo acumulador, por que hay cuentas asociadas al centro que tienen movimientos.', 16, 1) ;
			return		
		END 
	END

	Update dbo.cntCentroCosto set Descr = @Descr , Nivel1 = @Nivel1 , Nivel2 = @Nivel2 , Nivel3 = @Nivel3 , Nivel4 = @Nivel4 ,
	Acumulador = @Acumulador ,  IDCentroAcumulador = @IDCentroAcumulador, IDCentroAnterior= @IDCentroAnterior,Activo=@Activo
	where IDCentro = @IDCentro and ReadOnlySys <> 1
end

go


Create Procedure dbo.cntSeteaCuentaAnterior @Activa bit
-- @Aciva = 0 ==> incluye cuentas activas e inactivos, @Activo = 1 solo activos
as
set nocount on
Create Table #CuentaAnterior (ID int identity(1,1) not null, IDCuenta BIGINT default 0, cuenta nvarchar(50), IDCuentaAnterior BIGINT default 0) 

insert #CuentaAnterior (IDCuenta, Cuenta )
select IDCuenta, Cuenta
from dbo.cntCuenta 
where (@Activa = 0 and Activa in (0,1) ) or (@Activa = 1 and Activa = @Activa )
order by Nivel1, Nivel2, Nivel3, Nivel4, nivel5, nivel6

Update A set IDCuentaAnterior =  isnull(( Select  IDCuenta from #CuentaAnterior B where ( A.ID - 1 ) = B.ID ), 0 ) 
from #CuentaAnterior A 

Update C set IDCuentaAnterior = A.IDCuentaAnterior
from #CuentaAnterior A inner join dbo.cntCuenta C
on A.IDCuenta = C.IDCuenta 

drop table #CuentaAnterior

GO

CREATE Procedure dbo.cntUpdateCuenta @Operacion nvarchar(1), @IDCuenta BIGINT , @IDGrupo int , @IDTipo int , @Complementaria bit, 
@IDSubTipo int ,  @Nivel1 nvarchar(50)  , 
@Nivel2 nvarchar(50)  , @Nivel3 nvarchar(50) , @Nivel4 nvarchar(50)   , @Nivel5 nvarchar(50)  , @Nivel6 nvarchar(50)  ,
 @Descr nvarchar(255),  @EsMayor bit , 
@AceptaDatos bit , @Activa bit , @IDCuentaAnterior BIGINT	 , @IDCuentaMayor BIGINT ,
@UsaCentroCosto bit
as
Declare @Tipo nvarchar(1) , @SubTipo nvarchar(1) , @UsaComplementaria bit, @Naturaleza nvarchar(1) 
set nocount on

Select @UsaComplementaria = UsaComplementaria 
from dbo.cntGrupoCuenta 
where IDGrupo = @IDGrupo 

select @Tipo = Tipo 
from dbo.cntTipoCuenta  
where IDTipo = @IDTipo 

Select @SubTipo = SubTipo, @Naturaleza = Naturaleza
from dbo.cntSubTipoCuenta 
where IDTipo = @IDTipo and IDSubTipo = @IDSubTipo 

--if @Complementaria = 1
--begin
--	set @Naturaleza = case when @Naturaleza = 'D' then 'A' else 'D' end
--end

if upper(@Operacion) = 'I'
begin
	INSERT  dbo.cntcuenta  (IDGrupo,IDTipo,IDSubTipo, Tipo, SubTipo , Nivel1, Nivel2, Nivel3, Nivel4 , Nivel5, Nivel6,  
							Descr, Complementaria , EsMayor , AceptaDatos, IDCuentaAnterior , IDCuentaMayor, 
							UsaCentroCosto   ) 
	values ( @IDGrupo , @IDTipo , @IDSubTipo , @Tipo , @SubTipo , @Nivel1 , @Nivel2 , @Nivel3 , @Nivel4 , @Nivel5 , @Nivel6 ,
							@Descr, @Complementaria, @EsMayor, @AceptaDatos , @IDCuentaAnterior , @IDCuentaMayor,
							@UsaCentroCosto  )
	
	SET @IDCuenta =@@IDENTITY
	
	exec dbo.cntSeteaCuentaAnterior	1		
	
	IF (@UsaCentroCosto=1)
	BEGIN
		INSERT INTO dbo.cntCuentaCentro ( IDCuenta, IDCentro )
		VALUES  ( @IDCuenta,  0 )
	END	
	
					
end

if upper(@Operacion) = 'U'
BEGIN
	IF (@UsaCentroCosto=0) 
	BEGIN
		IF EXISTS(SELECT *  FROM dbo.cntCuentaCentro WHERE IDCuenta=@IDCuenta)
		BEGIN
			RAISERROR ( 'La cuenta contable tiene asociados centros de costos, elimine la relación y luego desactive la opción UsaCentroCosto', 16, 1) ;
			return		
		END
	END
	
	--Validar si el cambio es de mayor -> acepta datos y vice versa
	DECLARE @tmpAceptaDatos  AS BIT
	SELECT @tmpAceptaDatos= AceptaDatos  FROM dbo.cntCuenta WHERE IDCuenta=@IDCuenta
	
	IF (@tmpAceptaDatos <> @AceptaDatos)
	BEGIN
		IF EXISTS (SELECT TOP 1  * FROM dbo.cntSaldo WHERE IDCuenta=@IDCuenta AND Saldo>0)   
		BEGIN
			RAISERROR ( 'La cuenta contable tiene movimientos, no se puede realizar el cambio de tipo de Cuenta', 16, 1) ;
			return		
		END
	END
	
	
	Update dbo.cntcuenta set Descr = @Descr , Complementaria = @Complementaria , AceptaDatos = @AceptaDatos , EsMayor=@EsMayor ,Activa = @Activa , UsaCentroCosto=@UsaCentroCosto,
	IDCuentaAnterior = @IDCuentaAnterior , IDCuentaMayor = @IDCuentaMayor
	where IDCuenta = @IDCuenta 
	
	IF (@UsaCentroCosto=1)
	BEGIN
		IF NOT EXISTS(SELECT IDCentro  FROM dbo.cntCuentaCentro WHERE IDCuenta=@IDCuenta AND IDCentro=0)
		BEGIN
			INSERT INTO dbo.cntCuentaCentro ( IDCuenta, IDCentro )
			VALUES  ( @IDCuenta,  0 )
		END
	END	
	
	
end

if upper(@Operacion) = 'D'
begin

	if Exists ( Select IDCtaUtilidadAcumulada   from  dbo.cntParametros    Where (IDCtaUtilidadAcumulada   = @IDCuenta or IDCtaUtilidadPeriodoIngresos= @IDCuenta or IDCtaUtilidadPeriodoGastos= @IDCuenta or IDCtaUtilidadPeriodoCostos= @IDCuenta ))	
	begin 
		RAISERROR ( 'Esa Cuenta Contable no puede eliminarse porque tiene dependencias en los Parametros del Sistema', 16, 1) ;
		return				
	end
	if Exists ( Select IDCuenta   from  dbo.cntCuentaCentro   Where IDCuenta  = @IDCuenta)	
	begin 
		RAISERROR ( 'Esa Cuenta Contable no puede eliminarse porque tiene dependencias en la Relacion Cuentas - Centros', 16, 1) ;
		return				
	end
	if Exists ( Select IDcuenta  from  dbo.cntAsientoDetalle   Where IDCuenta  = @IDCuenta)	
	begin 
		RAISERROR ( 'La Cuenta no puede eliminarse porque tiene dependencias en asientos contables', 16, 1) ;
		return				
	END
	
	if Exists ( SELECT IDCuenta  FROM dbo.cntCuentaGrupoEstadosFinancieros WHERE IDCuenta=@IDCuenta)	
	begin 
		RAISERROR ( 'La Cuenta no puede eliminarse porque tiene dependencias en  Grupo de Estados Financieros', 16, 1) ;
		return				
	END
	
	IF  EXISTS (SELECT IDCuenta  FROM dbo.cntSaldo WHERE IDCuenta=@IDCuenta AND ( Debito>0 or Credito>0))
	BEGIN
		RAISERROR ( 'La Cuenta no puede eliminarse porque tiene posee movimientos', 16, 1) ;
		return	
	END
	
	IF NOT EXISTS (SELECT IDCuenta  FROM dbo.cntSaldo WHERE IDCuenta=@IDCuenta AND ( Debito>0 or Credito>0))
	BEGIN
		DELETE FROM dbo.cntSaldo WHERE IDCuenta=@IDCuenta
		DELETE FROM dbo.cntCuentaCentro WHERE IDCuenta=@IDCuenta
	end
	exec dbo.cntSeteaCuentaAnterior	1				
	Delete from dbo.cntcuenta Where IDCuenta = @IDCuenta 
end


go




--************ para grabar el Asiento Contable 
/*
DECLARE @XML xml
set @XML =
'<Root>
 <Asiento>
  <IDEjercicio>2017</IDEjercicio>
  <Periodo>201701</Periodo>
  <Asiento>FA0000000001</Asiento>
  <FechaHora>2017-01-02T00:00:00</FechaHora>
  <Tipo>FA</Tipo>
  <Createdby>azepeda</Createdby>
  <CreateDate>2017-01-01T00:00:00</CreateDate>
  <Modifiedby>azepeda</Modifiedby>
  <UpdatedDate>2017-01-01T00:00:00</UpdatedDate>
  <Concepto>APERTURA</Concepto>
  <Mayorizado>0</Mayorizado>
  <Anulado>0</Anulado>
  <TipoCambio>29.3000</TipoCambio>
  <CuadreTemporal>0</CuadreTemporal>
  <Detalle>
    <Asiento>FA0000000001</Asiento>
    <Linea>1</Linea>
    <IDCentro>0</IDCentro>
    <IDCuenta>5</IDCuenta>
    <Referencia>APERTURA</Referencia>
    <Debito>2500.0000</Debito>
    <Credito>0.0000</Credito>
    <Documento>APERTURA</Documento>
  </Detalle>
  <Detalle>
    <Asiento>FA0000000001</Asiento>
    <Linea>2</Linea>
    <IDCentro>0</IDCentro>
    <IDCuenta>6</IDCuenta>
    <Referencia>APERTURA</Referencia>
    <Debito>0.0000</Debito>
    <Credito>2500.0000</Credito>
    <Documento>APERTURA</Documento>
  </Detalle>
  <Detalle>
    <Asiento>FA0000000001</Asiento>
    <Linea>8</Linea>
    <IDCentro>0</IDCentro>
    <IDCuenta>7</IDCuenta>
    <Referencia>APERTURA</Referencia>
    <Debito>2500.0000</Debito>
    <Credito>2500.0000</Credito>
    <Documento>APERTURA</Documento>
  </Detalle>  
</Asiento>
</Root>'
--select @XML

exec dbo.cntUpdateAsientowithXML 'I', @XML , 'FA0000000001', 'FA'
select * from dbo.cntAsiento where Asiento = 'FA0000000005'
select * from dbo.cntAsientoDetalle  where Asiento = 'FA0000000005'
select * from dbo.cntTipoAsiento 
*/

--drop procedure dbo.cntUpdateAsientoWithXML 
CREATE procedure [dbo].[cntUpdateAsientoWithXML] @Operacion nvarchar(1), @XML xml, @Asiento nvarchar(20) OUTPUT, @Tipo nvarchar(2)
-- El Tipo se pasa para el proceso de insercion, para crear el numero del asiento en el tipo correspondiente...
as

set nocount on 
declare @LongAsiento INT , @Consecutivo int 

select @LongAsiento = LongAsiento from dbo.cntParametros 
-- LECTURA DE CABECERA 
select
    Tab.Col.value('IDEjercicio[1]', 'int') as IDEjercicio,
    Tab.Col.value('Periodo[1]', 'nvarchar(10)') as Periodo,
    Tab.Col.value('Asiento[1]', 'nvarchar(20)') as Asiento,
    --@Asiento Asiento, 
    Tab.Col.value('Tipo[1]', 'nvarchar(2)') as Tipo,
     Tab.Col.value('Fecha[1]', 'datetime') as Fecha,
    Tab.Col.value('FechaHora[1]', 'datetime') as FechaHora,
    Tab.Col.value('Createdby[1]', 'nvarchar(20)') as Createdby,
    Tab.Col.value('CreateDate[1]', 'datetime') as CreateDate,
    Tab.Col.value('Mayorizadoby[1]', 'nvarchar(20)') as Mayorizadoby,
    Tab.Col.value('MayorizadoDate[1]', 'datetime') as MayorizadoDate,
	Tab.Col.value('Concepto[1]', 'nvarchar(255)') as Concepto,
    Tab.Col.value('Mayorizado[1]', 'bit') as Mayorizado,
    Tab.Col.value('Anulado[1]', 'bit') as Anulado,
    Tab.Col.value('TipoCambio[1]', 'decimal(28,4)') as TipoCambio,
    Tab.Col.value('ModuloFuente[1]', 'nvarchar(2)') as ModuloFuente,
    Tab.Col.value('CuadreTemporal[1]', 'bit') as CuadreTemporal
into #Asiento
from @XML.nodes('//Root/Asiento') as Tab(Col)

-- LECTURA DE LINEAS DETALLE
select
	--@Asiento Asiento,  
	Tab1.Col1.value('Asiento[1]', 'nvarchar(20)') as Asiento,
    Tab1.Col1.value('Linea[1]', 'int') as Linea,
    Tab1.Col1.value('IDCentro[1]', 'int') as IDCentro,
    Tab1.Col1.value('IDCuenta[1]', 'bigint') as IDCuenta,
    --Tab1.Col1.value('Centro[1]', 'nvarchar(10)') as Centro,
    --Tab1.Col1.value('Cuenta[1]', 'nvarchar(50)') as Cuenta,
    Tab1.Col1.value('Referencia[1]', 'nvarchar(255)') as ReferenciaDet,
    Tab1.Col1.value('Debito[1]', 'decimal(28,4)') as Debito,
    Tab1.Col1.value('Credito[1]', 'decimal(28,4)') as Credito,
    Tab1.Col1.value('Documento[1]', 'nvarchar(255)') as Documento
into #AsientoDetalle    
from @XML.nodes('//Root/Detalle') as Tab1(Col1)



declare @msgDescuadre nvarchar(250), @Descuadrado bit
Select @Descuadrado = case when (SUM(Debito) <> sum(Credito) ) then  1 else 0 end,
@msgDescuadre = 'Debito: ' + cast(SUM(Debito) as nvarchar(20)) + 
' Credito: ' + cast(SUM(Credito) as nvarchar(20)) + ' Diferencia : ' + cast( SUM(Debito) - sum(Credito) as nvarchar(20)) 
From #AsientoDetalle

if Upper(@Operacion) in ('I', 'U')
begin 
	if  @Descuadrado  = 1
	begin
		begin
			declare @msg nvarchar(255)
			set @msg =  'El asiento Contable esta descuadrado ' + @msgDescuadre
			RAISERROR ( @msg , 16, 1) ;
			return		
		end

	end
end 
BEGIN TRANSACTION 
BEGIN TRY

	if upper(@Operacion) = 'D'
	begin
		if exists (Select Asiento From dbo.cntAsiento  where Asiento = @Asiento  and mayorizado = 1)
		begin
			RAISERROR ( 'Ese asiento contable no se puede eliminar porque ya ha sido mayorizado', 16, 1) ;
		
		end

			Delete From dbo.cntAsientoDetalle Where Asiento = @Asiento
			Delete From dbo.cntAsiento Where Asiento = @Asiento	

	end		

	if upper(@Operacion) = 'I'
	begin
 

			 	SELECT @Asiento = (tipo + RIGHT( replicate('0', @LongAsiento ) + cast (Consecutivo + 1 as nvarchar(20)), @LongAsiento ) ),
 				@Consecutivo = Consecutivo + 1     
				FROM dbo.cntTipoAsiento (UPDLOCK)                             
				WHERE TIPO = @Tipo
				if exists (Select Asiento From dbo.cntAsiento (NOLOCK)  where Asiento = @Asiento )
				begin
					RAISERROR ( 'Ya Existe ese asiento contable, no se puede crear', 16, 1) ;		
				end	
				Update dbo.cntTipoAsiento set UltimoAsiento = @Asiento , Consecutivo = @Consecutivo 		 			
				where Tipo = @Tipo 
					
				INSERT  dbo.cntAsiento ( IDEjercicio, Periodo, Asiento, Tipo, Fecha,FechaHora, Createdby, CreateDate, Concepto, Mayorizado,
				Anulado, TipoCambio, ModuloFuente, CuadreTemporal  )
				Select IDEjercicio, Periodo, @Asiento Asiento, Tipo,CAST( Fecha as DATE)  Fecha, FechaHora, Createdby, CreateDate, Concepto, Mayorizado,
				Anulado, TipoCambio, ModuloFuente, CuadreTemporal
				From #Asiento 
				--where asiento = @Asiento Linea ,Linea ,

				INSERT dbo.cntAsientoDetalle( Asiento,Linea , IDCentro, IDCuenta ,  Referencia , Debito, Credito , Documento )
				Select @Asiento Asiento, Linea, IDCentro, IDCuenta ,  ReferenciaDet , Debito, Credito , Documento 
				from #AsientoDetalle 
				--where asiento = @Asiento 
		
				--return
	end	
	
	if upper(@Operacion) = 'U'
	begin

		if exists (Select Asiento From dbo.cntAsiento  where Asiento = @Asiento  and mayorizado = 1)
		begin
			RAISERROR ( 'Ese asiento contable no se puede editar porque ya ha sido mayorizado', 16, 1) ;
			--return		
		end

			Delete From dbo.cntAsientoDetalle Where Asiento = @Asiento
			Delete From dbo.cntAsiento Where Asiento = @Asiento	
			
				INSERT  dbo.cntAsiento ( IDEjercicio, Periodo, Asiento, Tipo, Fecha,FechaHora, Createdby, CreateDate, Concepto, Mayorizado,
				Anulado, TipoCambio, ModuloFuente, Mayorizadoby, MayorizadoDate )
				Select IDEjercicio, Periodo, @Asiento Asiento, Tipo,CAST( Fecha as DATE)  Fecha, FechaHora, Createdby, CreateDate, Concepto, Mayorizado,
				Anulado, TipoCambio, ModuloFuente, Mayorizadoby, MayorizadoDate
				From #Asiento 
				--where asiento = @Asiento 
			
				INSERT dbo.cntAsientoDetalle( Asiento, Linea , IDCentro, IDCuenta ,  Referencia , Debito, Credito , Documento )
				Select @Asiento Asiento, Linea , IDCentro, IDCuenta ,  ReferenciaDet , Debito, Credito , Documento 
				from #AsientoDetalle 
				--where asiento = @Asiento		
		

	end		
END TRY
BEGIN CATCH
	declare @error nvarchar(500)
    SELECT @error = ERROR_MESSAGE()  
    RAISERROR ( @error, 16, 1) ;
	IF @@TRANCOUNT > 0  
		ROLLBACK TRANSACTION;
END CATCH
	IF @@TRANCOUNT > 0  
		COMMIT TRANSACTION; 	


drop table #AsientoDetalle
drop table #Asiento
 



go

-- drop procedure dbo.cntGetPeriodoFromEjercicio
Create Procedure dbo.cntGetPeriodoFromEjercicio (@IDEjercicio int output, @Periodo nvarchar(10) output, @Tipo nvarchar(1) )
-- @Tipo 'I' Inicio 'A' anterior 'F' Final
as
set nocount on 
declare @PeriodoResultado nvarchar(10)
if UPPER ( @Tipo ) = 'A' 
	select @PeriodoResultado =  substring (Periodo, 1,4 ) +RIGHT ( '0' + cast ( cast(substring (Periodo, 5,2 ) as int ) - 1 as nvarchar(10)) ,2)  
	from dbo.cntPeriodoContable 
	where IDEjercicio = @IDEjercicio and Periodo = @Periodo
if UPPER ( @Tipo ) = 'S' 
	select @PeriodoResultado =  substring (Periodo, 1,4 ) +RIGHT ( '0' + cast ( cast(substring (Periodo, 5,2 ) as int ) + 1 as nvarchar(10)) ,2)  
	from dbo.cntPeriodoContable 
	where IDEjercicio = @IDEjercicio and Periodo = @Periodo
if UPPER ( @Tipo ) = 'I' 	
	select TOP 1  @PeriodoResultado = MIN(Periodo) --, 1,4 ) + '01'
	from dbo.cntPeriodoContable 
	where IDEjercicio = @IDEjercicio --and Periodo = @Periodo
if UPPER ( @Tipo ) = 'F'
	select TOP 1 @PeriodoResultado = MAX(Periodo) --, 1,4 ) + '12'
	from dbo.cntPeriodoContable 
	where IDEjercicio = @IDEjercicio AND FINPERIODOFISCAL = 1 --and Periodo = @Periodo	
	
	if 	substring (@PeriodoResultado, 5,2 ) = '00'
	begin
		set @PeriodoResultado = cast(@IDEjercicio-1 as nvarchar(4))+ '13'
		set @IDEjercicio = @IDEjercicio-1
	end

	set @Periodo = 	@PeriodoResultado
		
go

Create View dbo.vcntAsiento
as 
Select A.IDEjercicio, A.Periodo, A.Asiento , A.Tipo , A.Fecha, A.FechaHora, A.Createdby, A.CreateDate, A.Concepto, 
A.Mayorizado, A.TipoCambio, A.ModuloFuente, A.CuadreTemporal, D.Linea , D.IDCuenta, D.IDCentro, D.Debito, D.Credito , D.Referencia ,
D.Documento, D.daterecord, A.Anulado 
from dbo.cntAsiento A INNER JOIN dbo.cntAsientoDetalle D
on A.Asiento = D.Asiento
go


-- Calcular Saldo de Una Cuenta
-- drop procedure dbo.cntGetSaldo

Create Procedure dbo.cntGetSaldo @IDCuenta BIGINT, @IDCentro int, @IDEjercicio int, @Periodo nvarchar(10), @Fecha date output,
 @Saldo decimal (28,4) output, @TipoCambio decimal (28,4) output
as
set nocount on 

Select @Fecha = Fecha, @Saldo = Saldo
--, @TipoCambio = TipoCambio
-- Cuando haga falta agregarlos... este es el saldo anterior del ciclo pasado por parametro
--, @FechaSaldoAnterior = FechaSaldoAnt, @SaldoAnterior = SaldoAnterior, @TipoCambioSaldoAnt = TipoCambioSaldoAnt
From dbo.cntSaldo (nolock)
Where IDEjercicio = @IDEjercicio and IDCuenta = @IDCuenta and IDCentro = @IDCentro 
and Periodo = @Periodo

if @Fecha is null
set @Fecha = '19800101'

if @TipoCambio is null
set @TipoCambio = 1

if @Saldo is null
set @Saldo = 0

if @TipoCambio is null
set @TipoCambio = 0

go

-- drop procedure dbo.cntGetMovimiento
Create Procedure dbo.cntGetMovimiento @IDCuenta BIGINT, @IDCentro int, @IDEjercicio int, @Periodo nvarchar(10),
@SoloMayor bit = true , 
@Debito decimal (28,4 ) output, @Credito decimal (28,4 ) output, @Movimiento decimal (28,4 ) output, @Naturaleza nvarchar(1) output
as 
set nocount on 

select @Naturaleza = NaturalezaSaldo  
from dbo.vcntCatalogo 
where IDCuenta = @IDCuenta


Select top 1 @Debito = isnull(SUM(Debito ),0) , @Credito = ISNULL( SUM(Credito ),0) ,  
@Movimiento = isnull(SUM(case when @Naturaleza = 'D' THEN Debito - Credito else Credito - Debito end ),0) 
from dbo.vcntasiento
where IDEjercicio = @IDEjercicio  and Periodo = @Periodo and  IDCuenta = @IDCuenta and IDCentro = @IDCentro 
and Anulado = 0 and ( ( Mayorizado = 1)  or (@SoloMayor = 0 and Mayorizado = 0) )
Group by IDEjercicio, IDCuenta, IDCentro   

go 


-- Parametros del stored procedure  drop procedure dbo.cntGetSaldoAcumulado
Create Procedure dbo.cntGetSaldoAcumulado @IDEjercicio int, @Periodo nvarchar(10), @IDCuenta BIGINT, @IDCentro int, @SoloMayor bit = 1
as
set nocount on 
declare  @Fecha date,@Saldo decimal (28,4) , @TipoCambio decimal (28,2), @IDEjercicioAnt int, @PeriodoAnt nvarchar(10)
declare @Debito decimal (28,4 ) , @Credito decimal (28,4 ) , @Movimiento decimal (28,4 ), @Naturaleza nvarchar(1)
declare @DescrCta nvarchar(255), @Cuenta nvarchar(50), @Centro nvarchar(10)
set @IDEjercicioAnt = @IDEjercicio
set @PeriodoAnt = @Periodo

exec dbo.cntGetPeriodoFromEjercicio @IDEjercicioAnt  output, @PeriodoAnt output, 'A'
exec dbo.cntGetSaldo   @IDCuenta, @IDCentro, @IDEjercicioAnt, @PeriodoAnt , @Fecha output,@Saldo output, @TipoCambio output
exec dbo.cntGetMovimiento @IDCuenta , @IDCentro , @IDEjercicio , @Periodo ,
 @SoloMayor , 
@Debito output , @Credito output  , @Movimiento  output, @Naturaleza output 

select @DescrCta = DescrCuenta, @Cuenta = Cuenta
from dbo.vcntCatalogo 
where IDCuenta = @IDCuenta 

Select @Centro = Centro  From dbo.vcntCentro where IDCentro = @IDCentro

select @IDCuenta IDCuenta, @Cuenta Cuenta, @DescrCta DescrCta, @Naturaleza Naturaleza, @IDCentro IDCentro, @Centro Centro,
 @Fecha fecha, isnull(@TipoCambio,0) TipoCambio, isnull(@Saldo,0) SaldoInicial, isnull(@Debito,0) Debito, isnull(@Credito,0) Credito, isnull(@Movimiento,0) SaldoMes, (isnull(@Saldo,0) + isnull(@Movimiento,0)) SaldoAcumulado

go
-- Se le pasa -1 para el nivel que quiero tomar el maximo
CREATE FUNCTION [dbo].[cntGetNextConsecutivoCuenta] (@Nivel1 AS INT,@Nivel2 AS INT,@Nivel3 AS INT,@Nivel4 AS INT,@Nivel5 AS INT ,@Nivel6 AS INT)
RETURNS int
AS
BEGIN
Declare @Resultado BIGINT

set @Resultado = (
	SELECT CASE  WHEN @Nivel1=-1 THEN MAX(CAST(Nivel1 AS bigint))
					WHEN @Nivel2=-1 THEN	MAX(CAST(Nivel2 AS bigint))
					WHEN @Nivel3=-1 THEN MAX(CAST(Nivel3 AS bigint))
					WHEN @Nivel4=-1 THEN MAX(CAST(Nivel4 AS bigint))
					WHEN @Nivel5=-1 THEN MAX(CAST(Nivel5 AS bigint))
					WHEN @Nivel6=-1 THEN MAX(CAST(Nivel6 AS bigint))
					END  Consecutivo  FROM dbo.cntCuenta 
	WHERE (Nivel1=@Nivel1 OR @Nivel1=-1) 
	AND (Nivel2=@Nivel2 OR @Nivel2=-1)
	AND (Nivel3=@Nivel3 OR @Nivel3=-1)
	AND (Nivel4=@Nivel4 OR @Nivel4=-1)
	AND (Nivel5=@Nivel5 OR @Nivel5=-1)
	AND (Nivel6=@Nivel6 OR @Nivel6=-1)	
	)
if @Resultado is null
	set @Resultado = 0

	

RETURN @Resultado
END

GO


CREATE FUNCTION [dbo].[cntGetMascaraCuentaByNivel] (@Nivel1 AS NVARCHAR(50),@Nivel2 AS NVARCHAR(50),@Nivel3 AS NVARCHAR(50),@Nivel4 AS NVARCHAR(50),@Nivel5 AS NVARCHAR(50),@Nivel6 AS NVARCHAR(50))
RETURNS NVARCHAR(50)
AS
BEGIN

Declare @Resultado NVARCHAR(50)
Declare @UsaSeparadorCta bit, @SeparadorCta nvarchar(1), @iCantidad int , @UsaPredecesor bit, @charPredecesor nvarchar(1), 
@cantCharNivel1 int,  @cantCharNivel2 int, @cantCharNivel3 int, @cantCharNivel4 int, @cantCharNivel5 int , @cantCharNivel6 int


Select top 1 @UsaSeparadorCta = UsaSeparadorCta, @SeparadorCta = SeparadorCta, @UsaPredecesor = UsaPredecesor,
@charPredecesor = charPredecesor, @cantCharNivel1 = cantCharNivel1, @cantCharNivel2 = cantCharNivel2,
@cantCharNivel3 = cantCharNivel3, @cantCharNivel4 = cantCharNivel4, @cantCharNivel5 = cantCharNivel5, @cantCharNivel6 = cantCharNivel6
from  dbo.cntParametros
	
set @Resultado = (
	
SELECT right(replicate ( @charPredecesor, @cantCharNivel1) +  ISNULL(@Nivel1,'')  , @cantCharNivel1 ) + 
case when @UsaSeparadorCta= 1 and @Nivel2<> '' then @SeparadorCta else '' end 
+ case when ISNULL(@Nivel2,'')<> '' then right (replicate ( @charPredecesor, @cantCharNivel2)+ @Nivel2, @cantCharNivel2)  else '' end 
+ case when @UsaSeparadorCta= 1 and @Nivel3<> '' then @SeparadorCta else '' end
+ case when ISNULL(@Nivel3,'')<> '' then right (replicate ( @charPredecesor, @cantCharNivel3)+ @Nivel3, @cantCharNivel3)  else '' end
+ case when @UsaSeparadorCta= 1 and @Nivel4<> '' then @SeparadorCta else '' end
+ case when ISNULL(@Nivel4,'')<> '' then right (replicate ( @charPredecesor, @cantCharNivel4)+ @Nivel4, @cantCharNivel4)  else '' end
+ case when @UsaSeparadorCta= 1 and @Nivel5<> '' then @SeparadorCta else '' end
+ case when ISNULL(@Nivel5,'')<> '' then right (replicate ( @charPredecesor, @cantCharNivel5)+ @Nivel5, @cantCharNivel5)  else '' end
+ case when @UsaSeparadorCta= 1 and @Nivel6<> '' then @SeparadorCta else '' end
+ case when ISNULL(@Nivel6,'')<> '' then right (replicate ( @charPredecesor, @cantCharNivel6)+ @Nivel6, @cantCharNivel6)  else '' end
	)
if @Resultado is null
	set @Resultado = ''

	

RETURN @Resultado
END


GO


CREATE FUNCTION [dbo].[cntGetCountCuentaByNivel] (@Nivel1 AS NVARCHAR(50),@Nivel2 AS NVARCHAR(50),@Nivel3 AS NVARCHAR(50),@Nivel4 AS NVARCHAR(50),@Nivel5 AS NVARCHAR(50),@Nivel6 AS NVARCHAR(50))
RETURNS int
AS
BEGIN
Declare @Resultado BIGINT
/*
DECLARE @Nivel1 NVARCHAR(50),@Nivel2 NVARCHAR(50),@Nivel3 NVARCHAR(50),@Nivel4 NVARCHAR(50),@Nivel5 NVARCHAR(50)


SET @Nivel1='1'
SET @Nivel2='1'
SET @Nivel3='1'
SET @Nivel4='*'
SET @Nivel5='*'
*/

IF (@Nivel1='0') SET @Nivel1='*'
IF (@Nivel2='0') SET @Nivel2='*'
IF (@Nivel3='0') SET @Nivel3='*'
IF (@Nivel4='0') SET @Nivel4='*'
IF (@Nivel5='0') SET @Nivel5='*'
IF (@Nivel6='0') SET @Nivel6='*'

SET @Resultado = (
SELECT COUNT(cuenta)FROM dbo.cntCuenta
WHERE (Nivel1=@Nivel1 OR @Nivel1='*') AND
			  (Nivel2=@Nivel2 OR @Nivel2='*') AND
			  (Nivel3=@Nivel3 OR @Nivel3='*') AND
			  (Nivel4=@Nivel4 OR @Nivel4='*') AND
			  (Nivel5=@Nivel5 OR @Nivel5='*') AND
			  (Nivel6=@Nivel6 OR @Nivel6='*')
 )




IF (@Resultado IS NULL)
	SET @Resultado =0
RETURN @Resultado

END



GO

Create Procedure [dbo].[cntUpdateCuentaCentroCosto] @Operacion nvarchar(1), @IDCentro int, @IDCuenta BIGINT
as
set nocount on 

if upper(@Operacion) = 'I'
begin
	INSERT  dbo.cntCuentaCentro( IDCuenta, IDCentro ) 
	VALUES  ( @IDCuenta,@IDCentro ) 
end

if upper(@Operacion) = 'D'
begin
	DELETE  FROM dbo.cntCuentaCentro WHERE IDCentro = @IDCentro AND IDCuenta=@IDCuenta
end



GO

CREATE  Procedure [dbo].[cntGetProximaCuenta] @iNivel1 int  , @iNivel2 int, @iNivel3 int , @iNivel4 int  , @iNivel5 int , @iNivel6 int , @NextCuenta int output
as
set nocount on
Declare @Resultado nvarchar(50)
Declare @Str nvarchar(250), @i int, @Anterior int, @Actual int, @CantItems int, @Found bit , @Siguiente INT

DECLARE @Nivel1 nvarchar(50)  , @Nivel2 nvarchar(50), @Nivel3 nvarchar(50) , @Nivel4 nvarchar(50)  , @Nivel5 nvarchar(50) , @Nivel6 nvarchar(50)


Declare  @iCantidad int , @UsaPredecesor bit, @charPredecesor nvarchar(1), @UsaSeparadorCuenta AS BIT,
@cantCharNivel1 int,  @cantCharNivel2 int, @cantCharNivel3 int, @cantCharNivel4 int, @cantCharNivel5 int , @cantCharNivel6 int ,@SeparadorCta NVARCHAR(1)



Select TOP 1 @UsaSeparadorCuenta = UsaSeparadorCta,@UsaPredecesor=UsaPredecesor,
@charPredecesor = charPredecesor, @cantCharNivel1 = cantCharNivel1, @cantCharNivel2 = cantCharNivel2,
@cantCharNivel3 = cantCharNivel3, @cantCharNivel4 = cantCharNivel4, @cantCharNivel5 = cantCharNivel5,@SeparadorCta=SeparadorCta
, @cantCharNivel6 = cantCharNivel6
from  dbo.cntParametros
	
	

	
SET @Nivel1 = CASE WHEN @iNivel1=-1 THEN '-1' WHEN @iNivel1=0 THEN '0' ELSE  CASE WHEN @UsaPredecesor=1 THEN  right(replicate ( @charPredecesor, @cantCharNivel1) +  ISNULL(CAST(@iNivel1 AS NVARCHAR(50)) ,'')  , @cantCharNivel1 )  ELSE CAST(@iNivel1 AS NVARCHAR(50)) END  END 
SET @Nivel2= CASE WHEN @iNivel2=-1 THEN '-1' WHEN @iNivel2=0 THEN '0' ELSE CASE WHEN @UsaPredecesor=1 THEN right (replicate ( @charPredecesor, @cantCharNivel2)+ CAST(@iNivel2 AS NVARCHAR(50)), @cantCharNivel2) ELSE CAST(@iNivel2 AS NVARCHAR(50)) END END
SET @Nivel3=  CASE WHEN @iNivel3=-1 THEN '-1' WHEN @iNivel3=0 THEN '0' ELSE CASE WHEN @UsaPredecesor=1 THEN right (replicate ( @charPredecesor, @cantCharNivel3)+ CAST(@iNivel3 AS NVARCHAR(50)), @cantCharNivel3) ELSE CAST(@iNivel3 AS NVARCHAR(50)) END END
SET @Nivel4=  CASE WHEN @iNivel4=-1 THEN '-1' WHEN @iNivel4=0 THEN '0' ELSE CASE WHEN @UsaPredecesor=1 THEN right (replicate ( @charPredecesor, @cantCharNivel4)+ CAST(@iNivel4 AS NVARCHAR(50)), @cantCharNivel4) ELSE CAST(@iNivel4 AS NVARCHAR(50)) END END
SET @Nivel5= CASE WHEN @iNivel5=-1 THEN '-1' WHEN @iNivel5=0 THEN '0' ELSE  CASE WHEN @UsaPredecesor=1 THEN right (replicate ( @charPredecesor, @cantCharNivel5)+ CAST(@iNivel5 AS NVARCHAR(50)), @cantCharNivel5) ELSE CAST(@iNivel5 AS NVARCHAR(50)) END END
SET @Nivel6= CASE WHEN @iNivel6=-1 THEN '-1' WHEN @iNivel6=0 THEN '0' ELSE  CASE WHEN @UsaPredecesor=1 THEN right (replicate ( @charPredecesor, @cantCharNivel6)+ CAST(@iNivel6 AS NVARCHAR(50)), @cantCharNivel6) ELSE CAST(@iNivel6 AS NVARCHAR(50)) END END

--SELECT @Nivel1,@Nivel2,@Nivel3,@Nivel4,@Nivel5,@Nivel6


--set @Str = case when @Nivel1 = '-1' then '' else '%' + @Nivel1 + '%' end
--set @Str = @Str + case when @Nivel2 = '-1' then '' else  @Nivel2 + '%' end
--set @Str = @Str + case when @Nivel3 = '-1' then '' else  @Nivel3 + '%' end
--set @Str = @Str + case when @Nivel4 = '-1' then '' else  @Nivel4 + '%' end
--set @Str = @Str + case when @Nivel5 = '-1' then '' else  @Nivel5 + '%' end

set @Str = case when @Nivel1 = '-1' then '%' WHEN @Nivel1='0' THEN ''  else   @Nivel1 + CASE WHEN @UsaSeparadorCuenta=1 AND @Nivel1<>'' THEN  @SeparadorCta ELSE '' END end
set @Str = @Str + case when @Nivel2 = '-1' then '%' WHEN @Nivel2='0' THEN '' else  @Nivel2 + CASE WHEN @UsaSeparadorCuenta=1 AND @Nivel2<>'' THEN  @SeparadorCta ELSE '' END  end
set @Str = @Str + case when @Nivel3 = '-1' then '%' WHEN @Nivel3='0' THEN '' else  @Nivel3 + CASE WHEN @UsaSeparadorCuenta=1 AND @Nivel2<>'' THEN @SeparadorCta ELSE '' END end
set @Str = @Str + case when @Nivel4 = '-1' then '%' WHEN @Nivel4='0' THEN '' else  @Nivel4 + CASE WHEN @UsaSeparadorCuenta=1 AND @Nivel3<>'' THEN @SeparadorCta ELSE '' END end
set @Str = @Str + case when @Nivel5 = '-1' then '%' WHEN @Nivel5='0' THEN ''  else  @Nivel5 + CASE WHEN @UsaSeparadorCuenta=1 AND @Nivel4<>'' THEN @SeparadorCta ELSE '' END end
set @Str = @Str + case when @Nivel6 = '-1' then '%' WHEN @Nivel6='0' THEN ''  else  @Nivel6  END


--SELECT @Str
--select Nivel1, Nivel2 , Nivel3 , Nivel4, Nivel5, Nivel6, Cuenta 
--from dbo.cntCuenta 
--where @Str = '' or Cuenta like @Str 
--ORDER BY CAST(Nivel1 AS INT),CAST(Nivel2 AS INT),CAST(Nivel3 AS INT),CAST(Nivel4 AS INT),CAST(Nivel5 AS INT),CAST(Nivel6 AS INT)


Create Table #Cuenta ( ID int identity(1,1), nivel1 nvarchar(50), nivel2 nvarchar(50),
nivel3 nvarchar(50),  nivel4 nvarchar(50), nivel5 nvarchar(50),nivel6 nvarchar(50), Cuenta nvarchar(50))
insert #Cuenta ( nivel1 , nivel2 , nivel3 ,nivel4 , nivel5 , nivel6 , Cuenta )
select Nivel1, Nivel2 , Nivel3 , Nivel4, Nivel5, Nivel6, Cuenta 
from dbo.cntCuenta 
where @Str = '' or Cuenta like @Str 
ORDER BY CAST(Nivel1 AS INT),CAST(Nivel2 AS INT),CAST(Nivel3 AS INT),CAST(Nivel4 AS INT),CAST(Nivel5 AS INT),CAST(Nivel6 AS INT)


set @CantItems = @@IDENTITY 

declare @First int, @Second int

set @i = 1
set @Found = 0
set @Anterior = -1
set @First = -1
while @i <= @CantItems and @Found = 0
begin
set @Anterior = @First 
Select @First = case when @nivel1 = '-1' then cast(nivel1 AS int)
				else
					case when @nivel2 = '-1' then cast(nivel2 AS int )
					else
						case when @nivel3 = '-1' then cast(nivel3 AS int )
						else
							case when @nivel4 = '-1' then cast(nivel4 AS int )
							else
								case when @nivel5 = '-1' then CAST( nivel5 AS int ) 
								else
									case when @nivel6 = '-1' then CAST( nivel6 AS int ) 
									END
								END
							end
						end
					end
				end 
			 

from #Cuenta
where ID = @i 
if @First <>  0 and @Anterior = -1	
begin
	set @Siguiente = ISNULL(@First,0) + 1
	set @Found = 1
end
else
begin

	if (@i <= @CantItems)  and (@first - @Anterior ) >1 
	begin

		set @Found = 1
		set @Siguiente = @Anterior + 1
	end
	else
	begin
		if @i = @CantItems --and (@first - @Anterior ) =1
		begin
			set @Found = 1
			set @Siguiente = @First + 1
		end
	end
end
set @i = @i + 1
end

set @NextCuenta = @Siguiente 
drop table #Cuenta
--SELECT  @NextCuenta
go



CREATE  PROCEDURE cntRptGetAsiento @Asiento AS NVARCHAR(20)
AS
--SET @Asiento='CG0000000016'

SELECT IDEjercicio,Periodo,Asiento,A.Tipo,B.Descr DescrTipo,Fecha,FechaHora,Createdby,CreateDate,Mayorizado,Mayorizadoby,MayorizadoDate,Concepto,Anulado, TipoCambio,ModuloFuente,CuadreTemporal
FROM dbo.cntAsiento A
INNER JOIN dbo.cntTipoAsiento B ON a.Tipo=B.Tipo
WHERE Asiento=@Asiento


GO 

CREATE  PROCEDURE cntRptGetAsientoDetalle @Asiento AS NVARCHAR(20)
AS
--SET @Asiento='CG0000000016'

SELECT Asiento,Linea,A.IDCentro,CC.Centro,cc.Descr DescrCentro,C.IDCuenta,C.Cuenta,C.Descr DescrCuenta,Debito,Credito,Documento,A.Referencia,daterecord  FROM dbo.cntAsientoDetalle A
INNER JOIN dbo.cntCuenta C ON a.IDCuenta=c.IDCuenta
INNER JOIN dbo.cntCentroCosto CC ON A.IDCentro=cc.IDCentro
WHERE Asiento=@Asiento
ORDER BY C.Cuenta

GO


CREATE FUNCTION [dbo].[ConvertListToTable](
 @String nvarchar (4000),
 @Delimiter nvarchar (10)
 )
returns @ValueTable table ([Value] nvarchar(4000))
begin
 declare @NextString nvarchar(4000)
 declare @Pos int
 declare @NextPos int
 declare @CommaCheck nvarchar(1)
 
 --Initialize
 set @NextString = ''
 set @CommaCheck = right(@String,1) 
 
 --Check for trailing Comma, if not exists, INSERT
 --if (@CommaCheck <> @Delimiter )
 set @String = @String + @Delimiter
 
 --Get position of first Comma
 set @Pos = charindex(@Delimiter,@String)
 set @NextPos = 1
 
 --Loop while there is still a comma in the String of levels
 while (@pos <>  0)  
 begin
  set @NextString = substring(@String,1,@Pos - 1)
 
  insert into @ValueTable ( [Value]) Values (@NextString)
 
  set @String = substring(@String,@pos +1,len(@String))
  
  set @NextPos = @Pos
  set @pos  = charindex(@Delimiter,@String)
 end
 
 return
end

GO


CREATE  PROCEDURE  [dbo].[cntGetAsientoByCriterio] @FechaInicial AS DATE,@FechaFinal AS DATE,@Tipo AS NVARCHAR(800),@Mayorizado AS INT,@Anulado AS INT,@ModuloFuente AS NVARCHAR(800),@CuadreTemporal AS INT,@Usuario NVARCHAR(20)
AS 
/*
SET @FechaInicial = '20170501'
SET @FechaFinal = '20170531'
SET @Tipo ='FA∞CG∞CI'
SET @Mayorizado=0
SET @Anulado=0
SET @ModuloFuente = 'CG'
SET @CuadreTemporal=0
*/

set @FechaInicial = CAST(SUBSTRING(CAST(@FechaInicial AS CHAR),1,11) + ' 00:00:00.000' AS DATETIME)
set @FechaFinal = CAST(SUBSTRING(CAST(@FechaFinal AS CHAR),1,11) + ' 23:59:59.998' AS DATETIME)


SELECT IDEjercicio, Periodo, Asiento, Tipo, Fecha, FechaHora, Createdby, CreateDate, Mayorizadoby, MayorizadoDate, 
                            Concepto, Mayorizado, Anulado, TipoCambio, ModuloFuente, CuadreTemporal 
                              FROM dbo.cntAsiento WHERE Fecha BETWEEN @FechaInicial AND @FechaFinal  AND (Tipo IN (SELECT Value FROM [dbo].[ConvertListToTable](@Tipo,'~'))) 
							AND (Mayorizado = @Mayorizado OR @Mayorizado = -1) AND(Anulado = @Anulado OR @Anulado = -1) AND (ModuloFuente  IN (SELECT Value FROM [dbo].[ConvertListToTable](@ModuloFuente,'~'))) 
                            AND(CuadreTemporal = @CuadreTemporal OR @CuadreTemporal = -1) AND Tipo IN (SELECT Tipo FROM dbo.TipoAsientoUsuario WHERE Usuario=@Usuario)


go 



Create Procedure [dbo].[cntUpdateParametrosContabilidad] @Operacion NVARCHAR(1),@ID INT, @UsaSeparadorCuenta BIT, @SeparadorCta nvarchar(1), @UsaPredecesor BIT,  @charPredecesor NVARCHAR(1),@CantCharNivel1 NVARCHAR(50), @CantCharNivel2 NVARCHAR(50),@CantCharNivel3 NVARCHAR(50),@CantCharNivel4 NVARCHAR(50),@CantCharNivel5 NVARCHAR(50), @CantCharNivel6 NVARCHAR(50),
@IDCtaUtilidadAcumulada BIGINT , @IDCtaUtilidadPeriodoIngresos BIGINT,@IDCtaUtilidadPeriodoGastos BIGINT,@IDCtaUtilidadPeriodoCostos BIGINT, @MesInicioPeriodoFiscal bit, @MesFinalPeriodoFiscal INT,@UsaSeparadorCentro BIT,@SeparadorCentro NVARCHAR(1),@UsaPredecesorCentro BIT, @charPredecesorCentro NVARCHAR(50),@LongAsiento INT,@TipoCambio NVARCHAR(20)
as
set nocount on 

if upper(@Operacion) = 'I'
begin
	INSERT  dbo.cntParametros( UsaSeparadorCta ,SeparadorCta ,UsaPredecesor ,charPredecesor ,CantCharNivel1 ,CantCharNivel2 ,CantCharNivel3 ,
														CantCharNivel4 ,CantCharNivel5 ,IDCtaUtilidadPeriodoIngresos,IDCtaUtilidadPeriodoCostos, IDCtaUtilidadPeriodoGastos ,IDCtaUtilidadAcumulada ,MesInicioPeriodoFiscal ,MesFinalPeriodoFiscal ,
														UsaSeparadorCentro ,SeparadorCentro ,UsaPredecesorCentro ,charPredecesorCentro ,LongAsiento,TipoCambio)
	VALUES  ( @UsaSeparadorCuenta,@SeparadorCta,@UsaPredecesor,@charPredecesor,@CantCharNivel1,@CantCharNivel2,@CantCharNivel3,@CantCharNivel4,@CantCharNivel5,
				@IDCtaUtilidadAcumulada,@IDCtaUtilidadPeriodoIngresos,@IDCtaUtilidadPeriodoCostos,@IDCtaUtilidadPeriodoGastos,@MesInicioPeriodoFiscal,@MesFinalPeriodoFiscal,@UsaSeparadorCentro,@SeparadorCentro,
				@UsaPredecesorCentro,@charPredecesorCentro,@LongAsiento,@TipoCambio)
	          
end


if upper(@Operacion) = 'U' 
BEGIN
	
	--//Validacion de las cuentas contables
	IF EXISTS (SELECT TOP 1 ID  FROM dbo.cntParametros 
		WHERE UsaSeparadorCta <> @UsaSeparadorCuenta OR SeparadorCta<>@SeparadorCta OR 
				 UsaPredecesor <> @UsaPredecesor OR charPredecesor <> @charPredecesor  OR 
				 CantCharNivel1 <> @CantCharNivel1 OR CantCharNivel2<> @CantCharNivel2 OR
				CantCharNivel3 <>@CantCharNivel3 OR CantCharNivel4<> @CantCharNivel4  OR 
				CantCharNivel5 <> @CantCharNivel5 OR CantCharNivel6 <> @CantCharNivel6 )
	BEGIN
		--//Validar que no exista cuentas contables
		IF  EXISTS ( SELECT  TOP 1 cuenta FROM dbo.cntCuenta)
		BEGIN
			RAISERROR ('No puede realizar cambios en los parametros de cuentas, el catalogo de cuentas contables no esta vacio.',16,1)
			RETURN	
		END
	END
	
	--// Validación de Centros de Costos
	IF EXISTS ( SELECT TOP 1 ID FROM dbo.cntParametros
			WHERE UsaSeparadorCentro <> @UsaSeparadorCentro OR  UsaPredecesorCentro <> @UsaPredecesorCentro OR SeparadorCentro <> @SeparadorCentro)
	BEGIN
		--//validar si hay centros de costos
		IF EXISTS (  SELECT  TOP 1 Centro from dbo.cntCentroCosto)
		BEGIN
			RAISERROR('No se puede realizar cambios en los parametros de centros de costos, el catalogo de centros de costos no se encuentra vacio',16,1)
			RETURN
		END
	END
	
	--//Validacion de las fechas
	IF EXISTS (SELECT  TOP 1 ID FROM dbo.cntParametros
			WHERE MesInicioPeriodoFiscal<>@MesInicioPeriodoFiscal OR MesFinalPeriodoFiscal <> @MesFinalPeriodoFiscal ) 
	BEGIN
		--//Validar si hay hacientos contables
		IF  EXISTS (SELECT TOP 1 *  FROM dbo.cntAsiento )
		BEGIN
			RAISERROR('No se puede realizar cambios en los parametros de centros de costos, existen asientos en el diario o mayor',16,1)
			RETURN
		END
	END
	
	
	UPDATE  dbo.cntParametros SET UsaSeparadorCta=@UsaSeparadorCuenta, SeparadorCta=@SeparadorCta,UsaPredecesor=@UsaPredecesor,
														charPredecesor=@charPredecesor,CantCharNivel1 =@CantCharNivel1,CantCharNivel2 =@CantCharNivel2,
														CantCharNivel3 =@CantCharNivel4,CantCharNivel4 =@CantCharNivel4,CantCharNivel5 =@CantCharNivel5, CantCharNivel6 =@CantCharNivel6,
														IDCtaUtilidadAcumulada=@IDCtaUtilidadAcumulada,IDCtaUtilidadPeriodoIngresos=@IDCtaUtilidadPeriodoIngresos,IDCtaUtilidadPeriodoCostos=@IDCtaUtilidadPeriodoCostos,IDCtaUtilidadPeriodoGastos=@IDCtaUtilidadPeriodoGastos,MesInicioPeriodoFiscal=@MesInicioPeriodoFiscal,
														MesFinalPeriodoFiscal =@MesFinalPeriodoFiscal,UsaSeparadorCentro=@UsaSeparadorCentro,SeparadorCentro=@SeparadorCentro,
														UsaPredecesorCentro =@UsaPredecesorCentro,charPredecesorCentro=@charPredecesorCentro,LongAsiento=@LongAsiento,TipoCambio = @TipoCambio
	WHERE ID=@ID
end


GO




/*

Select * from dbo.cntCuenta
Declare @IDEjercicio int, @Periodo nvarchar(10), @IDCuenta int, @Centro int, @SoloMayor bit = 1

set @IDEjercicio = 2017
set @Periodo = '201701'
set @IDCuenta = 5
set @Centro = 0
set @SoloMayor = 1

exec dbo.cntGetSaldoAcumulado @IDEjercicio, @Periodo, @IDCuenta, @Centro, @SoloMayor
*/
--@FechaSaldoAnt, @SaldoAnterior SaldoAnterior, @TipoCambioSaldoAnt TipoCambioAnt, 



/*




Select * from dbo.cntCuenta order by idgrupo, idTipo, IDSubTipo, idCuentaAnterior

SELECT * FROM dbo.cntAsiento 
SELECT * FROM dbo.cntAsientoDetalle 

select * from dbo.cntEjercicio 
select * from dbo.cntperiodocontable 

*/



-- ********************************************************************************************************************* 

/*

select * into test.dbo.tmpCuenta from dbo.cntCuenta where idcuenta > 7
 INSERT dbo.cntCuenta (  IDGrupo, IDtipo, IDSubTipo, Tipo, Subtipo, Nivel1, Nivel2 ,  Nivel3, Nivel4, Nivel5, Naturaleza, Descr, 
 Complementaria, EsMayor, AceptaDatos, IDCuentaAnterior , IDCuentaMayor )
 Values( 1,1,1,'B', 'A',  '1','', '','','', 'D','ACTIVO',  1,1, 0, 1,1)
go 
  INSERT dbo.cntCuenta (  IDGrupo, IDtipo, IDSubTipo, Tipo, Subtipo, Nivel1, Nivel2 ,  Nivel3, Nivel4, Nivel5, Naturaleza, Descr, 
 Complementaria, EsMayor, AceptaDatos, IDCuentaAnterior , IDCuentaMayor )
  Values( 1,1,1,'B', 'A',  '1','7', '','','', 'D','ACTIVO FIJO', 1,1, 0, 1,1)
go
 INSERT dbo.cntCuenta (  IDGrupo, IDtipo, IDSubTipo, Tipo, Subtipo, Nivel1, Nivel2 ,  Nivel3, Nivel4, Nivel5, Naturaleza, Descr, 
 Complementaria, EsMayor, AceptaDatos, IDCuentaAnterior , IDCuentaMayor )
  Values( 1,1,1,'B', 'A',  '1','1', '2','','', 'D','ACTIVO FIJO xx', 1,1, 0, 1,1)
go

 INSERT dbo.cntCuenta (  IDGrupo, IDtipo, IDSubTipo, Tipo, Subtipo, Nivel1, Nivel2 ,  Nivel3, Nivel4, Nivel5, Naturaleza, Descr, 
 Complementaria, EsMayor, AceptaDatos, IDCuentaAnterior , IDCuentaMayor )
  Values( 1,2,1,'B', 'A',  '1','1', '3','','', 'D','ACTIVO FIJO xxxxx', 1,1, 0, 1,1)
go


*/


-- ACTUALIZA EL SALDO DE UNA CUENTA exec dbo.cntUpdateSaldoCuenta 2017, '201701', 5,0,100,0
-- drop procedure dbo.cntUpdateSaldoCuenta
CREATE  Procedure dbo.cntUpdateSaldoCuenta @IDEjercicio int, @Periodo nvarchar(10),
 @IDCuenta BIGINT, @IDCentro int, @Debito decimal(28,4), @Credito decimal(28,4)
as
set nocount on


Declare @NaturalezaSaldo nvarchar(1), @MontoSaldo decimal(28,4), @Fecha date, @IDEjercicioAnt int, @PeriodoAnt nvarchar(10)
set @Debito = ISNULL(@Debito,0)
set @Credito = ISNULL( @Credito, 0)
set @IDEjercicioAnt = @IDEjercicio
set @PeriodoAnt = @Periodo
exec dbo.cntGetPeriodoFromEjercicio @IDEjercicioAnt  output, @PeriodoAnt output, 'A'

--select @PeriodoAnt periodoant

Select @Fecha = FechaFinal 
from dbo.cntPeriodoContable 
where IDEjercicio = @IDEjercicio and Periodo = @Periodo 

SELECT @NaturalezaSaldo = NaturalezaSaldo
FROM dbo.vcntCatalogo 
Where IDCuenta = @IDCuenta

if @NaturalezaSaldo = 'D' -- Naturaleza Deudora
	set @MontoSaldo = @Debito - @Credito
else
	set @MontoSaldo = @Credito - @Debito

Create table #CtasMayor ( IDCuenta BIGINT, IDCentro int, IDEjercicio int, Periodo nvarchar(10), SaldoAnt decimal(28,4) default 0  )

Declare @Sigue bit ,@IDCuentaMayor BIGINT, @IDCuentaActual BIGINT
set @Sigue = 1
set @IDCuentaActual = @IDCuenta
-- inserto la cuenta actual para luego calcular el saldo con las de mayor
insert #CtasMayor ( IDCuenta, IDCentro , IDEjercicio , Periodo  )
values (@IDCuenta, @IDCentro , @IDEjercicio , @Periodo )

while @Sigue = 1
begin
	Select  @IDCuentaMayor = IDCuentaMayor 
	from dbo.cntCuenta (nolock)
	where IDCuenta = @IDCuentaActual 
	if @IDCuentaMayor <> 0
		begin
		insert #CtasMayor ( IDCuenta, IDCentro , IDEjercicio , Periodo  )
		values (@IDCuentaMayor, @IDCentro , @IDEjercicio , @Periodo )
		end
	Select @IDCuentaActual = IDCuenta 
	From dbo.cntCuenta 
	where IDCuenta = @IDCuentaMayor

	if @IDCuentaMayor = 0
		set @Sigue = 0
	
	
end

-- Actualizo las que estan en saldo

Update S set Saldo = isnull(Saldo ,0 ) + @MontoSaldo ,S.Debito = isnull(S.Debito,0) +  @Debito,S.Credito=isnull(S.Credito,0) + @Credito
from dbo.cntSaldo (nolock) S inner join #CtasMayor M
on S.IDCuenta = M.IDCuenta and S.IDCentro = M.IDCentro and s.IDEjercicio = M.IDEjercicio and s.Periodo = M.Periodo 

Select @idejercicio IDEjercicio ,@Periodo  Periodo, IDCuenta, IDCentro, Saldo SaldoAnterior
into #SaldoAnterior 
from dbo.cntSaldo (nolock) S
where IDEjercicio = @IDEjercicioAnt and Periodo = @PeriodoAnt 
and IDCentro = @IDCentro and  IDCuenta in (Select IDCuenta from #CtasMayor )


-- para insertar los que no existen en saldos -- SELECT * FROM #CtasMayor 
-- estos son los que corresponden al periodo
INSERT dbo.cntSaldo(IDEjercicio, Periodo , IDCentro , IDCuenta ,  Fecha, Saldo,Debito,Credito )
SELECT A.IDEjercicio , A.Periodo , A.IDCentro , A.IDCuenta , A.Fecha, A.Saldo + ISNULL(B.SaldoAnterior,0) Saldo,@Debito,@Credito
FROM (
Select   M.IDEjercicio IDEjercicio, M.Periodo Periodo , M.IDCuenta, M.IDCentro  IDCentro, @Fecha Fecha,
@MontoSaldo Saldo
from dbo.cntSaldo (nolock) S right join #CtasMayor M
on S.IDCuenta = M.IDCuenta and S.IDCentro = M.IDCentro and S.IDEjercicio = M.IDEjercicio and S.Periodo = M.Periodo 
where S.IDCuenta is null and S.IDCENTRO IS NULL  AND S.IDEjercicio is null and S.Periodo is null
) A LEFT JOIN #SaldoAnterior B
ON A.IDCentro = B.IDCENTRO AND A.IDCuenta = B.IDCuenta and A.IDEjercicio = B.IDEjercicio and A.Periodo= B.Periodo


drop table #CtasMayor
drop table #SaldoAnterior


go


--drop procedure dbo.cntMayorizarAsiento
Create Procedure dbo.cntMayorizarAsiento  @IDEjercicio int, @Periodo nvarchar(10), @Asiento nvarchar(20), @Usuario nvarchar(20), @Exito bit output 
as
set nocount on
declare @Count int, @i int
set @Exito = 0
Select @Count = COUNT(*) 
from dbo.cntAsientoDetalle D inner join dbo.cntAsiento A
on D.Asiento = A.Asiento 
where D.Asiento = @Asiento and A.Mayorizado = 0 and A.Anulado  =0 and A.Cuadretemporal =0
if @Count = 0
begin
	RAISERROR ( 'Ese asiento contable no se puede Mayorizar porque puede estar ya Marorizado, Anulado o tiene Cuadre Temporal, por favor revise', 16, 1) ;
	return
end

DECLARE @IDCentro int, @IDCuenta BIGINT, @Debito decimal(28,4) ,@Credito decimal(28,4)
Create table #Detalle (ID int identity(1,1) not null,  Asiento nvarchar(20), IDCentro int, IDCuenta BIGINT, Debito decimal(28,4) default 0,
Credito decimal(28,4) default 0 )
-- ¢¢ Preguntar
--alter table #Detalle add constraint pkdetalle primary key (ID)
INSERT #Detalle (Asiento, IDCentro, IDCuenta, Debito , Credito )
Select D.Asiento, IDCentro, IDCuenta, Debito , Credito 
from dbo.cntAsientoDetalle D inner join dbo.cntAsiento A
on D.Asiento = A.Asiento 
where D.Asiento = @Asiento and A.Mayorizado = 0 and A.anulado =0 and A.Cuadretemporal =0
ORDER BY Linea ASC

BEGIN TRANSACTION 
BEGIN TRY

set @i = 1
While  @i <= @Count 
begin
	SELECT @IDCentro = IDCentro, @IDCuenta = IDCuenta, @Debito = DEBITO , @Credito = Credito 
	FROM #Detalle 
	WHERE ID = @i  
	exec dbo.cntUpdateSaldoCuenta @IDEjercicio , @Periodo , @IDCuenta , @IDCentro , @Debito , @Credito 	
	--select'vars ejercicio, periodo, cuenta, centro, debito, credito' descr, @IDEjercicio , @Periodo , @IDCuenta , @IDCentro , @Debito , @Credito 	
	set @i = @i + 1
end
-- actualizar la cabecera 
Update dbo.cntAsiento  set Mayorizado = 1, Mayorizadoby = @Usuario, MayorizadoDate = GETDATE()
Where Asiento = @Asiento 
set @Exito = 1
drop table #Detalle

END TRY
BEGIN CATCH
		IF @@TRANCOUNT > 0  
		begin
			ROLLBACK TRANSACTION;
			IF OBJECT_ID('tempdb..#Detalle') IS NOT NULL
				DROP TABLE #Detalle
			set @Exito = 0
		end
END CATCH
		IF @@TRANCOUNT > 0  
		begin
			COMMIT TRANSACTION; 	
			set @Exito = 1
		end
go

CREATE FUNCTION [dbo].[globalLastGetTipoCambioPeriodo] 
(--  Devuelve la ultima tasa de cambio del periodo para la fecha parametro si no existe devuele la anterior en la tabla de tipo cambio 
	@Fecha datetime
)
RETURNS DECIMAL
AS
BEGIN

	DECLARE @TipoCambio AS DECIMAL(28,8)

	DECLARE @FechaMax AS DATE
	SET @FechaMax = (SELECT MAX(Fecha)  FROM dbo.cntSaldo)

	IF (@Fecha>@FechaMax)
		SET @Fecha = @FechaMax

	SET @TipoCambio = (SELECT TOP 1 Monto  FROM dbo.globalTipoCambioDetalle WHERE Fecha < =DATEADD(D,-1,DATEADD(mm, DATEDIFF(m,0,@Fecha)+1,0)) AND IDTipoCambio='TVEN' ORDER BY Fecha desc)
	
	RETURN @TipoCambio
	
END

GO


Create Procedure [dbo].[cntRevertirAsiento]  @IDEjercicio int, @Periodo nvarchar(10), @Asiento nvarchar(20),@AsientoReversion NVARCHAR(20) OUTPUT, @Usuario nvarchar(20), @Exito bit output 
as
set nocount on
declare @Count int, @i int
set @Exito = 0
Select @Count = COUNT(*) 
from dbo.cntAsientoDetalle D inner join dbo.cntAsiento A
on D.Asiento = A.Asiento 
where D.Asiento = @Asiento and A.Mayorizado = 1 and A.Anulado  =0 and A.Cuadretemporal =0

if @Count = 0
begin
	RAISERROR ( 'Ese asiento contable no se puede revertir porque no esta Mayorizado,  por favor revise', 16, 1) ;
	return
END



DECLARE @IDCentro int, @IDCuenta BIGINT, @Debito decimal(28,4) ,@Credito decimal(28,4)
Create table #Detalle (ID int identity(1,1) not null, Linea INT, Asiento nvarchar(20), IDCentro int, IDCuenta BIGINT, Debito decimal(28,4) default 0,
Credito decimal(28,4) default 0,Referencia NVARCHAR(200) )
alter table #Detalle add constraint pkdetalle primary key (ID)

INSERT #Detalle (Asiento,Linea, IDCentro, IDCuenta, Debito , Credito, Referencia )
Select D.Asiento, Linea,IDCentro, IDCuenta, Credito ,Debito, 'Anulación del documento ' + @Asiento
from dbo.cntAsientoDetalle D inner join dbo.cntAsiento A
on D.Asiento = A.Asiento 
where D.Asiento = @Asiento and A.Mayorizado = 1 and A.anulado =0 and A.Cuadretemporal =0
ORDER BY Linea ASC


BEGIN TRANSACTION 
BEGIN TRY

set nocount on 
declare @LongAsiento INT , @Consecutivo int 
DECLARE @Tipo AS NVARCHAR(2)
DECLARE @TipoTC  AS NVARCHAR(20)

select @LongAsiento = LongAsiento, @TipoTC =TipoCambio from dbo.cntParametros 
SELECT @Tipo = Tipo FROM dbo.cntAsiento WHERE Asiento=@Asiento

--Ingresar el asiento de diario
SELECT @AsientoReversion = (tipo + RIGHT( replicate('0', @LongAsiento ) + cast (Consecutivo + 1 as nvarchar(20)), @LongAsiento ) ),
 				@Consecutivo = Consecutivo + 1     
FROM dbo.cntTipoAsiento (UPDLOCK)                             
WHERE TIPO = @Tipo


if exists (Select Asiento From dbo.cntAsiento (NOLOCK)  where Asiento = @AsientoReversion )
begin
	RAISERROR ( 'Ya Existe ese asiento contable, no se puede crear', 16, 1) ;		
end	

Update dbo.cntTipoAsiento set UltimoAsiento = @Asiento , Consecutivo = @Consecutivo 		 			
where Tipo = @Tipo 

DECLARE @TipoCambio AS DECIMAL(28,8)
DECLARE @FechaFinal AS DATE
DECLARE @FechaMax AS DATE

SET @FechaFinal = GETDATE()

SELECT @TipoCambio = [dbo].globalGetTipoCambio (@FechaFinal,@TipoTC)


--Insertar el documento
INSERT INTO dbo.cntAsiento        ( IDEjercicio ,          Periodo ,          Asiento ,          Tipo ,          Fecha ,          FechaHora ,          Createdby ,          CreateDate ,
          Mayorizadoby ,          MayorizadoDate ,          Concepto ,          Mayorizado ,          Anulado ,          TipoCambio ,          ModuloFuente ,          CuadreTemporal
        )
VALUES  ( @IdEjercicio , -- IDEjercicio - int
          @Periodo , -- Periodo - nvarchar(10)
           @AsientoReversion, -- Asiento - nvarchar(20)
          @Tipo , -- Tipo - nvarchar(2)
          GETDATE() , -- Fecha - date
          GETDATE(), -- FechaHora - datetime
          @Usuario , -- Createdby - nvarchar(20)
          GETDATE() , -- CreateDate - datetime
          NULL , -- Mayorizadoby - nvarchar(20)
		  NULL , -- MayorizadoDate - datetime
          N'Reversión del documento ' + @Asiento , -- Concepto - nvarchar(255)
          0 , -- Mayorizado - bit
          0 , -- Anulado - bit
          @TipoCambio , -- TipoCambio - decimal
          N'CG' , -- ModuloFuente - nvarchar(2)
          0  -- CuadreTemporal - bit
        )
       
      

INSERT INTO dbo.cntAsientoDetalle
        ( Asiento ,
          Linea ,
          IDCentro ,
          IDCuenta ,
          Referencia ,
          Debito ,
          Credito ,
          Documento ,
          daterecord
        )
SELECT @AsientoReversion,Linea, IDCentro, IDCuenta,Referencia, Debito , Credito, @Asiento,GETDATE()   FROM #Detalle 


set @i = 1
While  @i <= @Count 
begin
	SELECT @IDCentro = IDCentro, @IDCuenta = IDCuenta, @Debito = DEBITO , @Credito = Credito 
	FROM #Detalle 
	WHERE ID = @i  
	exec dbo.cntUpdateSaldoCuenta @IDEjercicio , @Periodo , @IDCuenta , @IDCentro , @Debito , @Credito 	
	--select'vars ejercicio, periodo, cuenta, centro, debito, credito' descr, @IDEjercicio , @Periodo , @IDCuenta , @IDCentro , @Debito , @Credito 	
	set @i = @i + 1
END
SELECT *  FROM dbo.cntAsiento
--Marcar anulado el AC Original

UPDATE dbo.cntAsiento SET  Anulado=1, AnuladoBy = @Usuario, AnuladoDate = GETDATE() WHERE Asiento =@Asiento
-- actualizar la cabecera 
Update dbo.cntAsiento  set Mayorizado = 1, Mayorizadoby = @Usuario, MayorizadoDate = GETDATE()
Where Asiento = @Asiento 

set @Exito = 1
drop table #Detalle

END TRY
BEGIN CATCH
		IF @@TRANCOUNT > 0  
		begin
			ROLLBACK TRANSACTION;
			IF OBJECT_ID('tempdb..#Detalle') IS NOT NULL
				DROP TABLE #Detalle
			set @Exito = 0
		end
END CATCH
		IF @@TRANCOUNT > 0  
		begin
			COMMIT TRANSACTION; 	
			set @Exito = 1
		end



go


CREATE PROCEDURE  dbo.cntCuadreTemporal(@Asiento AS NVARCHAR(20))
as
set nocount ON
DECLARE @Debito AS DECIMAL(28,2),@Credito AS DECIMAL(28,2)
DECLARE @Diferencia AS DECIMAL(28,2)
SELECT @Debito =SUM(Debito), @Credito= SUM(Credito)  FROM dbo.cntAsientoDetalle WHERE Asiento=@Asiento

SET @Diferencia =(@Debito-@Credito)
IF (@Diferencia >0 )
BEGIN
	IF (@Debito<@Credito)
		BEGIN
			SET @Debito = @Debito + @Diferencia
			UPDATE dbo.cntAsientoDetalle SET  Debito = @Debito WHERE Asiento =@Asiento AND Linea= 	(SELECT TOP 1 Linea FROM dbo.cntAsientoDetalle WHERE Asiento=@Asiento
			ORDER BY Linea DESC)
		END
	ELSE 
		BEGIN
			SET @Credito = @Credito + @Diferencia
			UPDATE dbo.cntAsientoDetalle SET  Credito = @Credito WHERE Asiento =@Asiento AND Linea= 	(SELECT TOP 1 Linea FROM dbo.cntAsientoDetalle WHERE Asiento=@Asiento
			ORDER BY Linea DESC)
		END
	UPDATE dbo.cntAsiento SET  CuadreTemporal=1 WHERE Asiento=@Asiento
END 	
	

GO


CREATE PROCEDURE	dbo.cntValidaFechaInPeriodoContables  @Fecha AS DATE
AS 
SET @Fecha =  DATEADD(s,-1,DATEADD(mm, DATEDIFF(m,0,@Fecha)+1,0))
DECLARE @PeriodoTrabajo AS BIT, @Cerrado AS BIT

SELECT @PeriodoTrabajo=PeriodoTrabajo,@Cerrado = Cerrado
  FROM dbo.cntPeriodoContable WHERE FechaFinal=@Fecha


IF (@Cerrado=1)
BEGIN
	RAISERROR('• La fecha seleccionada corresponde a un periodo de trabajo, ya CERRADO.',16,1)
END	

IF (@PeriodoTrabajo=0)
BEGIN
	RAISERROR('• La fecha seleccionada NO corresponde a un periodo de trabajo ACTIVO.',16,1)
END


go

CREATE PROCEDURE	[dbo].[cntGetPeriodoContableByFecha]  @Fecha AS DATE
AS 
DECLARE @TipoCambio AS DECIMAL(28,4)

SELECT @TipoCambio = Monto  FROM dbo.globalTipoCambioDetalle
WHERE IDTipoCambio = (SELECT TOP 1 IDTipoCambio  FROM dbo.globalCompania) AND Fecha=@Fecha

SET @Fecha =  DATEADD(s,-1,DATEADD(mm, DATEDIFF(m,0,@Fecha)+1,0))
DECLARE @PeriodoTrabajo AS BIT, @Cerrado AS BIT

SELECT  IDEjercicio ,
        Periodo ,
        FechaFinal ,
        Descr ,
        FinPeriodoFiscal ,
        Cerrado ,
        AjustesCierreFiscal ,
        Activo ,
        PeriodoTrabajo,
       @TipoCambio TipoCambio 
  FROM dbo.cntPeriodoContable WHERE FechaFinal=@Fecha
  
  
  GO
  
  
  
  
CREATE PROCEDURE [dbo].[cntGetNextConsecutivoCentroCostoFinal] (@iNivel1 AS INT,@iNivel2 AS INT,@iNivel3 AS INT,@iNivel4 AS INT,@NextCentro int output)
AS
set nocount on
	
	Declare @Str nvarchar(250), @i int, @Anterior int, @Actual int, @CantItems int, @Found bit , @Siguiente INT
	DECLARE @Nivel1 nvarchar(50)  , @Nivel2 nvarchar(50), @Nivel3 nvarchar(50), @Nivel4 nvarchar(50)
	Declare   @charPredecesor nvarchar(1), 
	@cantCharNivel1 int,  @cantCharNivel2 int, @cantCharNivel3 INT,@cantCharNivel4 INT,@SeparadorCentro NVARCHAR(1)

	SET @cantCharNivel1=2
	SET @cantCharNivel2=2
	set @cantCharNivel3=2
	set @cantCharNivel4=2
	--SET @charPredecesor='0'
	
	
	SELECT TOP 1 @SeparadorCentro= SeparadorCentro, @charPredecesor=charPredecesorCentro  FROM dbo.cntParametros

	SET @Nivel1 = CASE WHEN @iNivel1=-1 THEN '-1' WHEN @iNivel1=0 THEN '0' ELSE   right(replicate ( @charPredecesor, @cantCharNivel1) +  ISNULL(CAST(@iNivel1 AS NVARCHAR(50)) ,'')  , @cantCharNivel1 ) END 
	SET @Nivel2= CASE WHEN @iNivel2=-1 THEN '-1' WHEN @iNivel2=0 THEN '0' ELSE right (replicate ( @charPredecesor, @cantCharNivel2)+ CAST(@iNivel2 AS NVARCHAR(50)), @cantCharNivel2) END
	SET @Nivel3=  CASE WHEN @iNivel3=-1 THEN '-1' WHEN @iNivel3=0 THEN '0' ELSE right (replicate ( @charPredecesor, @cantCharNivel3)+ CAST(@iNivel3 AS NVARCHAR(50)), @cantCharNivel3) END
	SET @Nivel4=  CASE WHEN @iNivel4=-1 THEN '-1' WHEN @iNivel4=0 THEN '0' ELSE right (replicate ( @charPredecesor, @cantCharNivel4)+ CAST(@iNivel4 AS NVARCHAR(50)), @cantCharNivel4) END


	set @Str = case when @Nivel1 = '-1' then '%' WHEN @Nivel1='0' THEN ''  else   @Nivel1 + @SeparadorCentro end
	set @Str = @Str + case when @Nivel2 = '-1' then '%' WHEN @Nivel2='0' THEN '' else  @Nivel2 + @SeparadorCentro end
	set @Str = @Str + case when @Nivel3 = '-1' then '%' WHEN @Nivel3='0' THEN '' else  @Nivel3 + @SeparadorCentro END
	set @Str = @Str + case when @Nivel4 = '-1' then '%' WHEN @Nivel4='0' THEN '' else  @Nivel4 + @SeparadorCentro end


	Create Table #Centro ( ID int identity(1,1), nivel1 nvarchar(50), nivel2 nvarchar(50),
	nivel3 nvarchar(50), nivel4 nvarchar(50),  Centro nvarchar(50))
	

	INSERT  #Centro
			(  nivel1, nivel2, nivel3,nivel4, Centro )
	select Nivel1, Nivel2 , Nivel3 ,nivel4,Centro
	from dbo.cntCentroCosto 
	where @Str = '' or Centro like @Str 
	ORDER BY CAST(Nivel1 AS INT),CAST(Nivel2 AS INT),CAST(Nivel3 AS INT),CAST(Nivel4 AS INT)
	
	set @CantItems = @@IDENTITY 

	declare @First int, @Second int
	
	set @i = 1
	set @Found = 0
	set @Anterior = -1
	set @First = -1
	while @i <= @CantItems and @Found = 0
	begin
	set @Anterior = @First 
	Select @First = case when @nivel1 = '-1' then cast(nivel1 AS int)
					else
						case when @nivel2 = '-1' then cast(nivel2 AS int )
						else
							case when @nivel3 = '-1' then cast(nivel3 AS int ) 
							ELSE	
							case when @nivel4 = '-1' then cast(nivel4 AS int ) 
							END END end
						end
	from #Centro
	where ID = @i 
	
	
	if @First <>  0 and @Anterior = -1	
	begin
		set @Siguiente = ISNULL(@First,0) + 1
		set @Found = 1
	end
	else
	begin

		if (@i <= @CantItems)  and (@first - @Anterior ) >1 
		begin
			set @Found = 1
			set @Siguiente = @Anterior + 1
		end
		else
		begin
			if @i = @CantItems --and (@first - @Anterior ) =1
			begin
				set @Found = 1
				set @Siguiente = @First + 1
			end
		end
	end
	set @i = @i + 1
	END

	set @NextCentro = @Siguiente 
	drop table #Centro
	return @NextCentro

GO  
  
 CREATE  function dbo.cntExisteCuentaPrimerNivel(@Nivel AS INT)
RETURNS bit
BEGIN
	DECLARE @result as bit
	IF exists(SELECT *  FROM dbo.cntCuenta
	WHERE Nivel1=@Nivel AND Nivel2  + Nivel3  + Nivel4 + Nivel5+ Nivel6='00000') 
		SET @result = 1
	ELSE 
		SET @result = 0
	return (@result)
END

GO



CREATE  PROCEDURE  dbo.cntConsultaSaldosByCentroCuenta (@IdCentroCosto int , @IdCuentaContable AS BIGINT,@FechaInicial AS DATE,@FechaFinal AS DATE)
AS 
--DECLARE  @IdCentroCosto int , @IdCuentaContable AS INT,@FechaInicial AS DATE,@FechaFinal AS DATE

--SET @IdCentroCosto=0
--SET @IdCuentaContable=-1
--SET @FechaInicial  = '20170701'
--SET @FechaFinal='20170825'


DECLARE @TipoCambio AS DECIMAL(28,8)
DECLARE @TipoTC AS NVARCHAR(20)

SELECT @TipoTC = TipoCambio  FROM dbo.cntParametros 
SELECT @TipoCambio = [dbo].globalGetTipoCambio (@FechaFinal,@TipoTC)

set @FechaInicial = CONVERT(VARCHAR(25),DATEADD(dd,-(DAY(@FechaInicial)-1),@FechaInicial),101) 
set @FechaFinal = CONVERT(VARCHAR(25),DATEADD(dd,-(DAY(DATEADD(mm,1,@FechaFinal))),DATEADD(mm,1,@FechaFinal)),101)

DECLARE @FechaPeriodoAnterior  AS DATE

SET @FechaPeriodoAnterior = DATEADD(MONTH,-1,@FechaInicial)
SET @FechaPeriodoAnterior=  CONVERT(VARCHAR(25),DATEADD(dd,-(DAY(DATEADD(mm,1,@FechaPeriodoAnterior))),DATEADD(mm,1,@FechaPeriodoAnterior)),101)

DECLARE @tmpSaldos AS TABLE(IDCuenta BIGINT,Cuenta nvarchar(50), DescrCuenta nvarchar(255),IDCentro int,Centro nvarchar(50),DescrCentroCosto nvarchar(255),
										Fecha date, SaldoAnteriorLocal decimal(28,4) , SaldoAnteriorDolar decimal(28,4), DebitoLocal decimal(28,4),DebitoDolar decimal(28,4),
										CreditoLocal decimal(28,4), CreditoDolar decimal(28,4), SaldoLocal decimal(28,4),SaldoDolar decimal(28,4))


INSERT INTO @tmpSaldos( IDCuenta ,Cuenta ,DescrCuenta ,IDCentro ,Centro ,DescrCentroCosto ,Fecha ,SaldoAnteriorLocal ,SaldoAnteriorDolar ,DebitoLocal ,DebitoDolar ,CreditoLocal ,CreditoDolar ,SaldoLocal ,SaldoDolar)

SELECT A.IDCuenta, C.Cuenta,C.Descr DescrCuenta,A.IDCentro,CC.Centro,CC.Descr DescrCentroCosto,A.Fecha,
			 ISNULL(SaldoAnteriorLocal,0) SaldoAnteriorLocal, ISNULL(SaldoAnteriorDolar,0) SaldoAnteriorDolar, Debito DebitoLocal, Debito/@TipoCambio DebitoDolar,
			 Credito CreditoLocal, Credito/@TipoCambio CreditoDolar,
			CASE WHEN SC.Naturaleza='D' THEN ISNULL(SaldoAnteriorLocal,0) + (Debito-Credito) ELSE  ISNULL(SaldoAnteriorLocal,0)+ (Credito-Debito) END  SaldoLocal,
			CASE WHEN SC.Naturaleza='D' THEN  ISNULL(SaldoAnteriorLocal,0) + (Debito-Credito) ELSE  ISNULL(SaldoAnteriorLocal,0) + (Credito-Debito) END  /@TipoCambio  SaldoDolar -- INTO #tmpSaldos 
FROM dbo.cntSaldo A
LEFT JOIN (	
				SELECT IDCentro,IDCuenta, SUM(ISNULL(Saldo,0)) SaldoAnteriorLocal,  SUM(ISNULL(Saldo,0)) / @TipoCambio SaldoAnteriorDolar FROM dbo.cntSaldo 
				WHERE (IDCuenta=@IdCuentaContable OR @IdCuentaContable=-1)  AND (IDCentro=@IdCentroCosto OR @IdCentroCosto=-1) AND Fecha=@FechaPeriodoAnterior
				GROUP BY IDCentro,IDCuenta
			) B ON A.IDCentro = B.IDCentro AND A.IDCuenta = B.IDCuenta
INNER JOIN dbo.cntCuenta C ON A.IDCuenta=C.IDCuenta
INNER JOIN dbo.cntCentroCosto CC ON A.IDCentro=CC.IDCentro
INNER JOIN dbo.cntSubTipoCuenta SC ON C.IDTipo = SC.IDTipo AND C.IDSubTipo=SC.IDSubTipo
WHERE (A.IDCuenta=@IdCuentaContable OR @IdCuentaContable=-1)  AND (A.IDCentro=@IdCentroCosto OR @IdCentroCosto=-1)
AND Fecha BETWEEN @FechaInicial AND @FechaFinal


--IF (@IdCentroCosto<>-1  )
--	SELECT 0 SaldoAnteriorLocal, 0 SaldoAnteriorDolar,SUM(DebitoLocal) DebitoLocal,SUM(CreditoLocal) CreditoLocal,SUM(DebitoDolar) DebitoDolar,SUM(CreditoDolar) CreditoDolar,0 SaldoLocal, 0 SaldoDolar FROM @tmpSaldos S
--	INNER JOIN dbo.cntCuenta C ON S.Cuenta = C.Cuenta WHERE C.EsMayor=0 AND AceptaDatos=1
--ELSE 
--	SELECT SUM(SaldoAnteriorLocal) SaldoAnteriorLocal,SUM(SaldoAnteriorDolar) SaldoAnteriorDolar,SUM(DebitoLocal) DebitoLocal,SUM(CreditoLocal) CreditoLocal,SUM(DebitoDolar) DebitoDolar,SUM(CreditoDolar) CreditoDolar, SUM( SaldoLocal) SaldoLocal , SUM( SaldoDolar) SaldoDolar FROM @tmpSaldos
	
SELECT  IDCuenta,Cuenta ,        DescrCuenta ,  IDCentro,      Centro ,        DescrCentroCosto ,     SaldoAnteriorLocal ,   SaldoAnteriorDolar ,    SUM( DebitoLocal) DebitoLocal,   SUM(CreditoLocal) CreditoLocal,    SUM(DebitoDolar) DebitoDolar,   SUM(CreditoDolar) CreditoDolar ,        SUM( SaldoLocal) SaldoLocal, SUM(SaldoDolar) SaldoDolar  FROM @tmpSaldos
GROUP BY  IDCuenta,Cuenta ,        DescrCuenta ,  IDCentro,      Centro ,        DescrCentroCosto , SaldoAnteriorLocal ,   SaldoAnteriorDolar 


GO

 

CREATE TABLE [dbo].[cntGrupoEstadosFinancieros](
	[IDGrupo] [int] IDENTITY(0,1) NOT NULL,
	[Tipo] [nvarchar](2) NULL,
	[Nivel1] [nvarchar](2) NULL,
	[Nivel2] [nvarchar](2) NULL,
	[Nivel3] [nvarchar](2) NULL,
	[Grupo] [nvarchar](10) NULL,
	[Descr] [nvarchar](255) NULL,
	[Acumulador][bit] NULL,
	[IDGrupoAcumulador] [int] NULL,
	[IDGrupoCuenta] [int] NULL,
	[Activo] [bit] NULL,
 CONSTRAINT [pkGrupoEstadosFinancieros] PRIMARY KEY CLUSTERED 
(
	[IDGrupo] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [ukGrupoEstadosFinancieros] UNIQUE NONCLUSTERED 
(
	Grupo ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[cntGrupoEstadosFinancieros] ADD  DEFAULT ((1)) FOR [Activo]
GO

ALTER TABLE [dbo].[cntGrupoEstadosFinancieros] ADD  DEFAULT ((0)) FOR [Acumulador]
GO

ALTER TABLE dbo.cntGrupoEstadosFinancieros ADD DEFAULT((1)) FOR  IDGrupoAcumulador

ALTER TABLE [dbo].[cntGrupoEstadosFinancieros]  WITH CHECK ADD  CONSTRAINT [fkGrupoAcumulador] FOREIGN KEY([IDGrupoAcumulador])
REFERENCES [dbo].[cntGrupoEstadosFinancieros] ([IDGrupo])

ALTER TABLE [dbo].[cntGrupoEstadosFinancieros]  WITH CHECK ADD  CONSTRAINT [fkCuentaGrupoEstadosFinancieros_GrupoCuenta] FOREIGN KEY([IDGrupoCuenta])
REFERENCES [dbo].[cntGrupoCuenta] ([IDGrupo])



GO

ALTER TABLE [dbo].[cntGrupoEstadosFinancieros] CHECK CONSTRAINT [fkGrupoAcumulador]
GO


Create trigger [dbo].[trgGrupoEstadosFinancieros] on [dbo].[cntGrupoEstadosFinancieros] for Insert, Update
as
Declare @UsaSeparadorCentro bit, @SeparadorCentro nvarchar(1),  @UsaPredecesorCentro bit, @charPredecesorCentro nvarchar(1)

Select top 1 @UsaSeparadorCentro = 1, @SeparadorCentro = '-', 
@UsaPredecesorCentro = 1, @charPredecesorCentro = '0'



Update c set Grupo = i.Tipo + right(replicate ( @charPredecesorCentro, 2) +  ISNULL(i.Nivel1,'')  , 2 ) + 
case when @UsaSeparadorCentro= 1 and i.Nivel2<> '' then @SeparadorCentro else '' end 
+ case when ISNULL(i.Nivel2,'')<> '' then right (replicate ( @charPredecesorCentro, 2)+ isnull(i.Nivel2,''), 2)  else '' end 
+ case when @UsaSeparadorCentro= 1 and i.Nivel3<> '' then @SeparadorCentro else '' end
+ case when ISNULL(i.Nivel3,'')<> '' then right (replicate ( @charPredecesorCentro, 2)+ isnull(i.Nivel3,''), 2)  else '' end
From inserted i inner join dbo.cntGrupoEstadosFinancieros c
on i.IDGrupo = c.IDGrupo

GO

Insert dbo.[cntGrupoEstadosFinancieros] ( Nivel1, Nivel2, Nivel3 , Descr,Tipo , IDGrupoAcumulador, Acumulador,Activo )
values ( '0','0','0','No Definido', '',0,0,1)

go


CREATE   Procedure [dbo].[cntUpdateGrupoEstadoFinanciero] @Operacion nvarchar(1), @IDGrupo int, @Tipo AS NVARCHAR(2),@Nivel1 nvarchar(2), @Nivel2 nvarchar(2),
@Nivel3 nvarchar(2), @Descr nvarchar(255),@Acumulador AS BIT,@IDGrupoAcumulador AS INT,@IDGrupoCuenta AS INT =NULL, @Activo AS bit	
AS
set nocount on 


if upper(@Operacion) = 'I'
BEGIN
	IF (@IDGrupoCuenta IS NULL AND @IDGrupoAcumulador<>0)
	BEGIN
		SET @IDGrupoCuenta = (SELECT IDGrupoCuenta  FROM dbo.cntGrupoEstadosFinancieros WHERE IDGrupo=@IDGrupoAcumulador)
	END
	INSERT  dbo.cntGrupoEstadosFinancieros ( Nivel1, Nivel2 , Nivel3 ,Tipo, Descr,Acumulador, IDGrupoAcumulador,IDGrupoCuenta )
	VALUES ( @Nivel1 , @Nivel2 , @Nivel3, @Tipo,@Descr,@Acumulador,@IDGrupoAcumulador ,@IDGrupoCuenta  )
end

if upper(@Operacion) = 'D'
begin

	if Exists ( Select IDGrupo  from  dbo.cntCuentaGrupoEstadosFinancieros    Where IDGrupo  = @IDGrupo)	
	begin 
		RAISERROR ( 'El grupo no puede eliminarse porque tiene dependencias en la Relacion Grupo-CuentaContable  ', 16, 1) ;
		return				
	end
	
	DELETE  FROM dbo.cntGrupoEstadosFinancieros WHERE IDGrupo = @IDGrupo 
end

if upper(@Operacion) = 'U' 
begin
	Update dbo.cntGrupoEstadosFinancieros set Descr = @Descr , Nivel1 = @Nivel1 , Nivel2 = @Nivel2 , Nivel3 = @Nivel3 ,Activo=@Activo, Acumulador = @Acumulador,IDGrupoCuenta = @IDGrupoCuenta
	where IDGrupo = @IDGrupo 
end

GO


CREATE  PROCEDURE [dbo].[cntGetNextConsecutivoGrupoEstadoFinancieros] (@iNivel1 AS INT,@iNivel2 AS INT,@iNivel3 AS INT,@TIPO AS NVARCHAR(2),@NextGrupo int output)
AS
set nocount on
	
	Declare @Str nvarchar(250), @i int, @Anterior int, @Actual int, @CantItems int, @Found bit , @Siguiente INT
	DECLARE @Nivel1 nvarchar(50)  , @Nivel2 nvarchar(50), @Nivel3 nvarchar(50)
	Declare   @charPredecesor nvarchar(1), 
	@cantCharNivel1 int,  @cantCharNivel2 int, @cantCharNivel3 int

	SET @cantCharNivel1=2
	SET @cantCharNivel2=2
	set @cantCharNivel3=2
	SET @charPredecesor='0'

	SET @Nivel1 = CASE WHEN @iNivel1=-1 THEN '-1' WHEN @iNivel1=0 THEN '0' ELSE   right(replicate ( @charPredecesor, @cantCharNivel1) +  ISNULL(CAST(@iNivel1 AS NVARCHAR(50)) ,'')  , @cantCharNivel1 ) END 
	SET @Nivel2= CASE WHEN @iNivel2=-1 THEN '-1' WHEN @iNivel2=0 THEN '0' ELSE right (replicate ( @charPredecesor, @cantCharNivel2)+ CAST(@iNivel2 AS NVARCHAR(50)), @cantCharNivel2) END
	SET @Nivel3=  CASE WHEN @iNivel3=-1 THEN '-1' WHEN @iNivel3=0 THEN '0' ELSE right (replicate ( @charPredecesor, @cantCharNivel3)+ CAST(@iNivel3 AS NVARCHAR(50)), @cantCharNivel3) END


	
	set @Str =@Tipo + case when @Nivel1 = '-1' then '%' WHEN @Nivel1='0' THEN ''  else   @Nivel1 + '-' end
	set @Str = @Str + case when @Nivel2 = '-1' then '%' WHEN @Nivel2='0' THEN '' else  @Nivel2 + '-' end
	set @Str = @Str + case when @Nivel3 = '-1' then '%' WHEN @Nivel3='0' THEN '' else  @Nivel3 + '-' end

	

	Create Table #Grupo ( ID int identity(1,1), nivel1 nvarchar(50), nivel2 nvarchar(50),
	nivel3 nvarchar(50),  Grupo nvarchar(50))
	

	INSERT  #Grupo
			(  nivel1, nivel2, nivel3, Grupo )
	SELECT Nivel1,Nivel2,Nivel3,Grupo  FROM (
			select Nivel1, Nivel2 , Nivel3 ,Grupo
			from dbo.cntGrupoEstadosFinancieros 
			where @Str = '' or Grupo like @Str AND Tipo=@TIPO
			UNION all
			SELECT  Nivel1, Nivel2 , Nivel3 ,Grupo FROM dbo.cntGrupoEstadosFinancieros WHERE IDGrupo=0) A
	ORDER BY  CAST(Nivel1 AS INT),CAST(Nivel2 AS INT),CAST(Nivel3 AS INT)
	set @CantItems = @@IDENTITY 

	declare @First int, @Second int
	
	set @i = 1
	set @Found = 0
	set @Anterior = -1
	set @First = -1
	while @i <= @CantItems and @Found = 0
	begin
	set @Anterior = @First 
	Select @First = case when @nivel1 = '-1' then cast(nivel1 AS int)
					else
						case when @nivel2 = '-1' then cast(nivel2 AS int )
						else
							case when @nivel3 = '-1' then cast(nivel3 AS int ) end
							end
						end
	from #Grupo
	where ID = @i 
	
	
	if @First <>  0 and @Anterior = -1	
	begin
		set @Siguiente = ISNULL(@First,0) + 1
		set @Found = 1
	end
	else
	begin

		if (@i <= @CantItems)  and (@first - @Anterior ) >1 
		begin
			set @Found = 1
			set @Siguiente = @Anterior + 1
		end
		else
		begin
			if @i = @CantItems --and (@first - @Anterior ) =1
			begin
				set @Found = 1
				set @Siguiente = @First + 1
			end
		end
	end
	set @i = @i + 1
	END


	IF (@CantItems IS NULL)
	BEGIN
		SET @Siguiente=1
	END
	
	set @NextGrupo = @Siguiente 
	drop table #Grupo
	return @NextGrupo


GO





CREATE TABLE [dbo].[cntCuentaGrupoEstadosFinancieros](
	[IDCuenta] [bigint] NOT NULL,
	[IDGrupo] [int] NOT NULL,
 CONSTRAINT [pkCuentaGrupoEstadosFinancieros] PRIMARY KEY CLUSTERED 
(
	[IDCuenta] ASC,
	[IDGrupo] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[cntCuentaGrupoEstadosFinancieros]  WITH CHECK ADD  CONSTRAINT [fkCuentaGrupoEstadosFinancieros_Cuenta] FOREIGN KEY([IDCuenta])
REFERENCES [dbo].[cntCuenta] ([IDCuenta])
GO

ALTER TABLE [dbo].[cntCuentaGrupoEstadosFinancieros] CHECK CONSTRAINT [fkCuentaGrupoEstadosFinancieros_Cuenta]
GO

ALTER TABLE [dbo].[cntCuentaGrupoEstadosFinancieros]  WITH CHECK ADD  CONSTRAINT [fkCuentaGrupoEstadosFinancieros_Grupo] FOREIGN KEY([IDGrupo])
REFERENCES [dbo].[cntGrupoEstadosFinancieros] ([IDGrupo])
GO

ALTER TABLE [dbo].[cntCuentaGrupoEstadosFinancieros] CHECK CONSTRAINT [fkCuentaGrupoEstadosFinancieros_Grupo]
GO



CREATE Procedure [dbo].[cntUpdateCuentaGrupoEstadosFinancieros] @Operacion nvarchar(1), @IDCuenta BIGINT, @IDGrupo int 
as
set nocount on 

if upper(@Operacion) = 'I'
begin
	INSERT INTO dbo.cntCuentaGrupoEstadosFinancieros  ( IDCuenta, IDGrupo )
	VALUES ( @IDCuenta , @IDGrupo )
end

if upper(@Operacion) = 'D'
begin

	DELETE  FROM dbo.cntCuentaGrupoEstadosFinancieros WHERE IDCuenta = @IDCuenta and  IDGrupo =@IDGrupo
end


GO


CREATE PROCEDURE dbo.cntGetMovimientosCentroCuenta @IDCuenta BIGINT,@IDCentro INT,@FechaInicial DATETIME,@FechaFinal DATETIME
AS 

SET @FechaInicial = DATEADD(dd,DATEDIFF(dd,0,@FechaInicial),0) 
SET @FechaFinal = DATEADD(ms,-3,DATEADD(dd,DATEDIFF(dd,0,@FechaFinal),1))


DECLARE @iNivel1 int  , @iNivel2 int, @iNivel3 int , @iNivel4 int  , @iNivel5 int , @iNivel6 int , @NextCuenta int
DECLARE @Nivel1 nvarchar(50)  , @Nivel2 nvarchar(50), @Nivel3 nvarchar(50) , @Nivel4 nvarchar(50)  , @Nivel5 nvarchar(50) , @Nivel6 nvarchar(50) ,@Str AS NVARCHAR(255)
DECLARE @TipoTC AS NVARCHAR(20)

SELECT @iNivel1= Nivel1,@iNivel2=Nivel2,@iNivel3=Nivel3,@iNivel4=Nivel4,@iNivel5=Nivel5, @iNivel6=Nivel6 FROM dbo.cntCuenta WHERE IDCuenta=@IDCuenta

Declare  @iCantidad int , @UsaPredecesor bit, @charPredecesor nvarchar(1), @UsaSeparadorCuenta AS BIT,
@cantCharNivel1 int,  @cantCharNivel2 int, @cantCharNivel3 int, @cantCharNivel4 int, @cantCharNivel5 int , @cantCharNivel6 INT, @SeparadorCta NVARCHAR(1)

Select TOP 1
@UsaSeparadorCuenta = UsaSeparadorCta,@UsaPredecesor=UsaPredecesor, 
@charPredecesor = charPredecesor, @cantCharNivel1 = cantCharNivel1, @cantCharNivel2 = cantCharNivel2,
@cantCharNivel3 = cantCharNivel3, @cantCharNivel4 = cantCharNivel4, @cantCharNivel5 = cantCharNivel5 , @cantCharNivel6 = cantCharNivel6,@SeparadorCta=SeparadorCta,@TipoTC  =TipoCambio
from  dbo.cntParametros


SET @Nivel1 = CASE WHEN @iNivel1=-1 THEN '-1' WHEN @iNivel1=0 THEN '0' ELSE  CASE WHEN @UsaPredecesor=1 THEN  right(replicate ( @charPredecesor, @cantCharNivel1) +  ISNULL(CAST(@iNivel1 AS NVARCHAR(50)) ,'')  , @cantCharNivel1 )  ELSE CAST(@iNivel1 AS NVARCHAR(50)) END  END 
SET @Nivel2= CASE WHEN @iNivel2=-1 THEN '-1' WHEN @iNivel2=0 THEN '0' ELSE CASE WHEN @UsaPredecesor=1 THEN right (replicate ( @charPredecesor, @cantCharNivel2)+ CAST(@iNivel2 AS NVARCHAR(50)), @cantCharNivel2) ELSE CAST(@iNivel2 AS NVARCHAR(50)) END END
SET @Nivel3=  CASE WHEN @iNivel3=-1 THEN '-1' WHEN @iNivel3=0 THEN '0' ELSE CASE WHEN @UsaPredecesor=1 THEN right (replicate ( @charPredecesor, @cantCharNivel3)+ CAST(@iNivel3 AS NVARCHAR(50)), @cantCharNivel3) ELSE CAST(@iNivel3 AS NVARCHAR(50)) END END
SET @Nivel4=  CASE WHEN @iNivel4=-1 THEN '-1' WHEN @iNivel4=0 THEN '0' ELSE CASE WHEN @UsaPredecesor=1 THEN right (replicate ( @charPredecesor, @cantCharNivel4)+ CAST(@iNivel4 AS NVARCHAR(50)), @cantCharNivel4) ELSE CAST(@iNivel4 AS NVARCHAR(50)) END END
SET @Nivel5= CASE WHEN @iNivel5=-1 THEN '-1' WHEN @iNivel5=0 THEN '0' ELSE  CASE WHEN @UsaPredecesor=1 THEN right (replicate ( @charPredecesor, @cantCharNivel5)+ CAST(@iNivel5 AS NVARCHAR(50)), @cantCharNivel5) ELSE CAST(@iNivel5 AS NVARCHAR(50)) END END
SET @Nivel6= CASE WHEN @iNivel6=-1 THEN '-1' WHEN @iNivel6=0 THEN '0' ELSE  CASE WHEN @UsaPredecesor=1 THEN right (replicate ( @charPredecesor, @cantCharNivel6)+ CAST(@iNivel6 AS NVARCHAR(50)), @cantCharNivel6) ELSE CAST(@iNivel6 AS NVARCHAR(50)) END END
	

set @Str = case when @Nivel1 = '-1' then '%' WHEN @Nivel1='0' THEN ''  else   @Nivel1 +  @SeparadorCta end
set @Str = @Str + case when @Nivel2 = '-1' then '%' WHEN @Nivel2='0' THEN '' else  @Nivel2 +  @SeparadorCta end
set @Str = @Str + case when @Nivel3 = '-1' then '%' WHEN @Nivel3='0' THEN '' else  @Nivel3 +  @SeparadorCta end
set @Str = @Str + case when @Nivel4 = '-1' then '%' WHEN @Nivel4='0' THEN '' else  @Nivel4 +  @SeparadorCta end
set @Str = @Str + case when @Nivel5 = '-1' then '%' WHEN @Nivel5='0' THEN ''  else  @Nivel5+  @SeparadorCta end
set @Str = @Str + case when @Nivel6 = '-1' then '%' WHEN @Nivel6='0' THEN ''  else  @Nivel6  END
SET @Str = @Str +'%'


select IDCuenta INTO #tmpCuentas
from dbo.cntCuenta 
where  Cuenta like @Str 




DECLARE @TipoCambio AS DECIMAL(28,8)

SELECT @TipoCambio = [dbo].globalGetTipoCambio (@FechaFinal,@TipoTC)



SELECT Fecha,C.Cuenta,C.Descr DescrCuenta,A.Asiento,ModuloFuente,A.Tipo,A.Concepto
,ISNULL(Debito,0) DebitoLocal,ISNULL(Debito/@TipoCambio,0) DebitoDolar,ISNULL(Credito,0) CreditoLocal, ISNULL(Credito/@TipoCambio,0) CreditoDolar, Createdby,Mayorizadoby,FechaHora FROM dbo.cntAsiento A
INNER JOIN dbo.cntAsientoDetalle B ON A.Asiento = B.Asiento
INNER JOIN dbo.cntCuenta C ON B.IDCuenta=C.IDCuenta
WHERE (IDCentro=@IDCentro OR @IDCentro=-1)  AND (B.IDCuenta IN (SELECT IDCuenta FROM #tmpCuentas)  OR @IDCuenta =-1) AND Mayorizado=1
AND A.Fecha BETWEEN @FechaInicial AND @FechaFinal


DROP TABLE #tmpCuentas


GO 


CREATE  PROCEDURE  [dbo].[cntrptConsultaSaldosByCentroCuenta] (@IdCentroCosto int , @IdCuentaContable AS BIGINT,@FechaInicial AS DATE,@FechaFinal AS DATE)
AS 
--DECLARE  @IdCentroCosto int , @IdCuentaContable AS INT,@FechaInicial AS DATE,@FechaFinal AS DATE

--SET @IdCentroCosto=-1
--SET @IdCuentaContable=-1
--SET @FechaInicial  = '20170701'
--SET @FechaFinal='20170825'


DECLARE @TipoCambio AS DECIMAL(28,8)
DECLARE @TipoTC  AS NVARCHAR(20)

SELECT @TipoTC =TipoCambio  FROM dbo.cntParametros

SELECT @TipoCambio = [dbo].globalGetTipoCambio (@FechaFinal,@TipoTC)

set @FechaInicial = CONVERT(VARCHAR(25),DATEADD(dd,-(DAY(@FechaInicial)-1),@FechaInicial),101) 
set @FechaFinal = CONVERT(VARCHAR(25),DATEADD(dd,-(DAY(DATEADD(mm,1,@FechaFinal))),DATEADD(mm,1,@FechaFinal)),101)

DECLARE @FechaPeriodoAnterior  AS DATE

SET @FechaPeriodoAnterior = DATEADD(MONTH,-1,@FechaInicial)
SET @FechaPeriodoAnterior=  CONVERT(VARCHAR(25),DATEADD(dd,-(DAY(DATEADD(mm,1,@FechaPeriodoAnterior))),DATEADD(mm,1,@FechaPeriodoAnterior)),101)


DECLARE @tmpSaldos AS TABLE(IDCuenta BIGINT,Cuenta nvarchar(50), DescrCuenta nvarchar(255),IDCentro int,Centro nvarchar(50),DescrCentroCosto nvarchar(255),
										Fecha date, SaldoAnteriorLocal decimal(28,4) , SaldoAnteriorDolar decimal(28,4), DebitoLocal decimal(28,4),DebitoDolar decimal(28,4),
										CreditoLocal decimal(28,4), CreditoDolar decimal(28,4), SaldoLocal decimal(28,4),SaldoDolar decimal(28,4))

INSERT INTO @tmpSaldos( IDCuenta ,Cuenta ,DescrCuenta ,IDCentro ,Centro ,DescrCentroCosto ,Fecha ,SaldoAnteriorLocal ,SaldoAnteriorDolar ,DebitoLocal ,DebitoDolar ,CreditoLocal ,CreditoDolar ,SaldoLocal ,SaldoDolar)
SELECT A.IDCuenta, C.Cuenta,C.Descr DescrCuenta,A.IDCentro,CC.Centro,CC.Descr DescrCentroCosto,A.Fecha,
			 ISNULL(SaldoAnteriorLocal,0) SaldoAnteriorLocal, ISNULL(SaldoAnteriorDolar,0) SaldoAnteriorDolar, SUM(Debito) DebitoLocal, SUM(Debito)/@TipoCambio DebitoDolar,
			 SUM(Credito) CreditoLocal, SUM(Credito)/@TipoCambio CreditoDolar, CASE WHEN SC.Naturaleza='D' THEN SUM(Debito-Credito) ELSE sum(Credito-Debito) END  SaldoLocal,
			CASE WHEN SC.Naturaleza='D' THEN SUM(Debito-Credito)/@TipoCambio ELSE sum(Credito-Debito)/@TipoCambio END  SaldoDolar 
			-- Saldo SaldoLocal, Saldo / @TipoCambio SaldoDolar -- INTO #tmpSaldos 
FROM dbo.cntSaldo A
LEFT JOIN (	
				SELECT IDCentro,IDCuenta, SUM(ISNULL(Saldo,0)) SaldoAnteriorLocal,  SUM(ISNULL(Saldo,0)) / @TipoCambio SaldoAnteriorDolar FROM dbo.cntSaldo 
				WHERE (IDCuenta=@IdCuentaContable OR @IdCuentaContable=-1)  AND (IDCentro=@IdCentroCosto OR @IdCentroCosto=-1) AND Fecha=@FechaPeriodoAnterior
				GROUP BY IDCentro,IDCuenta
			) B ON A.IDCentro = B.IDCentro AND A.IDCuenta = B.IDCuenta
INNER JOIN dbo.cntCuenta C ON A.IDCuenta=C.IDCuenta
INNER JOIN dbo.cntCentroCosto CC ON A.IDCentro=CC.IDCentro
INNER JOIN dbo.cntSubTipoCuenta SC ON C.IDSubTipo=SC.IDSubTipo
WHERE (A.IDCuenta=@IdCuentaContable OR @IdCuentaContable=-1)  AND (A.IDCentro=@IdCentroCosto OR @IdCentroCosto=-1)
AND Fecha BETWEEN @FechaInicial AND @FechaFinal
 GROUP BY A.IDCuenta, C.Cuenta,C.Descr ,A.IDCentro,CC.Centro,CC.Descr ,A.Fecha,
			 ISNULL(SaldoAnteriorLocal,0) , ISNULL(SaldoAnteriorDolar,0),SC.Naturaleza




IF (@IdCentroCosto<>-1  )
BEGIN
	SELECT 0 SaldoAnteriorLocal, 0 SaldoAnteriorDolar,SUM(DebitoLocal) DebitoLocal,SUM(CreditoLocal) CreditoLocal,SUM(DebitoDolar) DebitoDolar,SUM(CreditoDolar) CreditoDolar,0 SaldoLocal, 0 SaldoDolar FROM @tmpSaldos S
	INNER JOIN dbo.cntCuenta C ON S.Cuenta = C.Cuenta WHERE C.EsMayor=0 AND AceptaDatos=1
END
ELSE 
BEGIN
	SELECT S.cuenta,SUM(SaldoAnteriorLocal) SaldoAnteriorLocal,SUM(SaldoAnteriorDolar) SaldoAnteriorDolar,SUM(DebitoLocal) DebitoLocal,SUM(CreditoLocal) CreditoLocal,SUM(DebitoDolar) DebitoDolar,SUM(CreditoDolar) CreditoDolar,
	SUM(CASE WHEN ST.Naturaleza='D' THEN DebitoLocal - CreditoLocal ELSE CreditoLocal-DebitoLocal END ) SaldoLocal, SUM(CASE WHEN ST.Naturaleza='D' THEN DebitoDolar - CreditoDolar ELSE CreditoDolar-DebitoDolar END ) SaldoDolar
	--SUM( SaldoLocal) SaldoLocal , SUM( SaldoDolar) SaldoDolar
	 FROM @tmpSaldos S	INNER JOIN dbo.cntCuenta C ON S.IDCuenta = C.IDCuenta 
	INNER JOIN dbo.cntSubTipoCuenta ST ON C.IDSubTipo=ST.IDSubTipo AND C.IDTipo=ST.IDTipo
	-- WHERE C.EsMayor=0 AND AceptaDatos=1
   GROUP BY S.Cuenta,ST.Naturaleza
END

SELECT  A.IDCuenta, 
			CASE WHEN C.Nivel1<>0 AND C.Nivel2 + C.Nivel3 +C.Nivel4+C.Nivel5=0 THEN 1 ELSE 0 END NIVEL1,
			CASE WHEN C.Nivel2<>0 AND C.Nivel3 +C.Nivel4+C.Nivel5=0 THEN 1 ELSE 0 END NIVEL2 ,
			CASE WHEN C.Nivel3<>0 AND C.Nivel4+C.Nivel5=0 THEN 1 ELSE 0 END NIVEL3,
			CASE WHEN C.Nivel4<>0 AND C.Nivel5=0 THEN 1 ELSE 0 END NIVEL4,
			CASE WHEN C.Nivel5<>0 AND C.Nivel6=0 THEN 1 ELSE 0 END NIVEL5, 
			CASE WHEN C.Nivel6<>0  THEN 1 ELSE 0 END NIVEL6, 
 A.Cuenta ,        DescrCuenta ,  A.IDCentro,  CC.Nivel1 CentroNivel1,CC.Nivel2 CentroNivel2,CC.Nivel3 CentroNivel3 , A.Centro ,        DescrCentroCosto ,        Fecha ,        SaldoAnteriorLocal ,   SaldoAnteriorDolar ,     DebitoLocal,   CreditoLocal ,    DebitoDolar,   CreditoDolar ,         SaldoLocal, SaldoDolar  FROM @tmpSaldos A
INNER JOIN dbo.cntCuenta C ON A.IDCuenta = C.IDCuenta
INNER JOIN dbo.cntCentroCosto CC ON A.IDCentro=CC.IDCentro
--WHERE Fecha=@FechaFinal 
ORDER BY A.Cuenta ASC


GO

CREATE TYPE [dbo].[cntCuentaTableType] AS TABLE(
	[IDCuenta] [bigint] NULL
)
GO

CREATE FUNCTION [dbo].[globalGetTipoCambio] 
(-- @Cual = 'U' ultimo Dia 'P' Primemr
	@Fecha DATETIME,
	@Tipo NVARCHAR(4)
)
RETURNS DECIMAL(28,8)
AS
BEGIN

	DECLARE @TipoCambio AS DECIMAL(28,8)
	SET @TipoCambio = (SELECT Monto  FROM dbo.globalTipoCambioDetalle WHERE Fecha=DATEADD(D,-1,DATEADD(mm, DATEDIFF(m,0,@Fecha)+1,0)) AND IDTipoCambio=@Tipo)
	RETURN @TipoCambio
END


GO

CREATE  PROCEDURE [dbo].[cntConsultaLibroMayor]( @CuentasDeMayor AS BIT, @FechaInicial AS DATE,@FechaFinal AS DATE, @CuentaContable AS cntCuentaTableType READONLY)
as
--DECLARE @CuentasDeMayor AS BIT
--DECLARE @FechaInicial AS DATE,@FechaFinal AS DATE
--DECLARE @CuentaContable AS  TABLE(IDCuenta  int)
--INSERT INTO @CuentaContable
--        ( IDCuenta )
--VALUES  ( 1  -- IDCuenta - int
--          )
         
--         INSERT INTO @CuentaContable
--        ( IDCuenta )
--VALUES  ( 2  -- IDCuenta - int
--          ) 
--SET @CuentasDeMayor = 1
--SET @FechaInicial = '20170601'
--SET @FechaFinal = '20170930'


DECLARE @TipoCambio AS DECIMAL(28,8)
DECLARE @TipoTC  AS NVARCHAR(20)

SELECT @TipoTC= TipoCambio FROM dbo.cntParametros
SELECT @TipoCambio = [dbo].globalGetTipoCambio (@FechaFinal,@TipoTC)

set @FechaInicial = CONVERT(VARCHAR(25),DATEADD(dd,-(DAY(@FechaInicial)-1),@FechaInicial),101) 
set @FechaFinal = CONVERT(VARCHAR(25),DATEADD(dd,-(DAY(DATEADD(mm,1,@FechaFinal))),DATEADD(mm,1,@FechaFinal)),101)

DECLARE @FechaPeriodoAnterior  AS DATE

SET @FechaPeriodoAnterior = DATEADD(MONTH,-1,@FechaInicial)
SET @FechaPeriodoAnterior=  CONVERT(VARCHAR(25),DATEADD(dd,-(DAY(DATEADD(mm,1,@FechaPeriodoAnterior))),DATEADD(mm,1,@FechaPeriodoAnterior)),101)


SELECT P.FechaFinal,P.Descr,C.IDCuenta,C.Cuenta,C.Descr DescrCuenta,
SUM(A.SaldoAnterior) SaldoAnteriorLocal,SUM(Debito) DebitoLocal,SUM(Credito) CreditoLocal, SUM(Saldo) SaldoLocal, 
SUM(A.SaldoAnterior)/@TipoCambio SaldoAnteriorDolar,SUM(Debito)/@TipoCambio DebitoDolar,SUM(Credito)/@TipoCambio CreditoDolar, SUM(Saldo)/@TipoCambio SaldoDolar, C.EsMayor INTO #tmpDetalle
FROM dbo.cntSaldo A
INNER JOIN dbo.cntCuenta C ON A.IDCuenta=c.IDCuenta
INNER JOIN dbo.cntSubTipoCuenta SC ON SC.IDSubTipo=C.IDSubTipo AND SC.IDTipo=C.IDTipo
INNER JOIN dbo.cntPeriodoContable P ON A.IDEjercicio=P.IDEjercicio AND a.Periodo=P.Periodo
WHERE /*EsMayor=@CuentasDeMayor AND */ A.Fecha BETWEEN @FechaInicial AND @FechaFinal AND C.IDCuenta IN (SELECT IDCuenta  FROM @CuentaContable)
GROUP BY P.FechaFinal,P.Descr,C.IDCuenta,C.Cuenta,C.Descr ,C.EsMayor
ORDER BY Cuenta, P.FechaFinal asc

SELECT  FechaFinal ,
        Descr ,
        IDCuenta ,
        Cuenta ,
        DescrCuenta ,
        SaldoAnteriorLocal ,
        DebitoLocal ,
        CreditoLocal ,
        SaldoLocal ,
        SaldoAnteriorDolar ,
        DebitoDolar ,
        CreditoDolar ,
        SaldoDolar  FROM 
(SELECT   FechaFinal ,
        Descr ,
        IDCuenta ,
        Cuenta ,
        DescrCuenta ,
        SaldoAnteriorLocal ,
        DebitoLocal ,
        CreditoLocal ,
        SaldoLocal ,
        SaldoAnteriorDolar ,
        DebitoDolar ,
        CreditoDolar ,
        SaldoDolar,EsMayor  FROM #tmpDetalle
UNION ALL 
SELECT P.FechaFinal,P.Descr,C.IDCuenta,C.Cuenta,C.Descr DescrCuenta,
SUM(A.SaldoAnterior) SaldoAnteriorLocal,SUM(Debito) DebitoLocal,SUM(Credito) CreditoLocal, SUM(Saldo) SaldoLocal, 
SUM(A.SaldoAnterior)/@TipoCambio SaldoAnteriorDolar,SUM(Debito)/@TipoCambio DebitoDolar,SUM(Credito)/@TipoCambio CreditoDolar, SUM(Saldo)/@TipoCambio SaldoDolar,C.EsMayor
FROM dbo.cntSaldo A
INNER JOIN dbo.cntCuenta C ON A.IDCuenta=c.IDCuenta
INNER JOIN dbo.cntSubTipoCuenta SC ON SC.IDSubTipo=C.IDSubTipo AND SC.IDTipo=C.IDTipo
INNER JOIN dbo.cntPeriodoContable P ON A.IDEjercicio=P.IDEjercicio AND a.Periodo=P.Periodo
WHERE   A.Fecha BETWEEN @FechaInicial AND @FechaFinal AND C.IDCuenta IN (SELECT C.IDCuentaMayor  FROM #tmpDetalle A INNER JOIN dbo.cntCuenta C ON A.IDCuenta = C.IDCuenta)
GROUP BY P.FechaFinal,P.Descr,C.IDCuenta,C.Cuenta,C.Descr ,C.EsMayor
) A
WHERE EsMayor=@CuentasDeMayor 
ORDER BY Cuenta, FechaFinal asc


GO


CREATE PROCEDURE [dbo].[cntTieneHijosGrupoEstadosFinancieros] (@IDGrupo INT,@TIPO  NVARCHAR(2))
AS
--DECLARE @IDGrupo INT,@TIPO AS NVARCHAR(2)

--SET @IDGrupo=57
DECLARE @TieneHijos BIT
DECLARE @iNivel1 AS INT,@iNivel2 AS INT,@iNivel3 AS INT

SELECT  @INivel1 = Nivel1,@iNivel2 = Nivel2,@iNivel3 =Nivel3  FROM dbo.cntGrupoEstadosFinancieros WHERE IDGrupo=@IDGrupo

	Declare @Str nvarchar(250), @i int, @Anterior int, @Actual int, @CantItems int, @Found bit , @Siguiente INT
	DECLARE @Nivel1 nvarchar(50)  , @Nivel2 nvarchar(50), @Nivel3 nvarchar(50)
	Declare   @charPredecesor nvarchar(1), 
	@cantCharNivel1 int,  @cantCharNivel2 int, @cantCharNivel3 INT,@SeparadorCentro NVARCHAR(1)

	SELECT TOP 1 @SeparadorCentro= SeparadorCentro, @charPredecesor=charPredecesorCentro  FROM dbo.cntParametros

	SET @cantCharNivel1=2
	SET @cantCharNivel2=2
	set @cantCharNivel3=2
	--SET @charPredecesor='0'

	SET @Nivel1 = CASE WHEN @iNivel1=-1 THEN '-1' WHEN @iNivel1=0 THEN '0' ELSE   right(replicate ( @charPredecesor, @cantCharNivel1) +  ISNULL(CAST(@iNivel1 AS NVARCHAR(50)) ,'')  , @cantCharNivel1 ) END 
	SET @Nivel2= CASE WHEN @iNivel2=-1 THEN '-1' WHEN @iNivel2=0 THEN '0' ELSE right (replicate ( @charPredecesor, @cantCharNivel2)+ CAST(@iNivel2 AS NVARCHAR(50)), @cantCharNivel2) END
	SET @Nivel3=  CASE WHEN @iNivel3=-1 THEN '-1' WHEN @iNivel3=0 THEN '0' ELSE right (replicate ( @charPredecesor, @cantCharNivel3)+ CAST(@iNivel3 AS NVARCHAR(50)), @cantCharNivel3) END


	
	set @Str =@Tipo + case when @Nivel1 = '-1' then '%' WHEN @Nivel1='0' THEN ''  else   @Nivel1 + @SeparadorCentro end
	set @Str = @Str + case when @Nivel2 = '-1' then '%' WHEN @Nivel2='0' THEN '' else  @Nivel2 + @SeparadorCentro end
	set @Str = @Str + case when @Nivel3 = '-1' then '%' WHEN @Nivel3='0' THEN '' else  @Nivel3 end
	SET @Str= @Str + '%'

DECLARE @Cantidad  AS DECIMAL(28,2)
SET @Cantidad = (	
			SELECT COUNT(Grupo)   FROM (
					select Nivel1, Nivel2 , Nivel3 ,Grupo
					from dbo.cntGrupoEstadosFinancieros 
					where @Str = '' or Grupo like @Str AND Tipo=@TIPO
					) A
	)
	
IF (@Cantidad>1)
	SET  @TieneHijos=1
ELSE 
	SET @TieneHijos=0
	
	SELECT  @TieneHijos


GO



CREATE  PROCEDURE [dbo].[cntrptBalanceGeneral]  @FechaInicial AS DATE, @FechaFinal AS DATE,@Moneda NVARCHAR(1)
AS 

--DECLARE @FechaInicial AS DATE
--DECLARE @FechaFinal AS DATE
DECLARE @Tipo AS NVARCHAR(2)
SET @Tipo='BG'
--SET @FechaInicial = '20170601'
--SET @FechaFinal = '20170930'

set @FechaInicial = CONVERT(VARCHAR(25),DATEADD(dd,-(DAY(@FechaInicial)-1),@FechaInicial),101) 
set @FechaFinal = CONVERT(VARCHAR(25),DATEADD(dd,-(DAY(DATEADD(mm,1,@FechaFinal))),DATEADD(mm,1,@FechaFinal)),101)

DECLARE @Balance  AS TABLE(
[IDGrupo] [int] NOT NULL,
[Nivel1] [int] NOT NULL,
[Nivel2] [int] NOT NULL,
[Nivel3] [int] NOT NULL,
[Grupo] [nvarchar](10) NULL,
[Descr] [nvarchar](255) NULL,
[DescrTipo] [nvarchar](255) NOT NULL,
[Acumulador] [bit] NULL,
[IDGrupoAcumulador] [int] NULL,
[Saldo] [decimal](38, 4) NOT NULL
) 

DECLARE @TC AS DECIMAL(28,4)
SET @TC =1
IF (@Moneda='D')
BEGIN
	DECLARE	@TipoTC AS NVARCHAR(20)
	SELECT @TipoTC = TipoCambio FROM dbo.cntParametros
	SELECT @TC = [dbo].globalGetTipoCambio (@FechaFinal,@TipoTC)
END


DECLARE @Saldo AS TABLE(IDCuenta  BIGINT,Saldo  decimal(28,4))
DECLARE @FechaPeriodoAnterior  AS DATE
SET @FechaPeriodoAnterior=  CONVERT(VARCHAR(25),DATEADD(dd,-(DAY(DATEADD(mm,1,@FechaInicial))),DATEADD(mm,1,@FechaInicial)),101)

INSERT INTO @Saldo (IDCuenta,Saldo)
SELECT S.IDCuenta, ISNULL(SA.SaldoAnterior,0) + SUM(CASE  WHEN SC.Naturaleza='D'  THEN  (ISNULL(Debito,0) - ISNULL(Credito,0)) ELSE (ISNULL(Credito,0) - ISNULL(Debito,0)) END ) Saldo   FROM dbo.cntSaldo S
LEFT JOIN (
	SELECT IDCuenta, ISNULL(SUM(SaldoAnterior),0) SaldoAnterior  FROM dbo.cntSaldo S WHERE Fecha=@FechaPeriodoAnterior
	GROUP BY IDCuenta
)  SA ON S.IDCuenta=SA.IDCuenta
INNER JOIN dbo.cntCuenta C ON S.IDCuenta=C.IDCuenta
INNER JOIN dbo.cntSubTipoCuenta SC ON C.IDTipo=SC.IDTipo AND C.IDSubTipo=SC.IDSubTipo
WHERE Fecha BETWEEN @FechaInicial AND @FechaFinal
GROUP BY S.IDCuenta,SA.SaldoAnterior




INSERT INTO @Balance   ( IDGrupo ,          Nivel1 ,          Nivel2 ,          Nivel3 ,          Grupo ,          Descr ,          DescrTipo ,          Acumulador ,          IDGrupoAcumulador ,          Saldo        )
SELECT  A.IDGrupo,A.Nivel1,A.Nivel2,A.Nivel3,Grupo,A.Descr,GC.Descr DescrTipo, Acumulador ,IDGrupoAcumulador ,ISNULL(SUM(S.Saldo/@TC),0) Saldo  
FROM 
(SELECT CASE WHEN Nivel1 <>0 AND Nivel2 + Nivel3=0 THEN 1 ELSE 0 END Nivel1,
			CASE WHEN Nivel2 <>0 AND Nivel3=0 THEN 1 ELSE 0 END Nivel2,
			CASE WHEN Nivel3 <>0  THEN 1 ELSE 0 END Nivel3,
			IDGrupo,Grupo,Descr,Tipo,IDGrupoCuenta,Acumulador,IDGrupoAcumulador
FROM dbo.cntGrupoEstadosFinancieros) A
LEFT JOIN dbo.cntCuentaGrupoEstadosFinancieros B ON A.IDGrupo = B.IDGrupo
LEFT  JOIN dbo.cntCuenta C ON B.IDCuenta=C.IDCuenta
LEFT  JOIN @Saldo S ON C.IDCuenta=S.IDCuenta
INNER JOIN dbo.cntGrupoCuenta GC ON A.IDGrupoCuenta=GC.IDGrupo
WHERE Grupo<>'00-00-00'  AND A.Tipo=@Tipo 
GROUP BY A.IDGrupo,A.Nivel1,A.Nivel2,A.Nivel3,Grupo,A.Descr,GC.Descr,A.Acumulador,A.IDGrupoAcumulador
ORDER BY A.Grupo ASC

DECLARE @Fuente  AS TABLE(
[Agrupador] [int] NOT NULL,
[IDGrupo] [int] NOT NULL,
IDGrupoAcumulador [int] NOT NULL,
acumulador [bit] NOT NULL,
[Saldo] [decimal](38, 4) NOT NULL DEFAULT 0
) 

INSERT INTO @Fuente        ( Agrupador ,          IDGrupo ,          IDGrupoAcumulador ,          acumulador ,          Saldo        )
SELECT Agrupador,IDGrupo, IDGrupoAcumulador, acumulador,Saldo
from (
select IDGrupo AGrupador,IDGrupo, IDGrupoAcumulador, acumulador,Saldo
from @Balance
where acumulador = 1
union all
select IDGrupoAcumulador Agrupador, IDGrupo, IDGrupoAcumulador, acumulador,Saldo
from @Balance
WHERE acumulador = 0 

) x
ORDER BY AGrupador 

Update F set SAldo = D.Saldo 
From @Fuente F inner join (
select agrupador, SUM(Saldo) Saldo 
from @Fuente
where acumulador = 0 
group by agrupador 
) D 
on F.Agrupador = D.Agrupador 
where acumulador = 1


Update F set Saldo = D.Saldo 
from @Fuente F inner join (

SELECT IDGrupoAcumulador, acumulador, SUM( Saldo ) Saldo
from @Fuente 
WHERE Acumulador = 1 AND IDGRUPOACUMULADOR <>0
GROUP BY IDGrupoAcumulador , acumulador
) D on F.IDGrupo = D.IDGrupoAcumulador

SELECT A.IDGrupo, B.Nivel1,B.Nivel2,B.Nivel3, B.Grupo,DescrTipo,B.Acumulador,B.Descr,A.IDGrupoAcumulador, A.Saldo FROM @Fuente A
INNER JOIN @Balance B ON A.idGrupo =B.idGrupo


GO


CREATE  PROCEDURE dbo.cntGetCentroCostoByCuentaContable( @IDCuenta AS BIGINT)
AS 
--DECLARE @IDCuenta AS INT
--SET @IDCuenta =-1
SELECT  DISTINCT A.IDCentro,A.Nivel1,A.Nivel2,A.Nivel3,A.Centro,A.Descr,A.IDCentroAnterior,A.Acumulador,A.IDCentroAcumulador,A.ReadOnlySys,A.Activo  FROM dbo.cntCentroCosto A
LEFT JOIN dbo.cntCuentaCentro C ON	A.IDCentro = C.IDCentro
WHERE (@IDCuenta = -1 OR IDCuenta= @IDCuenta) AND A.IDCentro!=0 AND Acumulador=0
UNION ALL
SELECT   A.IDCentro,A.Nivel1,A.Nivel2,A.Nivel3,A.Centro,A.Descr,A.IDCentroAnterior,A.Acumulador,A.IDCentroAcumulador,A.ReadOnlySys,A.Activo  FROM dbo.cntCentroCosto A
WHERE IDCentro=0

GO


CREATE PROCEDURE dbo.cntGetCuentaConbleByCentroCosto (@IDCentro AS INT)
AS 
--DECLARE @IDCentro AS INT
--SET @IDCentro =8
SELECT  DISTINCT A.IDCuenta,A.IDGrupo,A.IDTipo,A.IDSubTipo,A.Tipo,A.SubTipo,A.Nivel1,A.Nivel2,A.Nivel3,A.Nivel4,A.Nivel5,A.Cuenta,A.Descr,A.Complementaria  FROM dbo.cntCuenta A
LEFT  JOIN dbo.cntCuentaCentro C ON	A.IDCuenta = C.IDCuenta 
WHERE (@IDCentro = 0 OR IDCentro= @IDCentro)  AND A.AceptaDatos=1

GO


CREATE PROCEDURE [dbo].[cntrpEstadoResultado]  @FechaInicial AS DATE, @FechaFinal AS DATE,@Moneda NVARCHAR(1),@BaseReporte AS INT
AS 
--BaseReporte : 1 - Movimento del periodo
--						2- Saldo Final

--DECLARE @FechaInicial AS DATE
--DECLARE @FechaFinal AS DATE
DECLARE @Tipo AS NVARCHAR(2)
SET @Tipo='ER'
--SET @FechaInicial = '20170601'
--SET @FechaFinal = '20170930'

set @FechaInicial = CONVERT(VARCHAR(25),DATEADD(dd,-(DAY(@FechaInicial)-1),@FechaInicial),101) 
set @FechaFinal = CONVERT(VARCHAR(25),DATEADD(dd,-(DAY(DATEADD(mm,1,@FechaFinal))),DATEADD(mm,1,@FechaFinal)),101)

DECLARE @Balance  AS TABLE(
[IDGrupo] [int] NOT NULL,
[Nivel1] [int] NOT NULL,
[Nivel2] [int] NOT NULL,
[Nivel3] [int] NOT NULL,
[Grupo] [nvarchar](10) NULL,
[Descr] [nvarchar](255) NULL,
[DescrTipo] [nvarchar](255) NOT NULL,
[Acumulador] [bit] NULL,
[IDGrupoAcumulador] [int] NULL,
[Saldo] [decimal](38, 4) NOT NULL
) 

DECLARE @TC AS DECIMAL(28,4)
DECLARE @TipoTC  AS NVARCHAR(20)
SET @TC =1
IF (@Moneda='D')
BEGIN
	SELECT @TipoTC = TipoCambio  FROM dbo.cntParametros
	SELECT @TC = [dbo].globalGetTipoCambio (@FechaFinal,@TipoTC)


END

DECLARE @Saldo AS TABLE(IDCuenta  BIGINT,Saldo  decimal(28,4))
DECLARE @FechaPeriodoAnterior  AS DATE
SET @FechaPeriodoAnterior=  CONVERT(VARCHAR(25),DATEADD(dd,-(DAY(DATEADD(mm,1,@FechaInicial))),DATEADD(mm,1,@FechaInicial)),101)

INSERT INTO @Saldo (IDCuenta,Saldo)

SELECT S.IDCuenta, (CASE WHEN @BaseReporte=2  THEN ISNULL(SA.SaldoAnterior,0)  ELSE  0  END)+ SUM(CASE  WHEN SC.Naturaleza='D'  THEN  (ISNULL(Debito,0) - ISNULL(Credito,0)) ELSE (ISNULL(Credito,0) - ISNULL(Debito,0)) END ) Saldo   FROM dbo.cntSaldo S
LEFT JOIN (
	SELECT IDCuenta, ISNULL(SUM(SaldoAnterior),0) SaldoAnterior  FROM dbo.cntSaldo S WHERE Fecha=@FechaPeriodoAnterior
	GROUP BY IDCuenta
)  SA ON S.IDCuenta=SA.IDCuenta
INNER JOIN dbo.cntCuenta C ON S.IDCuenta=C.IDCuenta
INNER JOIN dbo.cntSubTipoCuenta SC ON C.IDTipo=SC.IDTipo AND C.IDSubTipo=SC.IDSubTipo
WHERE Fecha BETWEEN @FechaInicial AND @FechaFinal
GROUP BY S.IDCuenta,SA.SaldoAnterior



INSERT INTO @Balance   ( IDGrupo ,          Nivel1 ,          Nivel2 ,          Nivel3 ,          Grupo ,          Descr ,          DescrTipo ,          Acumulador ,          IDGrupoAcumulador ,          Saldo        )
SELECT  A.IDGrupo,A.Nivel1,A.Nivel2,A.Nivel3,Grupo,A.Descr,GC.Descr DescrTipo, Acumulador ,IDGrupoAcumulador ,ISNULL(SUM(S.Saldo/@TC),0) Saldo  
FROM 
(SELECT CASE WHEN Nivel1 <>0 AND Nivel2 + Nivel3=0 THEN 1 ELSE 0 END Nivel1,
			CASE WHEN Nivel2 <>0 AND Nivel3=0 THEN 1 ELSE 0 END Nivel2,
			CASE WHEN Nivel3 <>0  THEN 1 ELSE 0 END Nivel3,
			IDGrupo,Grupo,Descr,Tipo,IDGrupoCuenta,Acumulador,IDGrupoAcumulador
FROM dbo.cntGrupoEstadosFinancieros) A
LEFT JOIN dbo.cntCuentaGrupoEstadosFinancieros B ON A.IDGrupo = B.IDGrupo
LEFT  JOIN dbo.cntCuenta C ON B.IDCuenta=C.IDCuenta
LEFT  JOIN @Saldo S ON C.IDCuenta=S.IDCuenta
INNER JOIN dbo.cntGrupoCuenta GC ON A.IDGrupoCuenta=GC.IDGrupo
WHERE Grupo<>'00-00-00'  AND A.Tipo=@Tipo 
GROUP BY A.IDGrupo,A.Nivel1,A.Nivel2,A.Nivel3,Grupo,A.Descr,GC.Descr,A.Acumulador,A.IDGrupoAcumulador
ORDER BY A.Grupo ASC

DECLARE @Fuente  AS TABLE(
[Agrupador] [int] NOT NULL,
[IDGrupo] [int] NOT NULL,
IDGrupoAcumulador [int] NOT NULL,
acumulador [bit] NOT NULL,
[Saldo] [decimal](38, 4) NOT NULL DEFAULT 0
) 




INSERT INTO @Fuente        ( Agrupador ,          IDGrupo ,          IDGrupoAcumulador ,          acumulador ,          Saldo        )
SELECT Agrupador,IDGrupo, IDGrupoAcumulador, acumulador,Saldo
from (
select IDGrupo AGrupador,IDGrupo, IDGrupoAcumulador, acumulador,Saldo --CASE WHEN DescrTipo IN ('GASTOS','COSTOS')  THEN  Saldo * -1 ELSE Saldo END Saldo
from @Balance
where acumulador = 1
union all
select IDGrupoAcumulador Agrupador, IDGrupo, IDGrupoAcumulador, acumulador,Saldo --CASE WHEN DescrTipo IN ('GASTOS','COSTOS') THEN Saldo *-1 ELSE Saldo END Saldo
from @Balance
WHERE acumulador = 0 

) x
ORDER BY AGrupador 

Update F set SAldo = D.Saldo 
From @Fuente F inner join (
select agrupador, SUM(Saldo) Saldo 
from @Fuente
where acumulador = 0 
group by agrupador 
) D 
on F.Agrupador = D.Agrupador 
where acumulador = 1


Update F set Saldo = D.Saldo 
from @Fuente F inner join (

SELECT IDGrupoAcumulador, acumulador, SUM( Saldo ) Saldo
from @Fuente 
WHERE Acumulador = 1 AND IDGRUPOACUMULADOR <>0
GROUP BY IDGrupoAcumulador , acumulador
) D on F.IDGrupo = D.IDGrupoAcumulador

SELECT A.IDGrupo, B.Nivel1,B.Nivel2,B.Nivel3, B.Grupo,DescrTipo,B.Acumulador,B.Descr,A.IDGrupoAcumulador, A.Saldo FROM @Fuente A
INNER JOIN @Balance B ON A.idGrupo =B.idGrupo


GO

CREATE PROCEDURE dbo.cntValidarEjerciosPeriodoTrabajo(@Fecha AS date)
AS 
--DECLARE @Fecha AS DATE
DECLARE  @IDEjercicio AS INT
DECLARE @Periodo AS NVARCHAR(10)

--SET @Fecha = '20170901'
SELECT TOP 1 @IDEjercicio = ISNULL(IDEjercicio,0), @Periodo = Periodo 
FROM dbo.cntPeriodoContable 
WHERE FechaFinal= CAST( DATEADD(s,-1,DATEADD(mm, DATEDIFF(m,0,@Fecha)+1,0)) AS DATE) AND AjustesCierreFiscal<>1

IF @IDEjercicio>0
BEGIN	
	IF NOT  EXISTS(SELECT *  FROM  dbo.cntPeriodoContable WHERE PeriodoTrabajo=1 AND Periodo=@Periodo)
		SELECT 'No hay periodos de trabajo abiertos para el periodo seleccionado por favor verifique' msg
	ELSE
		SELECT 'OK' msg
END
ELSE 
	SELECT 'No existe Ejercicio fiscal para la fecha seleccionada' msg


GO



CREATE TABLE [dbo].[globalFiltrosReportes](
	[IDReporte] INT NOT NULL,
	[Usuario] NVARCHAR(20)  NOT NULL,
	[IDCuenta] [bigint] NOT NULL,
	[IDCentro][int] NOT NULL,
	[Fecha] [datetime],
 CONSTRAINT [pkglobalFiltrosReportes] PRIMARY KEY CLUSTERED 
(
	[IDReporte] ASC,
	[Usuario] ASC,
	[IDCuenta] ASC,
	[IDCentro] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO



CREATE PROCEDURE dbo.globalSetCuentaCentroReporte ( @StrCuentas AS NVARCHAR(4000),@StrCentros AS NVARCHAR(4000),@IDReporte  AS INT,@Usuario NVARCHAR(50))
--DECLARE @StrCuentas AS NVARCHAR(1000),@StrCentros AS NVARCHAR(1000),@IDReporte  AS INT,@Usuario NVARCHAR(50)
AS 
--SET @StrCuentas = '1,2,3,4'
--SET @StrCentros = '1,2,3,4'
--SET @IDReporte=1
--SET @Usuario ='Azepeda'
SELECT Value Cuentas INTO #Cuentas  FROM dbo.ConvertListToTable(@StrCuentas,',')
SELECT Value Centros INTO #Centros FROM dbo.ConvertListToTable(@StrCentros,',')

DELETE FROM dbo.globalFiltrosReportes WHERE @Usuario=@Usuario AND @IDReporte=@IDReporte

INSERT INTO dbo.globalFiltrosReportes  ( IDReporte ,Usuario ,IDCuenta ,IDCentro ,Fecha)
SELECT DISTINCT @IDReporte,@Usuario,Cuentas,Centros,CAST(GETDATE() AS DATE) Fecha  FROM #Cuentas C CROSS JOIN #Centros CC

DROP TABLE  #Cuentas
DROP TABLE  #Centros

GO

CREATE PROCEDURE  [dbo].[cntGetBalanceComprabacion]  @IDReporte AS INT,@Usuario NVARCHAR(20),@FechaInicial DATETIME,@FechaFinal DATETIME,
																					@IncluyeAsientosDiario BIT,@SoloCuentasdeMayor AS int,@TipoCuentaSinMovimiento AS INT,
																					@ConsolidadByCuenta BIT
AS 
--DECLARE @IDReporte AS INT,@Usuario NVARCHAR(20),@FechaInicial DATETIME,@FechaFinal DATETIME,@IncluyeAsientosDiario BIT,@ConsolidadByCuenta INT,@SoloCuentasdeMayor AS INT,@TipoCuentaSinMovimiento AS INT
--SET @TipoCuentaSinMovimiento=1
--SET @IDReporte =1 
--SET @Usuario='azepeda'
--SET @FechaInicial  = '20170601'
--SET @FechaFinal = '20171030'
--SET @IncluyeAsientosDiario = 0
--SET @ConsolidadByCuenta=1
--SET @SoloCuentasdeMayor =-1

DECLARE @IDCuenta AS BIGINT,@IDCentro AS INT

--Si la variable contiene -1 quiere decir que son todos los centros de costo o todas las cuentas contables
SET @IDCuenta  = (SELECT DISTINCT TOP 1   IDCuenta FROM globalFiltrosReportes WHERE Usuario=@Usuario AND IDReporte = @IDReporte)
SET @IDCentro  = (SELECT DISTINCT TOP 1   IDCentro FROM globalFiltrosReportes WHERE Usuario=@Usuario AND IDReporte = @IDReporte)



DECLARE @TipoCambio AS DECIMAL(28,8)
DECLARE @TipoTC  AS NVARCHAR(20)


SELECT @TipoTC = TipoCambio  FROM dbo.cntParametros
SELECT @TipoCambio = [dbo].globalGetTipoCambio (@FechaFinal,@TipoTC)

set @FechaInicial = CONVERT(VARCHAR(25),DATEADD(dd,-(DAY(@FechaInicial)-1),@FechaInicial),101) 
set @FechaFinal = CONVERT(VARCHAR(25),DATEADD(dd,-(DAY(DATEADD(mm,1,@FechaFinal))),DATEADD(mm,1,@FechaFinal)),101)

DECLARE @FechaPeriodoAnterior  AS DATE

SET @FechaPeriodoAnterior=  CONVERT(VARCHAR(25),DATEADD(dd,-(DAY(DATEADD(mm,1,@FechaInicial))),DATEADD(mm,1,@FechaInicial)),101)

DECLARE @tmpSaldos AS TABLE(IDCuenta BIGINT,DescrCuenta NVARCHAR(100),IDCentro INT, Descr NVARCHAR(100),SaldoAnteriorLocal DECIMAL(28,4),SaldoAnteriorDolar DECIMAL(28,4),
												DebitoLocal DECIMAL(28,4), DebitoDolar DECIMAL(28,4),CreditoLocal DECIMAL(28,4),CreditoDolar DECIMAL(28,4),SaldoLocal DECIMAL(28,4),SaldoDolar Decimal(28,4))


INSERT INTO @tmpSaldos       ( IDCuenta ,          DescrCuenta ,          IDCentro ,          Descr ,          SaldoAnteriorLocal ,          SaldoAnteriorDolar ,     
	     DebitoLocal ,          DebitoDolar ,          CreditoLocal ,      CreditoDolar ,          SaldoLocal ,          SaldoDolar        )
SELECT  C.IDCuenta,C.DescrCuenta,CC.IDCentro,CC.Descr,ISNULL(PA.SaldoAnteriorLocal,0) SaldoAnteriorLocal,ISNULL(PA.SaldoAnteriorDolar,0) SaldoAnteriorDolar,
			SUM(S.Debito) DebitoLocal,SUM(s.Debito)/@TipoCambio DebitoDolar,
			SUM(S.Credito) CreditoLocal,SUM(S.Credito)/@TipoCambio CreditoDolar,
			ISNULL(PA.SaldoAnteriorLocal,0) + CASE WHEN C.Naturaleza='D' THEN SUM(S.Debito-S.Credito) ELSE SUM(S.Credito-S.Debito) END SaldoLocal,
			ISNULL(PA.SaldoAnteriorDolar,0) + CASE WHEN C.Naturaleza='D' THEN SUM(S.Debito-S.Credito)/@TipoCambio ELSE SUM(S.Credito-S.Debito)/@TipoCambio END SaldoDolar 
FROM dbo.cntSaldo S
INNER JOIN dbo.vcntCatalogo C ON S.IDCuenta = C.IDCuenta
INNER JOIN dbo.cntCentroCosto CC ON S.IDCentro=CC.IDCentro 
LEFT JOIN (
				SELECT IDCentro,IDCuenta, SUM(ISNULL(SaldoAnterior,0)) SaldoAnteriorLocal,  SUM(ISNULL(SaldoAnterior,0)) / @TipoCambio SaldoAnteriorDolar FROM dbo.cntSaldo 
				WHERE (@IDCuenta=-1 OR IDCuenta IN (SELECT DISTINCT  IDCuenta  FROM  globalFiltrosReportes WHERE Usuario=@Usuario AND IDReporte = @IDReporte))
					 AND (@IDCentro =-1 OR IDCentro  IN (SELECT DISTINCT  IDCentro  FROM  globalFiltrosReportes WHERE Usuario=@Usuario AND IDReporte = @IDReporte))
					 AND Fecha=@FechaPeriodoAnterior
				GROUP BY IDCentro,IDCuenta ) PA ON S.IDCuenta=PA.IDCuenta AND S.IDCentro=PA.IDCentro
WHERE (@IDCuenta=-1 OR S.IDCuenta IN (SELECT DISTINCT  IDCuenta  FROM  globalFiltrosReportes WHERE Usuario=@Usuario AND IDReporte = @IDReporte))
	AND (@IDCentro =-1 OR S.IDCentro  IN (SELECT DISTINCT  IDCentro  FROM  globalFiltrosReportes WHERE Usuario=@Usuario AND IDReporte = @IDReporte))
	AND S.Fecha BETWEEN @FechaInicial AND @FechaFinal
GROUP BY C.IDCuenta,C.DescrCuenta,CC.IDCentro,CC.Descr,PA.SaldoAnteriorLocal,PA.SaldoAnteriorDolar,Naturaleza

--tomar en cuenta los asientos sin mayorizar
IF (@IncluyeAsientosDiario=1)
BEGIN
	DECLARE @i AS INT,@Count AS INT
	
	DECLARE @IDCentroTmp int, @IDCuentaTmp BIGINT, @Debito decimal(28,4) ,@Credito decimal(28,4)

	DECLARE  @Detalle  AS TABLE(ID int identity(1,1) not null,   IDCentro int, IDCuenta BIGINT, Debito decimal(28,4) default 0,
	Credito decimal(28,4) default 0 , IDCuentaMayor BIGINT, NaturalezaSaldo nvarchar(1) )
	
	
	INSERT @Detalle ( IDCentro, IDCuenta, Debito , Credito, IDCuentaMayor, NaturalezaSaldo  )
	SELECT IDCentro, D.IDCuenta, SUM(Debito) , SUM(Credito) , C.IDCuentaMayor, C.NaturalezaSaldo 
	from dbo.cntAsientoDetalle D inner join dbo.cntAsiento A
	on D.Asiento = A.Asiento inner join dbo.vcntCatalogo C
	on D.IDCuenta = C.IDCuenta 
	where A.Fecha BETWEEN @FechaInicial AND @FechaFinal
	and Mayorizado = 0 and  A.anulado =0 
	GROUP BY  IDCentro, D.IDCuenta,C.IDCuentaMayor, C.NaturalezaSaldo 
	
	SET @Count=@@rowcount
	
	set @i = 1
	
	While  @i <= @Count 
	begin
		SELECT @IDCentroTmp = IDCentro, @IDCuentaTmp = IDCuenta, @Debito = ISNULL(DEBITO,0) , @Credito = ISNULL(Credito,0)
		FROM @Detalle 
		WHERE ID = @i  
		--exec dbo.cntUpdateSaldoCuenta @IDEjercicio , @Periodo , @IDCuenta , @IDCentro , @Debito , @Credito 
		Declare @NaturalezaSaldo nvarchar(1), @MontoSaldo decimal(28,4), @Fecha date, @IDEjercicioAnt int, @PeriodoAnt nvarchar(10)

		SELECT @NaturalezaSaldo = NaturalezaSaldo
		FROM dbo.vcntCatalogo 
		Where IDCuenta = @IDCuentaTmp

		if @NaturalezaSaldo = 'D' -- Naturaleza Deudora
			set @MontoSaldo = @Debito - @Credito
		else
			set @MontoSaldo = @Credito - @Debito

		
		--Actualizar las cuentas de mayor	
		DECLARE  @CtasMayor  AS TABLE( IDCuenta BIGINT, IDCentro int, SaldoAnt decimal(28,4) default 0  )

		Declare @Sigue bit ,@IDCuentaMayor BIGINT, @IDCuentaActual BIGINT
		set @Sigue = 1
		set @IDCuentaActual = @IDCuentaTmp
		-- inserto la cuenta actual para luego calcular el saldo con las de mayor
		insert @CtasMayor ( IDCuenta, IDCentro  )
		values (@IDCuentaTmp, @IDCentroTmp )

		while @Sigue = 1
		begin
			Select  @IDCuentaMayor = IDCuentaMayor 
			from dbo.cntCuenta (nolock)
			where IDCuenta = @IDCuentaActual 
			if @IDCuentaMayor <> 0
				begin
				insert @CtasMayor ( IDCuenta, IDCentro )
				values (@IDCuentaMayor, @IDCentroTmp)
				end
			Select @IDCuentaActual = IDCuenta 
			From dbo.cntCuenta 
			where IDCuenta = @IDCuentaMayor

			if @IDCuentaMayor = 0
				set @Sigue = 0
		end

			-- Inserto en tmpSaldo las cuenta de mayor con saldo cero
		INSERT INTO @tmpSaldos       ( IDCuenta ,          DescrCuenta ,          IDCentro ,          Descr ,          SaldoAnteriorLocal ,          SaldoAnteriorDolar ,     
	     DebitoLocal ,          DebitoDolar ,          CreditoLocal ,      CreditoDolar ,          SaldoLocal ,          SaldoDolar        )
		SELECT M.IDcuenta, T.DescrCuenta DescrCta,  M.IDCentro, '' DescrCentro, 0 SaldoAnt, 0 SADolar, 0 debloc, 0 debdolar, 0 credloc, 0 creddol, 0 saltoloc, 0 saldodolar 
		FROM (SELECT DISTINCT * FROM @CtasMayor) M left JOIN @tmpSaldos  S 
		ON M.IDCuenta = S.IDCuenta AND M.idCentro = S.IDCentro INNER JOIN dbo.vcntCatalogo t ON M.IDcuenta = T.IDcuenta 
		WHERE  S.IDcuenta IS NULL AND S.IDCentro IS NULL 
		

		-- Actualizo las que estan en saldo

		Update S set S.SaldoLocal = isnull(SaldoLocal ,0 ) + @MontoSaldo ,
							S.SaldoDolar = ISNULL(SaldoDolar,0) + @MontoSaldo/@TipoCambio,
						    S.DebitoLocal = isnull(S.DebitoLocal,0) +  @Debito,
						    S.DebitoDolar = isnull(S.DebitoDolar,0) +  @Debito/@TipoCambio,
						    S.CreditoLocal=isnull(S.CreditoLocal,0) + @Credito,
						    S.CreditoDolar=isnull(S.CreditoDolar,0) + @Credito/@TipoCambio
		from @tmpSaldos  S inner join @CtasMayor M
		on S.IDCuenta = M.IDCuenta and S.IDCentro = M.IDCentro 
		
		
		DELETE FROM @CtasMayor
	
		set @i = @i + 1
		
	end
	
	
END

DECLARE  @tmpSaldo AS TABLE (
	[IDCuenta] [bigint] NOT NULL,
	[Cuenta] [varchar](50) NOT NULL,
	[DescrCuenta] [varchar](255) NOT NULL,
	[EsMayor] [int] NOT NULL,
	[NIVEL1] [int] NOT NULL,
	[NIVEL2] [int] NOT NULL,
	[NIVEL3] [int] NOT NULL,
	[NIVEL4] [int] NOT NULL,
	[NIVEL5] [int] NOT NULL,
	[NIVEL6] [int] NOT NULL,
	[Tipo] [varchar](1) NOT NULL,
	[IDCentro] [int] NOT NULL,
	[Centro] [varchar](20) NOT NULL,
	[DescrCentro] [varchar](255) NOT NULL,
	[SaldoAnteriorLocal] [decimal](28, 4)  NULL,
	[SaldoAnteriorDolar] [decimal](28, 4)  NULL,
	[DebitoLocal] [decimal](28, 4) NULL,
	[DebitoDolar] [decimal](28, 4) NULL,
	[CreditoLocal] [decimal](28, 4) NULL,
	[CreditoDolar] [decimal](28, 4) NULL,
	[SaldoLocal] [decimal](28, 4)  NULL,
	[SaldoDolar] [decimal](28, 4)  NULL
) 






--Calculando los totales del Balance de Comprobacion
			IF (@SoloCuentasdeMayor=1)		
			BEGIN
					INSERT  @tmpSaldo( IDCuenta ,Cuenta ,DescrCuenta ,EsMayor ,NIVEL1 ,NIVEL2 ,NIVEL3 ,NIVEL4 ,NIVEL5, NIVEL6 ,Tipo ,IDCentro ,Centro ,DescrCentro ,SaldoAnteriorLocal ,SaldoAnteriorDolar ,DebitoLocal ,DebitoDolar ,CreditoLocal ,CreditoDolar ,SaldoLocal ,SaldoDolar)
					SELECT -1 IDCuenta,'ZZZ' Cuenta,'TOTALES' DescrCuenta, 1 EsMayor,
						1 NIVEL1,
						 0  NIVEL2 ,
						0  NIVEL3,
						0  NIVEL4,
						0 NIVEL5, 
						0 NIVEL6,
						'T' Tipo,0 IDCentro ,'0' Centro, 'N/D'  DescrCentro,0 SaldoAnteriorLocal, 0 SaldoAnteriorDolar,
						SUM(DebitoLocal) DebitoLocal,SUM(DebitoDolar) DebitoDolar,SUM(CreditoLocal) CreditoLocal,SUM(CreditoDolar) CreditoDolar,0 SaldoLocal,0 SaldoDolar FROM  @tmpSaldos A
				INNER JOIN dbo.vcntCatalogo C ON C.IDCuenta=A.IdCuenta
				WHERE C.EsMayor=1 AND Nivel1<>0 AND Nivel2=0 AND Nivel3=0 AND Nivel4=0 AND Nivel5=0 AND Nivel6=0
			END
			ELSE 
			BEGIN
				INSERT  @tmpSaldo( IDCuenta ,Cuenta ,DescrCuenta ,EsMayor ,NIVEL1 ,NIVEL2 ,NIVEL3 ,NIVEL4 ,NIVEL5, NIVEL6 ,Tipo ,IDCentro ,Centro ,DescrCentro ,SaldoAnteriorLocal ,SaldoAnteriorDolar ,DebitoLocal ,DebitoDolar ,CreditoLocal ,CreditoDolar ,SaldoLocal ,SaldoDolar)
				SELECT -1 IDCuenta,'ZZZ' Cuenta,'TOTALES' DescrCuenta, 1 EsMayor,
						1 NIVEL1,
						 0  NIVEL2 ,
						0  NIVEL3,
						0  NIVEL4,
						0 NIVEL5, 
						0 NIVEL6,
						'T' Tipo,0 IDCentro ,'0' Centro, 'N/D'  DescrCentro,0 SaldoAnteriorLocal, 0 SaldoAnteriorDolar, SUM(DebitoLocal) DebitoLocal,SUM(DebitoDolar) DebitoDolar,SUM(CreditoLocal) CreditoLocal,SUM(CreditoDolar) CreditoDolar,0 SaldoLocal,0 SaldoDolar    FROM  @tmpSaldos A
				INNER JOIN dbo.vcntCatalogo C ON C.IDCuenta=A.IdCuenta
				WHERE C.EsMayor=0 
			END




IF (@ConsolidadByCuenta=1)
BEGIN
	INSERT  @tmpSaldo( IDCuenta ,Cuenta ,DescrCuenta ,EsMayor ,NIVEL1 ,NIVEL2 ,NIVEL3 ,NIVEL4 ,NIVEL5, NIVEL6 ,Tipo ,IDCentro ,Centro ,DescrCentro ,SaldoAnteriorLocal ,SaldoAnteriorDolar ,DebitoLocal ,DebitoDolar ,CreditoLocal ,CreditoDolar ,SaldoLocal ,SaldoDolar)
	SELECT A.IDCuenta,B.Cuenta,A.DescrCuenta,B.EsMayor,
				CASE WHEN B.Nivel1<>0 AND B.Nivel2 + B.Nivel3 +B.Nivel4+B.Nivel5=0 THEN 1 ELSE 0 END NIVEL1,
				CASE WHEN B.Nivel2<>0 AND B.Nivel3 +B.Nivel4+B.Nivel5=0 THEN 1 ELSE 0 END NIVEL2 ,
				CASE WHEN B.Nivel3<>0 AND B.Nivel4+B.Nivel5=0 THEN 1 ELSE 0 END NIVEL3,
				CASE WHEN B.Nivel4<>0 AND B.Nivel5=0 THEN 1 ELSE 0 END NIVEL4,
				CASE WHEN B.Nivel5<>0 AND B.Nivel6=0 THEN 1 ELSE 0 END NIVEL5, 
				CASE WHEN B.Nivel6<>0  THEN 1 ELSE 0 END NIVEL6,
				B.Tipo,0 IDCentro ,'0' Centro, 'N/D'  DescrCentro,A.SaldoAnteriorLocal,A.SaldoAnteriorDolar,SUM(A.DebitoLocal) DebitoLocal,SUM(A.DebitoDolar) DebitoDolar,
				SUM(A.CreditoLocal) CreditoLocal,SUM(A.CreditoDolar) CreditoDolar,SUM(A.SaldoLocal) SaldoLocal,SUM(A.SaldoDolar) SaldoDolar
	  FROM @tmpSaldos A
	INNER JOIN dbo.vcntCatalogo B ON a.IDCuenta =B.IDCuenta
	WHERE (@SoloCuentasdeMayor=-1 OR  B.EsMayor=@SoloCuentasdeMayor) 		
		AND (((@TipoCuentaSinMovimiento = 3 and (ISNULL(DebitoLocal,0) + ISNULL(CreditoLocal,0))>0) OR (@TipoCuentaSinMovimiento=-1)) or
		 ((@TipoCuentaSinMovimiento = 1 ) OR (@TipoCuentaSinMovimiento=-1)) or
		-- ((@TipoCuentaSinMovimiento = 2 and DebitoLocal + CreditoLocal=0) OR (@TipoCuentaSinMovimiento=-1)))
		 ((@TipoCuentaSinMovimiento = 2 AND ISNULL(saldoLocal,0) >0) OR (@TipoCuentaSinMovimiento=-1)))
	GROUP BY A.IDCuenta,B.Cuenta,A.DescrCuenta,B.EsMayor,B.Tipo ,A.SaldoAnteriorLocal,A.SaldoAnteriorDolar,
				Nivel1,Nivel2,Nivel3,Nivel4,Nivel5,Nivel6
	ORDER BY CAST(B.Nivel1 AS INT),CAST(B.Nivel2 AS INT),CAST(B.nivel3 AS INT),CAST(B.nivel4 AS INT), CAST(B.nivel5 AS INT)
END
ELSE 
BEGIN	
		INSERT  @tmpSaldo( IDCuenta ,Cuenta ,DescrCuenta ,EsMayor ,NIVEL1 ,NIVEL2 ,NIVEL3 ,NIVEL4 ,NIVEL5, NIVEL6 ,Tipo ,IDCentro ,Centro ,DescrCentro ,SaldoAnteriorLocal ,SaldoAnteriorDolar ,DebitoLocal ,DebitoDolar ,CreditoLocal ,CreditoDolar ,SaldoLocal ,SaldoDolar)
		SELECT A.IDCuenta,B.Cuenta,A.DescrCuenta,B.EsMayor,
				CASE WHEN B.Nivel1<>0 AND B.Nivel2 + B.Nivel3 +B.Nivel4+B.Nivel5=0 THEN 1 ELSE 0 END NIVEL1,
				CASE WHEN B.Nivel2<>0 AND B.Nivel3 +B.Nivel4+B.Nivel5=0 THEN 1 ELSE 0 END NIVEL2 ,
				CASE WHEN B.Nivel3<>0 AND B.Nivel4+B.Nivel5=0 THEN 1 ELSE 0 END NIVEL3,
				CASE WHEN B.Nivel4<>0 AND B.Nivel5=0 THEN 1 ELSE 0 END NIVEL4,
				CASE WHEN B.Nivel5<>0 AND B.NIVEL6=0 THEN 1 ELSE 0 END NIVEL5, 
				CASE WHEN B.Nivel6<>0  THEN 1 ELSE 0 END NIVEL6,
				B.Tipo,A.IDCentro,C.Centro,A.Descr DescrCentro,A.SaldoAnteriorLocal,A.SaldoAnteriorDolar,A.DebitoLocal,A.DebitoDolar,
				A.CreditoLocal,A.CreditoDolar,A.SaldoLocal,A.SaldoDolar
	  FROM @tmpSaldos A
	INNER JOIN dbo.vcntCatalogo B ON a.IDCuenta =B.IDCuenta
	INNER JOIN dbo.cntCentroCosto C ON A.IDCentro =C.IDCentro
	WHERE (@SoloCuentasdeMayor=-1 OR  B.EsMayor=@SoloCuentasdeMayor) 		
			AND (((@TipoCuentaSinMovimiento = 3 and ISNULL(DebitoLocal,0) + ISNULL(CreditoLocal,0)>0) OR (@TipoCuentaSinMovimiento=-1)) or
		 ((@TipoCuentaSinMovimiento = 1) OR (@TipoCuentaSinMovimiento=-1)) or
		-- ((@TipoCuentaSinMovimiento = 2 and DebitoLocal + CreditoLocal=0) OR (@TipoCuentaSinMovimiento=-1)))
		 ((@TipoCuentaSinMovimiento = 2 AND ISNULL(saldoLocal,0) >0) OR (@TipoCuentaSinMovimiento=-1)))
	ORDER BY CAST(B.Nivel1 AS INT),CAST(B.Nivel2 AS INT),CAST(B.nivel3 AS INT),CAST(B.nivel4 AS INT), CAST(B.nivel5 AS INT)
END


SELECT *  FROM @tmpSaldo


GO


-- drop function  dbo.cntPuedoCerrarPeriodo
CREATE FUNCTION  dbo.cntPuedoCerrarPeriodo (@IDEjercicio int, @Periodo nvarchar(10))
-- indica si se puede cerrar un periodo, no se puede si hay uno de trabajo anterior
RETURNS bit
AS
BEGIN
declare @Puedo bit

if Exists ( 
	Select Periodo  
	From dbo.cntPeriodoContable
	where IDEjercicio = @IDEjercicio and Periodo < @Periodo and PeriodoTrabajo = 1 and Activo = 1
) 
	set @Puedo = 0
else 
	begin
		if Exists ( 
			Select Periodo  
			From dbo.cntPeriodoContable
			where IDEjercicio = @IDEjercicio and Periodo = @Periodo and Cerrado = 0 and PeriodoTrabajo = 1 and Activo = 1
		) 
			set @Puedo = 1
		else
			set @Puedo = 0	
		
	end
	
RETURN @Puedo
END	
go


CREATE Procedure [dbo].[cntInicializaCuentaSaldo] @IDEjercicio int, @Periodo nvarchar(10), @Error bit output
-- este proceso inicializa las cuentas en Saldos en el periodo pasado por parametro... 
-- las incerta con valores CERO, debe ser llamada al cerrar 
-- un periodo, al crear una cuenta o asignar centro de costo
as
Set Nocount On 

DECLARE @Fecha datetime 

Select @Fecha = FechaFinal 
From dbo.cntPeriodoContable 
Where IDEjercicio = @IDEjercicio and Periodo = @Periodo 
set @Error = 0


INSERT dbo.cntSaldo (IDEjercicio,Periodo,IDCuenta,IDCentro,Fecha,Saldo,Debito,Credito, SaldoAnterior) 
SELECT C.IDEjercicio,C.Periodo,C.IDCuenta,C.IDCentro,C.Fecha,C.Saldo,C.Debito,C.Credito, C.SaldoAnterior
FROM dbo.cntSaldo S (nolock)
 right join (
Select @IDEjercicio IDEjercicio, @Periodo Periodo, C.IDCuenta, isnull(T.IDCentro , 0) IDCentro,@Fecha Fecha, 
0 Saldo, 0 Debito, 0 Credito, 0 SaldoAnterior
From dbo.cntcuenta C (nolock) left join dbo.cntCuentaCentro T (nolock)
on C.IDCuenta = T.IDCuenta
) C 
on S.IDEjercicio = C.IDEjercicio and S.Periodo = C.Periodo and S.IDCuenta = C.IDCuenta AND S.IDCentro=C.IDCentro
where S.IDEjercicio is null and S.Periodo is null and S.IDcuenta is null and S.IDCentro is null


if @@ERROR <> 0
begin
RAISERROR ( 'Ha ocurrrido un errror al inicializar las Cuentas en Saldos ', 16, 1) ;
set @Error = 1
end

return 

GO


-- drop procedure dbo.cntCierraPeriodoContable
CREATE Procedure dbo.cntCierraPeriodoContable @IDEjercicio int, @Periodo nvarchar(10), @error BIT OUT
-- Este proceso cierra un periodo contable y considera actualizr los saldos iniciales y saldos 
as
set nocount on 

DECLARE @IDEjercicioNext int, @PeriodoNext nvarchar(10), @IDEjercicioOrig int, 
@PeriodoOrig nvarchar(10), @PeriodoLast nvarchar(10), @PeriodoPivot nvarchar(10), @OpenNext bit 

if  (select dbo.cntPuedoCerrarPeriodo(@IDEjercicio, @Periodo )) = 0
	begin
		RAISERROR ( 'No se puede Cerrar ese Periodo Fiscal porque hay antes otro periodo de Trabajo que no se ha cerrado o ya Fue Cerrado...', 16, 1) ;
		return
	end

set @IDEjercicioOrig = @IDEjercicio 
set @PeriodoOrig = @Periodo 

set @IDEjercicioNext = @IDEjercicio 
SET @Periodonext = @Periodo

Select @PeriodoLast =  max(Periodo) From dbo.cntPeriodoContable 
where IDEjercicio = @IDEjercicio and Cerrado = 0 and Activo = 1 and PeriodoTrabajo = 1
if @PeriodoLast = @Periodonext and SUBSTRING (@Periodonext,5,2)<>'13'  -- debo abrir el periodo
begin
	set @PeriodoPivot = @Periodonext
	exec dbo.cntGetPeriodoFromEjercicio @IDEjercicio Output , @PeriodoPivot Output , 'S'
	Update dbo.cntPeriodoContable set PeriodoTrabajo = 1, Cerrado = 0 where IDEjercicio = @IDEjercicio and Periodo = @PeriodoPivot
	set @PeriodoLast = @PeriodoPivot
end
	
BEGIN TRANSACTION 
BEGIN TRY
While (isnull((Select top 1 PeriodoTrabajo from dbo.cntPeriodoContable 
				where IDEjercicio = @IDEjercicioNext and Periodo = @PeriodoNext
				 and PeriodoTrabajo = 1 and Cerrado = 0 ),0) = 1) 
Begin 
	set @IDEjercicio = @IDEjercicioNext 
	set @Periodo = @PeriodoNext 
	exec dbo.cntGetPeriodoFromEjercicio @IDEjercicio Output , @Periodo Output , 'S'
	if @Periodo <= @PeriodoLast 
	begin 
		-- Get Saldo de las cuentas en el periodo Inicial
		Select IDEjercicio, Periodo, IDCuenta, IDCentro, Saldo Saldo, Debito, Credito 
		into #SaldoActual 
		From dbo.cntSaldo (nolock)
		Where IDEjercicio = @IDEjercicioNext and Periodo = @Periodonext
		-- obtengo el siguiente periodo
		exec dbo.cntGetPeriodoFromEjercicio @IDEjercicioNext Output , @Periodonext Output , 'S'
		-- inicializo las cuentas en saldos correspondiente al periodo siguiente
		exec dbo.cntInicializaCuentaSaldo @IDEjercicioNext, @Periodonext, @error output
		-- Saldos del proximo periodo
		Select IDEjercicio, Periodo, IDCuenta, IDCentro, Saldo Saldo, SaldoAnterior, Debito, Credito 
		into #SaldoActualNext 
		From dbo.cntSaldo (nolock)
		Where IDEjercicio = @IDEjercicioNext and Periodo = @Periodonext 
		-- Actualizo el Saldo Anterior y el Saldo Actual en el periodo siguiente
		Update S set SaldoAnterior = R.SaldoAnteriorUpd, Saldo = NuevoSaldo
		From dbo.cntSaldo S inner join
		(
		Select n.IDEjercicio, n.Periodo, A.IDCuenta, A.IDCentro, A.Saldo SaldoAnteriorUpd,
		case when C.NaturalezaSaldo = 'D' then N.Debito - N.Credito else N.Credito - N.Debito end Movimiento, 
		(A.Saldo  + case when C.NaturalezaSaldo = 'D' then N.Debito - N.Credito else N.Credito - N.Debito end) NuevoSaldo
		from #SaldoActual A inner join #SaldoActualNext N on A.IDCuenta = N.IDCuenta and A.IDCentro = N.IDCentro
		inner join dbo.vcntCatalogo C on A.IDCuenta = C.IDCuenta
		where N.SaldoAnterior <> A.Saldo
		) R on S.IDEjercicio = R.IDEjercicio and S.Periodo = R.Periodo and S.IDCuenta = R.IDCuenta and S.IDCentro = R.IDCentro 

		DROP TABLE #SaldoActual 
		DROP TABLE #SaldoActualNext
    end
    else
		set @PeriodoNext = @Periodo
End

Update P set Cerrado = 1, PeriodoTrabajo = 0
From dbo.cntPeriodoContable P
Where IDEjercicio = @IDEjercicioOrig  and Periodo = @PeriodoOrig  

END TRY
BEGIN CATCH
	IF @@TRANCOUNT > 0  
	begin
		ROLLBACK TRANSACTION
		IF OBJECT_ID('tempdb..#SaldoActual') IS NOT NULL
			DROP TABLE #SaldoActual	
		IF OBJECT_ID('tempdb..#SaldoActualNext') IS NOT NULL
			DROP TABLE #SaldoActualNext					
	end
END CATCH
	IF @@TRANCOUNT > 0  
		COMMIT TRANSACTION 

GO



CREATE PROCEDURE  cntGetPeriodoContableACerrar
AS 
SELECT TOP 1  IDEjercicio ,        Periodo ,        FechaFinal ,        Descr ,        FinPeriodoFiscal ,        
				Cerrado ,        AjustesCierreFiscal ,        Activo ,        PeriodoTrabajo  
FROM dbo.cntPeriodoContable WHERE Activo= 1 AND Cerrado=0 AND PeriodoTrabajo=1 ORDER BY FechaFinal asc


GO

CREATE FUNCTION [dbo].[parseJSON]( @JSON NVARCHAR(MAX))
RETURNS @hierarchy TABLE
  (
   element_id INT IDENTITY(1, 1) NOT NULL, /* internal surrogate primary key gives the order of parsing and the list order */
   sequenceNo [int] NULL, /* the place in the sequence for the element */
   parent_ID INT,/* if the element has a parent then it is in this column. The document is the ultimate parent, so you can get the structure from recursing from the document */
   Object_ID INT,/* each list or object has an object id. This ties all elements to a parent. Lists are treated as objects here */
   NAME NVARCHAR(2000),/* the name of the object */
   StringValue NVARCHAR(MAX) NOT NULL,/*the string representation of the value of the element. */
   ValueType VARCHAR(10) NOT null /* the declared type of the value represented as a string in StringValue*/
  )
AS
BEGIN
  DECLARE
    @FirstObject INT, --the index of the first open bracket found in the JSON string
    @OpenDelimiter INT,--the index of the next open bracket found in the JSON string
    @NextOpenDelimiter INT,--the index of subsequent open bracket found in the JSON string
    @NextCloseDelimiter INT,--the index of subsequent close bracket found in the JSON string
    @Type NVARCHAR(10),--whether it denotes an object or an array
    @NextCloseDelimiterChar CHAR(1),--either a '}' or a ']'
    @Contents NVARCHAR(MAX), --the unparsed contents of the bracketed expression
    @Start INT, --index of the start of the token that you are parsing
    @end INT,--index of the end of the token that you are parsing
    @param INT,--the parameter at the end of the next Object/Array token
    @EndOfName INT,--the index of the start of the parameter at end of Object/Array token
    @token NVARCHAR(200),--either a string or object
    @value NVARCHAR(MAX), -- the value as a string
    @SequenceNo int, -- the sequence number within a list
    @name NVARCHAR(200), --the name as a string
    @parent_ID INT,--the next parent ID to allocate
    @lenJSON INT,--the current length of the JSON String
    @characters NCHAR(36),--used to convert hex to decimal
    @result BIGINT,--the value of the hex symbol being parsed
    @index SMALLINT,--used for parsing the hex value
    @Escape INT --the index of the next escape character
   
 
  DECLARE @Strings TABLE /* in this temporary table we keep all strings, even the names of the elements, since they are 'escaped' in a different way, and may contain, unescaped, brackets denoting objects or lists. These are replaced in the JSON string by tokens representing the string */
    (
     String_ID INT IDENTITY(1, 1),
     StringValue NVARCHAR(MAX)
    )
  SELECT--initialise the characters to convert hex to ascii
    @characters='0123456789abcdefghijklmnopqrstuvwxyz',
    @SequenceNo=0, --set the sequence no. to something sensible.
  /* firstly we process all strings. This is done because [{} and ] aren't escaped in strings, which complicates an iterative parse. */
    @parent_ID=0;
  WHILE 1=1 --forever until there is nothing more to do
    BEGIN
      SELECT
        @start=PATINDEX('%[^a-zA-Z]["]%', @json collate SQL_Latin1_General_CP850_Bin);--next delimited string
      IF @start=0 BREAK --no more so drop through the WHILE loop
      IF SUBSTRING(@json, @start+1, 1)='"'
        BEGIN --Delimited Name
          SET @start=@Start+1;
          SET @end=PATINDEX('%[^\]["]%', RIGHT(@json, LEN(@json+'|')-@start) collate SQL_Latin1_General_CP850_Bin);
        END
      IF @end=0 --no end delimiter to last string
        BREAK --no more
      SELECT @token=SUBSTRING(@json, @start+1, @end-1)
      --now put in the escaped control characters
      SELECT @token=REPLACE(@token, FROMString, TOString)
      FROM
        (SELECT
          '\"' AS FromString, '"' AS ToString
         UNION ALL SELECT '\\', '\'
         UNION ALL SELECT '\/', '/'
         UNION ALL SELECT '\b', CHAR(08)
         UNION ALL SELECT '\f', CHAR(12)
         UNION ALL SELECT '\n', CHAR(10)
         UNION ALL SELECT '\r', CHAR(13)
         UNION ALL SELECT '\t', CHAR(09)
        ) substitutions
      SELECT @result=0, @escape=1
  --Begin to take out any hex escape codes
      WHILE @escape>0
        BEGIN
          SELECT @index=0,
          --find the next hex escape sequence
          @escape=PATINDEX('%\x[0-9a-f][0-9a-f][0-9a-f][0-9a-f]%', @token collate SQL_Latin1_General_CP850_Bin)
          IF @escape>0 --if there is one
            BEGIN
              WHILE @index<4 --there are always four digits to a \x sequence  
                BEGIN
                  SELECT --determine its value
                    @result=@result+POWER(16, @index)
                    *(CHARINDEX(SUBSTRING(@token, @escape+2+3-@index, 1),
                                @characters)-1), @index=@index+1 ;
        
                END
                -- and replace the hex sequence by its unicode value
              SELECT @token=STUFF(@token, @escape, 6, NCHAR(@result))
            END
        END
      --now store the string away
      INSERT INTO @Strings (StringValue) SELECT @token
      -- and replace the string with a token
      SELECT @JSON=STUFF(@json, @start, @end+1,
                    '@string'+CONVERT(NVARCHAR(5), @@identity))
    END
  -- all strings are now removed. Now we find the first leaf. 
  WHILE 1=1  --forever until there is nothing more to do
  BEGIN
 
  SELECT @parent_ID=@parent_ID+1
  --find the first object or list by looking for the open bracket
  SELECT @FirstObject=PATINDEX('%[{[[]%', @json collate SQL_Latin1_General_CP850_Bin)--object or array
  IF @FirstObject = 0 BREAK
  IF (SUBSTRING(@json, @FirstObject, 1)='{')
    SELECT @NextCloseDelimiterChar='}', @type='object'
  ELSE
    SELECT @NextCloseDelimiterChar=']', @type='array'
  SELECT @OpenDelimiter=@firstObject
 
  WHILE 1=1 --find the innermost object or list...
    BEGIN
      SELECT
        @lenJSON=LEN(@JSON+'|')-1
  --find the matching close-delimiter proceeding after the open-delimiter
      SELECT
        @NextCloseDelimiter=CHARINDEX(@NextCloseDelimiterChar, @json,
                                      @OpenDelimiter+1)
  --is there an intervening open-delimiter of either type
      SELECT @NextOpenDelimiter=PATINDEX('%[{[[]%',
             RIGHT(@json, @lenJSON-@OpenDelimiter)collate SQL_Latin1_General_CP850_Bin)--object
      IF @NextOpenDelimiter=0
        BREAK
      SELECT @NextOpenDelimiter=@NextOpenDelimiter+@OpenDelimiter
      IF @NextCloseDelimiter<@NextOpenDelimiter
        BREAK
      IF SUBSTRING(@json, @NextOpenDelimiter, 1)='{'
        SELECT @NextCloseDelimiterChar='}', @type='object'
      ELSE
        SELECT @NextCloseDelimiterChar=']', @type='array'
      SELECT @OpenDelimiter=@NextOpenDelimiter
    END
  ---and parse out the list or name/value pairs
  SELECT
    @contents=SUBSTRING(@json, @OpenDelimiter+1,
                        @NextCloseDelimiter-@OpenDelimiter-1)
  SELECT
    @JSON=STUFF(@json, @OpenDelimiter,
                @NextCloseDelimiter-@OpenDelimiter+1,
                '@'+@type+CONVERT(NVARCHAR(5), @parent_ID))
  WHILE (PATINDEX('%[A-Za-z0-9@+.e]%', @contents collate SQL_Latin1_General_CP850_Bin))<>0
    BEGIN
      IF @Type='Object' --it will be a 0-n list containing a string followed by a string, number,boolean, or null
        BEGIN
          SELECT
            @SequenceNo=0,@end=CHARINDEX(':', ' '+@contents)--if there is anything, it will be a string-based name.
          SELECT  @start=PATINDEX('%[^A-Za-z@][@]%', ' '+@contents collate SQL_Latin1_General_CP850_Bin)--AAAAAAAA
          SELECT @token=SUBSTRING(' '+@contents, @start+1, @End-@Start-1),
            @endofname=PATINDEX('%[0-9]%', @token collate SQL_Latin1_General_CP850_Bin),
            @param=RIGHT(@token, LEN(@token)-@endofname+1)
          SELECT
            @token=LEFT(@token, @endofname-1),
            @Contents=RIGHT(' '+@contents, LEN(' '+@contents+'|')-@end-1)
          SELECT  @name=stringvalue FROM @strings
            WHERE string_id=@param --fetch the name
        END
      ELSE
        SELECT @Name=null,@SequenceNo=@SequenceNo+1
      SELECT
        @end=CHARINDEX(',', @contents)-- a string-token, object-token, list-token, number,boolean, or null
      IF @end=0
        SELECT  @end=PATINDEX('%[A-Za-z0-9@+.e][^A-Za-z0-9@+.e]%', @Contents+' ' collate SQL_Latin1_General_CP850_Bin)
          +1
       SELECT
        @start=PATINDEX('%[^A-Za-z0-9@+.e][A-Za-z0-9@+.e]%', ' '+@contents collate SQL_Latin1_General_CP850_Bin)
      --select @start,@end, LEN(@contents+'|'), @contents 
      SELECT
        @Value=RTRIM(SUBSTRING(@contents, @start, @End-@Start)),
        @Contents=RIGHT(@contents+' ', LEN(@contents+'|')-@end)
      IF SUBSTRING(@value, 1, 7)='@object'
        INSERT INTO @hierarchy
          (NAME, SequenceNo, parent_ID, StringValue, Object_ID, ValueType)
          SELECT @name, @SequenceNo, @parent_ID, SUBSTRING(@value, 8, 5),
            SUBSTRING(@value, 8, 5), 'object'
      ELSE
        IF SUBSTRING(@value, 1, 6)='@array'
          INSERT INTO @hierarchy
            (NAME, SequenceNo, parent_ID, StringValue, Object_ID, ValueType)
            SELECT @name, @SequenceNo, @parent_ID, SUBSTRING(@value, 7, 5),
              SUBSTRING(@value, 7, 5), 'array'
        ELSE
          IF SUBSTRING(@value, 1, 7)='@string'
            INSERT INTO @hierarchy
              (NAME, SequenceNo, parent_ID, StringValue, ValueType)
              SELECT @name, @SequenceNo, @parent_ID, stringvalue, 'string'
              FROM @strings
              WHERE string_id=SUBSTRING(@value, 8, 5)
          ELSE
            IF @value IN ('true', 'false')
              INSERT INTO @hierarchy
                (NAME, SequenceNo, parent_ID, StringValue, ValueType)
                SELECT @name, @SequenceNo, @parent_ID, @value, 'boolean'
            ELSE
              IF @value='null'
                INSERT INTO @hierarchy
                  (NAME, SequenceNo, parent_ID, StringValue, ValueType)
                  SELECT @name, @SequenceNo, @parent_ID, @value, 'null'
              ELSE
                IF PATINDEX('%[^0-9]%', @value collate SQL_Latin1_General_CP850_Bin)>0
                  INSERT INTO @hierarchy
                    (NAME, SequenceNo, parent_ID, StringValue, ValueType)
                    SELECT @name, @SequenceNo, @parent_ID, @value, 'real'
                ELSE
                  INSERT INTO @hierarchy
                    (NAME, SequenceNo, parent_ID, StringValue, ValueType)
                    SELECT @name, @SequenceNo, @parent_ID, @value, 'int'
      if @Contents=' ' Select @SequenceNo=0
    END
  END
INSERT INTO @hierarchy (NAME, SequenceNo, parent_ID, StringValue, Object_ID, ValueType)
  SELECT '-',1, NULL, '', @parent_id-1, @type
--
   RETURN
END


GO


CREATE procedure dbo.[globalUpLoadTipoCambio] @TipoCambio as nvarchar(max)
as  
--set @TipoCambio='[{"Fecha":"2016-02-10","Valor":"28.0813","Ano":"2016","Mes":"2","Dia":"10"},{"Fecha":"2016-02-26","Valor":"28.1413","Ano":"2016","Mes":"2","Dia":"26"},{"Fecha":"2016-02-09","Valor":"28.0776","Ano":"2016","Mes":"2","Dia":"9"},{"Fecha":"2016-02-17","Valor":"28.1076","Ano":"2016","Mes":"2","Dia":"17"},{"Fecha":"2016-02-23","Valor":"28.13","Ano":"2016","Mes":"2","Dia":"23"},{"Fecha":"2016-02-18","Valor":"28.1113","Ano":"2016","Mes":"2","Dia":"18"},{"Fecha":"2016-02-27","Valor":"28.145","Ano":"2016","Mes":"2","Dia":"27"},{"Fecha":"2016-02-29","Valor":"28.1526","Ano":"2016","Mes":"2","Dia":"29"},{"Fecha":"2016-02-06","Valor":"28.0664","Ano":"2016","Mes":"2","Dia":"6"},{"Fecha":"2016-02-20","Valor":"28.1188","Ano":"2016","Mes":"2","Dia":"20"},{"Fecha":"2016-02-22","Valor":"28.1263","Ano":"2016","Mes":"2","Dia":"22"},{"Fecha":"2016-02-19","Valor":"28.115","Ano":"2016","Mes":"2","Dia":"19"},{"Fecha":"2016-02-21","Valor":"28.1225","Ano":"2016","Mes":"2","Dia":"21"},{"Fecha":"2016-02-04","Valor":"28.0589","Ano":"2016","Mes":"2","Dia":"4"},{"Fecha":"2016-02-12","Valor":"28.0888","Ano":"2016","Mes":"2","Dia":"12"},{"Fecha":"2016-02-25","Valor":"28.1375","Ano":"2016","Mes":"2","Dia":"25"},{"Fecha":"2016-02-08","Valor":"28.0739","Ano":"2016","Mes":"2","Dia":"8"},{"Fecha":"2016-02-03","Valor":"28.0551","Ano":"2016","Mes":"2","Dia":"3"},{"Fecha":"2016-02-11","Valor":"28.0851","Ano":"2016","Mes":"2","Dia":"11"},{"Fecha":"2016-02-13","Valor":"28.0926","Ano":"2016","Mes":"2","Dia":"13"},{"Fecha":"2016-02-14","Valor":"28.0963","Ano":"2016","Mes":"2","Dia":"14"},{"Fecha":"2016-02-01","Valor":"28.0477","Ano":"2016","Mes":"2","Dia":"1"},{"Fecha":"2016-02-16","Valor":"28.1038","Ano":"2016","Mes":"2","Dia":"16"},{"Fecha":"2016-02-24","Valor":"28.1338","Ano":"2016","Mes":"2","Dia":"24"},{"Fecha":"2016-02-05","Valor":"28.0626","Ano":"2016","Mes":"2","Dia":"5"},{"Fecha":"2016-02-15","Valor":"28.1001","Ano":"2016","Mes":"2","Dia":"15"},{"Fecha":"2016-02-28","Valor":"28.1488","Ano":"2016","Mes":"2","Dia":"28"},{"Fecha":"2016-02-07","Valor":"28.0701","Ano":"2016","Mes":"2","Dia":"7"},{"Fecha":"2016-02-02","Valor":"28.0514","Ano":"2016","Mes":"2","Dia":"2"}]'
DECLARE @retries INT
SET @retries = 4 

WHILE ( @retries > 0 ) 
    BEGIN
			begin try
						begin transaction 


						select * into #tmpTipoCambio from parseJSON( @TipoCambio ) 
						where ValueType in ( 'date','string','real','int') and NAME <>''

						

						Select parent_ID,
										max(case when name='Fecha' then convert(nvarchar,StringValue) else '' end) as Fecha,
										max(case when name='Valor' then convert(decimal(28,8),StringValue) else 0 end)  as Valor
							INTO #Result2
							from #tmpTipoCambio	
							group by parent_ID
							
					DECLARE  @FECHA AS DATE
					SET @FECHA = (SELECT TOP 1 Fecha FROM #Result2)			
					
					DELETE FROM dbo.GlobalTipoCambioDetalle WHERE  MONTH(FECHA)=MONTH(@FECHA) AND YEAR(FECHA)=YEAR(@FECHA)
					
					INSERT INTO dbo.GlobalTipoCambioDetalle(IDTipoCambio,Fecha,Monto)
					select  'TVEN',Fecha,Valor  from #Result2 ORDER BY Fecha ASC 
					
					
					drop table #tmpTipoCambio
					drop table #Result2
					
						SET @retries = 0 
						
					
						commit
						
			end try
		begin catch	
				-- Error is a deadlock
				IF ( ERROR_NUMBER() = 1205 ) 
					SET @retries = @retries - 1 
				ELSE 
					BEGIN
						DECLARE @ErrorMessage NVARCHAR(4000) ;
						DECLARE @ErrorSeverity INT ;
						DECLARE @ErrorState INT ;

						SELECT  @ErrorMessage = ERROR_MESSAGE() ,
								@ErrorSeverity = ERROR_SEVERITY() ,
								@ErrorState = ERROR_STATE() ;
	                   
						-- Re-Raise the Error that caused the problem
						RAISERROR (@ErrorMessage, -- Message text.
						   @ErrorSeverity, -- Severity.
						   @ErrorState -- State.
						   ) ;
						SET @retries = 0 ;
					END
				IF NOT (object_id('TempDb..#tmpTipoCambio','U') IS NOT NULL) 
					drop table #tmpTipoCambio
			    
				 IF NOT (object_id('TempDb..#Result','U') IS NOT NULL) 
					drop table #Result	

					
				IF XACT_STATE() <> 0 
                ROLLBACK TRANSACTION ; 
			               
			end catch
end

GO
 


CREATE PROCEDURE  [dbo].[globalGetNextConsecutivo] @TipoAsiento NVARCHAR(3),  @Asiento NVARCHAR(20)  OUTPUT
AS
BEGIN
	declare @LongAsiento INT , @Consecutivo int 
	select @LongAsiento = LongAsiento from dbo.cntParametros 

 	SELECT @Asiento = (tipo + RIGHT( replicate('0', @LongAsiento ) + cast (Consecutivo + 1 as nvarchar(20)), @LongAsiento ) ),
 				@Consecutivo = Consecutivo + 1     
	FROM dbo.cntTipoAsiento (UPDLOCK)                             
	WHERE TIPO =@TipoAsiento
				
	if exists (Select Asiento From dbo.cntAsiento (NOLOCK)  where Asiento = @Asiento )
	begin
		RAISERROR ( 'Ya Existe ese asiento contable, no se puede crear', 16, 1) ;		
	end	
	
	Update dbo.cntTipoAsiento set UltimoAsiento = @Asiento , Consecutivo = @Consecutivo 		 			
	where Tipo = @TipoAsiento
					
	--RETURN @Asiento
END

GO


CREATE PROCEDURE [dbo].[cntGetCuentas](@IDCuenta AS bigint, @IDGrupo AS int,@IDSubTipo int, 
		@Nivel1 nvarchar(50), @Nivel2 nvarchar(50),@Nivel3 nvarchar(50),@Nivel4 nvarchar(50),@Nivel5 nvarchar(50),@Nivel6 nvarchar(50),
		@Cuenta nvarchar(50),@Complementaria INT ,@EsMayor INT ,@AceptaDatos int,@Activa int,@IDCuentaMayor int,@UsaCentroCosto int	)
AS 
 SELECT A.IDCuenta,A.IDGrupo,G.Descr DescrGrupo,A.IDTipo,T.Descr DescrTipo,A.IDSubTipo,ST.Descr DescrSubTipo,A.Tipo,A.SubTipo,A.Nivel1,A.Nivel2,A.Nivel3,A.Nivel4,A.Nivel5,A.Nivel6,A.Cuenta,A.Descr,A.Complementaria, 
 A.EsMayor,A.AceptaDatos,A.Activa,A.IDCuentaAnterior,A.IDCuentaMayor,B.Descr DescrCuentaMayor, A.UsaCentroCosto  
FROM dbo.cntCuenta A 
 LEFT JOIN dbo.cntCuenta B ON A.IDCuentaMayor = B.IDCuenta  
INNER JOIN dbo.cntTipoCuenta T ON A.IDTipo=T.IDTipo  
INNER JOIN dbo.cntSubTipoCuenta ST ON A.IDSubTipo = ST.IDSubTipo AND A.IDTipo = ST.IDTipo  
INNER JOIN dbo.cntGrupoCuenta G ON A.IDTipo = G.IDTipo AND A.IDSubTipo = G.IDSubTipo AND A.IDGrupo = G.IDGrupo  
WHERE(A.IDCuenta = @IDCuenta OR @IDCuenta = -1) AND(A.IDGrupo = @IDGrupo OR  @IDGrupo = -1)  
AND(A.IDSubTipo = @IDSubTipo OR @IDSubTipo = -1) AND(A.Nivel1 = @Nivel1 OR @Nivel1 = '*')  
AND(A.Nivel2 = @Nivel2 OR @Nivel2 = '*')  AND(A.Nivel3 = @Nivel3 OR @Nivel3 = '*')  
AND(A.Nivel4 = @Nivel4 OR @Nivel4 = '*') AND(A.Nivel5 = @Nivel5 OR @Nivel5 = '*')   AND (A.Nivel6 = @Nivel6 OR @Nivel6 = '*')  
AND(A.Cuenta = @Cuenta OR @Cuenta = '*') AND(A.Complementaria = @Complementaria OR  @Complementaria = -1)  
AND(A.EsMayor = @EsMayor OR @EsMayor = -1) AND(A.AceptaDatos = @AceptaDatos  OR @AceptaDatos = -1)  
AND(A.Activa = @Activa OR @Activa = -1) AND(A.IDCuentaMayor = @IDCuentaMayor OR @IDCuentaMayor = -1)  
AND(A.UsaCentroCosto = @UsaCentroCosto OR @UsaCentroCosto = -1) 
order by CAST(A.Nivel1 AS INT),CAST(A.Nivel2 AS INT),CAST(A.Nivel3 AS INT),CAST(A.Nivel4 AS INT), CAST(A.Nivel5 AS INT),CAST(A.Nivel6 AS INT)  



GO

--Consultas de detalle de asientos
CREATE  PROCEDURE [dbo].[cntConsultaAsientosMayor]( @Asiento NVARCHAR(20), @TipoAsiento NVARCHAR(800), @ModuloFuente NVARCHAR(800), @FechaInicial AS DATE,@FechaFinal AS DATE,@Usuario NVARCHAR(20), @Mayorizado BIT = 1)
as

set @FechaInicial = CONVERT(VARCHAR(25),DATEADD(dd,-(DAY(@FechaInicial)-1),@FechaInicial),101) 
set @FechaFinal = CONVERT(VARCHAR(25),DATEADD(dd,-(DAY(DATEADD(mm,1,@FechaFinal))),DATEADD(mm,1,@FechaFinal)),101)

SELECT  IDEjercicio ,Periodo ,Asiento ,Tipo ,Fecha ,FechaHora ,Createdby ,CreateDate ,Mayorizadoby ,MayorizadoDate ,Anuladoby ,AnuladoDate ,
        Concepto  ,Anulado ,TipoCambio ,ModuloFuente 
FROM dbo.cntAsiento 
WHERE Fecha  BETWEEN @FechaInicial AND @FechaFinal
AND (Tipo IN (SELECT Value FROM [dbo].[ConvertListToTable](@TipoAsiento,'~'))) 
AND (ModuloFuente IN (SELECT Value FROM dbo.ConvertListToTable(@ModuloFuente, '~')))
AND Tipo IN (SELECT Tipo FROM dbo.TipoAsientoUsuario WHERE Usuario=@Usuario) AND Mayorizado=@Mayorizado

GO

--Consultas de detalle de asientos
CREATE   PROCEDURE [dbo].[cntConsultaDetalleAsientosMayor]( @Asiento NVARCHAR(20), @TipoAsiento NVARCHAR(800), @ModuloFuente NVARCHAR(800), @CentroCosto  AS NVARCHAR(4000),@CuentaContable NVARCHAR(4000), @FechaInicial AS DATE,@FechaFinal AS DATE,@Usuario NVARCHAR(20), @Mayorizado BIT =1)
as

set @FechaInicial = CONVERT(VARCHAR(25),DATEADD(dd,-(DAY(@FechaInicial)-1),@FechaInicial),101) 
set @FechaFinal = CONVERT(VARCHAR(25),DATEADD(dd,-(DAY(DATEADD(mm,1,@FechaFinal))),DATEADD(mm,1,@FechaFinal)),101)

SELECT  IDEjercicio ,Periodo ,A.Asiento ,A.Tipo ,Fecha ,FechaHora ,Createdby ,CreateDate ,Mayorizadoby ,MayorizadoDate ,Anuladoby ,AnuladoDate ,
        Concepto  ,Anulado ,TipoCambio ,ModuloFuente, C.Centro,C.Descr DescrCentro,CC.Cuenta,CC.Descr DescrCuenta,B.Debito,B.Credito,B.Referencia
FROM dbo.cntAsiento A
INNER JOIN dbo.cntAsientoDetalle B ON A.Asiento = B.Asiento
LEFT JOIN dbo.cntCentroCosto C ON B.IDCentro=C.IDCentro
LEFT  JOIN dbo.cntCuenta CC ON B.IDCuenta=CC.IDCuenta 
WHERE Fecha  BETWEEN @FechaInicial AND @FechaFinal
AND (A.Tipo IN (SELECT Value FROM [dbo].[ConvertListToTable](@TipoAsiento,'~'))) 
AND (ModuloFuente IN (SELECT Value FROM dbo.ConvertListToTable(@ModuloFuente, '~')))
AND (@CuentaContable ='*' OR  B.IDCuenta IN (SELECT CAST(Value AS BIGINT) Value FROM dbo.ConvertListToTable(@CuentaContable, ',')))
AND (@CentroCosto ='*' OR B.IDCentro IN (SELECT Cast(Value AS INT) Value FROM dbo.ConvertListToTable(@CentroCosto, ',')))
AND A.Tipo IN (SELECT Tipo FROM dbo.TipoAsientoUsuario WHERE Usuario=@Usuario) AND Mayorizado=@Mayorizado

GO


CREATE PROCEDURE dbo.cntCierreFiscal @IDEjercicio AS INT,@Usuario NVARCHAR(20)
AS 
DECLARE @IDCuentaUtilidadPeriodoIngresos AS BIGINT,@IDCuentaUtilidadPeriodoGastos AS BIGINT, @IDCuentaUtilidadPeriodoCostos AS BIGINT

SELECT TOP 1 @IDCuentaUtilidadPeriodoIngresos = IDCtaUtilidadPeriodoIngresos, 
			 @IDCuentaUtilidadPeriodoCostos= IDCtaUtilidadPeriodoCostos,
			 @IDCuentaUtilidadPeriodoGastos =  IDCtaUtilidadPeriodoGastos
FROM dbo.cntParametros


--ingresos
SELECT IDCuenta,Cuenta,Naturaleza INTO #tmpIngresos FROM dbo.cntCuenta a
INNER JOIN dbo.cntGrupoCuenta B  ON a.IDGrupo = B.IDGrupo
INNER JOIN dbo.cntSubTipoCuenta C ON B.IDTipo = C.IDTipo AND B.IDSubTipo = C.IDSubTipo
WHERE B.IDGrupo =4 AND AceptaDatos=1


--gastos
SELECT IDCuenta,Cuenta,Naturaleza INTO #tmpGastos FROM dbo.cntCuenta a
INNER JOIN dbo.cntGrupoCuenta B  ON a.IDGrupo = B.IDGrupo
INNER JOIN dbo.cntSubTipoCuenta C ON B.IDTipo = C.IDTipo AND B.IDSubTipo = C.IDSubTipo
WHERE B.IDGrupo =5 AND AceptaDatos=1


--costos
SELECT IDCuenta, Cuenta,Naturaleza INTO #tmpCostos  FROM dbo.cntCuenta a
INNER JOIN dbo.cntGrupoCuenta B  ON a.IDGrupo = B.IDGrupo
INNER JOIN dbo.cntSubTipoCuenta C ON B.IDTipo = C.IDTipo AND B.IDSubTipo = C.IDSubTipo
WHERE B.IDGrupo =6 AND AceptaDatos=1


DECLARE @Periodo AS NVARCHAR(20)

SELECT @Periodo = Periodo  FROM dbo.cntPeriodoContable
WHERE IDEjercicio=@IDEjercicio AND AjustesCierreFiscal=1


declare @LongAsiento INT , @Consecutivo int 
DECLARE @Tipo AS NVARCHAR(2)
DECLARE @TipoTC  AS NVARCHAR(20),@Asiento NVARCHAR(20)

select @LongAsiento = LongAsiento, @TipoTC =TipoCambio from dbo.cntParametros 

SET @Tipo ='CF'

SELECT @Asiento = (tipo + RIGHT( replicate('0', @LongAsiento ) + cast (Consecutivo + 1 as nvarchar(20)), @LongAsiento ) ),
 				@Consecutivo = Consecutivo + 1     
FROM dbo.cntTipoAsiento (UPDLOCK)                             
WHERE TIPO = @Tipo


if exists (Select Asiento From dbo.cntAsiento (NOLOCK)  where Asiento = @Asiento )
begin
	RAISERROR ( 'Ya Existe ese asiento contable, no se puede crear', 16, 1) ;		
end	

Update dbo.cntTipoAsiento set UltimoAsiento = @Asiento , Consecutivo = @Consecutivo 		 			
where Tipo = @Tipo 

DECLARE @TipoCambio AS DECIMAL(28,8), @Fecha AS DATE

SET @Fecha = GETDATE()

SELECT @TipoCambio = [dbo].globalGetTipoCambio (@Fecha,@TipoTC)


INSERT INTO dbo.cntAsiento( IDEjercicio ,Periodo ,Asiento ,Tipo ,Fecha ,FechaHora ,Createdby ,CreateDate ,Mayorizadoby ,MayorizadoDate ,Anuladoby ,AnuladoDate ,Concepto ,Mayorizado ,Anulado ,TipoCambio ,ModuloFuente ,CuadreTemporal)
VALUES (@IDEjercicio,@Periodo,@Asiento,@Tipo,@Fecha,GETDATE(),@Usuario,GETDATE(),NULL,NULL,NULL,NULL,'ASIENTO DE CIERRE FISCAL',0,0,@TipoTC,'CG',0)

--Insertar el detalle de asiento contable
INSERT INTO dbo.cntAsientoDetalle( Asiento ,Linea ,IDCentro ,IDCuenta ,Referencia ,Debito ,Credito ,Documento ,daterecord)
SELECT @Asiento,1,0,@IDCuentaUtilidadPeriodoIngresos,'Ingresos',A.Credito,A.Debito,'ND',GETDATE()
FROM dbo.cntSaldo A
INNER JOIN #tmpIngresos I ON A.IDCuenta = I.IDCuenta

INSERT INTO dbo.cntAsientoDetalle( Asiento ,Linea ,IDCentro ,IDCuenta ,Referencia ,Debito ,Credito ,Documento ,daterecord)
SELECT @Asiento,1,0,@IDCuentaUtilidadPeriodoIngresos,'Gastos',A.Credito,A.Debito,'ND',GETDATE()
FROM dbo.cntSaldo A
INNER JOIN #tmpGastos I ON A.IDCuenta = I.IDCuenta

INSERT INTO dbo.cntAsientoDetalle( Asiento ,Linea ,IDCentro ,IDCuenta ,Referencia ,Debito ,Credito ,Documento ,daterecord)
SELECT @Asiento,1,0,@IDCuentaUtilidadPeriodoIngresos,'Costos',A.Credito,A.Debito,'ND',GETDATE()
FROM dbo.cntSaldo A
INNER JOIN #tmpCostos I ON A.IDCuenta = I.IDCuenta

SELECT @Asiento,1,0,@IDCuentaUtilidadPeriodoIngresos,'Ingresos',A.Credito,A.Debito,'ND',GETDATE()
FROM dbo.cntSaldo A
INNER JOIN #tmpIngresos I ON A.IDCuenta = I.IDCuenta

UPDATE  dbo.cntPeriodoContable SET Cerrado=1 
WHERE IDEjercicio=@IDEjercicio AND Periodo=@Periodo
	
DROP TABLE #tmpIngresos
DROP TABLE #tmpGastos
DROP TABLE #tmpCostos


GO



CREATE PROCEDURE dbo.cntGetCuentaByCentroCosto @IdCentroCosto int ,@FechaInicial AS DATE,@FechaFinal AS DATE
AS 
--declare @IdCentroCosto int ,@FechaInicial AS DATE,@FechaFinal AS DATE
--SET @FechaInicial  = '20210101'
--SET @FechaFinal='20210131'
--SET @IdCentroCosto=-1


SELECT DISTINCT A.IDCuenta,Cuenta,Descr,Nivel1,Nivel2,Nivel3,Nivel4,Nivel5,Nivel6,B.EsMayor  FROM dbo.cntSaldo A
INNER JOIN dbo.cntCuenta B ON A.IDCuenta = B.IDCuenta
WHERE A.Fecha BETWEEN @FechaInicial AND @FechaFinal 
AND (A.IDCentro = @IdCentroCosto OR @IdCentroCosto = -1)
AND Credito + Debito <>0
ORDER BY Nivel1,Nivel2,Nivel3,Nivel4,Nivel5,Nivel6,B.EsMayor

GO


--Saldos por Cuenta Contable
CREATE PROCEDURE dbo.cntGetCentroByCuenta  @IDCuenta BIGINT ,@FechaInicial AS DATE,@FechaFinal AS DATE
AS 
--DECLARE  @IDCuenta BIGINT ,@FechaInicial AS DATE,@FechaFinal AS DATE
--SET @FechaInicial  = '20210101'
--SET @FechaFinal='20210131'
--SET @IdCuenta=-1


SELECT DISTINCT A.IDCentro INTO #tmpCentros FROM dbo.cntSaldo A
INNER JOIN dbo.cntCentroCosto B ON A.IDCentro = B.IDCentro
WHERE A.Fecha BETWEEN @FechaInicial AND @FechaFinal 
AND (A.IDCuenta = @IdCuenta OR @IdCuenta = -1)
AND Credito + Debito <>0

SELECT  IDCentro,Centro,Descr,Nivel1,Nivel2,Nivel3,Nivel4,Acumulador FROM dbo.cntCentroCosto  A
WHERE IDCentroAcumulador IN (SELECT IDCentro FROM #tmpCentros) AND IDCentro!= 0
UNION ALL 
SELECT  IDCentro,Centro,Descr,Nivel1,Nivel2,Nivel3,Nivel4,Acumulador FROM dbo.cntCentroCosto  A
WHERE IDCentro IN (SELECT IDCentro FROM #tmpCentros) 

DROP TABLE #tmpCentros


GO


CREATE  PROCEDURE dbo.cntGetSaldoCuentasHijas @IDCuenta BIGINT, @IDCentro INT, @FechaInicial AS DATE,@FechaFinal AS DATE, @TipoView INT 
AS 
----Obtener las cuentas hijas de mayor de una cuenta de mayor
--DECLARE  @IDCuenta BIGINT ,@FechaInicial AS DATE,@FechaFinal AS DATE
--SET @FechaInicial  = '20210101'
--SET @FechaFinal='20210131'
--SET @IdCuenta=1

set @FechaInicial = CONVERT(VARCHAR(25),DATEADD(dd,-(DAY(@FechaInicial)-1),@FechaInicial),101) 
set @FechaFinal = CONVERT(VARCHAR(25),DATEADD(dd,-(DAY(DATEADD(mm,1,@FechaFinal))),DATEADD(mm,1,@FechaFinal)),101)


DECLARE @TipoCambio AS DECIMAL(28,8)
DECLARE @TipoTC AS NVARCHAR(20)

SELECT @TipoTC = TipoCambio  FROM dbo.cntParametros 
SELECT @TipoCambio = [dbo].globalGetTipoCambio (@FechaFinal,@TipoTC)

IF (@TipoView = 1 )
BEGIN	
	SELECT B.IDCuenta,B.Cuenta,B.Descr,B.EsMayor,
			SUM(ISNULL(SaldoAnterior,0)) SaldoAnteriorLocal,SUM(ISNULL(SaldoAnterior / @TipoCambio,0)) SaldoAnteriorDolar,
			SUM(A.Debito) DebitoLocal, SUM(A.Debito/@TipoCambio) DebitoDolar,
			SUM(A.Credito) CreditoLocal,SUM(A.Credito/@TipoCambio) CreditoDolar,
			CASE WHEN  ST.Naturaleza='D' THEN SUM(ISNULL(SaldoAnterior,0) + Debito-Credito) ELSE SUM(ISNULL(SaldoAnterior,0)+ Credito-Debito) END SaldoLocal,
			CASE WHEN  ST.Naturaleza='D' THEN SUM((ISNULL(SaldoAnterior,0) + Debito-Credito)/@TipoCambio) ELSE SUM((ISNULL(SaldoAnterior,0)+ Credito-Debito)/@TipoCambio) END SaldoDolar
	FROM dbo.cntSaldo A INNER JOIN dbo.cntCuenta B ON A.IDCuenta = B.IDCuenta
	INNER JOIN dbo.cntSubTipoCuenta ST ON B.IDSubTipo = ST.IDSubTipo AND B.IDTipo = ST.IDTipo
	WHERE (B.IDCuenta = @IDCuenta) AND A.Fecha BETWEEN @FechaInicial AND @FechaFinal
	GROUP BY B.IDCuenta,B.Cuenta,B.Descr,B.EsMayor,ST.Naturaleza


	SELECT B.IDCuenta,B.Cuenta,B.Descr,B.EsMayor,
			SUM(ISNULL(SaldoAnterior,0)) SaldoAnteriorLocal,SUM(ISNULL(SaldoAnterior / @TipoCambio,0)) SaldoAnteriorDolar,
			SUM(A.Debito) DebitoLocal, SUM(A.Debito/@TipoCambio) DebitoDolar,
			SUM(A.Credito) CreditoLocal,SUM(A.Credito/@TipoCambio) CreditoDolar,
			CASE WHEN  ST.Naturaleza='D' THEN SUM(ISNULL(SaldoAnterior,0) + Debito-Credito) ELSE SUM(ISNULL(SaldoAnterior,0)+ Credito-Debito) END SaldoLocal,
			CASE WHEN  ST.Naturaleza='D' THEN SUM((ISNULL(SaldoAnterior,0) + Debito-Credito)/@TipoCambio) ELSE SUM((ISNULL(SaldoAnterior,0)+ Credito-Debito)/@TipoCambio) END SaldoDolar
	FROM dbo.cntSaldo A INNER JOIN dbo.cntCuenta B ON A.IDCuenta = B.IDCuenta
	INNER JOIN dbo.cntSubTipoCuenta ST ON B.IDSubTipo = ST.IDSubTipo AND B.IDTipo = ST.IDTipo
	WHERE (B.IDCuentaMayor = @IDCuenta OR @IDCuenta=-1) AND A.Fecha BETWEEN @FechaInicial AND @FechaFinal
	GROUP BY B.IDCuenta,B.Cuenta,B.Descr,B.EsMayor,ST.Naturaleza
END
ELSE 
BEGIN	
	--SELECT C.IDCentro,C.Centro,C.Descr,
	--		SUM(ISNULL(SaldoAnterior,0)) SaldoAnteriorLocal,SUM(ISNULL(SaldoAnterior / @TipoCambio,0)) SaldoAnteriorDolar,
	--		SUM(A.Debito) DebitoLocal, SUM(A.Debito/@TipoCambio) DebitoDolar,
	--		SUM(A.Credito) CreditoLocal,SUM(A.Credito/@TipoCambio) CreditoDolar,
	--		CASE WHEN  ST.Naturaleza='D' THEN SUM(ISNULL(SaldoAnterior,0) + Debito-Credito) ELSE SUM(ISNULL(SaldoAnterior,0)+ Credito-Debito) END SaldoLocal,
	--		CASE WHEN  ST.Naturaleza='D' THEN SUM((ISNULL(SaldoAnterior,0) + Debito-Credito)/@TipoCambio) ELSE SUM((ISNULL(SaldoAnterior,0)+ Credito-Debito)/@TipoCambio) END SaldoDolar
	--FROM dbo.cntSaldo A INNER JOIN dbo.cntCuenta B ON A.IDCuenta = B.IDCuenta
	--INNER JOIN dbo.cntSubTipoCuenta ST ON B.IDSubTipo = ST.IDSubTipo AND B.IDTipo = ST.IDTipo
	--INNER JOIN dbo.cntCentro C ON A.IDCentro = C.IDCentroAcumulador
	--WHERE (B.IDCuenta = @IDCuenta) AND (A.IDCentro=@IDCentro) AND A.Fecha BETWEEN @FechaInicial AND @FechaFinal
	--GROUP BY C.IDCentro,C.Centro,C.Descr,ST.Naturaleza


	--SELECT C.IDCentro,C.Centro,C.Descr,
	--		SUM(ISNULL(SaldoAnterior,0)) SaldoAnteriorLocal,SUM(ISNULL(SaldoAnterior / @TipoCambio,0)) SaldoAnteriorDolar,
	--		SUM(A.Debito) DebitoLocal, SUM(A.Debito/@TipoCambio) DebitoDolar,
	--		SUM(A.Credito) CreditoLocal,SUM(A.Credito/@TipoCambio) CreditoDolar,
	--		CASE WHEN  ST.Naturaleza='D' THEN SUM(ISNULL(SaldoAnterior,0) + Debito-Credito) ELSE SUM(ISNULL(SaldoAnterior,0)+ Credito-Debito) END SaldoLocal,
	--		CASE WHEN  ST.Naturaleza='D' THEN SUM((ISNULL(SaldoAnterior,0) + Debito-Credito)/@TipoCambio) ELSE SUM((ISNULL(SaldoAnterior,0)+ Credito-Debito)/@TipoCambio) END SaldoDolar
	--FROM dbo.cntSaldo A INNER JOIN dbo.cntCuenta B ON A.IDCuenta = B.IDCuenta
	--INNER JOIN dbo.cntSubTipoCuenta ST ON B.IDSubTipo = ST.IDSubTipo AND B.IDTipo = ST.IDTipo
	--INNER JOIN dbo.cntCentro C ON A.IDCentro = C.IDCentroAcumulador
	--WHERE (B.IDCuenta = @IDCuenta OR @IDCuenta=-1) AND A.Fecha BETWEEN @FechaInicial AND @FechaFinal
	--GROUP BY C.IDCentro,C.Centro,C.Descr,ST.Naturaleza
	
	
	SELECT C.IDCentro,C.Centro,C.Descr,C.Acumulador,
			SUM(ISNULL(SaldoAnterior,0)) SaldoAnteriorLocal,SUM(ISNULL(SaldoAnterior / @TipoCambio,0)) SaldoAnteriorDolar,
			SUM(A.Debito) DebitoLocal, SUM(A.Debito/@TipoCambio) DebitoDolar,
			SUM(A.Credito) CreditoLocal,SUM(A.Credito/@TipoCambio) CreditoDolar,
			CASE WHEN  ST.Naturaleza='D' THEN SUM(ISNULL(SaldoAnterior,0) + Debito-Credito) ELSE SUM(ISNULL(SaldoAnterior,0)+ Credito-Debito) END SaldoLocal,
			CASE WHEN  ST.Naturaleza='D' THEN SUM((ISNULL(SaldoAnterior,0) + Debito-Credito)/@TipoCambio) ELSE SUM((ISNULL(SaldoAnterior,0)+ Credito-Debito)/@TipoCambio) END SaldoDolar INTO #tmpSaldoCentros
	FROM dbo.cntSaldo A INNER JOIN dbo.cntCuenta B ON A.IDCuenta = B.IDCuenta
	INNER JOIN dbo.cntSubTipoCuenta ST ON B.IDSubTipo = ST.IDSubTipo AND B.IDTipo = ST.IDTipo
	INNER JOIN dbo.cntCentroCosto C ON A.IDCentro = C.IDCentro
	WHERE (B.IDCuenta = @IDCuenta) AND (C.IDCentroAcumulador=@IDCentro) AND A.Fecha BETWEEN @FechaInicial AND @FechaFinal
	GROUP BY C.IDCentro,C.Centro,C.Descr,C.Acumulador,ST.Naturaleza
	
	DECLARE @isCentroAcumulador BIT
	SELECT @isCentroAcumulador = Acumulador FROM dbo.cntCentroCosto WHERE idcentro = @IDCentro
	
	IF (@isCentroAcumulador=1)
	BEGIN
		SELECT D.IDCentro,D.Centro, D.Descr,D.Acumulador,SUM(SaldoAnteriorLocal) SaldoAnteriorLocal,SUM(SaldoAnteriorDolar) SaldoAnteriorDolar,SUM(DebitoLocal) DebitoLocal,SUM(DebitoDolar) DebitoDolar,SUM(CreditoLocal) CreditoLocal,SUM(CreditoDolar) CreditoDolar, SUM(SaldoLocal) SaldoLocal,SUM(SaldoDolar) SaldoDolar
		FROM #tmpSaldoCentros   A INNER JOIN dbo.cntCentroCosto b ON A.IDCentro = b.IDCentro
		INNER JOIN dbo.cntCentroCosto D ON B.IDCentroAcumulador=D.IDCentro
		GROUP BY D.IDCentro,D.Centro,D.Descr,D.Acumulador
		--WHERE B.IDCentro != 0
	END
	ELSE 
	BEGIN	
		SELECT C.IDCentro,C.Centro,C.Descr,C.Acumulador,
				SUM(ISNULL(SaldoAnterior,0)) SaldoAnteriorLocal,SUM(ISNULL(SaldoAnterior / @TipoCambio,0)) SaldoAnteriorDolar,
				SUM(A.Debito) DebitoLocal, SUM(A.Debito/@TipoCambio) DebitoDolar,
				SUM(A.Credito) CreditoLocal,SUM(A.Credito/@TipoCambio) CreditoDolar,
				CASE WHEN  ST.Naturaleza='D' THEN SUM(ISNULL(SaldoAnterior,0) + Debito-Credito) ELSE SUM(ISNULL(SaldoAnterior,0)+ Credito-Debito) END SaldoLocal,
				CASE WHEN  ST.Naturaleza='D' THEN SUM((ISNULL(SaldoAnterior,0) + Debito-Credito)/@TipoCambio) ELSE SUM((ISNULL(SaldoAnterior,0)+ Credito-Debito)/@TipoCambio) END SaldoDolar
		FROM dbo.cntSaldo A INNER JOIN dbo.cntCuenta B ON A.IDCuenta = B.IDCuenta
		INNER JOIN dbo.cntSubTipoCuenta ST ON B.IDSubTipo = ST.IDSubTipo AND B.IDTipo = ST.IDTipo
		INNER JOIN dbo.cntCentroCosto C ON A.IDCentro = C.IDCentro
		WHERE (B.IDCuenta = @IDCuenta) AND (C.IDCentro=@IDCentro) AND A.Fecha BETWEEN @FechaInicial AND @FechaFinal
		GROUP BY C.IDCentro,C.Centro,C.Descr,C.Acumulador,ST.Naturaleza
	END
	



	select B.IDCentro,B.Centro,B.Descr,B.Acumulador,A.SaldoAnteriorLocal, A.SaldoAnteriorDolar,A.DebitoLocal,A.DebitoDolar,A.CreditoLocal,A.CreditoDolar,A.SaldoLocal,A.SaldoDolar FROM #tmpSaldoCentros A INNER JOIN dbo.cntCentroCosto b ON A.IDCentro = b.IDCentroAcumulador
	WHERE B.IDCentro != 0
	UNION all
	select  IDCentro ,Centro ,Descr ,Acumulador,SaldoAnteriorLocal ,SaldoAnteriorDolar ,DebitoLocal ,DebitoDolar ,CreditoLocal ,
            CreditoDolar ,SaldoLocal ,SaldoDolar FROM #tmpSaldoCentros WHERE IDCentro!=0
	
	
	DROP TABLE #tmpSaldoCentros
END	

GO

CREATE PROCEDURE dbo.cntValidarPerioroTrece
AS 
DECLARE @Periodo NVARCHAR(10)
SET @Periodo = (SELECT MAX(Periodo)  FROM dbo.cntPeriodoContable WHERE Activo=1 AND PeriodoTrabajo =1 )

SELECT AjustesCierreFiscal  FROM dbo.cntPeriodoContable WHERE Periodo = @Periodo

GO




