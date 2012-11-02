
/** @class_declaration prod */
/////////////////////////////////////////////////////////////////
//// PRODUCCIÓN /////////////////////////////////////////////////
class prod extends oficial {
	var tbnGuardar:Object;
	var tbnQuitarProceso:Object;
	var tbnAsociarProceso:Object;
	var datosProceso_:Array;
	var pbnEditLote:Object;
	var procesosCargado_:Boolean;
	function prod( context ) { oficial ( context ); }
	function init() {
		return this.ctx.prod_init();
	}
	function editarLote() {
		return this.ctx.prod_editarLote();
	}
	function guardar_clicked():Boolean {
		return this.ctx.prod_guardar_clicked();
	}
	function guardarLinea():Boolean {
		return this.ctx.prod_guardarLinea();
	}
	function buscarLoteAplicable(referencia:String):String {
		return this.ctx.prod_buscarLoteAplicable(referencia);
	}
	function tbnQuitarProceso_clicked() {
		return this.ctx.prod_tbnQuitarProceso_clicked();
	}
	function tbnAsociarProceso_clicked() {
		return this.ctx.prod_tbnAsociarProceso_clicked();
	}
	function bufferChanged(fN:String) {
		return this.ctx.prod_bufferChanged(fN);
	}
	function controlArticuloProd() {
		return this.ctx.prod_controlArticuloProd();
	}
	function validateForm():Boolean {
		return this.ctx.prod_validateForm();
	}
}
//// PRODUCCIÓN /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition prod */
/////////////////////////////////////////////////////////////////
//// PROD ///////////////////////////////////////////////////////
/** \C Una vez establecida, no podrá modificarse la referencia de los artículos y si el artículo es por lotes tampoco podrá modificarse la cantidad.
\end */
function prod_init()
{
	this.iface.__init();

	this.iface.datosProceso_ = [];
	this.iface.procesosCargado_ = sys.isLoadedModule("flcolaproc");

	this.iface.tbnGuardar = this.child("tbnGuardar");
	this.iface.tbnQuitarProceso = this.child("tbnQuitarProceso");
	this.iface.tbnAsociarProceso = this.child("tbnAsociarProceso");
	this.iface.pbnEditLote = this.child("pbnEditLote");

	if (!this.iface.procesosCargado_) {
		this.iface.tbnGuardar.close();
		this.child("tbwLinea").setTabEnabled("procesos", false);
	}

	connect(this.iface.tbnGuardar, "clicked()", this, "iface.guardar_clicked()");
	connect(this.iface.tbnQuitarProceso, "clicked()", this, "iface.tbnQuitarProceso_clicked()");
	connect(this.iface.tbnAsociarProceso, "clicked()", this, "iface.tbnAsociarProceso_clicked()");
	connect(this.iface.pbnEditLote, "clicked()", this, "iface.editarLote()");

	var util:FLUtil = new FLUtil;
	var cursor:FLSqlCursor = this.cursor();
	switch (cursor.modeAccess()) {
		case cursor.Insert: {
			this.iface.controlArticuloProd();
// 			this.iface.tbnGuardar.enabled = false;
			break;
		}
		case cursor.Edit: {
			/// Inhabilitado para evitar que se queden procesos asociados a líneas erróneas
			this.child("fdbReferencia").setDisabled(true);

			if (util.sqlSelect("articulos", "tipostock", "referencia = '" + cursor.valueBuffer("referencia") + "'") == "Lotes") {

				this.child("fdbCantidad").setDisabled(true);
			}
			this.iface.tbnGuardar.enabled = false;
			this.iface.controlArticuloProd()
			break;
		}
		case cursor.Browse: {
			this.iface.tbnGuardar.enabled = false;
			break;
		}
	}
	this.child("tdbMoviStock").cursor().setMainFilter("idlineapc = " + cursor.valueBuffer("idlinea"));
	if (this.iface.procesosCargado_) {
		this.child("tdbLotesStock").cursor().setMainFilter("codlote IN (SELECT codlote FROM movistock WHERE idlineapc = " + cursor.valueBuffer("idlinea") + ") OR codlote IN (SELECT idobjeto FROM pr_procesos WHERE idlineapedidocli = " + cursor.valueBuffer("idlinea") + ")");
	} else {
		this.child("tdbLotesStock").cursor().setMainFilter("codlote IN (SELECT codlote FROM movistock WHERE idlineapc = " + cursor.valueBuffer("idlinea") + ")");
	}
	this.child("tdbMoviStock").refresh();
	this.child("tdbLotesStock").refresh();
}

