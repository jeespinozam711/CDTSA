﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using System.Data.SqlClient;
using Security;

namespace CG
{
    public static class CuentaContableDAC
    {
        public static SqlDataAdapter oAdaptador = InicializarAdaptador();

        private static SqlDataAdapter InicializarAdaptador()
        {
            String getSQL = "dbo.cntGetCuentas";
            String InsertSQL = "[dbo].[cntUpdateCuenta]";
            String UpdateSQL = "[dbo].[cntUpdateCuenta]";
            String DeleteSQL = "[dbo].[cntUpdateCuenta]";

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
                oAdaptador.SelectCommand.CommandType = CommandType.StoredProcedure;
                oAdaptador.SelectCommand.Parameters.Add("@IDCuenta", SqlDbType.BigInt).SourceColumn = "IDCuenta";
                oAdaptador.SelectCommand.Parameters.Add("@IDGrupo", SqlDbType.Int).SourceColumn = "IDGrupo";
                oAdaptador.SelectCommand.Parameters.Add("@IDSubTipo", SqlDbType.Int).SourceColumn = "IDSubTipo";
                oAdaptador.SelectCommand.Parameters.Add("@Nivel1", SqlDbType.NVarChar).SourceColumn = "Nivel1";
                oAdaptador.SelectCommand.Parameters.Add("@Nivel2", SqlDbType.NVarChar).SourceColumn = "Nivel2";
                oAdaptador.SelectCommand.Parameters.Add("@Nivel3", SqlDbType.NVarChar).SourceColumn = "Nivel3";
                oAdaptador.SelectCommand.Parameters.Add("@Nivel4", SqlDbType.NVarChar).SourceColumn = "Nivel4";
                oAdaptador.SelectCommand.Parameters.Add("@Nivel5", SqlDbType.NVarChar).SourceColumn = "Nivel5";
                oAdaptador.SelectCommand.Parameters.Add("@Nivel6", SqlDbType.NVarChar).SourceColumn = "Nivel6";
                oAdaptador.SelectCommand.Parameters.Add("@Cuenta", SqlDbType.NVarChar).SourceColumn = "Cuenta";
                oAdaptador.SelectCommand.Parameters.Add("@Complementaria", SqlDbType.Int).SourceColumn = "Complementaria";
                oAdaptador.SelectCommand.Parameters.Add("@EsMayor", SqlDbType.Int).SourceColumn = "EsMayor";
                oAdaptador.SelectCommand.Parameters.Add("@AceptaDatos", SqlDbType.Int).SourceColumn = "AceptaDatos";
                oAdaptador.SelectCommand.Parameters.Add("@Activa", SqlDbType.Int).SourceColumn = "Activa";
                oAdaptador.SelectCommand.Parameters.Add("@IDCuentaMayor", SqlDbType.BigInt).SourceColumn = "IDCuentaMayor";
                oAdaptador.SelectCommand.Parameters.Add("@UsaCentroCosto", SqlDbType.Int).SourceColumn = "UsaCentroCosto";



                //Paremetros Insert
                oAdaptador.InsertCommand.CommandType = CommandType.StoredProcedure;
                oAdaptador.InsertCommand.Parameters.Add("@Operacion", SqlDbType.NChar).Value = "I";
                oAdaptador.InsertCommand.Parameters.Add("@IDCuenta", SqlDbType.BigInt).SourceColumn = "IDCuenta";
                oAdaptador.InsertCommand.Parameters.Add("@IDGrupo", SqlDbType.Int).SourceColumn = "IDGrupo";
                oAdaptador.InsertCommand.Parameters.Add("@IDTipo", SqlDbType.Int).SourceColumn = "IDTipo";
                oAdaptador.InsertCommand.Parameters.Add("@IDSubTipo", SqlDbType.NVarChar).SourceColumn = "IDSubTipo";
                oAdaptador.InsertCommand.Parameters.Add("@Complementaria", SqlDbType.Bit).SourceColumn = "Complementaria";
                oAdaptador.InsertCommand.Parameters.Add("@Nivel1", SqlDbType.NVarChar).SourceColumn = "Nivel1";
                oAdaptador.InsertCommand.Parameters.Add("@Nivel2", SqlDbType.NVarChar).SourceColumn = "Nivel2";
                oAdaptador.InsertCommand.Parameters.Add("@Nivel3", SqlDbType.NVarChar).SourceColumn = "Nivel3";
                oAdaptador.InsertCommand.Parameters.Add("@Nivel4", SqlDbType.NVarChar).SourceColumn = "Nivel4";
                oAdaptador.InsertCommand.Parameters.Add("@Nivel5", SqlDbType.NVarChar).SourceColumn = "Nivel5";
                oAdaptador.InsertCommand.Parameters.Add("@Nivel6", SqlDbType.NVarChar).SourceColumn = "Nivel6";
                oAdaptador.InsertCommand.Parameters.Add("@Descr", SqlDbType.NVarChar).SourceColumn = "Descr";
                oAdaptador.InsertCommand.Parameters.Add("@EsMayor", SqlDbType.Bit).SourceColumn = "EsMayor";
                oAdaptador.InsertCommand.Parameters.Add("@AceptaDatos", SqlDbType.Bit).SourceColumn = "AceptaDatos";
                oAdaptador.InsertCommand.Parameters.Add("@Activa", SqlDbType.Bit).SourceColumn = "Activa";
                oAdaptador.InsertCommand.Parameters.Add("@IDCuentaAnterior", SqlDbType.BigInt).SourceColumn = "IDCuentaAnterior";
                oAdaptador.InsertCommand.Parameters.Add("@IDCuentaMayor", SqlDbType.BigInt).SourceColumn = "IDCuentaMayor";
                oAdaptador.InsertCommand.Parameters.Add("@UsaCentroCosto", SqlDbType.Bit).SourceColumn = "UsaCentroCosto";
                


                //Paremetros Update 
                oAdaptador.UpdateCommand.CommandType = CommandType.StoredProcedure;
                oAdaptador.UpdateCommand.Parameters.Add("@Operacion", SqlDbType.NChar).Value = "U";
                oAdaptador.UpdateCommand.Parameters.Add("@IDCuenta", SqlDbType.BigInt).SourceColumn = "IDCuenta";
                oAdaptador.UpdateCommand.Parameters.Add("@IDGrupo", SqlDbType.Int).SourceColumn = "IDGrupo";
                oAdaptador.UpdateCommand.Parameters.Add("@IDTipo", SqlDbType.Int).SourceColumn = "IDTipo";
                oAdaptador.UpdateCommand.Parameters.Add("@IDSubTipo", SqlDbType.NVarChar).SourceColumn = "IDSubTipo";
                oAdaptador.UpdateCommand.Parameters.Add("@Complementaria", SqlDbType.Bit).SourceColumn = "Complementaria";
                oAdaptador.UpdateCommand.Parameters.Add("@Nivel1", SqlDbType.NVarChar).SourceColumn = "Nivel1";
                oAdaptador.UpdateCommand.Parameters.Add("@Nivel2", SqlDbType.NVarChar).SourceColumn = "Nivel2";
                oAdaptador.UpdateCommand.Parameters.Add("@Nivel3", SqlDbType.NVarChar).SourceColumn = "Nivel3";
                oAdaptador.UpdateCommand.Parameters.Add("@Nivel4", SqlDbType.NVarChar).SourceColumn = "Nivel4";
                oAdaptador.UpdateCommand.Parameters.Add("@Nivel5", SqlDbType.NVarChar).SourceColumn = "Nivel5";
                oAdaptador.UpdateCommand.Parameters.Add("@Nivel6", SqlDbType.NVarChar).SourceColumn = "Nivel6";
                oAdaptador.UpdateCommand.Parameters.Add("@Descr", SqlDbType.NVarChar).SourceColumn = "Descr";
                oAdaptador.UpdateCommand.Parameters.Add("@EsMayor", SqlDbType.Bit).SourceColumn = "EsMayor";
                oAdaptador.UpdateCommand.Parameters.Add("@AceptaDatos", SqlDbType.Bit).SourceColumn = "AceptaDatos";
                oAdaptador.UpdateCommand.Parameters.Add("@Activa", SqlDbType.Bit).SourceColumn = "Activa";
                oAdaptador.UpdateCommand.Parameters.Add("@IDCuentaAnterior", SqlDbType.BigInt).SourceColumn = "IDCuentaAnterior";
                oAdaptador.UpdateCommand.Parameters.Add("@IDCuentaMayor", SqlDbType.BigInt).SourceColumn = "IDCuentaMayor";
                oAdaptador.UpdateCommand.Parameters.Add("@UsaCentroCosto", SqlDbType.Bit).SourceColumn = "UsaCentroCosto";
                




                //Paremetros Delete 
                oAdaptador.DeleteCommand.CommandType = CommandType.StoredProcedure;
                oAdaptador.DeleteCommand.Parameters.Add("@Operacion", SqlDbType.NChar).Value = "D";
                oAdaptador.DeleteCommand.Parameters.Add("@IDCuenta", SqlDbType.BigInt).SourceColumn = "IDCuenta";
                oAdaptador.DeleteCommand.Parameters.Add("@IDGrupo", SqlDbType.Int).SourceColumn = "IDGrupo";
                oAdaptador.DeleteCommand.Parameters.Add("@IDTipo", SqlDbType.Int).SourceColumn = "IDTipo";
                oAdaptador.DeleteCommand.Parameters.Add("@IDSubTipo", SqlDbType.NVarChar).SourceColumn = "IDSubTipo";
                oAdaptador.DeleteCommand.Parameters.Add("@Complementaria", SqlDbType.Bit).SourceColumn = "Complementaria";
                oAdaptador.DeleteCommand.Parameters.Add("@Nivel1", SqlDbType.NVarChar).SourceColumn = "Nivel1";
                oAdaptador.DeleteCommand.Parameters.Add("@Nivel2", SqlDbType.NVarChar).SourceColumn = "Nivel2";
                oAdaptador.DeleteCommand.Parameters.Add("@Nivel3", SqlDbType.NVarChar).SourceColumn = "Nivel3";
                oAdaptador.DeleteCommand.Parameters.Add("@Nivel4", SqlDbType.NVarChar).SourceColumn = "Nivel4";
                oAdaptador.DeleteCommand.Parameters.Add("@Nivel5", SqlDbType.NVarChar).SourceColumn = "Nivel5";
                oAdaptador.DeleteCommand.Parameters.Add("@Nivel6", SqlDbType.NVarChar).SourceColumn = "Nivel6";
                oAdaptador.DeleteCommand.Parameters.Add("@Descr", SqlDbType.NVarChar).SourceColumn = "Descr";
                oAdaptador.DeleteCommand.Parameters.Add("@EsMayor", SqlDbType.Bit).SourceColumn = "EsMayor";
                oAdaptador.DeleteCommand.Parameters.Add("@AceptaDatos", SqlDbType.Bit).SourceColumn = "AceptaDatos";
                oAdaptador.DeleteCommand.Parameters.Add("@Activa", SqlDbType.Bit).SourceColumn = "Activa";
                oAdaptador.DeleteCommand.Parameters.Add("@IDCuentaAnterior", SqlDbType.BigInt).SourceColumn = "IDCuentaAnterior";
                oAdaptador.DeleteCommand.Parameters.Add("@IDCuentaMayor", SqlDbType.BigInt).SourceColumn = "IDCuentaMayor";
                oAdaptador.DeleteCommand.Parameters.Add("@UsaCentroCosto", SqlDbType.Bit).SourceColumn = "UsaCentroCosto";
                
                
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
        }

