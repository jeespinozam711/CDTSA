--Estructura de Privilegios

create TABLE [dbo].[secUSUARIO](
	[USUARIO] [nvarchar](20) NOT NULL,
	[DESCR] [nvarchar](200) NULL,
	[ACTIVO] [bit] NULL,
	[PASSWORD] [nvarchar](250) NULL
)
alter table [dbo].[secUSUARIO] add
 CONSTRAINT [PK_secUSUARIO] PRIMARY KEY CLUSTERED 
(
	[USUARIO] ASC
)
GO

CREATE TABLE [dbo].[secROLE](
	[IDROLE] [int] NOT NULL,
	[DESCR] [nvarchar](50) NULL,
	[DescrLarga] [nvarchar](200) NULL
)
GO
Alter table [dbo].[secROLE]
add CONSTRAINT [PK_secROLE] PRIMARY KEY CLUSTERED 
(
	[IDROLE] ASC
)
GO

CREATE TABLE [dbo].[secMODULO](
	[IDModulo] [int] NOT NULL,
	[Descr] [nvarchar](200) NULL
)
GO
Alter table [dbo].[secMODULO] add
 CONSTRAINT [PK_secModulo] PRIMARY KEY CLUSTERED 
(
	[IDModulo] ASC
)
GO
CREATE TABLE [dbo].[secUSUARIOROLE](
	[IDROLE] [int] NOT NULL,
	[USUARIO] [nvarchar](20) NOT NULL,
	[IDMODULO] [int] NOT NULL
)
GO
Alter table [dbo].[secUSUARIOROLE] add

 CONSTRAINT [PK_secUsuarioRole] PRIMARY KEY CLUSTERED 
(
	[IDROLE] ASC,
	[USUARIO] ASC,
	[IDMODULO] ASC
)
GO

CREATE TABLE [dbo].[secROLEACCION](
	[IDMODULO] [int] NOT NULL,
	[IDROLE] [int] NOT NULL,
	[IDACCION] [int] NOT NULL
)
GO
alter table [dbo].[secROLEACCION] add
 CONSTRAINT [PK_secRoleAccion] PRIMARY KEY CLUSTERED 
(
	[IDMODULO] ASC,
	[IDROLE] ASC,
	[IDACCION] ASC
)

GO
CREATE TABLE [dbo].[secACCION](
	[IDModulo] [int] NOT NULL,
	[IDAccion] [int] NOT NULL,
	[Descr] [nvarchar](200) NULL
)
GO
alter table [dbo].[secACCION] add
 CONSTRAINT [PK_secACCION] PRIMARY KEY CLUSTERED 
(
	[IDModulo] ASC,
	[IDAccion] ASC
)
GO


ALTER TABLE [dbo].[secUSUARIOROLE]  WITH CHECK ADD  CONSTRAINT [FK_secUsuarioRolex_secModulo] FOREIGN KEY([IDMODULO])
REFERENCES [dbo].[secMODULO] ([IDModulo])
GO

ALTER TABLE [dbo].[secUSUARIOROLE]  WITH CHECK ADD  CONSTRAINT [FK_secUSUARIOROLE_secUSUARIO] FOREIGN KEY([USUARIO])
REFERENCES [dbo].[secUSUARIO] ([USUARIO])
GO
ALTER TABLE [dbo].[secROLEACCION]  WITH CHECK ADD  CONSTRAINT [FK_secRoleAccion_secAccion] FOREIGN KEY([IDMODULO], [IDACCION])
REFERENCES [dbo].[secACCION] ([IDModulo], [IDAccion])
GO


ALTER TABLE [dbo].[secROLEACCION]  WITH CHECK ADD  CONSTRAINT [FK_secRoleAccion_secRole] FOREIGN KEY([IDROLE])
REFERENCES [dbo].[secROLE] ([IDROLE])
GO