function prod_editarLote()
{
	var codLote = this.child("tdbLotesStock").cursor().valueBuffer("codlote");
	debug("codLote " + codLote);
	if(!codLote || codLote == "") {
		return false;
	}

	this.child("tdbLotesStock").cursor().editRecord();
}

function prod_guardar_clicked():Boolean
{
	var util:FLUtil = new FLUtil;
	var cursor:FLSqlCursor = this.cursor();

	var referencia:String = cursor.valueBuffer("referencia");

	if (util.sqlSelect("pr_procesos", "idproceso", "idlineapedidocli = " + cursor.valueBuffer("idlinea"))) {
		MessageBox.warning(util.translate("scripts", "Error: Ya hay procesos asociados a la línea de pedido"), MessageBox.Ok, MessageBox.NoButton);
		return false;
	}

	if (!this.iface.datosProceso_) {
		return false;
	}
	if (this.iface.datosProceso_["produccion"] == false) {
		MessageBox.warning(util.translate("scripts", "Sólo es necesario guardar las referencias asociadas a procesos de producción"), MessageBox.Ok, MessageBox.NoButton);
		return false;
	}

	var curTransaccion:FLSqlCursor = new FLSqlCursor("lotesstock");
	curTransaccion.transaction(false);
	try {
		if (this.iface.guardarLinea()) {
			curTransaccion.commit();
			this.child("tdbMoviStock").refresh();
			this.child("tdbLotesStock").refresh();
			this.child("tdbProcesos").refresh();
			return true;
		} else {
			curTransaccion.rollback();
			return false;
		}
	} catch (e) {
		curTransaccion.rollback();
		MessageBox.critical(util.translate("scripts", "Error al guardar la línea de pedido: ") + e, MessageBox.Ok, MessageBox.NoButton);
		return false;
	}

	return true;
}

function prod_guardarLinea():Boolean
{

	var util:FLUtil = new FLUtil;
	var cursor:FLSqlCursor = this.cursor();

	var referencia:String = cursor.valueBuffer("referencia");

	switch (this.iface.datosProceso_["tipoproduccion"]) {
		case "M": { /// Modificación
			var curProcesos:FLSqlCursor = this.child("tdbProcesos").cursor();
			if (!curProcesos.commitBufferCursorRelation()) {
				return false;
			}
			var idLineaPedido:String = cursor.valueBuffer("idlinea");
			var codLote:String = cursor.cursorRelation().valueBuffer("codlote");
			if(!codLote || codLote == "")
				codLote = this.iface.buscarLoteAplicable(referencia);

			if (!codLote || codLote == "") {
				return false;
			}

			if (!flcolaproc.iface.pub_crearProcesoProd(referencia, codLote, idLineaPedido)) {
				MessageBox.warning(util.translate("scripts", "Error al crear el proceso %1 para el lote %2").arg(this.iface.datosProceso_["idtipoproceso"]).arg(codLote), MessageBox.Ok, MessageBox.NoButton);
				return false;
			}
			break;
		}
		case "F": { /// Fabricación
			var curProcesos:FLSqlCursor = this.child("tdbProcesos").cursor();
			if (!curProcesos.commitBufferCursorRelation())
				return false;
//
// 			var idLineaPedido:String = cursor.valueBuffer("idlinea");
//
// 			var codLote:String;
// 			var qryLotes:FLSqlQuery = new FLSqlQuery;
// 			with (qryLotes) {
// 				setTablesList("lotesstock");
// 				setSelect("codlote");
// 				setFrom("lotesstock");
// 				setWhere("codlote IN (SELECT codlote FROM movistock WHERE idlineapc = " + cursor.valueBuffer("idlinea") + ") AND estado = 'PTE'");
// 				setForwardOnly(true);
// 			}
// 			if (!qryLotes.exec()) {
// 				return false;
// 			}
// 			while (qryLotes.next()) {
// 				codLote = qryLotes.value("codlote");
// 				if (util.sqlSelect("pr_procesos p INNER JOIN pr_tiposproceso tp ON p.idtipoproceso = tp.idtipoproceso", "p.idproceso", "p.idobjeto = '" + codLote + "' AND tp.tipoobjeto = 'lotesstock'")) {
// 					MessageBox.warning(util.translate("scripts", "Error: El lote %1, en estado PTE, ya tiene un proceso asociado").arg(codLote));
// 					return false;
// 				}
// 				if (!flcolaproc.iface.pub_crearProcesoProd(referencia, codLote, idLineaPedido)) {
// 					MessageBox.warning(util.translate("scripts", "Error al crear el proceso %1 para el lote %2").arg(this.iface.datosProceso_["idtipoproceso"]).arg(codLote), MessageBox.Ok, MessageBox.NoButton);
// 					return false;
// 				}
// 			}
			break;
		}
		default: {
			return false;
		}
	}
	return true;
}