        private static DataSet CreateDataSet()
        {
            DataSet DS = new DataSet();
            DataTable tipoTable = DS.Tables.Add("Data");
            return DS;
        }

        public static DataSet GetData(long IDCuenta,int IDGrupo,int IDSubGrupo,String Nivel1, String Nivel2, String Nivel3,
                                       String Nivel4, String Nivel5, String Nivel6, String Cuenta,int Complementaria,int EsMayor,int AceptaDatos,
                                       int Activa,long IDCuentaMayor,long UsaCentroCosto )
        {
            DataSet DS = CreateDataSet();
            oAdaptador.SelectCommand.Parameters["@IDCuenta"].Value = IDCuenta;
            oAdaptador.SelectCommand.Parameters["@IDGrupo"].Value = IDGrupo;
            oAdaptador.SelectCommand.Parameters["@IDSubTipo"].Value = IDSubGrupo;
            oAdaptador.SelectCommand.Parameters["@Nivel1"].Value = Nivel1;
            oAdaptador.SelectCommand.Parameters["@Nivel2"].Value = Nivel2;
            oAdaptador.SelectCommand.Parameters["@Nivel3"].Value = Nivel3;
            oAdaptador.SelectCommand.Parameters["@Nivel4"].Value = Nivel4;
            oAdaptador.SelectCommand.Parameters["@Nivel5"].Value = Nivel5;
            oAdaptador.SelectCommand.Parameters["@Nivel6"].Value = Nivel6;
            oAdaptador.SelectCommand.Parameters["@Cuenta"].Value = Cuenta;
            oAdaptador.SelectCommand.Parameters["@Complementaria"].Value = Complementaria;
            oAdaptador.SelectCommand.Parameters["@EsMayor"].Value = EsMayor;
            oAdaptador.SelectCommand.Parameters["@AceptaDatos"].Value = AceptaDatos;
            oAdaptador.SelectCommand.Parameters["@Activa"].Value = Activa;
            oAdaptador.SelectCommand.Parameters["@IDCuentaMayor"].Value = IDCuentaMayor;
            oAdaptador.SelectCommand.Parameters["@UsaCentroCosto"].Value = UsaCentroCosto;
    
            oAdaptador.Fill(DS.Tables["Data"]);
            return DS;
        }



    
        public static long GetNextConsecutivo(int Nivel1,int Nivel2, int Nivel3, int Nivel4, int Nivel5,int Nivel6)
        {
            long ID = 0;
            DataSet DS = new DataSet();
    
            SqlCommand oCmd = new SqlCommand("dbo.cntGetNextConsecutivoCuenta", ConnectionManager.GetConnection());
            SqlConnection oConn = oCmd.Connection;
            try
            {

               
                oCmd.CommandType = CommandType.StoredProcedure;
                oCmd.Parameters.Add("@Nivel1", SqlDbType.Int).Value = Nivel1;
                oCmd.Parameters.Add("@Nivel2", SqlDbType.Int).Value = Nivel2;
                oCmd.Parameters.Add("@Nivel3", SqlDbType.Int).Value = Nivel3;
                oCmd.Parameters.Add("@Nivel4", SqlDbType.Int).Value = Nivel4;
                oCmd.Parameters.Add("@Nivel5", SqlDbType.Int).Value = Nivel5;
                oCmd.Parameters.Add("@Nivel6", SqlDbType.Int).Value = Nivel6;
                oCmd.Parameters.Add("@Resultado", SqlDbType.BigInt).Direction = ParameterDirection.ReturnValue;

            
                if (oConn.State == ConnectionState.Closed)
                    oConn.Open();
                oCmd.ExecuteNonQuery();

                if (oCmd.Parameters["@Resultado"].Value != DBNull.Value)
                    ID = (long)oCmd.Parameters["@Resultado"].Value;
     
            }catch (Exception)
            {
                throw;
            }
            finally
            {
                if (oConn.State == ConnectionState.Open)
                    oConn.Close();
                
            }
            return ID;

        }


