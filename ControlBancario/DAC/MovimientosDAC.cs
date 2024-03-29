﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using System.Data.SqlClient;
using Security;

namespace ControlBancario.DAC
{
    public static class MovimientosDAC
    {
        public static SqlDataAdapter oAdaptador = InicializarAdaptador();

        private static SqlDataAdapter InicializarAdaptador()
        {
            String getSQL = "SELECT  M.IDCuentaBanco ,M.Fecha ,M.IDTipo ,M.IDSubTipo ,R.IDRuc,R.Nombre,R.Alias,M.Numero ,M.Pagadero_a ,M.Monto ,M.Asiento ,M.Anulado ,M.AsientoAnulacion ,M.Usuario ,M.UsuarioAnulacion ,M.FechaAnulacion, M.UsuarioAprobacion,M.FechaAprobacion,M.UsuarioImpresion,M.FechaImpresion,M.Impreso  ,M.ConceptoContable,M.IDMovimiento  " +
                            "FROM dbo.cbMovimientos M " +
                            "INNER JOIN dbo.cbCuentaBancaria CB ON M.IDCuentaBanco = CB.IDCuentaBanco " +
                            "INNER JOIN dbo.cbTipoCuenta T ON CB.IDTipo = T.IDTipo " +
                            "INNER JOIN dbo.cbRuc R ON M.IDRuc = R.IDRuc " +
                            "INNER JOIN dbo.cbSubTipoDocumento ST ON M.IDTipo=ST.IDTipo AND M.IDSubTipo=ST.IDSubtipo " +
                            "WHERE (M.IDCuentaBanco=@IDCuentaBanco OR @IDCuentaBanco=-1)  AND (M.IDTipo=@IDTipo OR @IDTipo=-1) " +
                            "AND (M.IDSubTipo=@IDSubTipo OR @IDSubTipo=-1) AND (Numero = @Numero OR @Numero='*') AND (M.IDRuc=@IDRuc OR @IDRuc=-1)";
            String InsertSQL = "[dbo].[cbUpdateMovimientos]";
            String UpdateSQL = "[dbo].[cbUpdateMovimientos]";
            String DeleteSQL = "[dbo].[cbUpdateMovimientos]";

            try
            {
                SqlDataAdapter oAdaptador = new SqlDataAdapter()
                {
                    SelectCommand = new SqlCommand(getSQL, ConnectionManager.GetConnection()),
                    InsertCommand = new SqlCommand(InsertSQL, ConnectionManager.GetConnection()),
                    UpdateCommand = new SqlCommand(UpdateSQL, ConnectionManager.GetConnection()),
                    DeleteCommand = new SqlCommand(DeleteSQL, ConnectionManager.GetConnection())
                };

                //Paremetros Select 
                oAdaptador.SelectCommand.Parameters.Add("@IDCuentaBanco", SqlDbType.Int).SourceColumn = "IDCuentaBanco";
                oAdaptador.SelectCommand.Parameters.Add("@IDTipo", SqlDbType.Int).SourceColumn = "IDTipo";
                oAdaptador.SelectCommand.Parameters.Add("@IDSubTipo", SqlDbType.Int).SourceColumn = "IDSubTipo";
                oAdaptador.SelectCommand.Parameters.Add("@IDRuc", SqlDbType.Int).SourceColumn = "IDRuc";
                oAdaptador.SelectCommand.Parameters.Add("@Numero", SqlDbType.NChar).SourceColumn = "Numero";

                


                //Paremetros Insert
                oAdaptador.InsertCommand.CommandType = CommandType.StoredProcedure;
                oAdaptador.InsertCommand.Parameters.Add("@Operacion", SqlDbType.NChar).Value = "I";
                oAdaptador.InsertCommand.Parameters.Add("@IDCuentaBanco", SqlDbType.Int).SourceColumn = "IDCuentaBanco";
				oAdaptador.InsertCommand.Parameters.Add("@IDMovimiento", SqlDbType.Int).SourceColumn = "IDMovimiento";
				oAdaptador.InsertCommand.Parameters["@IDMovimiento"].Direction = ParameterDirection.Output;
                oAdaptador.InsertCommand.Parameters.Add("@Fecha", SqlDbType.Date).SourceColumn = "Fecha";
                oAdaptador.InsertCommand.Parameters.Add("@IDTipo", SqlDbType.Int).SourceColumn = "IDTipo";
                oAdaptador.InsertCommand.Parameters.Add("@IDSubTipo", SqlDbType.Int).SourceColumn = "IDSubTipo";
                oAdaptador.InsertCommand.Parameters.Add("@IDRuc", SqlDbType.Int).SourceColumn = "IDRuc";
                oAdaptador.InsertCommand.Parameters.Add("@Numero", SqlDbType.NChar).SourceColumn = "Numero";
                oAdaptador.InsertCommand.Parameters.Add("@Pagaderoa", SqlDbType.NChar).SourceColumn = "Pagadero_a";
                oAdaptador.InsertCommand.Parameters.Add("@Monto", SqlDbType.Decimal).SourceColumn = "Monto";
                oAdaptador.InsertCommand.Parameters.Add("@Usuario", SqlDbType.NChar).SourceColumn = "Usuario";
                oAdaptador.InsertCommand.Parameters.Add("@ConceptoContable", SqlDbType.NChar).SourceColumn = "ConceptoContable";

                //Paremetros Update 
                oAdaptador.UpdateCommand.CommandType = CommandType.StoredProcedure;
                oAdaptador.UpdateCommand.Parameters.Add("@Operacion", SqlDbType.NChar).Value = "U";
                oAdaptador.UpdateCommand.Parameters.Add("@IDCuentaBanco", SqlDbType.Int).SourceColumn = "IDCuentaBanco";
				oAdaptador.UpdateCommand.Parameters.Add("@IDMovimiento", SqlDbType.Int).SourceColumn = "IDMovimiento";
				oAdaptador.UpdateCommand.Parameters["@IDMovimiento"].Direction = ParameterDirection.Output;
                oAdaptador.UpdateCommand.Parameters.Add("@Fecha", SqlDbType.Date).SourceColumn = "Fecha";
                oAdaptador.UpdateCommand.Parameters.Add("@IDTipo", SqlDbType.Int).SourceColumn = "IDTipo";
                oAdaptador.UpdateCommand.Parameters.Add("@IDSubTipo", SqlDbType.Int).SourceColumn = "IDSubTipo";
                oAdaptador.UpdateCommand.Parameters.Add("@IDRuc", SqlDbType.Int).SourceColumn = "IDRuc";
                oAdaptador.UpdateCommand.Parameters.Add("@Numero", SqlDbType.NChar).SourceColumn = "Numero";
                oAdaptador.UpdateCommand.Parameters.Add("@Pagaderoa", SqlDbType.NChar).SourceColumn = "Pagadero_a";
                oAdaptador.UpdateCommand.Parameters.Add("@Monto", SqlDbType.Decimal).SourceColumn = "Monto";
                oAdaptador.UpdateCommand.Parameters.Add("@Usuario", SqlDbType.NChar).SourceColumn = "Usuario";
                oAdaptador.UpdateCommand.Parameters.Add("@ConceptoContable", SqlDbType.NChar).SourceColumn = "ConceptoContable";



                //Paremetros Delete 
                oAdaptador.DeleteCommand.CommandType = CommandType.StoredProcedure;
                oAdaptador.DeleteCommand.Parameters.Add("@Operacion", SqlDbType.NChar).Value = "D";
                oAdaptador.DeleteCommand.Parameters.Add("@IDCuentaBanco", SqlDbType.Int).SourceColumn = "IDCuentaBanco";
				oAdaptador.DeleteCommand.Parameters.Add("@IDMovimiento", SqlDbType.Int).SourceColumn = "IDMovimiento";
				oAdaptador.DeleteCommand.Parameters["@IDMovimiento"].Direction = ParameterDirection.Output;
                oAdaptador.DeleteCommand.Parameters.Add("@Fecha", SqlDbType.Date).SourceColumn = "Fecha";
                oAdaptador.DeleteCommand.Parameters.Add("@IDTipo", SqlDbType.Int).SourceColumn = "IDTipo";
                oAdaptador.DeleteCommand.Parameters.Add("@IDSubTipo", SqlDbType.Int).SourceColumn = "IDSubTipo";
                oAdaptador.DeleteCommand.Parameters.Add("@IDRuc", SqlDbType.Int).SourceColumn = "IDRuc";
                oAdaptador.DeleteCommand.Parameters.Add("@Numero", SqlDbType.NChar).SourceColumn = "Numero";
                oAdaptador.DeleteCommand.Parameters.Add("@Pagaderoa", SqlDbType.NChar).SourceColumn = "Pagadero_a";
                oAdaptador.DeleteCommand.Parameters.Add("@Monto", SqlDbType.Decimal).SourceColumn = "Monto";
                oAdaptador.DeleteCommand.Parameters.Add("@Usuario", SqlDbType.NChar).SourceColumn = "Usuario";
                oAdaptador.DeleteCommand.Parameters.Add("@ConceptoContable", SqlDbType.NChar).SourceColumn = "ConceptoContable";

                return oAdaptador;
            }
            catch (Exception)
            {
                throw;
            }
        }