ALTER TABLE [dbo].[secACCION]  WITH CHECK ADD  CONSTRAINT [FK_secAccion_secModulo] FOREIGN KEY([IDModulo])
REFERENCES [dbo].[secMODULO] ([IDModulo])
go 


alter table dbo.secACCION add AccionPRG nvarchar(50) null
go

Create index idxAccion on dbo.secAccion  (AccionPRG)
go

Create trigger trgInsUpsecAccion on dbo.secAccion
For Insert, Update
as
declare @AccionPRG nvarchar(20)
Select @AccionPRG = i.AccionPRG
from inserted i

if (Select COUNT(*) FROM dbo.secACCION WHERE AccionPRG IN (@AccionPRG)) >1 
BEGIN
declare @msg nvarchar(255)
set @msg = 'La constante de Accion PRG : ' + @AccionPRG + ' ya Existe... debe ser �nica'
   RAISERROR (@msg , 16, 1)
   ROLLBACK TRANSACTION
END
go

Create Procedure dbo.secGetPrivilegioUsuario @Usuario as nvarchar(20), @AccionPRG as nvarchar(50)
as
if @AccionPRG is null
	set @AccionPRG = '*'

Select UR.IDMODULO, M.DESCR DescrModulo,  UR.IDROLE, R.DESCR DESCROLE,  UR.USUARIO, RA.IDACCION, A.Descr DescrAccion, A.AccionPRG
From dbo.secUSUARIOROLE UR INNER JOIN dbo.secROLEACCION RA
ON UR.IDMODULO = RA.IDMODULO AND UR.IDROLE = RA.IDROLE 
INNER JOIN DBO.secACCION A ON RA.IDACCION = A.IDAccion 
INNER JOIN DBO.secROLE R ON UR.IDROLE = R.IDROLE AND RA.IDROLE = R.IDROLE 
INNER JOIN DBO.secMODULO M ON UR.IDMODULO = M.IDModulo AND RA.IDMODULO = M.IDModulo AND RA.IDMODULO = M.IDModulo 
Where UR.USUARIO = @Usuario AND (A.ACCIONPRG = @AccionPRG or @AccionPRG = '*')
go

Create Function dbo.secUsuarioTieneAcceso (@Usuario as nvarchar(20), @AccionPRG as nvarchar(50))
returns bit
begin
declare @Acceso bit 
set @Acceso = 0 
if exists (Select UR.IDMODULO, M.DESCR DescrModulo,  UR.IDROLE, R.DESCR DESCROLE,  UR.USUARIO, RA.IDACCION, A.Descr DescrAccion, A.AccionPRG
			From dbo.secUSUARIOROLE UR INNER JOIN dbo.secROLEACCION RA
			ON UR.IDMODULO = RA.IDMODULO AND UR.IDROLE = RA.IDROLE 
			INNER JOIN DBO.secACCION A ON RA.IDACCION = A.IDAccion 
			INNER JOIN DBO.secROLE R ON UR.IDROLE = R.IDROLE AND RA.IDROLE = R.IDROLE 
			INNER JOIN DBO.secMODULO M ON UR.IDMODULO = M.IDModulo AND RA.IDMODULO = M.IDModulo AND RA.IDMODULO = M.IDModulo 
			Where UR.USUARIO = @Usuario AND A.ACCIONPRG = @AccionPRG 
		)
	set @Acceso = 1
else
	set @Acceso = 0
return @Acceso
end
go



create view [dbo].[vsecModuloRoleAccion]
as
SELECT     dbo.secROLEACCION.IDMODULO, dbo.secROLEACCION.IDROLE, dbo.secROLE.DESCR, dbo.secROLEACCION.IDACCION, 
                      dbo.secACCION.Descr AS DESCRACCION
FROM         dbo.secROLEACCION INNER JOIN
                      dbo.secROLE ON dbo.secROLEACCION.IDROLE = dbo.secROLE.IDROLE INNER JOIN
                      dbo.secACCION ON dbo.secROLEACCION.IDMODULO = dbo.secACCION.IDModulo AND dbo.secROLEACCION.IDACCION = dbo.secACCION.IDAccion
