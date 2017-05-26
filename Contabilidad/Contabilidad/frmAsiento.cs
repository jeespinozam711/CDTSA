﻿using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Linq;
using System.Threading.Tasks;
using System.Windows.Forms;
using DevExpress.XtraEditors;
using Util;
using DevExpress.XtraGrid;
using DevExpress.XtraGrid.Views.Grid;

namespace CG
{
    public partial class frmAsiento : DevExpress.XtraBars.Ribbon.RibbonForm
    {

        private DataTable _dtAsiento;
        private DataTable _dtDetalle;

        private DataSet _dsAsiento;
        private DataSet _dsDetalle;

        private DataTable _dtCuentas;
        private DataTable _dtCentros;

        private DataSet _dsEjercicioPeriodo;

        private DataRow _currentRow;
        private String Accion = "NEW";

        String sUsuario = "jespinoza";
        String _Asiento = "";
        String _ModuloFuente = "";
        String _tituloVentana = "Asiento";


        public frmAsiento()
        {
            InitializeComponent();
            InicializarControles();
            Accion = "New";
            //Obtener el Siguiente consecutivo de la solicitud"
            _dsAsiento = AsientoDAC.GetDataEmpty();
            _dtAsiento = _dsAsiento.Tables[0];
            _ModuloFuente = "CG";
            InicializarNuevoElemento();
            this.StartPosition = FormStartPosition.CenterScreen;
        }

        public frmAsiento(String Asiento)
        {
            InitializeComponent();
            InicializarControles();

            _dsAsiento = AsientoDAC.GetDataByAsiento(Asiento);
            _dtAsiento = _dsAsiento.Tables[0];
            
            //_ModuloFuente = ModuloFuente;
            _currentRow = _dsAsiento.Tables[0].Rows[0];

        }

        public frmAsiento( DataSet ds, DataRow dr)
        {
           // Accion = "Edit";
            InitializeComponent();
            InicializarControles();
            _dsAsiento = ds;
            _dtAsiento = ds.Tables[0];
            //_ModuloFuente = ModuloFuente;
            _currentRow = dr;

        }

        private void InicializarControles()
        {
            gridView1.OptionsBehavior.EditingMode = DevExpress.XtraGrid.Views.Grid.GridEditingMode.EditFormInplace;
            gridView1.OptionsView.NewItemRowPosition = DevExpress.XtraGrid.Views.Grid.NewItemRowPosition.Top;
        }



        private void InicializarNuevoElemento()
        {
            _dsEjercicioPeriodo = EjercicioDAC.GetEjercicioActivo();
            DataSet DS = new DataSet();
            DS = TipoCambioDetalleDAC.GetData("TVEN", DateTime.Now);

            //this.txtEjercicio.Text = _dsEjercicioPeriodo.Tables[0].Rows[0]["DescrEjercicio"].ToString();
            //this.txtPeriodo.Text = _dsEjercicioPeriodo.Tables[0].Rows[0]["DescrPeriodo"].ToString();

            //this.txtTipoCambio.Text = (DS.Tables[0].Rows.Count==0) ? "0" : DS.Tables[0].Rows[0]["Monto"].ToString();
            _currentRow = _dtAsiento.NewRow();
            _currentRow["IDEjercicio"] = _dsEjercicioPeriodo.Tables[0].Rows[0]["IDEjercicio"].ToString();
            _currentRow["Periodo"] = _dsEjercicioPeriodo.Tables[0].Rows[0]["Periodo"].ToString();
            _currentRow["TipoCambio"] = Convert.ToDecimal((DS.Tables[0].Rows.Count == 0) ? 0 : DS.Tables[0].Rows[0]["Monto"]);
            _currentRow["ModuloFuente"] = _ModuloFuente;
            _currentRow["FechaHora"] = DateTime.Now;
            _currentRow["Fecha"] = DateTime.Now;
            _currentRow["Tipo"] = "CG";
            _currentRow["Concepto"] = null;
            _currentRow["Mayorizado"] = false; 
            _currentRow["Anulado"] = false;
            _currentRow["CuadreTemporal"] = false;
            //_dtAsiento.Rows.Add(_currentRow);
            
        }


        private String EstadoAsiento()
        {
            String sEstado = "";
            if (Convert.ToBoolean(_currentRow["Mayorizado"]))
                sEstado = "Mayorizado";
            else if (Convert.ToBoolean(_currentRow["Anulado"]))
                sEstado = "Anulado";
            else if (Convert.ToBoolean(_currentRow["CuadreTemporal"]))
                sEstado = "Cuadre Temporal";
            else
                sEstado = "Editando..";
            return sEstado;
        }


        