        public static void SetTransactionToAdaptador(bool Activo)
        {
            oAdaptador.UpdateCommand.Transaction = (Activo) ? ConnectionManager.Tran : null;
            oAdaptador.DeleteCommand.Transaction = (Activo) ? ConnectionManager.Tran : null;
            oAdaptador.InsertCommand.Transaction = (Activo) ? ConnectionManager.Tran : null;
			oAdaptador.SelectCommand.Transaction = (Activo) ? ConnectionManager.Tran : null;
        }

        private static DataSet CreateDataSet()
        {
            DataSet DS = new DataSet();
            DataTable tipoTable = DS.Tables.Add("Data");
            return DS;
        }


        public static DataSet GetDataEmpty()
        {
            String strSQL = "SELECT  IDCuentaBanco ,Fecha ,IDTipo ,IDSubTipo ,IDRuc,Numero ,Pagadero_a ,Monto ,Asiento ,Anulado ,AsientoAnulacion ,Usuario ,UsuarioAnulacion, UsuarioAprobacion,FechaAprobacion,UsuarioImpresion,FechaImpresion,Impreso ,FechaAnulacion ,ConceptoContable,IDMovimiento  FROM dbo.cbMovimientos WHERE 1=2";

            SqlCommand oCmd = new SqlCommand(strSQL, ConnectionManager.GetConnection());
            SqlDataAdapter oAdaptador = new SqlDataAdapter(oCmd);
            DataSet DS = CreateDataSet();

            oAdaptador.Fill(DS.Tables["Data"]);
            return DS;
        }

        