GO

CREATE VIEW [dbo].[vsecPrivilegios]
as
SELECT su.Usuario, m.IDModulo, m.Descr DescrModulo, ra.IDROLE,r.Descr DescrRole, a.IDAccion, a.Descr DescrAccion 
FROM dbo.secModulo m INNER JOIN dbo.secACCION a
ON m.IDModulo = a.IDModulo INNER JOIN dbo.secROLEACCION ra 
ON a.IDModulo = ra.IDMODULO AND a.IDAccion = ra.IDACCION INNER JOIN dbo.secRole r 
ON ra.IDROLE = r.idrole INNER JOIN dbo.secUSUARIOROLE su
ON r.idrole = su.idrole

GO

CREATE PROCEDURE dbo.secGetAccionFromModuloRole @IDModulo INT, @IDRole INT
as
set nocount on
SELECT RA.IDMODULO, RA.IDROLE, R.DESCR DESCRROLE, RA.IDACCION, A.DESCR DESCRACCION
FROM dbo.secRoleAccion RA INNER JOIN dbo.secRole R on
RA.IDRole = R.IDRole inner join dbo.secACCION A
ON RA.IDACCION = A.IDACCION
where RA.IDModulo = @IDModulo and RA.IDRole = @IDRole
GO

--************** PARA OTRO ROLE select * from dbo.secroleaccion where idrole = 2
--exec dbo.secGetRoleFromModuloUsuario 1000, 'azepeda'  drop procedure dbo.secGetRoleFromModuloUsuario
Create procedure dbo.secGetRoleFromModuloUsuario @IDModulo int, @Usuario nvarchar(50)
as 
Select distinct RA.IDRole, R.Descr, U.IDModulo, U.Usuario
From dbo.secRoleAccion RA inner join dbo.secRole R
on R.IDRole = RA.IDRole inner join dbo.secUsuarioRole U
on RA.IDRole = U.IDRole and R.IDRole = U.IDRole
where U.IDModulo = @IDModulo and  U.Usuario = @Usuario
GO


Create procedure dbo.secGetAccionesFromModuloUsuario @IDModulo int, @Usuario nvarchar(50)
as 
Select distinct RA.IDRole, A.IDAccion,A.Descr DescrAccion, R.Descr DescrRole, U.IDModulo, U.Usuario
From dbo.secRoleAccion RA inner join dbo.secRole R  on R.IDRole = RA.IDRole 
inner join dbo.secUsuarioRole U on RA.IDRole = U.IDRole and R.IDRole = U.IDRole
INNER JOIN dbo.secAccion A ON RA.IDACCION=A.IDAccion AND RA.IDMODULO=A.IDModulo
where U.IDModulo = @IDModulo and  U.Usuario = @Usuario

GO

--INGRESO DE DATOS

insert [dbo].[secUSUARIO](
	[USUARIO] ,
	[DESCR] ,
	[ACTIVO] ,
	[PASSWORD] )
values ('admin', 'Administrador', 1, '123')

GO

insert [dbo].[secROLE] ([IDROLE] ,
	[DESCR] ,
	[DescrLarga])
values (1, 'Administrador', 'Administrador')
GO


insert [dbo].[secMODULO](
	[IDModulo],
	[Descr] )
VALUES (0, 'General')
GO

insert [dbo].[secMODULO](
	[IDModulo],
	[Descr] )
VALUES (100, 'M�dulo Contable')

GO

insert [dbo].[secMODULO](
	[IDModulo],
	[Descr] )
VALUES (200, 'M�dulo Control Bancario')

GO

insert [dbo].[secMODULO](
	[IDModulo],
	[Descr] )
VALUES (300, 'M�dulo Inventario')

GO

insert [dbo].[secMODULO](
	[IDModulo],
	[Descr] )
VALUES (400, 'M�dulo Compras')

