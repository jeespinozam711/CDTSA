﻿using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using CI.DAC;
using DevExpress.XtraEditors;

namespace CI.Consultas
{
    public partial class frmConsultaArticulo : DevExpress.XtraBars.Ribbon.RibbonForm
    {
        

        String sBodega, sLote,sPaquete,sTransaccion,sAplicacion,sReferencia ;
        DateTime FechaInicial, FechaFinal;
        
        

        public frmConsultaArticulo()
        {
            InitializeComponent();
        }


        private void frmConsultaArticulo_Load(object sender, EventArgs e)
        {
            sBodega = sLote=sPaquete=sTransaccion=sAplicacion=sReferencia= "*" ;
            FechaInicial = DateTime.Now.AddMonths(-1);
            FechaFinal = DateTime.Now;

            Util.Util.ConfigLookupEdit(this.slkupProducto, clsProductoDAC.GetProductoByID(-1, "*").Tables[0], "Descr", "IDProducto");
            Util.Util.ConfigLookupEditSetViewColumns(this.slkupProducto, "[{'ColumnCaption':'ID Producto','ColumnField':'IDProducto','width':30},{'ColumnCaption':'Descripción','ColumnField':'Descr','width':70}]");

            

        }

        private void CargarExistencias() {
            DataTable DtExistencias = new DataTable();
            DtExistencias = clsExistenciaBodegaDAC.GetExistenciaBodegaByClasificacion(sBodega,this.slkupProducto.EditValue.ToString(),sLote,"*","*","*","*","*","*",true).Tables[0];
            this.dtgExistencias.DataSource = DtExistencias;
        }

        private void CargarTransacciones() {
            DataTable DtTransacciones = new DataTable();
            DtTransacciones = clsDocumentoInvCabecera.GetTransaccionesByArticulo(sBodega, Convert.ToInt32(this.slkupProducto.EditValue),sLote,sTransaccion,sPaquete,sAplicacion,sReferencia,FechaInicial,FechaFinal ).Tables[0];
            this.dtgTransacciones.DataSource = DtTransacciones;
        }

        private void slkupProducto_EditValueChanged(object sender, EventArgs e)
        {
            SearchLookUpEdit editor = (sender as SearchLookUpEdit);
            int theIndex = editor.Properties.GetIndexByKeyValue(editor.EditValue);
            DataRow myRow = editor.Properties.View.GetDataRow(theIndex);
            SetDataToControl(myRow);
           
        }

        private void SetDataToControl(DataRow dr) {
            this.txtDescripcion.Text = dr["Descr"].ToString();
            this.txtAlias.Text = dr["Alias"].ToString();
            this.txtTipoImpuesto.Text = dr["DescrTipoImpuesto"].ToString();
            this.txtUnidadMedida.Text = dr["DescrUnidadMedida"].ToString();
            this.txtCodigoBarra.Text = dr["CodigoBarra"].ToString();
            this.txtFactorEmpaque.Text = dr["FactorEmpaque"].ToString();
            this.chkControlado.Checked = Convert.ToBoolean(dr["EsControlado"]);
            this.chkEtico.Checked = Convert.ToBoolean(dr["EsEtico"]);
            this.chkMuestra.Checked = Convert.ToBoolean(dr["EsMuestra"]);
            this.chkActivo.Checked = Convert.ToBoolean(dr["Activo"]);
            this.txtClasificacion1.Text = dr["DescrClasif1"].ToString();
            this.txtClasificacion2.Text = dr["DescrClasif2"].ToString();
            this.txtClasificacion3.Text = dr["DescrClasif3"].ToString();
            this.txtClasificacion4.Text = dr["DescrClasif4"].ToString();
            this.txtClasificacion5.Text = dr["DescrClasif5"].ToString();
            this.txtClasificacion6.Text = dr["DescrClasif6"].ToString();
            this.txtCostoPromDolar.Text = Convert.ToDouble(dr["CostoPromDolar"]).ToString("N2");
            this.txtCostoPromedioLocal.Text = Convert.ToDouble(dr["CostoPromLocal"]).ToString("N2");
            this.txtCostoUltimoDolar.Text = Convert.ToDouble(dr["CostoUltDolar"]).ToString("N2");
            this.txtCostoUltLocal.Text = Convert.ToDouble(dr["CostoUltLocal"]).ToString("N2");

        }



        
        private void TabControl_Selected(object sender, DevExpress.XtraTab.TabPageEventArgs e)
        {
            if (e.PageIndex == 0)
                btnFiltro.Enabled = false;
            if (e.PageIndex == 1)
                btnFiltro.Enabled = false;
            if (e.PageIndex == 2)
                btnFiltro.Enabled = false;
            if (e.PageIndex == 3)
                btnFiltro.Enabled = true;
            if (e.PageIndex == 4)
                btnFiltro.Enabled = true;
            
        }

        private void btnFiltro_ItemClick(object sender, DevExpress.XtraBars.ItemClickEventArgs e)
        {
            if (this.TabControl.SelectedTabPageIndex == 3)
            {
                frmFiltroConsultaArticuloExistencias ofrmFiltro = new frmFiltroConsultaArticuloExistencias(Convert.ToInt32(this.slkupProducto.EditValue), sLote, sBodega);
                ofrmFiltro.FormClosed += ofrmFiltro_FormClosed;
                ofrmFiltro.ShowDialog();
            }
            else {
                frmFiltroConsultaArticuloTransacciones ofrmFiltroTran = new frmFiltroConsultaArticuloTransacciones(Convert.ToInt32(this.slkupProducto.EditValue), sLote, sBodega, sPaquete, sTransaccion, sAplicacion, sReferencia, FechaInicial, FechaFinal);
                ofrmFiltroTran.FormClosed += ofrmFiltroTran_FormClosed;
                ofrmFiltroTran.ShowDialog();
            }
        }

        void ofrmFiltroTran_FormClosed(object sender, FormClosedEventArgs e)
        {
            frmFiltroConsultaArticuloTransacciones ofrmFiltroTran = (frmFiltroConsultaArticuloTransacciones)sender;
            ofrmFiltroTran.FormClosed -= ofrmFiltroTran_FormClosed;

            if (ofrmFiltroTran.DialogResult == System.Windows.Forms.DialogResult.OK)
            {

                sLote = ofrmFiltroTran.getLstFiltro("Lote");
                sBodega = ofrmFiltroTran.getLstFiltro("Bodega");
                sPaquete = ofrmFiltroTran.getLstFiltro("Paquete");
                sTransaccion = ofrmFiltroTran.getLstFiltro("Transaccion");
                sAplicacion = ofrmFiltroTran.GetAplicacion();
                sReferencia = ofrmFiltroTran.GetReferencia();
                FechaInicial = ofrmFiltroTran.GetFechaInicial();
                FechaFinal = ofrmFiltroTran.GetFechaFinal();
                CargarTransacciones();
            }
            
        }

        void ofrmFiltro_FormClosed(object sender, FormClosedEventArgs e)
        {
            frmFiltroConsultaArticuloExistencias ofrmFiltro = (frmFiltroConsultaArticuloExistencias)sender;
            ofrmFiltro.FormClosed -= ofrmFiltro_FormClosed;
            if (ofrmFiltro.DialogResult == System.Windows.Forms.DialogResult.OK) {
                
                    sLote = ofrmFiltro.getLstFiltro("Lote");
                    sBodega = ofrmFiltro.getLstFiltro("Bodega");
                    CargarExistencias();
            }

        }
    }
}