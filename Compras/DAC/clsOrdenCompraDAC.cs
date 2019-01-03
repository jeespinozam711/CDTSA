﻿using Security;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CO.DAC
{
    public static class clsOrdenCompraDAC {
    
        public static long InsertUpdate(string Operacion,int IDOrdenCompra,String OrdenCompra,DateTime Fecha,DateTime FechaRequerida,DateTime FechaEmision,DateTime FechaRequeridaEmbarque,DateTime FechaCotizacion,
                        int IDEstado, int IDBodega,int IDProveedor,int IDMoneda, int IDCondicionPago,decimal Descuento, Decimal Flete, decimal Documentacion, decimal Anticipos,
                        int IDTipoProrrateo,int  IDEmbarque ,int IDSolicitud, int IDDocumentoCP,decimal TipoCambio, string Usuario,string UsuarioEmbarque,DateTime FechaCreaEmbarque,
                        String UsuarioAprobacion,DateTime FechaAprobacion,DateTime createdDate,String createdBy, DateTime recordDate, String updatedBy, SqlTransaction tran)
        {
            long result = -1;
            String strSQL = "dbo.invUpdateSolicitudCompra";

            SqlCommand oCmd = new SqlCommand(strSQL, Security.ConnectionManager.GetConnection());

            oCmd.Parameters.Add(new SqlParameter("@Operacion", Operacion));
            oCmd.Parameters.Add(new SqlParameter("@IDOrdenCompra", IDOrdenCompra));
            oCmd.Parameters.Add(new SqlParameter("@OrdenCompra", OrdenCompra));
            oCmd.Parameters["@IDOrdenCompra"].Direction= ParameterDirection.InputOutput;
            oCmd.Parameters.Add(new SqlParameter("@Fecha", Fecha));
               oCmd.Parameters.Add(new SqlParameter("@FechaRequerida", FechaRequerida));
               oCmd.Parameters.Add(new SqlParameter("@FechaRequeridaEmbarque", FechaRequeridaEmbarque));
               oCmd.Parameters.Add(new SqlParameter("@FechaCotizacion", FechaCotizacion));
               oCmd.Parameters.Add(new SqlParameter("@IDEstado", IDEstado));
               oCmd.Parameters.Add(new SqlParameter("@IDBodega", IDBodega));
               oCmd.Parameters.Add(new SqlParameter("@IDProveedor",IDProveedor));
               oCmd.Parameters.Add(new SqlParameter("@IDMoneda", IDMoneda));
               oCmd.Parameters.Add(new SqlParameter("@IDCondicionPago", IDCondicionPago));
               oCmd.Parameters.Add(new SqlParameter("@Descuento", Descuento));
               oCmd.Parameters.Add(new SqlParameter("@Flete", Flete));
               oCmd.Parameters.Add(new SqlParameter("@Documentacion", Documentacion));
            oCmd.Parameters.Add(new SqlParameter("@Anticipos", Anticipos));
            oCmd.Parameters.Add(new SqlParameter("@IDTipoProrrateo", IDTipoProrrateo));
            oCmd.Parameters.Add(new SqlParameter("@IDEmbarque", IDEmbarque));
            oCmd.Parameters.Add(new SqlParameter("@IDSolicitud", IDSolicitud));
            oCmd.Parameters.Add(new SqlParameter("@IDDocumentoCP", IDDocumentoCP));
            oCmd.Parameters.Add(new SqlParameter("@TipoCambio", TipoCambio));
            oCmd.Parameters.Add(new SqlParameter("@Usuario", Usuario));
            oCmd.Parameters.Add(new SqlParameter("@UsuarioEmbarque", UsuarioEmbarque));
            oCmd.Parameters.Add(new SqlParameter("@FechaCreaEmbarque", FechaCreaEmbarque));
            oCmd.Parameters.Add(new SqlParameter("@UsuarioAprobacion", UsuarioAprobacion));
            oCmd.Parameters.Add(new SqlParameter("@FechaAprobacion", FechaAprobacion));
            oCmd.Parameters.Add(new SqlParameter("@CreateDate", createdDate));
            oCmd.Parameters.Add(new SqlParameter("@CreatedBy", createdBy));
            oCmd.Parameters.Add(new SqlParameter("@RecordDate", recordDate));
            oCmd.Parameters.Add(new SqlParameter("@UpdateBy", updatedBy));
            


            oCmd.CommandType = CommandType.StoredProcedure;
            oCmd.Transaction = tran;
            result = oCmd.ExecuteNonQuery();
           if (Operacion =="I")
                result = (long) oCmd.Parameters["@IDSolicitud"].Value;

            
            return result;

        }


        public static DataSet Get(int IDSolicitud, DateTime FechaInicial, DateTime FechaFinal, int IDEstado,int IDOrdenCompra)
        {
            String strSQL = "dbo.invGetSolicitudCompra";

            SqlCommand oCmd = new SqlCommand(strSQL, ConnectionManager.GetConnection());

            oCmd.Parameters.Add(new SqlParameter("@IDSolicitud", IDSolicitud));
            oCmd.Parameters.Add(new SqlParameter("@FechaInicial", FechaInicial));
            oCmd.Parameters.Add(new SqlParameter("@FechaFinal", FechaFinal));
            oCmd.Parameters.Add(new SqlParameter("@IDEstado", IDEstado));
            oCmd.Parameters.Add(new SqlParameter("@IDOrdenCompra", IDOrdenCompra));
            oCmd.CommandType = CommandType.StoredProcedure;

            SqlDataAdapter oAdap = new SqlDataAdapter(oCmd);
            DataSet DS = new DataSet();

            oAdap.Fill(DS.Tables["Data"]);
            return DS;
        }
    }
}