GO

insert [dbo].[secMODULO](
	[IDModulo],
	[Descr] )
VALUES (500, 'M�dulo Facturacion')

GO

insert [dbo].[secMODULO](
	[IDModulo],
	[Descr] )
VALUES (600, 'M�dulo Cuentas por Cobrar')

GO

insert [dbo].[secMODULO](
	[IDModulo],
	[Descr] )
VALUES (700, 'M�dulo Cuentas por Pagar')

GO





INSERT   [dbo].[secACCION](   [IDMODULO] ,   [IDACCION] ,   [DESCR]   )  values ( 0,1,'Acceso al Sistema')   
insert [dbo].[secACCION](   [IDMODULO] ,   [IDACCION] ,   [DESCR]   )  values ( 0,2,'Modificacion de Reportes')   
insert [dbo].[secACCION](   [IDMODULO] ,   [IDACCION] ,   [DESCR]   )  values ( 0,3,'Administracion del Sistema')   
insert [dbo].[secACCION](   [IDMODULO] ,   [IDACCION] ,   [DESCR]   )  values ( 0,4,'Parametros Generales')   
insert [dbo].[secACCION](   [IDMODULO] ,   [IDACCION] ,   [DESCR]   )  values ( 0,100,'Modulo Contable')  
insert [dbo].[secACCION](   [IDMODULO] ,   [IDACCION] ,   [DESCR]   )  values ( 100,101,'Catalogo Cuenta Contable') 
insert [dbo].[secACCION](   [IDMODULO] ,   [IDACCION] ,   [DESCR]   )  values ( 100,102,'Agregar Cuenta Contable')  
insert [dbo].[secACCION](   [IDMODULO] ,   [IDACCION] ,   [DESCR]   )  values ( 100,103,'Editar Cuenta Contable') 
insert [dbo].[secACCION](   [IDMODULO] ,   [IDACCION] ,   [DESCR]   )  values ( 100,104,'Eliminar Cuenta Contable')   
insert [dbo].[secACCION](   [IDMODULO] ,   [IDACCION] ,   [DESCR]   )  values ( 100,105,'Catalogo Centro Costo')  
insert [dbo].[secACCION](   [IDMODULO] ,   [IDACCION] ,   [DESCR]   )  values ( 100,106,'Agregar Centro Costo') 
insert [dbo].[secACCION](   [IDMODULO] ,   [IDACCION] ,   [DESCR]   )  values ( 100,107,'Editar Centro Costo')   
insert [dbo].[secACCION](   [IDMODULO] ,   [IDACCION] ,   [DESCR]   )  values ( 100,108,'Eliminar Centro Costo')  
insert [dbo].[secACCION](   [IDMODULO] ,   [IDACCION] ,   [DESCR]   )  values ( 100,109,'Asiento de Diario')   
insert [dbo].[secACCION](   [IDMODULO] ,   [IDACCION] ,   [DESCR]   )  values ( 100,110,'Agregar Asiento de Diario')   
insert [dbo].[secACCION](   [IDMODULO] ,   [IDACCION] ,   [DESCR]   )  values ( 100,111,'Editar Asiento de Diaro')  
insert [dbo].[secACCION](   [IDMODULO] ,   [IDACCION] ,   [DESCR]   )  values ( 100,112,'Eliminar Asiento de Diario')  
insert [dbo].[secACCION](   [IDMODULO] ,   [IDACCION] ,   [DESCR]   )  values ( 100,113,'Mayorizar Asiento de Diario')  
insert [dbo].[secACCION](   [IDMODULO] ,   [IDACCION] ,   [DESCR]   )  values ( 100,114,'Registrar Tipo de Cambio')    
insert [dbo].[secACCION](   [IDMODULO] ,   [IDACCION] ,   [DESCR]   )  values ( 100,115,'AnularAsientoMayorizado')   
insert [dbo].[secACCION](   [IDMODULO] ,   [IDACCION] ,   [DESCR]   )  values ( 100,116,'Parametros Modulo Contable') 
insert [dbo].[secACCION](   [IDMODULO] ,   [IDACCION] ,   [DESCR]   )  values ( 100,117,'Periodos Contables')  
insert [dbo].[secACCION](   [IDMODULO] ,   [IDACCION] ,   [DESCR]   )  values ( 100,118,'Cerrar Periodo Contable')  
insert [dbo].[secACCION](   [IDMODULO] ,   [IDACCION] ,   [DESCR]   )  values ( 100,119,'Establecer Periodo de Trabajo')  
insert [dbo].[secACCION](   [IDMODULO] ,   [IDACCION] ,   [DESCR]   )  values ( 100,120,'CrearEjericiosContables') 
insert [dbo].[secACCION](   [IDMODULO] ,   [IDACCION] ,   [DESCR]   )  values ( 100,121,'GrupoEstadosFinancieros')  
insert [dbo].[secACCION](   [IDMODULO] ,   [IDACCION] ,   [DESCR]   )  values ( 100,122,'Agregar GrupoEstadosFinancieros')  
insert [dbo].[secACCION](   [IDMODULO] ,   [IDACCION] ,   [DESCR]   )  values ( 100,123,'Editar GrupoEstadosFinancieros')    
insert [dbo].[secACCION](   [IDMODULO] ,   [IDACCION] ,   [DESCR]   )  values ( 100,124,'Eliminar GrupoEstadosFinancieros')  
insert [dbo].[secACCION](   [IDMODULO] ,   [IDACCION] ,   [DESCR]   )  values ( 100,125,'Relacion CuentaGrupoEstadosFinancieros')  