        public void UpdateControlsFromDataRow(DataRow row)
        {
            //_currentRow = _dtAsiento.NewRow();
            this.txtEjercicio.EditValue = _currentRow["IDEjercicio"].ToString();
            this.txtPeriodo.EditValue = _currentRow["Periodo"].ToString();
            this.txtTipoCambio.Text = Convert.ToDecimal(_currentRow["TipoCambio"]).ToString("N4");
            this.txtModuloFuente.EditValue = _currentRow["ModuloFuente"].ToString();
            this.dtpFecha.EditValue = Convert.ToDateTime(_currentRow["Fecha"]).ToShortDateString();
            this.txtFecha.EditValue = _currentRow["FechaHora"].ToString();
            this.slkupTipo.EditValue = "CG"; //_currentRow["Tipo"].ToString();
            this.txtConcepto.Text = _currentRow["Concepto"].ToString();
            this.txtEstado.Text = EstadoAsiento();
            //Obtener los datos segun cabecera
            PopulateGrid();
        }

        private void PopulateGrid()
        {
            String sAsiento = (this.Accion == "New") ? "--------" : _Asiento;
            _dsDetalle = AsientoDetalleDAC.GetData(sAsiento, -1, -1);
            _dtDetalle = _dsDetalle.Tables[0];

            this.grid.DataSource = _dtDetalle;
            
        }

        private void ClearControls()
        {
            this.txtConcepto.Text= "";
        }


        private void HabilitarControles(bool Activo)
        {
            this.dtpFecha.ReadOnly = !Activo;
            this.txtTipoCambio.ReadOnly = !Activo;
            this.txtConcepto.ReadOnly = !Activo;
            this.txtFecha.ReadOnly = !Activo;

            this.btnAgregar.Enabled = !Activo;
            this.btnEditar.Enabled = !Activo;
            this.btnGuardar.Enabled = Activo;
            this.btnCancelar.Enabled = Activo;
            this.btnEliminar.Enabled = !Activo;
        }

        //private void EnlazarEventos()
        //{
        //    this.btnAgregar.ItemClick += btnAgregar_ItemClick;
        //    this.btnEditar.ItemClick += btnEditar_ItemClick;
        //    this.btnEliminar.ItemClick += btnEliminar_ItemClick;
        //    this.btnGuardar.ItemClick += btnGuardar_ItemClick;
        //    this.btnCancelar.ItemClick += btnCancelar_ItemClick;
        //}