        public static DataSet GetData(int IDCuentaBanco,int IDTipo,int IDSubTipo,int IDRuc,String Numero)
        {
            DataSet DS = CreateDataSet();
            oAdaptador.SelectCommand.Parameters["@IDCuentaBanco"].Value = IDCuentaBanco;
            oAdaptador.SelectCommand.Parameters["@IDTipo"].Value = IDTipo;
            oAdaptador.SelectCommand.Parameters["@IDSubTipo"].Value = IDSubTipo;
            oAdaptador.SelectCommand.Parameters["@IDRuc"].Value = IDRuc;
            oAdaptador.SelectCommand.Parameters["@Numero"].Value = Numero;



            oAdaptador.Fill(DS.Tables["Data"]);
            return DS;
        }


        public static DataSet GetDatosByCriterio(DateTime FechaInicial,DateTime FechaFinal,int IDRuc,String NombreRuc,String AliasRUC,int IdTipo,int IdSubTipo,String PagaderoA,int Anulado,String Numero,String ConceptoContable)
        {

            DataSet DS = new DataSet();

            SqlCommand oCmd = new SqlCommand("dbo.cbGetMovimientosByCriterios", ConnectionManager.GetConnection());
            SqlConnection oConn = oCmd.Connection;
            try
            {


                oCmd.CommandType = CommandType.StoredProcedure;
                SqlDataAdapter oAdapatadorTmp = new SqlDataAdapter(oCmd);
                oCmd.Parameters.Add("@FechaInicial", SqlDbType.DateTime, 50).Value = FechaInicial;
                oCmd.Parameters.Add("@FechaFinal", SqlDbType.DateTime, 50).Value = FechaFinal;
                oCmd.Parameters.Add("@IDRuc", SqlDbType.Int, 50).Value = IDRuc;
                oCmd.Parameters.Add("@NombreRUC", SqlDbType.VarChar,200).Value = NombreRuc;
                oCmd.Parameters.Add("@AliasRUC", SqlDbType.VarChar,200).Value = AliasRUC;
                oCmd.Parameters.Add("@IDTipo", SqlDbType.Int, 50).Value = IdTipo;
                oCmd.Parameters.Add("@IDSubTipo", SqlDbType.Int, 50).Value = IdSubTipo;
                oCmd.Parameters.Add("@PagaderoA", SqlDbType.VarChar,200).Value = PagaderoA;
                oCmd.Parameters.Add("@Anulado", SqlDbType.Int, 50).Value = Anulado;
                oCmd.Parameters.Add("@ConceptoContable", SqlDbType.VarChar, 50).Value = ConceptoContable;
				oCmd.Parameters.Add("@Numero", SqlDbType.NVarChar, 250).Value = Numero;
                
                oAdapatadorTmp.Fill(DS, "Data");


            }
            catch (Exception)
            {
                throw;
            }
            finally
            {
                if (oConn.State == ConnectionState.Open)
                    oConn.Close();

            }
            return DS;

        }