GO

insert [dbo].[secROLEACCION](   [IDMODULO] ,   [IDROLE] ,   [IDACCION] )  values ( 0,1,1)  
insert [dbo].[secROLEACCION](   [IDMODULO] ,   [IDROLE] ,   [IDACCION] )  values ( 0,1,2)  
insert [dbo].[secROLEACCION](   [IDMODULO] ,   [IDROLE] ,   [IDACCION] )  values ( 0,1,3)  
insert [dbo].[secROLEACCION](   [IDMODULO] ,   [IDROLE] ,   [IDACCION] )  values ( 0,1,4)  
insert [dbo].[secROLEACCION](   [IDMODULO] ,   [IDROLE] ,   [IDACCION] )  values ( 0,1,100)  
insert [dbo].[secROLEACCION](   [IDMODULO] ,   [IDROLE] ,   [IDACCION] )  values ( 100,1,101)  
insert [dbo].[secROLEACCION](   [IDMODULO] ,   [IDROLE] ,   [IDACCION] )  values ( 100,1,102)  
insert [dbo].[secROLEACCION](   [IDMODULO] ,   [IDROLE] ,   [IDACCION] )  values ( 100,1,103)  
insert [dbo].[secROLEACCION](   [IDMODULO] ,   [IDROLE] ,   [IDACCION] )  values ( 100,1,104)  
insert [dbo].[secROLEACCION](   [IDMODULO] ,   [IDROLE] ,   [IDACCION] )  values ( 100,1,105)  
insert [dbo].[secROLEACCION](   [IDMODULO] ,   [IDROLE] ,   [IDACCION] )  values ( 100,1,106)  
insert [dbo].[secROLEACCION](   [IDMODULO] ,   [IDROLE] ,   [IDACCION] )  values ( 100,1,107)  
insert [dbo].[secROLEACCION](   [IDMODULO] ,   [IDROLE] ,   [IDACCION] )  values ( 100,1,108)  
insert [dbo].[secROLEACCION](   [IDMODULO] ,   [IDROLE] ,   [IDACCION] )  values ( 100,1,109)  
insert [dbo].[secROLEACCION](   [IDMODULO] ,   [IDROLE] ,   [IDACCION] )  values ( 100,1,110)  
insert [dbo].[secROLEACCION](   [IDMODULO] ,   [IDROLE] ,   [IDACCION] )  values ( 100,1,111)  
insert [dbo].[secROLEACCION](   [IDMODULO] ,   [IDROLE] ,   [IDACCION] )  values ( 100,1,112)  
insert [dbo].[secROLEACCION](   [IDMODULO] ,   [IDROLE] ,   [IDACCION] )  values ( 100,1,113)  
insert [dbo].[secROLEACCION](   [IDMODULO] ,   [IDROLE] ,   [IDACCION] )  values ( 100,1,114)  
insert [dbo].[secROLEACCION](   [IDMODULO] ,   [IDROLE] ,   [IDACCION] )  values ( 100,1,115)  
insert [dbo].[secROLEACCION](   [IDMODULO] ,   [IDROLE] ,   [IDACCION] )  values ( 100,1,116)  
insert [dbo].[secROLEACCION](   [IDMODULO] ,   [IDROLE] ,   [IDACCION] )  values ( 100,1,117)  
insert [dbo].[secROLEACCION](   [IDMODULO] ,   [IDROLE] ,   [IDACCION] )  values ( 100,1,118)  
insert [dbo].[secROLEACCION](   [IDMODULO] ,   [IDROLE] ,   [IDACCION] )  values ( 100,1,119)  
insert [dbo].[secROLEACCION](   [IDMODULO] ,   [IDROLE] ,   [IDACCION] )  values ( 100,1,120)  
insert [dbo].[secROLEACCION](   [IDMODULO] ,   [IDROLE] ,   [IDACCION] )  values ( 100,1,121)  
insert [dbo].[secROLEACCION](   [IDMODULO] ,   [IDROLE] ,   [IDACCION] )  values ( 100,1,122)  
insert [dbo].[secROLEACCION](   [IDMODULO] ,   [IDROLE] ,   [IDACCION] )  values ( 100,1,123)  
insert [dbo].[secROLEACCION](   [IDMODULO] ,   [IDROLE] ,   [IDACCION] )  values ( 100,1,124)  
insert [dbo].[secROLEACCION](   [IDMODULO] ,   [IDROLE] ,   [IDACCION] )  values ( 100,1,125)  