        private void frmAsiento_Load(object sender, EventArgs e)
        {
            try
            {
                //if (Accion=="New")
                //    CargarDatosPeriodoActivo();

                HabilitarControles(true);

                //        //SetDefaultBehaviorControls();
                Util.Util.SetDefaultBehaviorControls(this.gridView1, true, null,  _tituloVentana, this);
                //        EnlazarEventos();

                this.gridView1.EditFormPrepared += GridView1_EditFormPrepared;
                this.gridView1.NewItemRowText = Util.Util.constNewItemTextGrid;
                this.gridView1.ValidatingEditor += GridView1_ValidatingEditor;
                this.gridView1.InitNewRow += new DevExpress.XtraGrid.Views.Grid.InitNewRowEventHandler(this.gridView1_InitNewRow);
                //this.gridView1.CustomColumnDisplayText += GridView1_CustomColumnDisplayText;
                //        //Configurar searchLookUp
                _dtCentros = CentroCostoDAC.GetData(-1, "*", "*", "*", "*", 0).Tables[0];
                this.slkupCentroCostoGrid.DataSource = _dtCentros;
                this.slkupCentroCostoGrid.DisplayMember = "Centro";
                this.slkupCentroCostoGrid.ValueMember = "IDCentro";
                this.slkupCentroCostoGrid.NullText = " --- ---";
               // this.slkupCentroCostoGrid.EditValueChanged += SlkupCentroCostoGrid_EditValueChanged;

                _dtCuentas = CuentaContableDAC.GetData(-1, -1, -1, "*", "*", "*", "*", "*", "*", -1, -1, 1, 1, -1, -1).Tables[0];
                this.slkupCuentaContableGrid.DataSource = _dtCuentas;
                this.slkupCuentaContableGrid.DisplayMember = "Cuenta";
                this.slkupCuentaContableGrid.ValueMember = "IDCuenta";
                this.slkupCuentaContableGrid.NullText = " --- ---" ;

                Util.Util.ConfigLookupEdit(this.slkupTipo, TipoAsientoDAC.GetData().Tables["Data"], "Descr", "Tipo");
                Util.Util.ConfigLookupEditSetViewColumns(this.slkupTipo, "[{'ColumnCaption':'Tipo','ColumnField':'Tipo','width':30},{'ColumnCaption':'Descripcion','ColumnField':'Descr','width':70}]");
                grid.ProcessGridKey += Grid_ProcessGridKey;
                UpdateControlsFromDataRow(_currentRow);
                if (Accion == "New")
                {
                    ClearControls();
                    this.TabAuditoria.Visibility = DevExpress.XtraLayout.Utils.LayoutVisibility.Never;
                }
                else if (Convert.ToBoolean(_currentRow["Mayorizado"]) || Convert.ToBoolean(_currentRow["Anulado"]))
                {
                    Accion = "View";
                    this.TabAuditoria.Visibility = DevExpress.XtraLayout.Utils.LayoutVisibility.Always;
                }
                else
                {
                    Accion = "Edit";
                    this.TabAuditoria.Visibility = DevExpress.XtraLayout.Utils.LayoutVisibility.Always;
                }

                //Cargar Grilla
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        private void GridView1_CustomColumnDisplayText(object sender, DevExpress.XtraGrid.Views.Base.CustomColumnDisplayTextEventArgs e)
        {
            if (e.Column.FieldName == "IDCentro")
            {
                if (e.Value == null) return;
                DataView dt = new DataView();
                dt.Table = _dtCentros;
                dt.RowFilter = "IDCentro=" + e.Value.ToString();

                e.DisplayText = dt.ToTable().Rows[0]["Centro"].ToString() + "-" + dt.ToTable().Rows[0]["Descr"].ToString();
            }
            else if (e.Column.FieldName == "IDCuenta")
            {
                if (e.Value == null) return;
                DataView dt = new DataView();
                dt.Table = _dtCuentas;
                dt.RowFilter = "IDCuenta=" + e.Value.ToString();

                e.DisplayText = dt.ToTable().Rows[0]["Cuenta"].ToString() + "-" + dt.ToTable().Rows[0]["Descr"].ToString();
            }
        }

        //private void SlkupCentroCostoGrid_EditValueChanged(object sender, EventArgs e)
        //{
        //    try
        //    {
        //        //if (!isEdition)
        //        //    return;
        //        SearchLookUpEdit slkup = (sender as DevExpress.XtraEditors.SearchLookUpEdit);

        //        if (slkup.EditValue != null && slkup.EditValue.ToString() != "")
        //        {

        //            DataRowView rowView = (DataRowView)slkup.GetSelectedDataRow();
        //            DataRow row = rowView.Row;


        //            //slkup.row
        //            //DataRow row = slkup.getdata(theIndex);
        //            ////        e.DisplayText = row["Centro"].ToString() + "; " + row["Descr"].ToString();
        //            //slkup.GetSelectedDataRow if (e.Value == null) return;
        //            //DataView dt = new DataView();
        //            //dt.Table = _dtCentros;
        //            //dt.RowFilter = "IDCentro=" + e.Value.ToString();

        //            //e.DisplayText = dt.ToTable().Rows[0]["Centro"].ToString() + "-" + dt.ToTable().Rows[0]["Descr"].ToString();


        //        }
        //    }
        //    catch (Exception ex)
        //    {
        //        MessageBox.Show(ex.Message);
        //    }
        //}

        //private void SlkupCentroCostoGrid_CustomDisplayText(object sender, DevExpress.XtraEditors.Controls.CustomDisplayTextEventArgs e)
        //{
        //    SearchLookUpEdit edit = sender as SearchLookUpEdit;
        //    if (edit == null) return;
        //    int theIndex = edit.Properties.GetIndexByKeyValue(edit.EditValue);
        //    if (edit.Properties.View.IsDataRow(theIndex))
        //    {
        //        DataRow row = edit.Properties.View.GetDataRow(theIndex);
        //        e.DisplayText = row["Centro"].ToString() + "; " + row["Descr"].ToString();
        //    }
        //}

        private void Grid_ProcessGridKey(object sender, KeyEventArgs e)
        {
            var grid = sender as GridControl;
            var view = grid.FocusedView as GridView;
            if (e.KeyData == Keys.Delete)
            {
                if (MessageBox.Show("Esta seguro que desea eliminar el elemento seleccionado?", "Asiento de Diario", MessageBoxButtons.YesNo) == System.Windows.Forms.DialogResult.Yes)
                {
                    view.DeleteSelectedRows();
                    e.Handled = true;
                }
                else
                    e.Handled = false;
            }
        }

        private void GridView1_ValidatingEditor(object sender, DevExpress.XtraEditors.Controls.BaseContainerValidateEditorEventArgs e)
        {
            
        }

        private void GridView1_EditFormPrepared(object sender, EditFormPreparedEventArgs e)
        {
            Control ctrl = Util.Util.FindControl(e.Panel, "Update");
            if (ctrl != null)
                ctrl.Text = "Actualizar";
            ctrl = Util.Util.FindControl(e.Panel, "Cancel");
            if (ctrl != null)
                ctrl.Text = "Cancelar";
        }

        private void CargarDatosPeriodoActivo()
        {
            _dsEjercicioPeriodo = EjercicioDAC.GetEjercicioActivo();
            this.txtEjercicio.Text = _dsEjercicioPeriodo.Tables[0].Rows[0]["DescrEjercicio"].ToString();
            this.txtPeriodo.Text = _dsEjercicioPeriodo.Tables[0].Rows[0]["DescrPeriodo"].ToString();
            DataSet DS = new DataSet();
            DS = TipoCambioDetalleDAC.GetData("TVEN", DateTime.Now);
            this.txtTipoCambio.Text = DS.Tables[0].Rows[0]["Monto"].ToString();
        }

        private void EnlazarDatos()
        {
            this.txtFecha.Text = DateTime.Now.ToShortDateString();

        }

  
 
        private void gridView1_InitNewRow(object sender, InitNewRowEventArgs e)
        {
                DevExpress.XtraGrid.Views.Grid.GridView view = sender as DevExpress.XtraGrid.Views.Grid.GridView;
            
            var count = _dsDetalle.Tables[0].AsEnumerable().Max(a => a.Field<int>("Linea"));
                    
            view.SetRowCellValue(e.RowHandle, view.Columns["Linea"], _currentRow["Asiento"]);
            view.SetRowCellValue(e.RowHandle, view.Columns["Linea"], 1);
            //    view.SetRowCellValue(e.RowHandle, view.Columns["CodSucursal"], _currentRow["CodSucursal"]);
        }

        private void gridView1_CellValueChanged(object sender, DevExpress.XtraGrid.Views.Base.CellValueChangedEventArgs e)
        {
            GridView view = (GridView)sender;
            if (view == null) return;
            if (e.Column.FieldName == "IDCentro")
            {
                string cellValue = e.Value.ToString();
                DataView dt = new DataView();
                dt.Table = _dtCentros;
                dt.RowFilter = "IDCentro=" + cellValue;

                view.SetRowCellValue(e.RowHandle, view.Columns["DescrCentro"], dt.ToTable().Rows[0]["Descr"].ToString());
            }
            if (e.Column.FieldName == "IDCuenta")
            {
                string cellValue = e.Value.ToString();
                DataView dt = new DataView();
                dt.Table = _dtCuentas;
                dt.RowFilter = "IDCuenta=" + cellValue;

                view.SetRowCellValue(e.RowHandle, view.Columns["DescrCuenta"], dt.ToTable().Rows[0]["Descr"].ToString());
            }
        }

        //if (e.Value == null) return;
        //MessageBox.Show(e.Column.ColumnEdit.ToString());

        //SearchLookUpEdit edit = e.Column.ColumnEdit.ed as SearchLookUpEdit;
        //if (edit == null) return;
        //int theIndex = edit.Properties.GetIndexByKeyValue(edit.EditValue);
        //if (edit.Properties.View.IsDataRow(theIndex))
        //{
        //    DataRow row = edit.Properties.View.GetDataRow(theIndex);
        //    e.DisplayText = row["Centro"].ToString() + "; " + row["Descr"].ToString();
        //}
        //this.slkupCentroCostoGrid.GetIndexByKeyValue(e.Value);
        //if (ed)


        //SearchLookUpEdit edit = sender as SearchLookUpEdit;
        //if (edit == null) return;
        //int theIndex = edit.Properties.GetIndexByKeyValue(edit.EditValue);
        //if (edit.Properties.View.IsDataRow(theIndex))
        //{
        //    DataRow row = edit.Properties.View.GetDataRow(theIndex);
        //    e.DisplayText = row["Centro"].ToString() + "; " + row["Descr"].ToString();
        //}
        //if (Convert.ToDecimal(e.Value) == 0) e.DisplayText = "";







        //private void btnAgregar_ItemClick(object sender, DevExpress.XtraBars.ItemClickEventArgs e)
        //{
        //    HabilitarControles(true);
        //    ClearControls();
        //    Accion = "New";
        //    InicializarNuevoElemento();
        //    UpdateControlsFromDataRow(_currentRow);

        //}

        //private void btnEditar_ItemClick(object sender, DevExpress.XtraBars.ItemClickEventArgs e)
        //{
        //    Accion = "Edit";
        //    if (_currentRow == null)
        //    {
        //        lblStatusBar.Caption = "Por favor seleccion un elemento";
        //        return;
        //    }
        //    else
        //        lblStatusBar.Caption = "";

        //    HabilitarControles(true);
        //    lblStatusBar.Caption = "Editando :" + _currentRow["NumSolicitud"].ToString();

        //}

        //private void btnGuardar_ItemClick(object sender, DevExpress.XtraBars.ItemClickEventArgs e)
        //{
        //    if (Accion == "Edit")
        //    {
        //        lblStatusBar.Caption = "Actualizando : " + _currentRow["NumSolicitud"].ToString();

        //        Application.DoEvents();
        //        _currentRow.BeginEdit();
        //        _currentRow["NumSolicitud"] = this.txtNumSolicitud.Text.Trim();
        //        _currentRow["CodSucursal"] = this.txtCodSucursal.Text.Trim();
        //        _currentRow["CodCategoria"] = this.slkupCategoria.EditValue;
        //        _currentRow["Descripcion"] = this.txtDescr.Text.Trim();
        //        _currentRow["Estado"] = this.txtEstado.Text.Trim();
        //        _currentRow["UsuarioSolicitud"] = this.txtUsuario.Text.Trim();
        //        _currentRow["FechaSolicitud"] = this.txtFecha.Text.Trim();

        //        _currentRow.EndEdit();

        //        DataSet _dsChanged = _dsAsiento.GetChanges(DataRowState.Modified | DataRowState.Added);

        //        bool okFlag = true;
        //        if (_dsChanged != null && _dsChanged.HasErrors)
        //        {
        //            okFlag = false;
        //            string msg = "Error en la fila con el tipo Id";

        //            foreach (DataTable tb in _dsChanged.Tables)
        //            {
        //                if (tb.HasErrors)
        //                {
        //                    DataRow[] errosRow = tb.GetErrors();

        //                    foreach (DataRow dr in errosRow)
        //                    {
        //                        msg = msg + dr["NumSolicitud"].ToString();
        //                    }
        //                }
        //            }

        //            this.lblStatusBar.Caption = msg;
        //        }




        //        //Si no hay errores

        //        if (okFlag)
        //        {

        //            ConnectionManager.BeginTran();
        //            SolicitudDAC.SetTransactionToAdaptador(true);
        //            SolicitudDetalleDAC.SetTransactionToAdaptador(true);

        //            SolicitudDAC.oAdaptador.Update(_dsChanged, "Data");
        //            SolicitudDetalleDAC.oAdaptador.Update(_dsDetalle, "Data");

        //            this.lblStatusBar.Caption = "Actualizado " + _currentRow["Numsolicitud"].ToString();
        //            Application.DoEvents();

        //            _dsAsiento.AcceptChanges();
        //            _dsDetalle.AcceptChanges();

        //            ConnectionManager.CommitTran();
        //            SolicitudDAC.SetTransactionToAdaptador(false);
        //            SolicitudDetalleDAC.SetTransactionToAdaptador(false);

        //            PopulateGrid();
        //            HabilitarControles(false);
        //        }
        //        else
        //        {
        //            _dsAsiento.RejectChanges();


        //        }
        //    }
        //    else
        //    {
        //        //nuevo registro

        //        _currentRow["NumSolicitud"] = this.txtNumSolicitud.Text.Trim();
        //        _currentRow["CodSucursal"] = this.txtCodSucursal.Text.Trim();
        //        _currentRow["CodCategoria"] = this.slkupCategoria.EditValue;
        //        _currentRow["Descripcion"] = this.txtDescr.Text.Trim();
        //        _currentRow["Estado"] = this.txtEstado.Text.Trim();
        //        _currentRow["UsuarioSolicitud"] = this.txtUsuario.Text.Trim();
        //        _currentRow["FechaSolicitud"] = this.txtFecha.Text.Trim();

        //        _dtAsiento.Rows.Add(_currentRow);
        //        try
        //        {
        //            ConnectionManager.BeginTran();
        //            SolicitudDAC.SetTransactionToAdaptador(true);
        //            SolicitudDetalleDAC.SetTransactionToAdaptador(true);

        //            SolicitudDAC.oAdaptador.Update(_dsAsiento, "Data");
        //            _dsAsiento.AcceptChanges();

        //            //Agregar el detalle
        //            SolicitudDetalleDAC.oAdaptador.Update(_dsDetalle, "Data");
        //            _dsDetalle.AcceptChanges();

        //            ConnectionManager.CommitTran();
        //            SolicitudDAC.SetTransactionToAdaptador(false);
        //            SolicitudDetalleDAC.SetTransactionToAdaptador(false);

        //            this.lblStatusBar.Caption = "Se ha ingresado un nuevo registro";
        //            Application.DoEvents();
        //            PopulateGrid();
        //            HabilitarControles(false);
        //        }
        //        catch (System.Data.SqlClient.SqlException ex)
        //        {
        //            _dsAsiento.RejectChanges();
        //            _dsDetalle.RejectChanges();
        //            ConnectionManager.RollBackTran();
        //            MessageBox.Show(ex.Message);
        //        }
        //    }
        //}

        //private void btnCancelar_ItemClick(object sender, DevExpress.XtraBars.ItemClickEventArgs e)
        //{
        //    HabilitarControles(false);
        //    UpdateControlsFromDataRow(_currentRow);
        //    this.lblStatusBar.Caption = "";
        //}

        //private void btnEliminar_ItemClick(object sender, DevExpress.XtraBars.ItemClickEventArgs e)
        //{
        //    if (_currentRow != null)
        //    {
        //        if (MessageBox.Show("Esta seguro que desea eliminar el elemento: " + _currentRow["NumSolicitud"].ToString(), _tituloVentana, MessageBoxButtons.YesNo) == System.Windows.Forms.DialogResult.Yes)
        //        {
        //            string msg = _currentRow["NumSolicitud"] + " eliminado..";
        //            string sNumSolicitud = _currentRow["NumSolicitud"].ToString();
        //            _currentRow.Delete();

        //            try
        //            {
        //                ConnectionManager.BeginTran();
        //                SolicitudDAC.SetTransactionToAdaptador(true);


        //                System.Data.SqlClient.SqlCommand oCmd = new System.Data.SqlClient.SqlCommand("Delete from fnica.solSolicituddetalle where numsolicitud=@Solicitud", ConnectionManager.GetConnection(), ConnectionManager.Tran);
        //                oCmd.Parameters.Add("@Solicitud", SqlDbType.NVarChar).Value = sNumSolicitud;
        //                int i = oCmd.ExecuteNonQuery();

        //                SolicitudDAC.oAdaptador.Update(_dsAsiento, "Data");
        //                _dsAsiento.AcceptChanges();


        //                ConnectionManager.CommitTran();
        //                SolicitudDAC.SetTransactionToAdaptador(false);


        //                PopulateGrid();
        //                this.lblStatusBar.Caption = msg;
        //                Application.DoEvents();

        //                this.Close();
        //            }
        //            catch (System.Data.SqlClient.SqlException ex)
        //            {
        //                ConnectionManager.RollBackTran();
        //                _dsAsiento.RejectChanges();
        //                this.lblStatusBar.Caption = "";
        //                MessageBox.Show(ex.Message);
        //            }
        //        }
        //    }
        //}



        //private void gridViewDetalle_ValidatingEditor(object sender, DevExpress.XtraEditors.Controls.BaseContainerValidateEditorEventArgs e)
        //{
        //    if (this.gridViewDetalle.FocusedRowHandle == DevExpress.XtraGrid.GridControl.AutoFilterRowHandle)
        //        return;

        //    DevExpress.XtraGrid.Views.Grid.GridView view = sender as DevExpress.XtraGrid.Views.Grid.GridView;
        //    DataView dataView = view.DataSource as DataView;
        //    System.Collections.IEnumerator en = dataView.GetEnumerator();

        //    en.Reset();

        //    string currentCode = e.Value.ToString();

        //    while (en.MoveNext())
        //    {
        //        DataRowView row = en.Current as DataRowView;
        //        object colValue = row["Articulo"];
        //        if (colValue.ToString() == currentCode)
        //        {
        //            e.ErrorText = "El elemento ya existe.";
        //            e.Valid = false;
        //            break;
        //        }
        //    }
        //}
    }
}