        public static long GetNextConsecutivoFinal(int Nivel1, int Nivel2, int Nivel3, int Nivel4, int Nivel5, int Nivel6)
        {
            long ID = 0;
            DataSet DS = new DataSet();

            SqlCommand oCmd = new SqlCommand("dbo.cntGetProximaCuenta", ConnectionManager.GetConnection());
            SqlConnection oConn = oCmd.Connection;
            try
            {


                oCmd.CommandType = CommandType.StoredProcedure;
                oCmd.Parameters.Add("@iNivel1", SqlDbType.Int).Value = Nivel1;
                oCmd.Parameters.Add("@iNivel2", SqlDbType.Int).Value = Nivel2;
                oCmd.Parameters.Add("@iNivel3", SqlDbType.Int).Value = Nivel3;
                oCmd.Parameters.Add("@iNivel4", SqlDbType.Int).Value = Nivel4;
                oCmd.Parameters.Add("@iNivel5", SqlDbType.Int).Value = Nivel5;
                oCmd.Parameters.Add("@iNivel6", SqlDbType.Int).Value = Nivel6;
                oCmd.Parameters.Add("@NextCuenta", SqlDbType.Int).Value = 0;
                oCmd.Parameters["@NextCuenta"].Direction = ParameterDirection.Output;


                if (oConn.State == ConnectionState.Closed)
                    oConn.Open();
                oCmd.ExecuteNonQuery();

                if (oCmd.Parameters["@NextCuenta"].Value != DBNull.Value)
                    ID = (int)oCmd.Parameters["@NextCuenta"].Value;

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
            return ID;

        }


        public static bool ExisteCuentaPrimerNivel(int Nivel1)
        {
            bool result = false;
            DataSet DS = new DataSet();

            SqlCommand oCmd = new SqlCommand("dbo.cntExisteCuentaPrimerNivel", ConnectionManager.GetConnection());
            SqlConnection oConn = oCmd.Connection;
            try
            {


                oCmd.CommandType = CommandType.StoredProcedure;
                oCmd.Parameters.Add("@Nivel", SqlDbType.Int).Value = Nivel1;
                oCmd.Parameters.Add("@Result", SqlDbType.Bit).Direction = ParameterDirection.ReturnValue;

                if (oConn.State == ConnectionState.Closed)
                    oConn.Open();
                oCmd.ExecuteNonQuery();

                if (oCmd.Parameters["@Result"].Value != DBNull.Value)
                    result = (bool)oCmd.Parameters["@Result"].Value;

           
                

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
            return result;

        }



        public static String GetMascaraByNivel(String Nivel1, String Nivel2, String Nivel3, String Nivel4, String Nivel5,String Nivel6)
        {
            String ID = "";
            DataSet DS = new DataSet();

            SqlCommand oCmd = new SqlCommand("dbo.cntGetMascaraCuentaByNivel", ConnectionManager.GetConnection());
            SqlConnection oConn = oCmd.Connection;
            try
            {


                oCmd.CommandType = CommandType.StoredProcedure;
                oCmd.Parameters.Add("@Nivel1", SqlDbType.NVarChar,50).Value = Nivel1;
                oCmd.Parameters.Add("@Nivel2", SqlDbType.NVarChar, 50).Value = Nivel2;
                oCmd.Parameters.Add("@Nivel3", SqlDbType.NVarChar, 50).Value = Nivel3;
                oCmd.Parameters.Add("@Nivel4", SqlDbType.NVarChar, 50).Value = Nivel4;
                oCmd.Parameters.Add("@Nivel5", SqlDbType.NVarChar, 50).Value = Nivel5;
                oCmd.Parameters.Add("@Nivel6", SqlDbType.NVarChar, 50).Value = Nivel6;
                oCmd.Parameters.Add("@Resultado", SqlDbType.NVarChar, 50).Direction = ParameterDirection.ReturnValue;


                if (oConn.State == ConnectionState.Closed)
                    oConn.Open();
                oCmd.ExecuteNonQuery();

                if (oCmd.Parameters["@Resultado"].Value != DBNull.Value)
                    ID = oCmd.Parameters["@Resultado"].Value.ToString();

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
            return ID;

        }


        public static int GetCountCuentaByNivel(String Nivel1, String Nivel2, String Nivel3, String Nivel4, String Nivel5, String Nivel6)
        {
            int ID = 0;
            DataSet DS = new DataSet();

            SqlCommand oCmd = new SqlCommand("dbo.cntGetCountCuentaByNivel", ConnectionManager.GetConnection());
            SqlConnection oConn = oCmd.Connection;
            try
            {


                oCmd.CommandType = CommandType.StoredProcedure;
                oCmd.Parameters.Add("@Nivel1", SqlDbType.NVarChar, 50).Value = Nivel1;
                oCmd.Parameters.Add("@Nivel2", SqlDbType.NVarChar, 50).Value = Nivel2;
                oCmd.Parameters.Add("@Nivel3", SqlDbType.NVarChar, 50).Value = Nivel3;
                oCmd.Parameters.Add("@Nivel4", SqlDbType.NVarChar, 50).Value = Nivel4;
                oCmd.Parameters.Add("@Nivel5", SqlDbType.NVarChar, 50).Value = Nivel5;
                oCmd.Parameters.Add("@Nivel6", SqlDbType.NVarChar, 50).Value = Nivel6;
                oCmd.Parameters.Add("@Resultado", SqlDbType.NVarChar, 50).Direction = ParameterDirection.ReturnValue;

             
                if (oConn.State == ConnectionState.Closed)
                    oConn.Open();
                oCmd.ExecuteNonQuery();

                if (oCmd.Parameters["@Resultado"].Value != DBNull.Value)
                    ID = Convert.ToInt32( oCmd.Parameters["@Resultado"].Value);

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
            return ID;

        }


        public static DataSet GetCuentaByCentroCosto(int IDCentro)
        {
            String strSQL = "dbo.cntGetCuentaConbleByCentroCosto";

            SqlCommand oCmd = new SqlCommand(strSQL, ConnectionManager.GetConnection());

            oCmd.Parameters.Add(new SqlParameter("@IDCentro", IDCentro));
            oCmd.CommandType = CommandType.StoredProcedure;

            SqlDataAdapter oAdap = new SqlDataAdapter(oCmd);
            DataSet DS = CreateDataSet();

            oAdap.Fill(DS.Tables["Data"]);
            return DS;
        }


    
    }
}