function prod_buscarLoteAplicable(referencia:String):String
{
	var util:FLUtil = new FLUtil;

	var f:Object = new FLFormSearchDB("lotesstock");
	var curLote:FLSqlCursor = f.cursor();

	curLote.setMainFilter("estado = 'TERMINADO' AND cantotal > 0 AND referencia IN (SELECT refaplicable FROM articulosaplicables WHERE refproceso = '" + referencia + "')");

	f.setMainWidget();
	var codLote:String = f.exec("codlote");
	if (!codLote) {
		return false;
	}

	return codLote;
}

function prod_tbnQuitarProceso_clicked()
{
	var util:FLUtil = new FLUtil;

	var curProceso:FLSqlCursor = this.child("tdbProcesos").cursor();
	var idProceso:String = curProceso.valueBuffer("idproceso");
	var res:Number = MessageBox.warning(util.translate("scripts", "¿Desea desvincular el proceso %1 del pedido?").arg(idProceso), MessageBox.Yes, MessageBox.No);
	if (res != MessageBox.Yes) {
		return;
	}

	curProceso.setModeAccess(curProceso.Edit);
	curProceso.refreshBuffer();
	curProceso.setNull("idlineapedidocli");
	if (!curProceso.commitBuffer()) {
		return false;
	}

	this.child("tdbProcesos").refresh();
}

function prod_tbnAsociarProceso_clicked()
{
	var util:FLUtil = new FLUtil();
	var cursor:FLSqlCursor = this.cursor();

	var idTipoProceso:String = util.sqlSelect("articulos", "idtipoproceso", "referencia = '" + cursor.valueBuffer("referencia") + "'");

	var f:Object = new FLFormSearchDB("pr_procesos");
	var curProceso:FLSqlCursor = f.cursor();

	curProceso.setMainFilter("idtipoproceso = '" + idTipoProceso + "' AND idlineapedidocli IS NULL");
	f.setMainWidget();
	var idProceso:String = f.exec("idproceso");

	if (idProceso) {
		curProceso.select("idproceso = " + idProceso);
		if (!curProceso.first()) {
			return false;
		}
		curProceso.setModeAccess(curProceso.Edit);
		curProceso.refreshBuffer();
		curProceso.setValueBuffer("idlineapedidocli", cursor.valueBuffer("idlinea"));
		if (!curProceso.commitBuffer()) {
			return false;
		}
		this.child("tdbProcesos").refresh();
	}
}

function prod_bufferChanged(fN:String)
{
	switch (fN) {
		case "referencia": {
			this.iface.controlArticuloProd();
			this.iface.__bufferChanged(fN);
			break;
		}
		default: {
			this.iface.__bufferChanged(fN);
			break;
		}
	}
}

function prod_controlArticuloProd()
{
	var util:FLUtil = new FLUtil;
	var cursor:FLSqlCursor = this.cursor();

	this.iface.datosProceso_ = flfactalma.iface.pub_datosProcesoArticulo(cursor.valueBuffer("referencia"));
	if (!this.iface.datosProceso_) {
		this.iface.tbnGuardar.enabled = false;
		this.child("fdbCerrada").setDisabled(false);
	} else {
		if (this.iface.datosProceso_["produccion"]) {
			this.child("fdbCerrada").setValue(false);
			this.child("fdbCerrada").setDisabled(true);
			var idLinea:String = cursor.valueBuffer("idlinea");
			if (!util.sqlSelect("pr_procesos", "idproceso", "idlineapedidocli = " + idLinea)) {
				this.iface.tbnGuardar.enabled = true;
			} else {
				this.iface.tbnGuardar.enabled = false;
			}
		} else {
			this.iface.tbnGuardar.enabled = false;
			this.child("fdbCerrada").setDisabled(false);
		}
	}
}

function prod_validateForm():Boolean
{
	var util:FLUtil = new FLUtil;
	var cursor:FLSqlCursor = this.cursor();

	var idLinea:String = cursor.valueBuffer("idlinea");

	if (this.iface.procesosCargado_ && this.iface.datosProceso_) {
		if (this.iface.datosProceso_["produccion"]) {
			if (!util.sqlSelect("pr_procesos", "idproceso", "idlineapedidocli = " + idLinea)) {
				MessageBox.warning(util.translate("scripts", "Ha seleccionado un artículo de tipo proceso de producción.\nAntes de cerrar la línea debe usar el botón de guardar línea"), MessageBox.Ok, MessageBox.NoButton);
				return false;
			}
		}
	}

	if (!this.iface.__validateForm()) {
		return false;
	}
	return true;
}
//// PROD ///////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