GO

insert [dbo].[secUSUARIOROLE](
	[IDROLE] ,
	[USUARIO] ,
	[IDMODULO])
values (1, 'admin', 0)
GO


insert [dbo].[secUSUARIOROLE](
	[IDROLE] ,
	[USUARIO] ,
	[IDMODULO])
values (1, 'admin', 100)


GO

CREATE PROCEDURE dbo.secGetArbolAcciones
AS 
 SELECT  A.IDModulo ,
		B.Descr DescrModulo,
        A.IDAccion ,
        A.Descr  FROM dbo.secACCION A
INNER JOIN dbo.secMODULO B ON A.IDModulo = B.IDModulo

GO


CREATE PROCEDURE dbo.secUpdateRole(@Accion nvarchar(1), @IDRole int OUTPUT, @Descr nvarchar(50), @DescrLarga  nvarchar(250))
AS 
IF (@Accion ='I')
BEGIN
	SET @IDRole = (select ISNULL(MAX(IDROLE),0)  FROM dbo.secROLE) +1
	INSERT INTO dbo.secROLE
	        ( IDROLE, DESCR, DescrLarga )
	VALUES  (@IDRole,@Descr,@DescrLarga)
END
IF (@Accion='U')
BEGIN
	UPDATE dbo.secROLE SET DESCR=@Descr, DescrLarga = @DescrLarga WHERE IDROLE=@IDRole
END
IF (@Accion='D')
BEGIN
	DELETE dbo.secUSUARIOROLE WHERE IDROLE=@IDRole
	DELETE dbo.secROLEACCION WHERE IDROLE=@IDRole
	DELETE dbo.secROLE WHERE IDROLE=@IDRole
END