		public static String GetNotaFromMovimiento(int IDMovimiento)
        {

            DataSet DS = new DataSet();

            SqlCommand oCmd = new SqlCommand("dbo.getNotaMovLibro", ConnectionManager.GetConnection());
            SqlConnection oConn = oCmd.Connection;
            try
            {


                oCmd.CommandType = CommandType.StoredProcedure;
                SqlDataAdapter oAdapatadorTmp = new SqlDataAdapter(oCmd);
                oCmd.Parameters.Add("@IDMovimiento", SqlDbType.Int, 50).Value = IDMovimiento;

				oAdapatadorTmp.Fill(DS, "Data"); 

				

				

            }
            catch (Exception)
            {
                throw;
            }
            finally
            {
                if (oConn.State == ConnectionState.Open)
                    oConn.Close();

            }
			return DS.Tables[0].Rows[0]["NotaConciliacion"].ToString();

        }

        public static String GenerarAsientoContable(String Numero, int IDCuentaBanco,int IDTipo,int IDSubTipo, String Usuario)
        {
            String strSQL = "dbo.cbGenerarAsientoContableCheque";
            //bool Result = false;
            DataSet DS = new DataSet();
            String Asiento = "";
            SqlConnection oConn = ConnectionManager.GetConnection();
            SqlCommand oCmd = new SqlCommand(strSQL, oConn);
			//if (ConnectionManager.Tran != null)
			//	oCmd.Transaction = ConnectionManager.Tran;
            try
            {

                SqlDataAdapter oAdaptadorTmp = new SqlDataAdapter(oCmd );
                oCmd.Parameters.Add(new SqlParameter("@Numero", Numero));
                oCmd.Parameters.Add(new SqlParameter("@IDCuentaBanco", IDCuentaBanco));
                oCmd.Parameters.Add(new SqlParameter("@IDTipo", IDTipo));
                oCmd.Parameters.Add(new SqlParameter("@IDSubTipo", IDSubTipo));
                oCmd.Parameters.Add(new SqlParameter("@Usuario", Usuario));
                
                oCmd.CommandType = CommandType.StoredProcedure;

                oAdaptadorTmp.Fill(DS, "Data");
                Asiento = DS.Tables[0].Rows[0]["Asiento"].ToString();
                //md.Connection.Open();
                //oCmd.ExecuteNonQuery();

               // Result = true;
            }
            catch (Exception)
            {
                throw;
            }
            finally
            {
                if (oCmd.Connection.State == ConnectionState.Open)
                    oCmd.Connection.Close();
            }
            return Asiento;
        }
		