GO


CREATE PROCEDURE dbo.secUpdateRoleAccion (@Accion NVARCHAR(1), @IDModulo INT, @IDRole INT, @IDAccion INT )
AS 
IF (@Accion='I')
BEGIN	
	INSERT INTO dbo.secROLEACCION
        ( IDMODULO, IDROLE, IDACCION )
	VALUES  ( @IDModulo,@IDRole, @IDAccion)
END	
IF (@Accion='D')
BEGIN	
	DELETE dbo.secROLEACCION WHERE IDRole = @IDRole AND (IDAccion = @IDAccion OR @IDAccion=-1)
END	

GO


CREATE PROCEDURE dbo.secGetAccionByRole (@IDRole INT )
AS 
SELECT  IDMODULO ,IDROLE ,IDACCION  FROM dbo.secROLEACCION WHERE IDROLE=@IDRole

GO


CREATE PROCEDURE dbo.secGetRole(@IDRole INT)
AS 
SELECT  IDROLE ,
        DESCR ,
        DescrLarga  
FROM dbo.secROLE WHERE (IDROLE = @IDRole OR  @IDRole = -1)

GO



CREATE  PROCEDURE dbo.secGetUsuarioRole(@IDRole int )
AS 
SELECT DISTINCT  A.USUARIO, B.DESCR FROM dbo.secUSUARIOROLE A
INNER JOIN dbo.secUSUARIO B ON	A.USUARIO = B.USUARIO
WHERE (IDROLE = @IDRole OR @IDRole=-1) AND ACTIVO=1


GO

CREATE PROCEDURE dbo.secInsertUpdateUsuarioRole(@Accion NVARCHAR(1),@IDRole AS INT, @Usuario NVARCHAR(50), @IDModulo INT)
AS 
IF @Accion = 'I'
BEGIN
	INSERT INTO dbo.secUSUARIOROLE( IDROLE, USUARIO, IDMODULO )
	VALUES  ( @IDRole ,@Usuario,@IDModulo)
END	
IF @Accion = 'D'
BEGIN
	DELETE dbo.secUSUARIOROLE WHERE IDMODULO=@IDModulo AND IDROLE=@IDRole AND USUARIO=@Usuario AND IDMODULO=@IDModulo
END


GO

CREATE PROCEDURE dbo.secGetUsuariosNotInRole(@IDRole INT)
AS 
SELECT USUARIO,DESCR  FROM dbo.secUSUARIO
WHERE USUARIO NOT IN (
SELECT USUARIO  FROM dbo.secUSUARIOROLE WHERE IDROLE=@IDRole)

AS

CREATE PROCEDURE dbo.secGetUsuario(@Usuario nvarchar(50))
AS 
SELECT  USUARIO ,
        DESCR ,
        ACTIVO ,
       [PASSWORD]  FROM dbo.secUSUARIO WHERE (USUARIO=@Usuario OR @Usuario = '*')
       
AS 

CREATE PROCEDURE dbo.secInsertUpdateSecUsuario(@Accion nvarchar(1), @Usuario nvarchar(50), @Descr nvarchar(250),@Activo bit, @PassWord nvarchar(50))
AS 
IF (@Accion = 'I')
BEGIN
	INSERT INTO dbo.secUSUARIO( USUARIO, DESCR, ACTIVO, PASSWORD )
	VALUES  ( @Usuario,@Descr,@Activo,@Password)
END
IF (@Accion ='U')
BEGIN
	UPDATE dbo.secUSUARIO SET  DESCR=@Descr, ACTIVO=@Activo,PASSWORD=@Password WHERE USUARIO=@Usuario
END
IF (@Accion ='D')
BEGIN
	IF (@Usuario = 'admin')
	BEGIN
		RAISERROR ( 'El usuario administrador no puede ser eliminado.', 16, 1) ;
		return		
	END
	DELETE dbo.secUSUARIO WHERE USUARIO=@Usuario
END

GO