		public static bool SetNotaMovimiento(int IDMovimiento, String sNota) 
        {
            String strSQL = "dbo.cbSetNotaMovLibro";
            bool Result = false;

            SqlCommand oCmd = new SqlCommand(strSQL, ConnectionManager.GetConnection());
            try
            {


				oCmd.Parameters.Add(new SqlParameter("@IDMovimiento", IDMovimiento));
				oCmd.Parameters.Add(new SqlParameter("@Nota", sNota));
                
                oCmd.CommandType = CommandType.StoredProcedure;
                oCmd.Connection.Open();
                oCmd.ExecuteNonQuery();

                Result = true;
            }
            catch (Exception)
            {
                throw;
            }
            finally
            {
                if (oCmd.Connection.State == ConnectionState.Open)
                    oCmd.Connection.Close();
            }
            return Result;
        }

        public static bool SetChequeImpreso(int Numero, int IDCuentaBanco, int IDTipo, int IDSubTipo, String Usuario)
        {
            String strSQL = "dbo.cbMarcarChequeImpreso";
            bool Result = false;

            SqlCommand oCmd = new SqlCommand(strSQL, ConnectionManager.GetConnection());
            try
            {


                oCmd.Parameters.Add(new SqlParameter("@Numero", Numero));
                oCmd.Parameters.Add(new SqlParameter("@IDCuentaBanco", IDCuentaBanco));
                oCmd.Parameters.Add(new SqlParameter("@IDTipo", IDTipo));
                oCmd.Parameters.Add(new SqlParameter("@IDSubTipo", IDSubTipo));
                oCmd.Parameters.Add(new SqlParameter("@Usuario", Usuario));

                oCmd.CommandType = CommandType.StoredProcedure;
                oCmd.Connection.Open();
                oCmd.ExecuteNonQuery();

                Result = true;
            }
            catch (Exception)
            {
                throw;
            }
            finally
            {
                if (oCmd.Connection.State == ConnectionState.Open)
                    oCmd.Connection.Close();
            }
            return Result;
        }


        public static bool RevierteAsientoContable(String Numero, int IDCuentaBanco, int IDTipo, int IDSubTipo, String Usuario)
        {
            String strSQL = "dbo.cbAnularAsientoContableCheque";
            bool Result = false;

            SqlCommand oCmd = new SqlCommand(strSQL, ConnectionManager.GetConnection());
            try
            {


                oCmd.Parameters.Add(new SqlParameter("@Numero", Numero));
                oCmd.Parameters.Add(new SqlParameter("@IDCuentaBanco", IDCuentaBanco));
                oCmd.Parameters.Add(new SqlParameter("@IDTipo", IDTipo));
                oCmd.Parameters.Add(new SqlParameter("@IDSubTipo", IDSubTipo));
                oCmd.Parameters.Add(new SqlParameter("@Usuario", Usuario));

                oCmd.CommandType = CommandType.StoredProcedure;
				oCmd.Transaction = ConnectionManager.Tran;
                if (oCmd.Connection.State == ConnectionState.Closed) 
					oCmd.Connection.Open();
                oCmd.ExecuteNonQuery();

                Result = true;
            }
            catch (Exception)
            {
                 throw;
            }
            finally
            {
                if (oCmd.Connection.State == ConnectionState.Open)
                    oCmd.Connection.Close();
            }
            return Result;
        }

    }
}
